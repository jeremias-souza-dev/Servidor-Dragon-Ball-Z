-- Enquanto a guarda esta levantada (!guard), quanto mais forte o defensor
-- for em relacao ao atacante, maior a chance de esquivar/bloquear o golpe
-- por completo (retornar false no onStatsChange cancela o dano, o mesmo
-- mecanismo que o reflect.lua ja usa). Cada bloqueio bem-sucedido gasta um
-- pouco de Ki -- sem energia, a guarda nao segura o golpe.
local GUARD_BASE_PERCENT = 10 -- chance de bloqueio mesmo contra um adversario de forca igual
local GUARD_PERCENT_PER_LEVEL_GAP = 1 -- +1% de chance pra cada "level" de vantagem
local GUARD_MIN_PERCENT = 0
local GUARD_MAX_PERCENT = 90 -- nunca 100% garantido
local GUARD_KI_COST_PERCENT = 5 -- % do KiMax gasto por bloqueio bem-sucedido

-- Monstros nao tem "level" -- aproximamos um equivalente pela experiencia
-- que eles dao (heuristica simples, nao existe um "level de monstro" nativo).
local function getCreaturePowerLevel(cid)
	if isPlayer(cid) then
		return getPlayerLevel(cid)
	end

	local info = getMonsterInfo(getCreatureName(cid))
	if info and info.experience then
		return math.max(1, math.floor(info.experience / 100))
	end
	return 1
end

function onStatsChange(cid, attacker, type, combat, value)
	if type ~= STATSCHANGE_HEALTHLOSS then
		return true
	end

	if not isPlayer(cid) or getPlayerStorageValue(cid, GUARD_STORAGE) ~= 1 then
		return true
	end

	if not attacker or attacker == cid then
		return true
	end

	local cost = math.max(1, math.floor(getPlayerMaxKi(cid) * (GUARD_KI_COST_PERCENT / 100)))
	if getPlayerCurrentKi(cid) < cost then
		return true -- sem energia pra sustentar a guarda nesse golpe
	end

	local powerGap = getPlayerLevel(cid) - getCreaturePowerLevel(attacker)
	local dodgeChance = GUARD_BASE_PERCENT + (powerGap * GUARD_PERCENT_PER_LEVEL_GAP)
	dodgeChance = math.max(GUARD_MIN_PERCENT, math.min(GUARD_MAX_PERCENT, dodgeChance))

	if math.random(1, 100) <= dodgeChance then
		doPlayerConsumeKi(cid, cost)
		doSendMagicEffect(getCreaturePosition(cid), CONST_ME_YELLOW_RINGS)
		doSendAnimatedText(getCreaturePosition(cid), "BLOQUEADO!", COLOR_YELLOW)
		return false -- nega o dano por completo
	end

	return true
end
