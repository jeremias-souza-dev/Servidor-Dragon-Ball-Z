--[[
P Points System by LsM.
OTServ Brasil © 2011
Version : v1.0
]]--

function onLogin(cid)
    doCreatureSetStorage(cid, 1219, os.time())
	return true
end

function onLogout(cid)
    doCreatureSetStorage(cid, 1219, 0)
    return true
end