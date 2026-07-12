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
	if msgcontains(msg, "king vegeta") then
		selfSay("Voce tem certeza que quer virar king vegeta ?", cid)
		talkState[talkUser] = 1
	elseif (msgcontains(msg, "yes") and talkState[talkUser] == 1) and (getPlayerItemCount(cid, 9970) >= 500) then
		doPlayerRemoveItem(cid, 9970, 500)
        doPlayerAddItem(cid, 13488, 1)
		selfSay("Obrigado, Agora você podera virar king vegeta !", cid)
		talkState[talkUser] = 0
	elseif (msgcontains(msg, "yes") and talkState[talkUser] == 1) and (getPlayerItemCount(cid, 9970) <= 499) then
		selfSay("Desculpe, voce precisa ter 500 small topaz.", cid)
		talkState[talkUser] = 0
	end
   return true
end
 
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())