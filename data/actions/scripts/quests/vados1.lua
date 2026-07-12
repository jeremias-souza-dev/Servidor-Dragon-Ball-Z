function onUse(cid, item, frompos, item2, topos)
	if item.uid == 6030 then
		if getPlayerStorageValue(cid,6030) == -1 then
			doPlayerSendTextMessage(cid,25,"Voce ganhou um Vados Staff!")
			doPlayerAddItem(cid,2436,1)
			setPlayerStorageValue(cid,6030,1)
		else
			doPlayerSendTextMessage(cid,25,"Voce j?? recebeu seu item.")
		end
		return true
	end
end