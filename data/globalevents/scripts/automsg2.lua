local messages = {
"Ajudem-nos a manter o servidor online, a sua contribuição é de grande importância, adquira benefícios através de sua doação! Visite o nosso site: http://dborox.ddns.net/ e fique por dentro das atualizações e de como efetuar o pagamento. Obrigado pela atenção, bom jogo a todos!"
}

local i = 0
function onThink(interval, lastExecution)
local message = messages[(i % #messages) + 1]
for _, pid in ipairs(getPlayersOnline()) do
doPlayerSendTextMessage(pid, 20, "".. message .."")
i = i + 1
end
return TRUE
end