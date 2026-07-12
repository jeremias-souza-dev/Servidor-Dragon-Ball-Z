function onSay(cid, words, param, channel)
	local getP = getPoints(cid)
	doPlayerPopupFYI(cid, "Você tem ".. getP .." P points.")
	return true
end