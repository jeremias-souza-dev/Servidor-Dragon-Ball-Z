function onSay(cid, words, param)

if (getPlayerStorageValue(cid,100023) ~= 1 and (getPlayerLevel(cid) >= 800)) then
doPlayerAddExp(cid, getExperienceForLevel(100)-getPlayerExperience(cid))
doCreatureAddMana(cid, getCreatureMaxMana(cid)-getCreatureMana(cid))
doCreatureAddHealth(cid, getCreatureMaxHealth(cid)-getCreatureHealth(cid))
setPlayerStorageValue(cid,100023,1)
doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "Voce resetou!")
doRemoveCreature(cid)
else
doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "Voce ja tem 1 reset ou nao esta level 800.")
end
end