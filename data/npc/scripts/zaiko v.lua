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
	if msgcontains(msg, "zaiko") then
		selfSay("Voce tem certeza que quer virar zaiko ?", cid)
		talkState[talkUser] = 1
	elseif (msgcontains(msg, "yes") and talkState[talkUser] == 1) and (getPlayerItemCount(cid, 2147) <= 499) then
		selfSay("Desculpe, voce precisa ter 500 small rubies.", cid)
		talkState[talkUser] = 1
	elseif (msgcontains(msg, "yes") and talkState[talkUser] == 1) and (getPlayerItemCount(cid, 2147) >= 500) then
		doPlayerRemoveItem(cid, 2147, 500)
        doPlayerAddItem(cid, 13490, 1)
		selfSay("Obrigado, Agora voce podera virar Zaiko !", cid)
		talkState[talkUser] = 0
	end
   return true
end
 
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())