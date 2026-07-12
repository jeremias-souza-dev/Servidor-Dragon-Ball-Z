function onPrepareDeath(cid, lastHitKiller, mostDamageKiller)
if isPlayer(cid) == true then
if (getPlayerSlotItem(cid, 9).itemid == 12758) then
doCreatureSetDropLoot(cid, false)
return TRUE
end
end
return TRUE
end