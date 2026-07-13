-- Relays chat messages posted on the website into the matching in-game
-- channel, attributed to the sender's own character (works even if that
-- character isn't currently online). See app/Http/Controllers/ChatController.php
-- and app/Console/Commands/RelayGameChat.php on the Laravel side.
local MSG_TYPE = MESSAGE_STATUS_DEFAULT

function onThink(interval, lastExecution)
    local result = db.getResult("SELECT * FROM `chat_messages` WHERE `source` = 'site' AND `game_processed_at` IS NULL ORDER BY `id` ASC LIMIT 20;")
    if result:getID() ~= -1 then
        while true do
            local id = tonumber(result:getDataInt("id"))
            local channelId = tonumber(result:getDataInt("channel_id"))
            local author = tostring(result:getDataString("author_name"))
            local message = tostring(result:getDataString("message"))

            doChannelBroadcast(channelId, author .. " (site)", message, MSG_TYPE)
            db.query("UPDATE `chat_messages` SET `game_processed_at` = NOW() WHERE `id` = " .. id .. ";")

            if not result:next() then
                break
            end
        end
        result:free()
    end
    return true
end
