local combat1 = createCombatObject()
setCombatParam(combat1, COMBAT_PARAM_HITCOLOR, COLOR_TEAL)
setCombatParam(combat1, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat1, COMBAT_PARAM_DISTANCEEFFECT, 52)
setCombatFormula(combat1, COMBAT_FORMULA_LEVELMAGIC, -45.0, 0, -45.5, 0)

local function onCastSpell1(parameters)
doCombat(parameters.cid, parameters.combat1, parameters.var)
end

function rk1(cid)
	if isCreature(cid) and isCreature(getCreatureTarget(cid)) then
		local position1 = {x=getThingPosition(getCreatureTarget(cid)).x, y=getThingPosition(getCreatureTarget(cid)).y, z=getThingPosition(getCreatureTarget(cid)).z}
		doSendMagicEffect(position1, 1)
	end
end

function onCastSpell(cid, var)
local parameters = {cid = cid, var = var, combat1 = combat1}

for k = 1, 10 do
	addEvent(function()
		if isCreature(cid) then
			addEvent(onCastSpell1, 1, parameters)
		end
	end, 1 + ((k-1) * 225))
end
for i = 1, 4 do
	addEvent(function()
		if isCreature(cid) then
			addEvent(rk1,1,cid)
		end
	end, 1 + ((i-1) * 650))
end
return true
end