--[[


	ADVANCED FORGE SYSTEM

				FINAL


	Criado por Oneshot


	É proibido a venda ou a cópia sem os devidos créditos desse script.


]]--


RecipeHandler = {

	itemtype = 0,

	items = {},

	level = 1,

	maglevel = 0,

	skills = {[0] = 0, [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0}

}


Forge = {

	type = nil,

	position = nil,

	magicEffect = 4,

	messages = {

		class = MESSAGE_STATUS_DEFAULT,

		success = "You have successfully forged a %s.",

		needskill = "You don't have enough %s to create a %s.",

		needlevel = "You need level %s to create a %s.",

		needmaglevel = "You need magic level %s to create a %s."

	}

}


function RecipeHandler:new(itemtype, items, level, maglevel, skills)

	local obj = {

		itemtype = (itemtype or 0),

		items = (items or {}),

		level = (level or 1),

		maglevel = (maglevel or 0),

		skills = (skills or {[0] = 0, [1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0})

	}

	table.insert(Recipes, obj)

	return setmetatable(obj, {__index = self})

end


function RecipeHandler:setItem(itemtype)

	self.itemtype = (itemtype or 0)

end


function RecipeHandler:setRecipe(...)

	self.items = {...}

end


function RecipeHandler:setRecipeItem(itemid, amount)

	table.insert(self.items, {itemid, amount})

end


function RecipeHandler:setSkill(skillid, value)

	self.skills[skillid] = value

end


function RecipeHandler:setLevel(value)

	self.level = value

end


function RecipeHandler:setMagLevel(value)

	self.maglevel = value

end


function RecipeHandler:check(position)

	local match = false


	for n, item in ipairs(self.items) do

		local thing = getTileItemById(position, item[1])

		if thing.uid > 0 and math.max(1, thing.type) >= item[2] then

			if n == #self.items then

				match = true

			end

		else

			break

		end

	end


	return match

end


function RecipeHandler:get(position)

	if self:check(position) == true then

		return setmetatable({type = self, position = position}, {__index = Forge})

	end

	return false

end


function Forge:create(cid)

	if self.type.itemid == 0 then

		print("[FORGE SYSTEM - ERROR] ATTEMPT TO CREATE A RECIPE ITEMID 0")

		return

	end


	local status = true

	if(cid) then

		if getPlayerLevel(cid) < self.type.level then

			doPlayerSendTextMessage(cid, self.messages.class, self.messages.needlevel:format(self.type.level, getItemNameById(self.type.itemtype)))

			return

		end


		if getPlayerMagLevel(cid) < self.type.maglevel then

			doPlayerSendTextMessage(cid, self.messages.class, self.messages.needmaglevel:format(self.type.maglevel, getItemNameById(self.type.itemtype)))

			return

		end


		for skillid, value in pairs(self.type.skills) do

			if getPlayerSkillLevel(cid, skillid) < value then

				status = false

				doPlayerSendTextMessage(cid, self.messages.class, self.messages.needskill:format(SKILL_NAMES[skillid], getItemNameById(self.type.itemtype)))

				break

			end

		end

	end


	if status == true then

		for _, item in ipairs(self.type.items) do

			local thing = getTileItemById(self.position, item[1])

			doRemoveItem(thing.uid, item[2])

		end

		doSendMagicEffect(self.position, self.magicEffect)

		doPlayerSendTextMessage(cid, self.messages.class, self.messages.success:format(getItemNameById(self.type.itemtype)))

		doCreateItem(self.type.itemtype, self.position)

	end

end


dofile(getDataDir() .."/lib/recipes.lua")