-- Illusion Quest por Dyego

function onUse(cid, item, frompos, item2, topos)
if item.uid == 20019 then
queststatus = getPlayerStorageValue(cid,20019)
if queststatus == -1 then
doPlayerSendTextMessage(cid,22,"Voce ganhou Demonic Gloves.")
doPlayerAddItem(cid,12714,1)
setPlayerStorageValue(cid,20019,1)
else
doPlayerSendTextMessage(cid,22,"Esta Vazio.")
end
elseif item.uid == 20020 then
queststatus = getPlayerStorageValue(cid,20019)
if queststatus == -1 then
doPlayerSendTextMessage(cid,22,"Voce ganhou Demonic Sword.")
doPlayerAddItem(cid,13466,1)
setPlayerStorageValue(cid,20019,1)
else
doPlayerSendTextMessage(cid,22,"Esta Vazio.")
end
return 0
end
return 1
end