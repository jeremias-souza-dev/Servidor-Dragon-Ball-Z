-- Recebe os gatilhos de dash/grito do cliente via extended opcode:
--  - opcode 211 (Ctrl+Shift+Click, ver gameinterface.lua): encadeia varios
--    dashes na direcao do alvo clicado, ate chegar perto, ficar sem Ki, ou
--    esbarrar em algo no caminho.
--  - opcode 212 (Ctrl+Shift+seta, ver game_walk/walk.lua): um dash na
--    direcao da seta. Segurar/repetir a tecla encadeia hops (fadiga sobe
--    junto), mas a cadeia reseta se ficar mais de 2s sem usar.
--  - opcode 214 (Ctrl+Enter, ver gameinterface.lua): grito de carga de Ki de
--    10s (4 passos "ha"/"haaa"/"haaaa"/"haaaaaaaaaaaaaaaa"), mensagens
--    privadas (so o proprio jogador ve), cancela se o jogador se mover.
--  - opcode 215 (Ctrl+E, ver gameinterface.lua): liga/desliga exploracao
--    automatica - anda sozinho na direcao atual, e se bater numa parede
--    escolhe outra direcao livre e continua, ate apertar Ctrl+E de novo.
local DASH_CLICK_OPCODE = 211
local DASH_KEY_OPCODE = 212
local SCREAM_CHARGE_OPCODE = 214
local EXPLORE_TOGGLE_OPCODE = 215
local DASH_CHAIN_RESET_SECONDS = 2
local DASH_CHAIN_STORAGE = 91102
local DASH_CHAIN_TIME_STORAGE = 91103
local SCREAM_CHARGE_STORAGE = 91104 -- 1 enquanto o grito de 10s esta ativo
local EXPLORE_ACTIVE_STORAGE = 91105 -- 1 enquanto a exploracao automatica esta ativa
local EXPLORE_DIR_STORAGE = 91106 -- direcao atual da exploracao (NORTH/EAST/SOUTH/WEST)

local SCREAM_CHARGE_TICK_MS = 2500 -- 4 passos * 2.5s = 10s
local SCREAM_CHARGE_KI_PERCENT_PER_TICK = 15 -- mesma taxa do !charge
local SCREAM_CHARGE_TEXTS = {"ha", "haaa", "haaaa", "haaaaaaaaaaaaaaaa"}
-- efeito visual escala junto com o grito (visivel pra quem estiver perto,
-- diferente do texto do grito que e privado - so pro proprio jogador)
local SCREAM_CHARGE_EFFECTS = {CONST_ME_MAGIC_BLUE, CONST_ME_MAGIC_BLUE, CONST_ME_ENERGYAREA, CONST_ME_YELLOWENERGY}

local EXPLORE_DIRECTIONS = {NORTH, EAST, SOUTH, WEST}

local function isSamePos(a, b)
	return a.x == b.x and a.y == b.y and a.z == b.z
end

-- exploracao deve CORRER, nao andar no ritmo lento de um tick fixo: calcula
-- o proximo passo baseado na velocidade real do personagem (mesma formula
-- classica de Tibia, duracao = 1000 * velocidadeDoChao / velocidadeDoPersonagem),
-- assumindo chao normal (velocidade 150) ja que nao da pra ler o item do
-- chao direto daqui. min 100ms pra nao virar spam de pacotes.
local function getExploreStepDelay(cid)
	local speed = getCreatureSpeed(cid)
	if not speed or speed <= 0 then
		return 300
	end
	return math.max(100, math.floor(150000 / speed))
end

-- tenta mover na direcao dada; retorna true se a posicao realmente mudou
-- (doMoveCreature "sucesso" nao garante isso sozinho de forma simples, entao
-- comparamos a posicao antes/depois, que e robusto independente do retorno).
-- flag 0 = movimento normal; SEM isso doMoveCreature usa FLAG_NOLIMIT por
-- padrao, que ignora paredes/itens bloqueantes (documentado em cylinder.h) -
-- era por isso que a exploracao atravessava parede.
local function tryMove(cid, direction, beforePos)
	doMoveCreature(cid, direction, 0)
	return not isSamePos(getCreaturePosition(cid), beforePos)
end

local function exploreTick(cid, expectedPos)
	if not isPlayer(cid) or getPlayerStorageValue(cid, EXPLORE_ACTIVE_STORAGE) ~= 1 then
		return
	end

	if getCreatureHealth(cid) <= 0 then
		doPlayerSetStorageValue(cid, EXPLORE_ACTIVE_STORAGE, -1)
		return
	end

	local beforePos = getCreaturePosition(cid)
	if expectedPos and not isSamePos(beforePos, expectedPos) then
		-- a posicao mudou sem ser pelo proprio script (jogador andou com
		-- seta ou clicou pra andar): assumiu o controle, entao para
		doPlayerSetStorageValue(cid, EXPLORE_ACTIVE_STORAGE, -1)
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Voce assumiu o controle, exploracao parada.")
		return
	end

	local dir = getPlayerStorageValue(cid, EXPLORE_DIR_STORAGE)
	if dir < 0 then
		dir = getCreatureLookDirection(cid)
	end

	if not tryMove(cid, dir, beforePos) then
		-- bateu em algo: tenta as outras 3 direcoes em ordem aleatoria antes de desistir
		local candidates = {}
		for _, d in ipairs(EXPLORE_DIRECTIONS) do
			if d ~= dir then
				table.insert(candidates, d)
			end
		end
		for i = #candidates, 2, -1 do
			local j = math.random(i)
			candidates[i], candidates[j] = candidates[j], candidates[i]
		end

		local moved = false
		for _, candidate in ipairs(candidates) do
			if tryMove(cid, candidate, beforePos) then
				dir = candidate
				moved = true
				break
			end
		end

		if not moved then
			doPlayerSetStorageValue(cid, EXPLORE_ACTIVE_STORAGE, -1)
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Exploracao parada: sem caminho livre.")
			return
		end
	end

	doPlayerSetStorageValue(cid, EXPLORE_DIR_STORAGE, dir)
	addEvent(exploreTick, getExploreStepDelay(cid), cid, getCreaturePosition(cid))
end

local function screamChargeTick(cid, pos, step)
	if not isPlayer(cid) or getPlayerStorageValue(cid, SCREAM_CHARGE_STORAGE) ~= 1 then
		return
	end

	local currentPos = getCreaturePosition(cid)
	if currentPos.x ~= pos.x or currentPos.y ~= pos.y or currentPos.z ~= pos.z then
		doPlayerSetStorageValue(cid, SCREAM_CHARGE_STORAGE, -1)
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Voce se moveu e perdeu a concentracao!")
		return
	end

	doPlayerSendTextMessage(cid, MESSAGE_STATUS_SMALL, SCREAM_CHARGE_TEXTS[step])
	doSendMagicEffect(currentPos, SCREAM_CHARGE_EFFECTS[step])

	local maxKi = getPlayerMaxKi(cid)
	local gain = math.floor(maxKi * (SCREAM_CHARGE_KI_PERCENT_PER_TICK / 100))
	doPlayerSetKi(cid, getPlayerCurrentKi(cid) + gain)

	if step < #SCREAM_CHARGE_TEXTS then
		addEvent(screamChargeTick, SCREAM_CHARGE_TICK_MS, cid, pos, step + 1)
	else
		doPlayerSetStorageValue(cid, SCREAM_CHARGE_STORAGE, -1)
	end
end

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

	if opcode == SCREAM_CHARGE_OPCODE then
		if getPlayerStorageValue(cid, SCREAM_CHARGE_STORAGE) == 1 then
			return true -- ja esta gritando, ignora
		end

		if getPlayerCurrentKi(cid) >= getPlayerMaxKi(cid) then
			doPlayerSendCancel(cid, "Seu Ki ja esta no maximo.")
			return true
		end

		doPlayerSetStorageValue(cid, SCREAM_CHARGE_STORAGE, 1)
		screamChargeTick(cid, getCreaturePosition(cid), 1)
		return true
	end

	if opcode == EXPLORE_TOGGLE_OPCODE then
		if getPlayerStorageValue(cid, EXPLORE_ACTIVE_STORAGE) == 1 then
			doPlayerSetStorageValue(cid, EXPLORE_ACTIVE_STORAGE, -1)
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Exploracao parada.")
			return true
		end

		doPlayerSetStorageValue(cid, EXPLORE_ACTIVE_STORAGE, 1)
		doPlayerSetStorageValue(cid, EXPLORE_DIR_STORAGE, getCreatureLookDirection(cid))
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Explorando automaticamente... (Ctrl+X de novo pra parar)")
		exploreTick(cid)
		return true
	end

	return true
end
