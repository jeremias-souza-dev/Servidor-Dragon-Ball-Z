function prepareShutdown(minutes)
        if(minutes <= 0) then
                doSetGameState(GAMESTATE_SHUTDOWN)
                return false
        end

        if(minutes == 1) then
                doBroadcastMessage("Server vai reiniciar em " .. minutes .. " minutos para dar save. Va para um lugar seguro !")
        elseif(minutes <= 3) then
                doBroadcastMessage("Server vai reiniciar em " .. minutes .. " minutos para dar save. Va para um lugar seguro !")
        else
                doBroadcastMessage("Server vai reiniciar em " .. minutes .. " minutes para dar save.")
        end

        shutdownEvent = addEvent(prepareShutdown, 60000, minutes - 1)
        return true
end

function onTime()
    return prepareShutdown(5) -- Quantos minutos pra executar o ServeSave. 
end