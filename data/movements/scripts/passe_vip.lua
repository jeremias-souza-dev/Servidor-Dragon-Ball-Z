-- Creditos: Breno Neves (KotZletY) = Criador do Script!


function onStepIn(cid, item, position, fromPosition)
	
		if getPlayerPremiumDays(cid) >= 1 then
		doSendMagicEffect(getThingPos(cid), 4)
		doPlayerSendTextMessage(cid, 25, "Seja Bem-vindo ".. getPlayerName(cid) .." !")
	 
	 else
		
		doTeleportThing(cid, fromPosition, true)
		doSendMagicEffect(getThingPos(cid), 5)
		doPlayerSendTextMessage(cid, 25, "Apenas Players Vip's podem passa.")
	
	end
		
			return true
		
	end