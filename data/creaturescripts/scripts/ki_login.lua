function onLogin(cid)
	doPlayerSuppressKi(cid)
	doPlayerSetChargingKi(cid, false)
	registerCreatureEvent(cid, "KiChargeInterrupt")
	registerCreatureEvent(cid, "GuardBlock")
	return true
end
