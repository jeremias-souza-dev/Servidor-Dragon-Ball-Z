function onThink(cid, interval)
local itemid = 13487
local outfit = {lookType = 330}
local outfit2 = {lookType = 536}

if isPlayer(cid) then
if getPlayerItemCount(cid, itemid) >= 1 then
if getPlayerStorageValue(cid,99023) == 4 and doCreatureChangeOutfit(cid, outfit2) and doPlayerRemoveItem(cid, itemid, 1) and addEvent(doRemoveCreature, 1, cid) then
doPlayerSetVocation(cid, 526)
elseif getPlayerStorageValue(cid,30023) == 4 and doCreatureChangeOutfit(cid, outfit) and doPlayerRemoveItem(cid, itemid, 1) and addEvent(doRemoveCreature, 1, cid) then
doPlayerSetVocation(cid, 418)
elseif getPlayerStorageValue(cid,60150) == 1 and doCreatureChangeOutfit(cid, outfit) and doPlayerRemoveItem(cid, itemid, 1) and addEvent(doRemoveCreature, 1, cid) then
doPlayerSetVocation(cid, 413)
end
end
return true
end
end