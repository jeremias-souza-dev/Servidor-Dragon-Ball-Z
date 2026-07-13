-- "Guarda levantada": quando alguem muito mais forte se prepara pra
-- defender, ele consegue esquivar/bloquear o ataque do adversario quase sem
-- esforco -- classico do Dragon Ball. A logica de bloqueio em si fica em
-- creaturescripts/scripts/guard_block.lua; aqui so ligamos/desligamos a
-- postura.
GUARD_STORAGE = 91201

function onSay(cid, words, param)
	local guarding = getPlayerStorageValue(cid, GUARD_STORAGE) == 1
	if guarding then
		doPlayerSetStorageValue(cid, GUARD_STORAGE, 0)
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Voce abaixou a guarda.")
	else
		doPlayerSetStorageValue(cid, GUARD_STORAGE, 1)
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Voce levantou a guarda. Contra adversarios mais fracos, voce vai esquivar/bloquear a maioria dos golpes (gasta um pouco de Ki por bloqueio).")
		doSendMagicEffect(getCreaturePosition(cid), CONST_ME_YELLOW_RINGS)
	end
	return false
end
