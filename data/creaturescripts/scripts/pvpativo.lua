function onCombat(cid, target)
    if isPlayer(cid) and isPlayer(target) then
    	if getPlayerStorageValue(cid, 123456) == 1 then return false end
    end
    return true
end

function onTarget(cid,target)
	if isPlayer(cid) and isPlayer(target) then
		if getPlayerStorageValue(cid,123456) == 1 then
			doPlayerSendCancel(cid, "Reative o PVP para atacar um jogador.")
			return false
		end
	end
	return true
end

function onLogin(cid)
	registerCreatureEvent(cid, "PVPCombat")
	registerCreatureEvent(cid, "PVPTarget")
	return true
end