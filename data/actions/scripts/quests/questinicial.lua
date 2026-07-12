function onUse(cid, item, frompos, item2, topos)

if getPlayerStorageValue(cid, 9999) < 1 then
doPlayerSendTextMessage(cid,22,"Voce Termino a Quest")
local bag = doPlayerAddItem(cid, 1999, 1)
doAddContainerItem(bag, 12627, 1)
doAddContainerItem(bag, 12655, 1)
doAddContainerItem(bag, 12779, 200)
doAddContainerItem(bag, 12675, 1)
doAddContainerItem(bag, 12693, 1)
doAddContainerItem(bag, 12728, 1)
doAddContainerItem(bag, 2160, 20)
doAddContainerItem(bag, 12713, 1)
setPlayerStorageValue(cid, 9999, 1)
else
doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Voce Ja Fez a Quest.")
end

return TRUE
end