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
	if msgcontains(msg, "yes") then
		selfSay("Voce quer se tornar um Zeno?{quero}", cid)
		talkState[talkUser] = 1
	elseif (msgcontains(msg, "quero") and talkState[talkUser] == 1) and (getPlayerItemCount(cid, 13540) >= 1) then
		doPlayerRemoveItem(cid, 13540, 1)
        doPlayerAddItem(cid, 2139, 1)
		selfSay("Obrigado, Agora voce podera virar um Zeno !", cid)
		talkState[talkUser] = 0
	elseif (msgcontains(msg, "quero") and talkState[talkUser] == 1) and (getPlayerItemCount(cid, 13540) <= 0) then
		selfSay("Desculpe, voce não tem uma Prismatic Stone.", cid)
		talkState[talkUser] = 0
	end
   return true
end
 
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())