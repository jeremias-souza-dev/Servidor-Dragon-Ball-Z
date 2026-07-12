function onCombat(cid, target)
    if isPlayer(target) and isInParty(cid) and isInParty(target) then
        if getPlayerParty(target) == getPlayerParty(cid) or getPartyLeader(target) == cid then return false end
    end
    return true
end