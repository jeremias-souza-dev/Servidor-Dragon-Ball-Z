function onSay(cid, words, param)
   if doPlayerRemoveMoney(cid, 0) then
      doPlayerAddItem(cid, 12761, 1)
      doSendMagicEffect(getThingPos(cid),13)
      doCreatureSay(cid, "Voce ganhou um blue capsule!", TALKTYPE_ORANGE_1)
   else
      doPlayerSendCancel(cid, "Você não tem dinheiro suficiente para comprar uma BOL.")
      doSendMagicEffect(getThingPos(cid), 2)
   end
  return true
end