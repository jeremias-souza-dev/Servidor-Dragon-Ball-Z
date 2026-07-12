function onThink(cid, interval)
local itemid = 13486
local outfit = {lookType = 316}
local outfit2 = {lookType = 596}

if isPlayer(cid) then
if getPlayerItemCount(cid, itemid) >= 1 then
if getPlayerStorageValue(cid,99023) == 4 and doCreatureChangeOutfit(cid, outfit2) and doPlayerRemoveItem(cid, itemid, 1) and addEvent(doRemoveCreature, 1, cid) then
doPlayerSetVocation(cid, 498)
elseif getPlayerStorageValue(cid,30023) == 4 and doCreatureChangeOutfit(cid, outfit) and doPlayerRemoveItem(cid, itemid, 1) and addEvent(doRemoveCreature, 1, cid) then
doPlayerSetVocation(cid, 405)
elseif getPlayerStorageValue(cid,60150) == 1 and doCreatureChangeOutfit(cid, outfit) and doPlayerRemoveItem(cid, itemid, 1) and addEvent(doRemoveCreature, 1, cid) then
doPlayerSetVocation(cid, 400)
end
end
return true
end
end