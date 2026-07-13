function onStatsChange(cid, attacker, type, combat, value)
	if type == STATSCHANGE_HEALTHLOSS and value >= 1 and isPlayerChargingKi(cid) then
		doPlayerSetChargingKi(cid, false)
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Voce foi atingido e perdeu a concentracao! O carregamento de Ki foi interrompido.")
	end
	return true
end
