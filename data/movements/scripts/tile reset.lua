function onStepIn(cid, item, position, fromPosition)
	
		if getPlayerStorageValue(cid,100023) == 1 then
		doSendMagicEffect(getThingPos(cid), 12)
		doPlayerSendTextMessage(cid, 25, "Seja Bem-vindo ".. getPlayerName(cid) .." !")
	 
	 else
		
		doTeleportThing(cid, fromPosition, true)
		doSendMagicEffect(getThingPos(cid), 2)
		doPlayerSendTextMessage(cid, 25, "Apenas Players com reset podem passa.")
	
	end
		
			return true
		
	end