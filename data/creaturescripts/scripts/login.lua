local config = {
	loginMessage = getConfigValue('loginMessage'),
	useFragHandler = getBooleanFromString(getConfigValue('useFragHandler'))
}

function onLogin(cid)
registerCreatureEvent(cid, "onPrepareDeathinifi")
	local loss = getConfigValue('deathLostPercent')
	if(loss ~= nil) then
		doPlayerSetLossPercent(cid, PLAYERLOSS_EXPERIENCE, loss * 10)
	end
		local lastLogin, str = getPlayerLastLoginSaved(cid), config.loginMessage
		if(lastLogin > 0) then
			doPlayerSendTextMessage(cid, MESSAGE_STATUS_DEFAULT, str)
			str = "Your last visit was on " .. os.date("%a %b %d %X %Y", lastLogin) .. "."
		else
									setPlayerStorageValue(cid, 30024, 0)
		end


	if(not isPlayerGhost(cid)) then
		doSendMagicEffect(getCreaturePosition(cid), CONST_ME_TELEPORT)
	end

	registerCreatureEvent(cid, "Mail")
	registerCreatureEvent(cid, "SkullCheck")
	registerCreatureEvent(cid, "NoPartyAttack")
	registerCreatureEvent(cid, "TiraBattle")
	registerCreatureEvent(cid, "Idle")
	if(config.useFragHandler) then
		registerCreatureEvent(cid, "SkullCheck")
		registerCreatureEvent(cid, "Reward")
	end
	registerCreatureEvent(cid, "FullHpMana")
	registerCreatureEvent(cid, "AdvanceSave")
	registerCreatureEvent(cid, "ZombieAttack")
	registerCreatureEvent(cid, "BlessCheck")
	registerCreatureEvent(cid, "advance")
	registerCreatureEvent(cid, "SkullCheck")
	registerCreatureEvent(cid, "ReportBug")
	registerCreatureEvent(cid,"Outfit")
	registerCreatureEvent(cid, "FragReward")
	registerCreatureEvent(cid, "Niwdeath")
	registerCreatureEvent(cid, "AdvanceSave")
	registerCreatureEvent(cid, "LevelRecompense")
	registerCreatureEvent(cid, "BoasVindas")
	registerCreatureEvent(cid, "BroadDeath")
	registerCreatureEvent(cid, "SaveStamina")
	registerCreatureEvent(cid, "Vip")
	--------- SHOP ---------
	registerCreatureEvent(cid, "VocShenron")
	registerCreatureEvent(cid, "VocVegetto")
	registerCreatureEvent(cid, "VocTapion")
	registerCreatureEvent(cid, "VocKame")
	registerCreatureEvent(cid, "VocKagome")
	registerCreatureEvent(cid, "VocKingVegeta")
	registerCreatureEvent(cid, "VocZaiko")
	registerCreatureEvent(cid, "VocChilled")
	registerCreatureEvent(cid, "VocC8")
	registerCreatureEvent(cid, "VocGoku")
	registerCreatureEvent(cid, "VocBills")
	registerCreatureEvent(cid, "VocFreeza")
	registerCreatureEvent(cid, "VocZamasu")
	registerCreatureEvent(cid, "VocWhiss")
	registerCreatureEvent(cid, "VocGogeta")
	registerCreatureEvent(cid, "VocVados")
	registerCreatureEvent(cid, "VocVegettoblack")
	registerCreatureEvent(cid, "VocVegettoblue")
	registerCreatureEvent(cid, "VocGokuevo")
	registerCreatureEvent(cid, "VocZeno")
	registerCreatureEvent(cid, "RemovedorDeFrags")
	--------------- REFLECT ----------------
	registerCreatureEvent(cid, "Reflect")
	if getPlayerStorageValue(cid, 3482101) ~= 0 then
			setPlayerStorageValue(cid, 3482101, 0) 
	end

return true
end