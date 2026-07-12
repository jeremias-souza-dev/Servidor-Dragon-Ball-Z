function onUse(cid, item, fromPosition, itemEx, toPosition)
ITEM = 12780
local storage = 50000
local wait = 1.5
local pos1 = {x = getPlayerPosition(cid).x, y = getPlayerPosition(cid).y + 0, z = getPlayerPosition(cid).z}
if fromPosition.x ~= CONTAINER_POSITION and exhaustion.get(cid, storage) == FALSE then
REG_HEALTH = 125000
REG_MANA = 125000
doPlayerAddMana(cid, REG_MANA)
doCreatureAddHealth(cid, REG_HEALTH)
doCreatureSay(cid, 'I feel much better!!!!', TALKTYPE_ORANGE_1)
doSendMagicEffect(pos1, 103)
exhaustion.set(cid, storage, wait)
elseif item.itemid == ITEM and exhaustion.get(cid, storage) == FALSE then
REG_HEALTH = 125000
REG_MANA = 125000
doPlayerAddMana(cid, REG_MANA)
doRemoveItem(item.uid, 1)
doCreatureAddHealth(cid, REG_HEALTH)
doCreatureSay(cid, 'I feel much better!!!!', TALKTYPE_ORANGE_1)
doSendMagicEffect(pos1, 103)
exhaustion.set(cid, storage, wait)
else
doPlayerSendCancel(cid, "You are exhausted.")
end
return TRUE
end