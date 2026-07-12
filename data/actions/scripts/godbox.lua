local items =
 { --[numeração] = {id = ID DO ITEM, count = QUANTIDADE DO ITEM}
[1]={id=2144, count=1}, -- 
[2]={id=2144, count=10}, -- 
[3]={id=2144, count=20}, -- 
[4]={id=2144, count=30}, -- 
[5]={id=2144, count=40}, --
[6]={id=2144, count=50}, -- 
[7]={id=2144, count=60}, -- 
[8]={id=2144, count=70}, --
[9]={id=2144, count=80}, -- 
[10]={id=2144, count=90}, -- 
[11]={id=2144, count=100}, -- 
}
 
function onUse(cid, item, fromPosition, itemEx, toPosition)
                a = math.random(1, #items)
doPlayerAddItem(cid, items[a].id, items[a].count)
      doSendAnimatedText(getPlayerPosition(cid), "Box!", TEXTCOLOR_GREEN)
                doPlayerSendTextMessage(cid, 27, "Você abriu a box e ganhou "..items[a].count.."x "..getItemNameById(items[a].id)..(items[a].count > 1 and "s" or "")..".")
doRemoveItem(item.uid, 1)
return true
end