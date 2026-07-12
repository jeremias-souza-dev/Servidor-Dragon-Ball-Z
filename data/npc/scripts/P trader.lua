local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}
function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end
function creatureSayCallback(cid, type, msg)
if(not npcHandler:isFocused(cid)) then
return false
end
local talkUser = NPCHANDLER_CONVbehavior == CONVERSATION_DEFAULT and 0 or cid
local shopWindow = {}
local t = {
          [5957] = 270, -- [id do item] = quantos pontos vai custar
          [2159] = 55,
          [2396] = 35,
          [2397] = 35,
          [2398] = 35,
          [2493] = 35,
          [2494] = 35,
          [2495] = 35,
          [2496] = 35,
		  [6104] = 1,
		  [4846] = 5,
          [2331] = 34
          }
local onBuy = function(cid, item, subType, amount, ignoreCap, inBackpacks)
if t[item] and getPoints(cid) < t[item] then
selfSay("Você precisa de "..t[item].." P points para comprar este item.", cid)
else
doPlayerRemovePoints(cid, t[item])
doPlayerAddItem(cid, item)
selfSay("Aqui esta seu item", cid)
end
return true
end
if (msgcontains(msg, 'trade') or msgcontains(msg, 'TRADE'))then
                        for var, ret in pairs(t) do
                                        table.insert(shopWindow, {id = var, subType = 0, buy = ret, sell = 0, name = getItemNameById(var)})
                                end
                        openShopWindow(cid, shopWindow, onBuy, onSell)
                end
return true
end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())