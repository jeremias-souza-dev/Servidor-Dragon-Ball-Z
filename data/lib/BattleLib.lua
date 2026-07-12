_Lib_Battle_Info = {
Reward = {2160,100},
Reward2 = {12780,300},
TeamOne = {name = "Demonics", storage = 140120, pos = {x=696,y=647,z=15}},
TeamTwo = {name = "Saiyajins",storage = 140121,pos = {x=759,y=688,z=15}},
storage_count = 180400,
tpPos = {x=662, y=391, z=7},
limit_Time = 10 -- em minutos
}

function resetBattle()
return setGlobalStorageValue(_Lib_Battle_Info.TeamOne.storage, 0) and setGlobalStorageValue(_Lib_Battle_Info.TeamTwo.storage, 0)
end

function OpenWallBattle()
local B = {
-- Demonics
{1524,{x=695, y=664, z=15, stackpos = 1}},
{1524,{x=696, y=664, z=15, stackpos = 1}},
{1524,{x=697, y=664, z=15, stackpos = 1}},
{1524,{x=698, y=664, z=15, stackpos = 1}},
{1526,{x=708, y=660, z=15, stackpos = 1}},
{1526,{x=708, y=652, z=15, stackpos = 1}},
{1526,{x=708, y=651, z=15, stackpos = 1}},
{1526,{x=708, y=650, z=15, stackpos = 1}},
{1526,{x=708, y=649, z=15, stackpos = 1}},
-- Saiyajins
{1526,{x=744, y=691, z=15, stackpos = 1}},
{1526,{x=744, y=690, z=15, stackpos = 1}},
{1526,{x=744, y=689, z=15, stackpos = 1}},
{1526,{x=744, y=688, z=15, stackpos = 1}},
{1526,{x=744, y=679, z=15, stackpos = 1}},
{1524,{x=755, y=675, z=15, stackpos = 1}},
{1524,{x=756, y=675, z=15, stackpos = 1}},
{1524,{x=757, y=675, z=15, stackpos = 1}},
{1524,{x=758, y=675, z=15, stackpos = 1}}
}
for i = 1, #B do
if getTileItemById(B[i][2], B[i][1]).uid == 0 then
doCreateItem(B[i][1], 1, B[i][2])
else
doRemoveItem(getThingfromPos(B[i][2]).uid,1)
end
end
end

function doBroadCastBattle(type,msg)
local players = {}
for _, cid in pairs(getPlayersOnline()) do
if getPlayerStorageValue(cid, _Lib_Battle_Info.TeamOne.storage) == 1 or getPlayerStorageValue(cid, _Lib_Battle_Info.TeamTwo.storage) == 1 then
table.insert(players, cid)
end
end
for i = 1, #players do
doPlayerSendTextMessage(players[i],type,msg)
end
end

function removeBattleTp()
local t = getTileItemById(_Lib_Battle_Info.tpPos, 1387).uid
return t > 0 and doRemoveItem(t) and doSendMagicEffect(_Lib_Battle_Info.tpPos, CONST_ME_POFF)
end

function getWinnersBattle(storage)
local players,str = {},""
for _, cid in pairs(getPlayersOnline()) do
if getPlayerStorageValue(cid, storage) == 1 then
table.insert(players, cid)
end
end
str = str .. ""..#players.." Jogador"..(#players > 1 and "es" or "").." do time "..(getGlobalStorageValue(_Lib_Battle_Info.TeamOne.storage) == 0 and _Lib_Battle_Info.TeamTwo.name or _Lib_Battle_Info.TeamOne.name).." ganharam o evento Battlefield e receberam ".._Lib_Battle_Info.Reward[2].." "..getItemNameById(_Lib_Battle_Info.Reward[1]).." + ".._Lib_Battle_Info.Reward2[2].." "..getItemNameById(_Lib_Battle_Info.Reward2[1]).."!"
for i = 1, #players do
doPlayerAddItem(players[i], _Lib_Battle_Info.Reward[1], _Lib_Battle_Info.Reward[2])
doPlayerAddItem(players[i], _Lib_Battle_Info.Reward2[1], _Lib_Battle_Info.Reward2[2])
doRemoveCondition(players[i], CONDITION_OUTFIT)
doTeleportThing(players[i], getTownTemplePosition(getPlayerTown(players[i])))
setPlayerStorageValue(players[i], storage, -1)
end
resetBattle()
OpenWallBattle()
return doBroadcastMessage(str)
end

function CheckEvent(delay)
if delay > 0 and getGlobalStorageValue(_Lib_Battle_Info.storage_count) > 0 then
doBroadcastMessage("[BattleField] Estamos à espera de "..getGlobalStorageValue(_Lib_Battle_Info.storage_count).." jogadores para o Battlefield iniciar.")
elseif delay == 0 and getGlobalStorageValue(_Lib_Battle_Info.storage_count) > 0 then
local players = {}
for _, cid in pairs(getPlayersOnline()) do
if getPlayerStorageValue(cid, _Lib_Battle_Info.TeamOne.storage) == 1 or getPlayerStorageValue(cid, _Lib_Battle_Info.TeamTwo.storage) == 1 then
table.insert(players, cid)
end
end
for i = 1, #players do
doRemoveCondition(players[i], CONDITION_OUTFIT)
doTeleportThing(players[i], getTownTemplePosition(getPlayerTown(players[i])))
setPlayerStorageValue(players[i], getPlayerStorageValue(players[i], _Lib_Battle_Info.TeamOne.storage) == 1 and _Lib_Battle_Info.TeamOne.storage or _Lib_Battle_Info.TeamTwo.storage, -1)
end
doBroadcastMessage("O evento Battlefield não iniciou por não ter jogadores suficientes.")
setGlobalStorageValue(_Lib_Battle_Info.storage_count, 0)
resetBattle()
removeBattleTp()
end
addEvent(CheckEvent, 60000, delay-1)
end