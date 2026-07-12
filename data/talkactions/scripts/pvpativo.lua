function onSay(cid, words, param, channel)

	if param == "" then
		return doPlayerSendCancel(cid, "Escolha se quer deixar o PVP on ou off.")
	end

	if isInArray({"on","off"}, param) then
		local value = param == "on" and 0 or 1
		local status = param == "on" and "ativou" or "desativou"
		doPlayerSetStorageValue(cid, 123456, value)
		doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Você "..status.." o PVP.")
	else
		doPlayerSendCancel(cid, "Escolha se quer deixar o PVP on ou off.")
	end
	return true
end