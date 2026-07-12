function onUse(cid, item, frompos, item2, topos)
local voc = 425 -- id da vocation que ele vai ser promovido
local outfit = 343
if item.itemid == 13558 then -- id do item que vai ter que clicar
doPlayerSetVocation(cid,voc)
doCreatureChangeOutfit(cid, {lookType = outfit})
doRemoveItem(item.uid,1)
doPlayerSendTextMessage(cid, 22, "Parabéns você trocou de vocation")
end
return true
end