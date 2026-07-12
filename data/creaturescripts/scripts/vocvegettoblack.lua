function onThink(cid, interval)
local itemid = 6125
local outfit = {lookType = 630}
local outfit2 = {lookType = 635}
local outfit3 = {lookType = 630}

if isPlayer(cid) then
if getPlayerItemCount(cid, itemid) >= 1 then
if getPlayerStorageValue(cid,99023) == 4 and doCreatureChangeOutfit(cid, outfit2) and doPlayerRemoveItem(cid, itemid, 1) and addEvent(doRemoveCreature, 1, cid) then
doPlayerSetVocation(cid, 601)
elseif getPlayerStorageValue(cid,30023) == 4 and doCreatureChangeOutfit(cid, outfit3) and doPlayerRemoveItem(cid, itemid, 1) and addEvent(doRemoveCreature, 1, cid) then
doPlayerSetVocation(cid, 595)
elseif getPlayerStorageValue(cid,60150) == 1 and doCreatureChangeOutfit(cid, outfit) and doPlayerRemoveItem(cid, itemid, 1) and addEvent(doRemoveCreature, 1, cid) then
doPlayerSetVocation(cid, 592)
end
end
return true
end
end