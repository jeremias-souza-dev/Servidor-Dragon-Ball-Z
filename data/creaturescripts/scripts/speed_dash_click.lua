-- Recebe os gatilhos de dash do cliente via extended opcode:
--  - opcode 211 (Ctrl+Shift+Click, ver gameinterface.lua): encadeia varios
--    dashes na direcao do alvo clicado, ate chegar perto, ficar sem Ki, ou
--    esbarrar em algo no caminho.
--  - opcode 212 (Ctrl+Shift+seta, ver game_walk/walk.lua): um dash na
--    direcao da seta. Segurar/repetir a tecla encadeia hops (fadiga sobe
--    junto), mas a cadeia reseta se ficar mais de 2s sem usar.
local DASH_CLICK_OPCODE = 211
local DASH_KEY_OPCODE = 212
local DASH_CHAIN_RESET_SECONDS = 2
local DASH_CHAIN_STORAGE = 91102
local DASH_CHAIN_TIME_STORAGE = 91103

function onExtendedOpcode(cid, opcode, buffer)
	if opcode == DASH_CLICK_OPCODE then
		local x, y, z = buffer:match("^(%-?%d+),(%-?%d+),(%-?%d+)$")
		if not x then
			return true
		end

		local target = {x = tonumber(x), y = tonumber(y), z = tonumber(z)}

		for hop = 1, DASH_MAX_HOPS_PER_CLICK do
			local pos = getCreaturePosition(cid)
			if pos.z ~= target.z then
				break
			end

			local dx, dy = target.x - pos.x, target.y - pos.y
			if math.abs(dx) <= 1 and math.abs(dy) <= 1 then
				break -- ja chegou perto o suficiente
			end

			local direction
			if math.abs(dx) >= math.abs(dy) then
				direction = dx > 0 and EAST or WEST
			else
				direction = dy > 0 and SOUTH or NORTH
			end

			if not doPlayerDashDirection(cid, direction, hop) then
				break -- sem Ki ou bloqueado: para onde estiver
			end
		end

		return true
	end

	if opcode == DASH_KEY_OPCODE then
		local direction = tonumber(buffer)
		if direction == nil then
			return true
		end

		local lastTime = getPlayerStorageValue(cid, DASH_CHAIN_TIME_STORAGE)
		local chain = getPlayerStorageValue(cid, DASH_CHAIN_STORAGE)
		if chain < 1 or (os.time() - lastTime) > DASH_CHAIN_RESET_SECONDS then
			chain = 1
		else
			chain = chain + 1
		end

		if doPlayerDashDirection(cid, direction, chain) then
			doPlayerSetStorageValue(cid, DASH_CHAIN_STORAGE, chain)
			doPlayerSetStorageValue(cid, DASH_CHAIN_TIME_STORAGE, os.time())
		end

		return true
	end

	return true
end
