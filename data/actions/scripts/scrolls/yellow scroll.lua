local lvl = 2  
local text = "Parabéns! Voce ganhou "..lvl.." level."
function onUse(cid, item, fromPosition, itemEx, toPosition)
doPlayerAddLevel(cid, lvl)
doCreatureSay(cid, text, 19)
doSendMagicEffect(getCreaturePosition(cid), 115)
doRemoveItem(cid, item.uid, 1)
return true
end