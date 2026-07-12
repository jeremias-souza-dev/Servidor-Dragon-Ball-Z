function onUse(cid, item, frompos, item2, topos)

if getPlayerStorageValue(cid, 13589) < 1 then
doPlayerSendTextMessage(cid,22,"Voce Termino a Quest")
local bag = doPlayerAddItem(cid, 1999, 1)
doAddContainerItem(bag, 12633, 1)
doAddContainerItem(bag, 13394, 1)
doAddContainerItem(bag, 13395, 1)
doAddContainerItem(bag, 13396, 1)
setPlayerStorageValue(cid, 13589, 1)
else
doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Voce Ja Fez a Quest.")
end

return TRUE
end