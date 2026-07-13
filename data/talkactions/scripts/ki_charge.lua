local KI_CHARGE_TICK_MS = 1000
local KI_CHARGE_RATE_PERCENT = 15 -- % do MaxKi ganho a cada tick

local function chargeTick(cid, pos)
	if not isPlayer(cid) or not isPlayerChargingKi(cid) then
		return
	end

	local currentPos = getCreaturePosition(cid)
	if currentPos.x ~= pos.x or currentPos.y ~= pos.y or currentPos.z ~= pos.z then
		doPlayerSetChargingKi(cid, false)
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Voce se moveu e perdeu a concentracao!")
		return
	end

	local maxKi = getPlayerMaxKi(cid)
	local gain = math.floor(maxKi * (KI_CHARGE_RATE_PERCENT / 100))
	local newKi = doPlayerSetKi(cid, getPlayerCurrentKi(cid) + gain)
	doSendMagicEffect(currentPos, CONST_ME_MAGIC_BLUE)

	if newKi >= maxKi then
		doPlayerSetChargingKi(cid, false)
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Seu Ki atingiu o maximo!")
		return
	end

	addEvent(chargeTick, KI_CHARGE_TICK_MS, cid, pos)
end

function onSay(cid, words, param)
	if words == "!ki" then
		local current, max = getPlayerCurrentKi(cid), getPlayerMaxKi(cid)
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Ki: " .. current .. "/" .. max .. " (" .. math.floor((current / max) * 100) .. "%)")
		return false
	end

	-- words == "!charge": diga novamente para parar de carregar
	if isPlayerChargingKi(cid) then
		doPlayerSetChargingKi(cid, false)
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Voce parou de carregar Ki.")
		return false
	end

	if getPlayerCurrentKi(cid) >= getPlayerMaxKi(cid) then
		doPlayerSendCancel(cid, "Seu Ki ja esta no maximo.")
		return false
	end

	doPlayerSetChargingKi(cid, true)
	doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Voce comeca a carregar seu Ki... (fique parado; diga !charge de novo para parar)")
	addEvent(chargeTick, KI_CHARGE_TICK_MS, cid, getCreaturePosition(cid))
	return false
end
