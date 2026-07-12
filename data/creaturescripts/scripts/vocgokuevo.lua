function onThink(cid, interval)
local itemid = 2141
local outfit = {lookType = 651}
local outfit2 = {lookType = 656}
local outfit3 = {lookType = 651}

if isPlayer(cid) then
if getPlayerItemCount(cid, itemid) >= 1 then
if getPlayerStorageValue(cid,99023) == 4 and doCreatureChangeOutfit(cid, outfit2) and doPlayerRemoveItem(cid, itemid, 1) and addEvent(doRemoveCreature, 1, cid) then
doPlayerSetVocation(cid, 641)
elseif getPlayerStorageValue(cid,30023) == 4 and doCreatureChangeOutfit(cid, outfit3) and doPlayerRemoveItem(cid, itemid, 1) and addEvent(doRemoveCreature, 1, cid) then
doPlayerSetVocation(cid, 635)
elseif getPlayerStorageValue(cid,60150) == 1 and doCreatureChangeOutfit(cid, outfit) and doPlayerRemoveItem(cid, itemid, 1) and addEvent(doRemoveCreature, 1, cid) then
doPlayerSetVocation(cid, 632)
end
end
return true
end
end