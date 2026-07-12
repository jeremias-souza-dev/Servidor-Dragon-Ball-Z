local items =
 { --[numeração] = {id = ID DO ITEM, count = QUANTIDADE DO ITEM}
[1]={id=2144, count=50}, -- 
[2]={id=2496, count=1}, -- 
[3]={id=2495, count=1}, -- 
[4]={id=2494, count=1}, -- 
[5]={id=2493, count=1}, --
[6]={id=2398, count=1}, -- 
[7]={id=2396, count=1}, -- 
[8]={id=2397, count=1}, --
[9]={id=12682, count=1}, -- 
[10]={id=12696, count=1}, -- 
[11]={id=12663, count=1}, -- 
}
 
function onUse(cid, item, fromPosition, itemEx, toPosition)
                a = math.random(1, #items)
doPlayerAddItem(cid, items[a].id, items[a].count)
      doSendAnimatedText(getPlayerPosition(cid), "Box!", TEXTCOLOR_GREEN)
                doPlayerSendTextMessage(cid, 27, "Você abriu a box e ganhou "..items[a].count.."x "..getItemNameById(items[a].id)..(items[a].count > 1 and "s" or "")..".")
doRemoveItem(item.uid, 1)
return true
end