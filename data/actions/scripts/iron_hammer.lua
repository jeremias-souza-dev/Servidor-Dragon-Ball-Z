function onUse(cid, item, fromPosition, itemEx, toPosition)

	local recipe = nil


	for _, v in ipairs(Recipes) do

		recipe = v:get(toPosition)

		if(recipe ~= false) then

			break

		end

	end


	if(recipe) then

		recipe:create(cid)

	else

		doPlayerSendCancel(cid, "Essa nao e uma receita valida. Use /recipes.")

	end

	return true

end