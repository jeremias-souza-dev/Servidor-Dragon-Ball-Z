function onUse(cid, item, frompos, item2, topos)
	if item.uid == 6029 then
		if getPlayerStorageValue(cid,6029) == -1 then
			doPlayerSendTextMessage(cid,25,"Voce ganhou um Strange Symbol!")
			doPlayerAddItem(cid,2174,1)
			setPlayerStorageValue(cid,6029,1)
		else
			doPlayerSendTextMessage(cid,25,"Voce já recebeu seu item.")
		end
		return true
	end
end