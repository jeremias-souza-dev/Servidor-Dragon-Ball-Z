-- Logica compartilhada do "dash" de velocidade estilo Dragon Ball: o
-- personagem some e reaparece mais a frente numa direcao cardeal.
--
-- Modelo de custo:
--  - O KI e o fator PRINCIPAL: cada hop custa uma fatia do KiMax proporcional
--    a DISTANCIA percorrida naquele hop (ir mais longe custa mais).
--  - O LEVEL e um fator SECUNDARIO de eficiencia: pra uma MESMA distancia, um
--    personagem de level maior gasta menos Ki que um de level menor (a
--    "crianca" cansa mais que o "adulto" andando o mesmo tanto).
--  - Fadiga: dentro de uma UNICA cadeia de viagem (varios hops seguidos, ver
--    speed_dash_click.lua), cada hop subsequente fica progressivamente mais
--    caro que o anterior (andar 30km cansa desproporcionalmente mais que
--    andar 1km, nao e so "30x o custo de 1km"). Cada comando novo comeca a
--    fadiga do zero.
--
-- Usado por talkactions/scripts/speed_dash.lua (!speed manual, hopIndex=1)
-- e creaturescripts/scripts/speed_dash_click.lua (Ctrl+Shift+Click, hopIndex
-- cresce a cada hop dentro do mesmo clique).

DASH_BASE_KI_COST_PERCENT = 3 -- % do KiMax por tile de distancia percorrido (base, antes de eficiencia/fadiga)
DASH_FATIGUE_STEP = 0.20 -- cada hop na mesma cadeia fica 20% mais caro que o anterior
DASH_MAX_HOPS_PER_CLICK = 20

local DASH_DIRECTION_VECTOR = {
	[NORTH] = {x = 0, y = -1},
	[EAST]  = {x = 1, y = 0},
	[SOUTH] = {x = 0, y = 1},
	[WEST]  = {x = -1, y = 0},
}

-- Alcance maximo de UM hop -- capacidade fisica de "sumir e reaparecer",
-- escala com o level (fator secundario que tambem aumenta o alcance).
function getPlayerMaxDashDistance(cid)
	return math.min(15, 3 + math.floor(getPlayerLevel(cid) / 25))
end

-- Eficiencia energetica: >1 significa gasta MENOS Ki pra mesma distancia.
function getPlayerDashEfficiency(cid)
	return 1 + (getPlayerLevel(cid) / 200)
end

-- Custo em Ki (absoluto) de um hop de "distance" tiles, sendo o "hopIndex"-esimo
-- hop dentro da cadeia de viagem atual (1 = primeiro hop, sem fadiga extra).
function getPlayerDashCost(cid, distance, hopIndex)
	local fatigue = 1 + ((hopIndex - 1) * DASH_FATIGUE_STEP)
	local costPercent = (DASH_BASE_KI_COST_PERCENT * distance * fatigue) / getPlayerDashEfficiency(cid)
	return math.max(1, math.floor(getPlayerMaxKi(cid) * (costPercent / 100)))
end

local function isDashTileFree(pos)
	local tile = getTileInfo(pos)
	if not tile or not tile.uid or tile.uid == 0 then
		return false -- sem chao (buraco/vazio)
	end
	if tile.creatures > 0 then
		return false
	end
	return true
end

-- Tenta um dash na direcao dada (NORTH/EAST/SOUTH/WEST). Procura a MAIOR
-- distancia livre que o jogador consiga pagar (se nao der pra ir longe,
-- tenta uma distancia menor e mais barata antes de desistir). Retorna a
-- posicao de destino em caso de sucesso, ou nil se nem o hop minimo couber
-- no Ki disponivel ou nao houver espaco livre.
function doPlayerDashDirection(cid, direction, hopIndex)
	hopIndex = hopIndex or 1
	local vector = DASH_DIRECTION_VECTOR[direction]
	if not vector then
		return nil
	end

	local origin = getCreaturePosition(cid)
	local maxDistance = getPlayerMaxDashDistance(cid)

	for distance = maxDistance, 1, -1 do
		local candidate = {x = origin.x + (vector.x * distance), y = origin.y + (vector.y * distance), z = origin.z}
		if isDashTileFree(candidate) and isSightClear(origin, candidate, true) then
			local cost = getPlayerDashCost(cid, distance, hopIndex)
			if getPlayerCurrentKi(cid) >= cost then
				doPlayerConsumeKi(cid, cost)
				doSendMagicEffect(origin, CONST_ME_POFF)
				doTeleportThing(cid, candidate, false)
				doSendMagicEffect(candidate, CONST_ME_ENERGYAREA)
				return candidate
			end
			-- essa distancia ficou cara demais: tenta uma mais curta (mais barata) a seguir
		end
	end

	return nil
end
