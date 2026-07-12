function onUse(cid, item, frompos, item2, topos)
	if item.uid == 60150 then
		if getPlayerStorageValue(cid,60150) == -1 then
			doPlayerSendTextMessage(cid,25,"Voce ganhou uma Senzu Bean !")
			doPlayerAddItem(cid,12779,1)
			setPlayerStorageValue(cid,60150,1)
		else
			doPlayerSendTextMessage(cid,25,"Voce já recebeu seu item.")
		end
		return true
	end
end