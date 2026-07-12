local STORAGE = 30023 -- Storage necessária para viajar
local DESTINO = {x = 377, y = 250, z = 15} -- POSIÇÃO DE DESTINO
 
local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
 
function onCreatureAppear(cid)         npcHandler:onCreatureAppear(cid)         end
function onCreatureDisappear(cid)      npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)   npcHandler:onCreatureSay(cid, type, msg:lower())   end
function onThink()                  npcHandler:onThink()                  end
local talkState = {}
 
function creatureSayCallback(cid, type, msg)
   if(not npcHandler:isFocused(cid)) then
      return false
   end
 
   local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
	if msgcontains(msg, "reborn quest") then
		selfSay("Se for nao ha mais volta, tem certeza disso?", cid)
		talkState[talkUser] = 1
	elseif msgcontains(msg, "yes") and talkState[talkUser] == 1 then
		if (getPlayerStorageValue(cid,30023) ~= 4) then
			doSendMagicEffect(getThingPos(cid), 10)
			npcHandler:releaseFocus(cid)
			doTeleportThing(cid, DESTINO)
			doSendMagicEffect(DESTINO, 10)
		elseif getPlayerStorageValue(cid,30023) == 4 then
			selfSay("Desculpe, mas voce ja rebornou!", cid)
		end
	talkState[talkUser] = 0
	end
 
   return true
end
 
 
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())