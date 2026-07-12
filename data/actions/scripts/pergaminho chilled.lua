function onUse(cid, item, frompos, item2, topos)
local voc = 461 -- id da vocation que ele vai ser promovido
local outfit = 376
if item.itemid == 13566 then -- id do item que vai ter que clicar
doPlayerSetVocation(cid,voc)
doCreatureChangeOutfit(cid, {lookType = outfit})
doRemoveItem(item.uid,1)
doPlayerSendTextMessage(cid, 22, "Parabéns você trocou de vocation")
end
return true
end