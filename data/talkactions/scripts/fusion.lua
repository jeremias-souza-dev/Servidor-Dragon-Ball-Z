-- Sistema de Fusao: os dois jogadores controlam o MESMO personagem ao mesmo
-- tempo. Mecanica de rede: a conexao do convidado e realocada para apontar
-- pro Player do anfitriao (doPlayerStartFusion, nativo em C++), reaproveitando
-- o sistema de Cast (cSpectators) ja existente pra espelhar toda saida.
--
-- Uso: os dois jogadores dizem "!fusion <nome do outro>" dentro de 10
-- segundos um do outro. Quem tiver o maior level vira o "anfitriao" (o corpo
-- que fica visivel no mapa); o outro (convidado) tem seu corpo teleportado
-- pra um ponto fixo e fica invisivel enquanto sua conexao controla o corpo
-- fundido. "!unfusion" desfaz.
--
-- Isso e uma primeira versao funcional: a distincao completa entre Metamoru
-- (restricoes de level, timer que anda mais rapido gastando Ki) e Potara
-- (soma total de HP/Mana/Ki, timer fixo) fica para uma proxima etapa —
-- aqui o Ki simplesmente soma no anfitriao (limitado ao KiMax dele).

local FUSION_REQUEST_STORAGE = 91001 -- guarda o time() do pedido
local FUSION_REQUEST_TARGET_STORAGE = 91002 -- guarda o playerId do alvo pedido
local FUSION_GUEST_STORAGE = 91003 -- no anfitriao: guarda o playerId do convidado
local FUSION_HOST_STORAGE = 91004 -- no convidado: guarda o playerId do anfitriao
local FUSION_LIMBO_POS = {x = 1000, y = 1000, z = 7} -- ponto fixo pra "guardar" o corpo do convidado

local FUSION_REQUEST_WINDOW = 10 -- segundos pra ambos dizerem !fusion

-- Avisa o cliente (via extended opcode, ver otclient-mobile/modules/game_interface/
-- gameinterface.lua) se o jogador esta fundido agora, pra ele esconder/mostrar
-- a opcao "Fazer fusao" no menu de clique direito.
local FUSION_STATE_OPCODE = 213
local function notifyFusionState(cid, isFused)
	doSendPlayerExtendedOpcode(cid, FUSION_STATE_OPCODE, isFused and "1" or "0")
end

function onSay(cid, words, param)
	if words == "!unfusion" then
		local hostId = getPlayerStorageValue(cid, FUSION_HOST_STORAGE)
		local guestId = getPlayerStorageValue(cid, FUSION_GUEST_STORAGE)

		local guest, host
		if hostId > 0 then
			-- quem disse o comando e o convidado
			guest, host = cid, hostId
		elseif guestId > 0 then
			-- quem disse o comando e o anfitriao
			guest, host = guestId, cid
		else
			doPlayerSendCancel(cid, "Voce nao esta fundido com ninguem.")
			return false
		end

		if not isCreature(guest) or not isCreature(host) then
			doPlayerSendCancel(cid, "O parceiro de fusao nao esta mais online.")
			return false
		end

		doPlayerEndFusion(guest)

		-- tile livre do lado do anfitriao, nao encima dele (senao os dois
		-- ficam empilhados no mesmo quadrado, sprites sobrepostos)
		local hostPos = getCreaturePosition(host)
		local freePos = getClosestFreeTile(guest, hostPos, true)
		doTeleportThing(guest, freePos or hostPos)
		doRemoveCondition(guest, CONDITION_INVISIBLE)

		doPlayerSetStorageValue(host, FUSION_GUEST_STORAGE, -1)
		doPlayerSetStorageValue(guest, FUSION_HOST_STORAGE, -1)

		doPlayerSendTextMessage(host, MESSAGE_STATUS_CONSOLE_BLUE, "A fusao foi desfeita.")
		doPlayerSendTextMessage(guest, MESSAGE_STATUS_CONSOLE_BLUE, "A fusao foi desfeita.")

		notifyFusionState(host, false)
		notifyFusionState(guest, false)
		return false
	end

	-- !fusion <nome>
	if param == "" then
		doPlayerSendCancel(cid, "Use: !fusion nomeDoParceiro")
		return false
	end

	local target = getPlayerByNameWildcard(param)
	if not target or not isPlayer(target) or target == cid then
		doPlayerSendCancel(cid, "Jogador nao encontrado.")
		return false
	end

	if getPlayerStorageValue(cid, FUSION_GUEST_STORAGE) > 0 or getPlayerStorageValue(cid, FUSION_HOST_STORAGE) > 0 then
		doPlayerSendCancel(cid, "Voce ja esta fundido. Use !unfusion primeiro.")
		return false
	end

	-- o alvo ja pediu fusao com este jogador dentro da janela de tempo?
	local targetRequestTime = getPlayerStorageValue(target, FUSION_REQUEST_STORAGE)
	local targetRequestWho = getPlayerStorageValue(target, FUSION_REQUEST_TARGET_STORAGE)

	if targetRequestWho == getPlayerGUID(cid) and (os.time() - targetRequestTime) <= FUSION_REQUEST_WINDOW then
		-- fusao confirmada! decide quem e o anfitriao (maior level)
		local host, guest = cid, target
		if getPlayerLevel(target) > getPlayerLevel(cid) then
			host, guest = target, cid
		end

		doPlayerSetStorageValue(cid, FUSION_REQUEST_STORAGE, -1)
		doPlayerSetStorageValue(target, FUSION_REQUEST_STORAGE, -1)

		-- esconde o corpo original do convidado ANTES de redirecionar a conexao
		-- (doPlayerStartFusion). doPlayerStartFusion reenvia pro cliente do
		-- convidado um snapshot completo do mapa ao redor do anfitriao (pra
		-- resincronizar); se o convidado ainda estivesse visivel/no lugar
		-- antigo nesse momento, esse snapshot capturava o corpo dele "preso"
		-- ali, e o pacote de remocao/invisibilidade que vem DEPOIS acaba
		-- passando pela mesma conexao (agora apontando pro anfitriao) e se
		-- perde - dai os dois corpos aparecerem sobrepostos durante a fusao.
		local guestOriginalPos = getCreaturePosition(guest)
		local limboPos = getClosestFreeTile(guest, FUSION_LIMBO_POS, true) or FUSION_LIMBO_POS
		doTeleportThing(guest, limboPos)
		local invisible = createConditionObject(CONDITION_INVISIBLE)
		setConditionParam(invisible, CONDITION_PARAM_TICKS, -1)
		doAddCondition(guest, invisible)

		if not doPlayerStartFusion(guest, host) then
			doRemoveCondition(guest, CONDITION_INVISIBLE)
			doTeleportThing(guest, guestOriginalPos)
			doPlayerSendCancel(cid, "Nao foi possivel iniciar a fusao.")
			return false
		end

		-- soma o Ki do convidado no anfitriao (limitado ao KiMax do anfitriao)
		doPlayerSetKi(host, getPlayerCurrentKi(host) + getPlayerCurrentKi(guest))

		doPlayerSetStorageValue(host, FUSION_GUEST_STORAGE, getPlayerGUID(guest))
		doPlayerSetStorageValue(guest, FUSION_HOST_STORAGE, getPlayerGUID(host))

		doPlayerSendTextMessage(host, MESSAGE_STATUS_CONSOLE_BLUE, "Fusao iniciada! Voce e " .. getCreatureName(guest) .. " agora controlam o mesmo corpo. Diga !unfusion para desfazer.")
		doPlayerSendTextMessage(guest, MESSAGE_STATUS_CONSOLE_BLUE, "Fusao iniciada! Voce agora controla o corpo de " .. getCreatureName(host) .. ". Diga !unfusion para desfazer.")

		notifyFusionState(host, true)
		notifyFusionState(guest, true)
		return false
	end

	-- registra o pedido e espera o outro confirmar
	doPlayerSetStorageValue(cid, FUSION_REQUEST_STORAGE, os.time())
	doPlayerSetStorageValue(cid, FUSION_REQUEST_TARGET_STORAGE, getPlayerGUID(target))
	doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Pedido de fusao enviado. " .. getCreatureName(target) .. " precisa aceitar em ate " .. FUSION_REQUEST_WINDOW .. " segundos.")

	-- abre o modal nativo (Aceitar/Recusar) no cliente do convidado; aceitar
	-- reenvia "!fusion <nome>" automaticamente (ver Game::playerAnswerFusionModal)
	doPlayerSendFusionInvite(target, getCreatureName(cid))
	return false
end
