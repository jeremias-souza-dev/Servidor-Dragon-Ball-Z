function onThink(cid, interval)
local itemid = 2139
local outfit = {lookType = 641}
local outfit2 = {lookType = 646}
local outfit3 = {lookType = 641}

if isPlayer(cid) then
if getPlayerItemCount(cid, itemid) >= 1 then
if getPlayerStorageValue(cid,99023) == 4 and doCreatureChangeOutfit(cid, outfit2) and doPlayerRemoveItem(cid, itemid, 1) and addEvent(doRemoveCreature, 1, cid) then
doPlayerSetVocation(cid, 631)
elseif getPlayerStorageValue(cid,30023) == 4 and doCreatureChangeOutfit(cid, outfit3) and doPlayerRemoveItem(cid, itemid, 1) and addEvent(doRemoveCreature, 1, cid) then
doPlayerSetVocation(cid, 625)
elseif getPlayerStorageValue(cid,60150) == 1 and doCreatureChangeOutfit(cid, outfit) and doPlayerRemoveItem(cid, itemid, 1) and addEvent(doRemoveCreature, 1, cid) then
doPlayerSetVocation(cid, 622)
end
end
return true
end
end