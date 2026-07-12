function onUse(cid, item, frompos, item2, topos)
local voc = 449 -- id da vocation que ele vai ser promovido
local outfit = 364
if item.itemid == 13568 then -- id do item que vai ter que clicar
doPlayerSetVocation(cid,voc)
doCreatureChangeOutfit(cid, {lookType = outfit})
doRemoveItem(item.uid,1)
doPlayerSendTextMessage(cid, 22, "Parabéns você trocou de vocation")
end
return true
end