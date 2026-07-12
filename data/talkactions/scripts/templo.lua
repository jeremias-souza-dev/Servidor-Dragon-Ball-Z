function onSay(cid, words, param)

local pos = {x=99, y=188, z=7}
 
 if getCreatureCondition(cid, CONDITION_INFIGHT) then
  doPlayerSendCancel(cid, "Voce nao pode fazer isso em luta")

 else 
 
         doSendMagicEffect(getPlayerPosition(cid),53)
         doPlayerSendCancel(cid,"Voce foi teleportado Com Sucesso")
         doTeleportThing(cid,pos)
end

return true 
end