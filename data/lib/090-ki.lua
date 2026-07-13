-- Sistema de Ki: reserva de energia vinculada ao level (nao cresce lutando).
-- O jogador controla quanto quer carregar via !charge; magias como o
-- Kamehameha consomem o Ki atual, enquanto a Genki Dama ignora o Ki e
-- canaliza usando Soul Points (ver ki_charge.lua, kamehameha.lua, genki dama.lua).
--
-- Ki/KiMax agora sao nativos no C++ (Creature::ki/kiMax, colunas `ki`/`kimax`
-- da tabela `players`, enviados ao cliente automaticamente via sendStats() —
-- ver creature.h/cpp, player.h/cpp, iologindata.cpp, protocolgame.cpp). Essas
-- funcoes Lua sao apenas wrappers convenientes sobre getCreatureKi/
-- getCreatureMaxKi/doCreatureAddKi.

KI_STORAGE_CHARGING = 90002
KI_SUPPRESSED_PERCENT = 0.05 -- Ki ao logar / fora de luta (energia oculta)

function getPlayerMaxKi(cid)
	return getCreatureMaxKi(cid)
end

function getPlayerCurrentKi(cid)
	return getCreatureKi(cid)
end

function doPlayerSetKi(cid, value)
	local maxKi = getPlayerMaxKi(cid)
	if value < 0 then
		value = 0
	elseif value > maxKi then
		value = maxKi
	end

	local delta = value - getPlayerCurrentKi(cid)
	if delta ~= 0 then
		doCreatureAddKi(cid, delta)
	end
	return value
end

function doPlayerSuppressKi(cid)
	return doPlayerSetKi(cid, math.floor(getPlayerMaxKi(cid) * KI_SUPPRESSED_PERCENT))
end

function doPlayerConsumeKi(cid, amount)
	local current = getPlayerCurrentKi(cid)
	if current < amount then
		return false
	end
	doCreatureAddKi(cid, -amount)
	return true
end

function isPlayerChargingKi(cid)
	return getPlayerStorageValue(cid, KI_STORAGE_CHARGING) == 1
end

function doPlayerSetChargingKi(cid, charging)
	doPlayerSetStorageValue(cid, KI_STORAGE_CHARGING, charging and 1 or 0)
end
