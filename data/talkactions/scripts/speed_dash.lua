-- "Velocidade" estilo Dragon Ball: !speed faz um dash manual na direcao que
-- o personagem esta olhando. Para viajar longas distancias com um clique,
-- veja creaturescripts/scripts/speed_dash_click.lua (Ctrl+Shift+Click).
local COOLDOWN_SECONDS = 3
local EXHAUST_ID = 91101

function onSay(cid, words, param)
	if exhaustion.check(cid, EXHAUST_ID) == TRUE then
		doPlayerSendCancel(cid, "Aguarde " .. (COOLDOWN_SECONDS - (os.time() - getPlayerStorageValue(cid, EXHAUST_ID))) .. " segundos.")
		return false
	end

	if not doPlayerDashDirection(cid, getCreatureLookDirection(cid)) then
		doPlayerSendCancel(cid, "Ki insuficiente ou sem espaco livre nessa direcao.")
		return false
	end

	exhaustion.set(cid, EXHAUST_ID, COOLDOWN_SECONDS)
	return false
end
