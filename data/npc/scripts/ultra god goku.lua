local focus = 0
local talk_start = 0
local target = 0
local following = false
local attacking = false
local tab = {
	item = {2144, 100}} -- {itemID, count}

function onThingMove(creature, thing, oldpos, oldstackpos)
end

function onCreatureAppear(creature)
end

function onCreatureDisappear(cid, pos)
if focus == cid then
selfSay('???')
focus = 0
talk_start = 0
end
end


function onCreatureTurn(creature)
end
function msgcontains(txt, str)
return (string.find(txt, str) and not string.find(txt, '(%w+)' .. str) and not string.find(txt, str .. '(%w+)'))
end

function onCreatureSay(cid, type, msg)
msg = string.lower(msg)
if (msgcontains(msg, 'hi') and (focus == 0)) and getDistanceToCreature(cid) < 4 then
selfSay('Ola! Se voce esta pronto, diga "ultra god".')
focus = cid
talk_start = os.clock()
elseif msgcontains(msg, 'hi') and (focus ~= cid) and getDistanceToCreature(cid) < 4 then
selfSay('Desculpe, ' .. getCreatureName(cid) .. '! Hey!.')
elseif focus == cid then
talk_start = os.clock()
if msgcontains(msg, 'ultra god') and getPlayerStorageValue(cid,99023) == 4 then
selfSay('Desculpe, mas voce já é ultra god.')
focus = 0
talk_start = 0
elseif msgcontains(msg, 'ultra god') and (getPlayerLevel(cid) < 800 and getPlayerStorageValue(cid,99023) ~= 4) then
selfSay('Apenas level 800 ou mais podem virar ultra god.')
focus = 0
talk_start = 0
elseif msgcontains(msg, 'ultra god') then
selfSay('Realmente quer isto?')
talk_state = 2
--_GOKU_--
elseif msgcontains(msg, 'yes') and talk_state == 2 and getPlayerLevel(cid) >= 800 and getPlayerVocation(cid) == 473 then		
if (getPlayerItemCount(cid, tab.item[1]) >= tab.item[2]) and
			doPlayerRemoveItem(cid, tab.item[1], tab.item[2])then
doUltragod(cid,560,499)
else
talk_state = 0
end

--_Vegeta_--
elseif msgcontains(msg, 'yes') and talk_state == 2 and getPlayerLevel(cid) >= 800 and getPlayerVocation(cid) == 474 then		
if (getPlayerItemCount(cid, tab.item[1]) >= tab.item[2]) and
			doPlayerRemoveItem(cid, tab.item[1], tab.item[2])then
doUltragod(cid,567,500)
else
talk_state = 0
end

--_Chilled_--
elseif msgcontains(msg, 'yes') and talk_state == 2 and getPlayerLevel(cid) >= 800 and getPlayerVocation(cid) == 492 then		
if (getPlayerItemCount(cid, tab.item[1]) >= tab.item[2]) and
			doPlayerRemoveItem(cid, tab.item[1], tab.item[2])then
doUltragod(cid,574,494)
else
talk_state = 0
end

--_Zaiko_--
elseif msgcontains(msg, 'yes') and talk_state == 2 and getPlayerLevel(cid) >= 800 and getPlayerVocation(cid) == 477 then		
if (getPlayerItemCount(cid, tab.item[1]) >= tab.item[2]) and
			doPlayerRemoveItem(cid, tab.item[1], tab.item[2])then
doUltragod(cid,572,495)
else
talk_state = 0
end

--_Kagome_--
elseif msgcontains(msg, 'yes') and talk_state == 2 and getPlayerLevel(cid) >= 800 and getPlayerVocation(cid) == 448 then		
if (getPlayerItemCount(cid, tab.item[1]) >= tab.item[2]) and
			doPlayerRemoveItem(cid, tab.item[1], tab.item[2])then
doUltragod(cid,571,496)
else
talk_state = 0
end

--_King Vegeta_--
elseif msgcontains(msg, 'yes') and talk_state == 2 and getPlayerLevel(cid) >= 800 and getPlayerVocation(cid) == 436 then		
if (getPlayerItemCount(cid, tab.item[1]) >= tab.item[2]) and
			doPlayerRemoveItem(cid, tab.item[1], tab.item[2])then
doUltragod(cid,563,497)
else
talk_state = 0
end

--_Piccolo_--
elseif msgcontains(msg, 'yes') and talk_state == 2 and getPlayerLevel(cid) >= 800 and getPlayerVocation(cid) == 44 then		
if (getPlayerItemCount(cid, tab.item[1]) >= tab.item[2]) and
			doPlayerRemoveItem(cid, tab.item[1], tab.item[2])then
doUltragod(cid,553,501)
else
talk_state = 0
end

--_Gohan_--
elseif msgcontains(msg, 'yes') and talk_state == 2 and getPlayerLevel(cid) >= 800 and getPlayerVocation(cid) == 70 then		
if (getPlayerItemCount(cid, tab.item[1]) >= tab.item[2]) and
			doPlayerRemoveItem(cid, tab.item[1], tab.item[2])then
doUltragod(cid,559,502)
else
talk_state = 0
end

--_Trunks_--
elseif msgcontains(msg, 'yes') and talk_state == 2 and getPlayerLevel(cid) >= 800 and getPlayerVocation(cid) == 490 then		
if (getPlayerItemCount(cid, tab.item[1]) >= tab.item[2]) and
			doPlayerRemoveItem(cid, tab.item[1], tab.item[2])then
doUltragod(cid,565,503)
else
talk_state = 0
end

--_Cell_--
elseif msgcontains(msg, 'yes') and talk_state == 2 and getPlayerLevel(cid) >= 800 and getPlayerVocation(cid) == 94 then		
if (getPlayerItemCount(cid, tab.item[1]) >= tab.item[2]) and
			doPlayerRemoveItem(cid, tab.item[1], tab.item[2])then
doUltragod(cid,575,504)
else
talk_state = 0
end

--_Freeza_--
elseif msgcontains(msg, 'yes') and talk_state == 2 and getPlayerLevel(cid) >= 800 and getPlayerVocation(cid) == 110 then		
if (getPlayerItemCount(cid, tab.item[1]) >= tab.item[2]) and
			doPlayerRemoveItem(cid, tab.item[1], tab.item[2])then
doUltragod(cid,551,505)
else
talk_state = 0
end

--_Brolly_--
elseif msgcontains(msg, 'yes') and talk_state == 2 and getPlayerLevel(cid) >= 800 and getPlayerVocation(cid) == 139 then		
if (getPlayerItemCount(cid, tab.item[1]) >= tab.item[2]) and
			doPlayerRemoveItem(cid, tab.item[1], tab.item[2])then
doUltragod(cid,558,506)
else
talk_state = 0
end

--_C18_--
elseif msgcontains(msg, 'yes') and talk_state == 2 and getPlayerLevel(cid) >= 800 and getPlayerVocation(cid) == 151 then		
if (getPlayerItemCount(cid, tab.item[1]) >= tab.item[2]) and
			doPlayerRemoveItem(cid, tab.item[1], tab.item[2])then
doUltragod(cid,554,507)
else
talk_state = 0
end

--_Gotenks(goten)_--
elseif msgcontains(msg, 'yes') and talk_state == 2 and getPlayerLevel(cid) >= 800 and getPlayerVocation(cid) == 177 then		
if (getPlayerItemCount(cid, tab.item[1]) >= tab.item[2]) and
			doPlayerRemoveItem(cid, tab.item[1], tab.item[2])then
doUltragod(cid,561,508)
else
talk_state = 0
end

--_Gotenks (Chibi trunks)_--
elseif msgcontains(msg, 'yes') and talk_state == 2 and getPlayerLevel(cid) >= 800 and getPlayerVocation(cid) == 191 then		
if (getPlayerItemCount(cid, tab.item[1]) >= tab.item[2]) and
			doPlayerRemoveItem(cid, tab.item[1], tab.item[2])then
doUltragod(cid,561,509)
else
talk_state = 0
end

--_Cooler_--
elseif msgcontains(msg, 'yes') and talk_state == 2 and getPlayerLevel(cid) >= 800 and getPlayerVocation(cid) == 205 then		
if (getPlayerItemCount(cid, tab.item[1]) >= tab.item[2]) and
			doPlayerRemoveItem(cid, tab.item[1], tab.item[2])then
doUltragod(cid,573,510)
else
talk_state = 0
end

--_Dende_--
elseif msgcontains(msg, 'yes') and talk_state == 2 and getPlayerLevel(cid) >= 800 and getPlayerVocation(cid) == 217 then		
if (getPlayerItemCount(cid, tab.item[1]) >= tab.item[2]) and
			doPlayerRemoveItem(cid, tab.item[1], tab.item[2])then
doUltragod(cid,552,511)
else
talk_state = 0
end
--_Tsuful_--
elseif msgcontains(msg, 'yes') and talk_state == 2 and getPlayerLevel(cid) >= 800 and getPlayerVocation(cid) == 229 then		
if (getPlayerItemCount(cid, tab.item[1]) >= tab.item[2]) and
			doPlayerRemoveItem(cid, tab.item[1], tab.item[2])then
doUltragod(cid,569,512)
else
talk_state = 0
end

--_Bardock_--
elseif msgcontains(msg, 'yes') and talk_state == 2 and getPlayerLevel(cid) >= 800 and getPlayerVocation(cid) == 243 then		
if (getPlayerItemCount(cid, tab.item[1]) >= tab.item[2]) and
			doPlayerRemoveItem(cid, tab.item[1], tab.item[2])then
doUltragod(cid,552,513)
else
talk_state = 0
end

--_Kuririn_--
elseif msgcontains(msg, 'yes') and talk_state == 2 and getPlayerLevel(cid) >= 800 and getPlayerVocation(cid) == 255 then		
if (getPlayerItemCount(cid, tab.item[1]) >= tab.item[2]) and
			doPlayerRemoveItem(cid, tab.item[1], tab.item[2])then
doUltragod(cid,542,514)
else
talk_state = 0
end

--_Pan_--
elseif msgcontains(msg, 'yes') and talk_state == 2 and getPlayerLevel(cid) >= 800 and getPlayerVocation(cid) == 267 then		
if (getPlayerItemCount(cid, tab.item[1]) >= tab.item[2]) and
			doPlayerRemoveItem(cid, tab.item[1], tab.item[2])then
doUltragod(cid,543,515)
else
talk_state = 0
end

--_Kaio_--
elseif msgcontains(msg, 'yes') and talk_state == 2 and getPlayerLevel(cid) >= 800 and getPlayerVocation(cid) == 279 then		
if (getPlayerItemCount(cid, tab.item[1]) >= tab.item[2]) and
			doPlayerRemoveItem(cid, tab.item[1], tab.item[2])then
doUltragod(cid,583,516)
else
talk_state = 0
end

--_Janemba_--
elseif msgcontains(msg, 'yes') and talk_state == 2 and getPlayerLevel(cid) >= 800 and getPlayerVocation(cid) == 491 then		
if (getPlayerItemCount(cid, tab.item[1]) >= tab.item[2]) and
			doPlayerRemoveItem(cid, tab.item[1], tab.item[2])then
doUltragod(cid,576,517)
else
talk_state = 0
end

--_Tenshinhan_--
elseif msgcontains(msg, 'yes') and talk_state == 2 and getPlayerLevel(cid) >= 800 and getPlayerVocation(cid) == 315 then		
if (getPlayerItemCount(cid, tab.item[1]) >= tab.item[2]) and
			doPlayerRemoveItem(cid, tab.item[1], tab.item[2])then
doUltragod(cid,580,518)
else
talk_state = 0
end

--_Jenk_--
elseif msgcontains(msg, 'yes') and talk_state == 2 and getPlayerLevel(cid) >= 800 and getPlayerVocation(cid) == 327 then		
if (getPlayerItemCount(cid, tab.item[1]) >= tab.item[2]) and
			doPlayerRemoveItem(cid, tab.item[1], tab.item[2])then
doUltragod(cid,562,519)
else
talk_state = 0
end

--_Raditz_--
elseif msgcontains(msg, 'yes') and talk_state == 2 and getPlayerLevel(cid) >= 800 and getPlayerVocation(cid) == 339 then		
if (getPlayerItemCount(cid, tab.item[1]) >= tab.item[2]) and
			doPlayerRemoveItem(cid, tab.item[1], tab.item[2])then
doUltragod(cid,564,520)
else
talk_state = 0
end

--_C16_--
elseif msgcontains(msg, 'yes') and talk_state == 2 and getPlayerLevel(cid) >= 800 and getPlayerVocation(cid) == 351 then		
if (getPlayerItemCount(cid, tab.item[1]) >= tab.item[2]) and
			doPlayerRemoveItem(cid, tab.item[1], tab.item[2])then
doUltragod(cid,555,521)
else
talk_state = 0
end

--_Turles_--
elseif msgcontains(msg, 'yes') and talk_state == 2 and getPlayerLevel(cid) >= 800 and getPlayerVocation(cid) == 363 then		
if (getPlayerItemCount(cid, tab.item[1]) >= tab.item[2]) and
			doPlayerRemoveItem(cid, tab.item[1], tab.item[2])then
doUltragod(cid,566,522)
else
talk_state = 0
end

--_Bulma_--
elseif msgcontains(msg, 'yes') and talk_state == 2 and getPlayerLevel(cid) >= 800 and getPlayerVocation(cid) == 375 then		
if (getPlayerItemCount(cid, tab.item[1]) >= tab.item[2]) and
			doPlayerRemoveItem(cid, tab.item[1], tab.item[2])then
doUltragod(cid,578,523)
else
talk_state = 0
end

--_Shenron_--
elseif msgcontains(msg, 'yes') and talk_state == 2 and getPlayerLevel(cid) >= 800 and getPlayerVocation(cid) == 387 then		
if (getPlayerItemCount(cid, tab.item[1]) >= tab.item[2]) and
			doPlayerRemoveItem(cid, tab.item[1], tab.item[2])then
doUltragod(cid,577,524)
else
talk_state = 0
end

--_Vegetto_--
elseif msgcontains(msg, 'yes') and talk_state == 2 and getPlayerLevel(cid) >= 800 and getPlayerVocation(cid) == 399 then		
if (getPlayerItemCount(cid, tab.item[1]) >= tab.item[2]) and
			doPlayerRemoveItem(cid, tab.item[1], tab.item[2])then
doUltragod(cid,568,525)
else
talk_state = 0
end

--_Kame_--
elseif msgcontains(msg, 'yes') and talk_state == 2 and getPlayerLevel(cid) >= 800 and getPlayerVocation(cid) == 424 then		
if (getPlayerItemCount(cid, tab.item[1]) >= tab.item[2]) and
			doPlayerRemoveItem(cid, tab.item[1], tab.item[2])then
doUltragod(cid,536,526)
else
talk_state = 0
end

--_C8_--
elseif msgcontains(msg, 'yes') and talk_state == 2 and getPlayerLevel(cid) >= 800 and getPlayerVocation(cid) == 489 then		
if (getPlayerItemCount(cid, tab.item[1]) >= tab.item[2]) and
			doPlayerRemoveItem(cid, tab.item[1], tab.item[2])then
doUltragod(cid,579,527)
else
talk_state = 0
end

--_Majin Boo_--
elseif msgcontains(msg, 'yes') and talk_state == 2 and getPlayerLevel(cid) >= 800 and getPlayerVocation(cid) == 475 then		
if (getPlayerItemCount(cid, tab.item[1]) >= tab.item[2]) and
			doPlayerRemoveItem(cid, tab.item[1], tab.item[2])then
doUltragod(cid,581,528)
else
talk_state = 0
end
--_Uub_--
elseif msgcontains(msg, 'yes') and talk_state == 2 and getPlayerLevel(cid) >= 800 and getPlayerVocation(cid) == 163 then		
if (getPlayerItemCount(cid, tab.item[1]) >= tab.item[2]) and
			doPlayerRemoveItem(cid, tab.item[1], tab.item[2])then
doUltragod(cid,582,529)
else
talk_state = 0
end
--_Goku Black_--
elseif msgcontains(msg, 'yes') and talk_state == 2 and getPlayerLevel(cid) >= 800 and getPlayerVocation(cid) == 540 then		
if (getPlayerItemCount(cid, tab.item[1]) >= tab.item[2]) and
			doPlayerRemoveItem(cid, tab.item[1], tab.item[2])then
doUltragod(cid,604,541)
else
talk_state = 0
end
--_Golden Freeza_--
elseif msgcontains(msg, 'yes') and talk_state == 2 and getPlayerLevel(cid) >= 800 and getPlayerVocation(cid) == 550 then		
if (getPlayerItemCount(cid, tab.item[1]) >= tab.item[2]) and
			doPlayerRemoveItem(cid, tab.item[1], tab.item[2])then
doUltragod(cid,603,551)
else
talk_state = 0
end
--_Bills_--
elseif msgcontains(msg, 'yes') and talk_state == 2 and getPlayerLevel(cid) >= 800 and getPlayerVocation(cid) == 560 then		
if (getPlayerItemCount(cid, tab.item[1]) >= tab.item[2]) and
			doPlayerRemoveItem(cid, tab.item[1], tab.item[2])then
doUltragod(cid,584,561)
else
talk_state = 0
end
--_Zamasu_--
elseif msgcontains(msg, 'yes') and talk_state == 2 and getPlayerLevel(cid) >= 800 and getPlayerVocation(cid) == 570 then		
if (getPlayerItemCount(cid, tab.item[1]) >= tab.item[2]) and
			doPlayerRemoveItem(cid, tab.item[1], tab.item[2])then
doUltragod(cid,614,571)
else
talk_state = 0
end
--_Whiss_--
elseif msgcontains(msg, 'yes') and talk_state == 2 and getPlayerLevel(cid) >= 800 and getPlayerVocation(cid) == 580 then		
if (getPlayerItemCount(cid, tab.item[1]) >= tab.item[2]) and
			doPlayerRemoveItem(cid, tab.item[1], tab.item[2])then
doUltragod(cid,621,581)
else
talk_state = 0
end
--_Vados_--
elseif msgcontains(msg, 'yes') and talk_state == 2 and getPlayerLevel(cid) >= 800 and getPlayerVocation(cid) == 590 then		
if (getPlayerItemCount(cid, tab.item[1]) >= tab.item[2]) and
			doPlayerRemoveItem(cid, tab.item[1], tab.item[2])then
doUltragod(cid,626,591)
else
talk_state = 0
end
--_Vegetto Black_--
elseif msgcontains(msg, 'yes') and talk_state == 2 and getPlayerLevel(cid) >= 800 and getPlayerVocation(cid) == 600 then		
if (getPlayerItemCount(cid, tab.item[1]) >= tab.item[2]) and
			doPlayerRemoveItem(cid, tab.item[1], tab.item[2])then
doUltragod(cid,635,601)
else
talk_state = 0
end
--_Blue Gogeta_--
elseif msgcontains(msg, 'yes') and talk_state == 2 and getPlayerLevel(cid) >= 800 and getPlayerVocation(cid) == 610 then		
if (getPlayerItemCount(cid, tab.item[1]) >= tab.item[2]) and
			doPlayerRemoveItem(cid, tab.item[1], tab.item[2])then
doUltragod(cid,639,611)
else
talk_state = 0
end
--_Vegetto Blue_--
elseif msgcontains(msg, 'yes') and talk_state == 2 and getPlayerLevel(cid) >= 800 and getPlayerVocation(cid) == 620 then		
if (getPlayerItemCount(cid, tab.item[1]) >= tab.item[2]) and
			doPlayerRemoveItem(cid, tab.item[1], tab.item[2])then
doUltragod(cid,650,621)
else
talk_state = 0
end
--_Zeno_--
elseif msgcontains(msg, 'yes') and talk_state == 2 and getPlayerLevel(cid) >= 800 and getPlayerVocation(cid) == 630 then		
if (getPlayerItemCount(cid, tab.item[1]) >= tab.item[2]) and
			doPlayerRemoveItem(cid, tab.item[1], tab.item[2])then
doUltragod(cid,646,631)
else
talk_state = 0
end
--_Goku Black Evo_--
elseif msgcontains(msg, 'yes') and talk_state == 2 and getPlayerLevel(cid) >= 800 and getPlayerVocation(cid) == 640 then		
if (getPlayerItemCount(cid, tab.item[1]) >= tab.item[2]) and
			doPlayerRemoveItem(cid, tab.item[1], tab.item[2])then
doUltragod(cid,656,641)
else
talk_state = 0
end
--_Videl_--
elseif msgcontains(msg, 'yes') and talk_state == 2 and getPlayerLevel(cid) >= 800 and getPlayerVocation(cid) == 291 then		
if (getPlayerItemCount(cid, tab.item[1]) >= tab.item[2]) and
			doPlayerRemoveItem(cid, tab.item[1], tab.item[2])then
doUltragod(cid,605,530)
else
talk_state = 0
end
--_Tapion_--
elseif msgcontains(msg, 'yes') and talk_state == 2 and getPlayerLevel(cid) >= 800 and getPlayerVocation(cid) == 476 then		
if (getPlayerItemCount(cid, tab.item[1]) >= tab.item[2]) and
			doPlayerRemoveItem(cid, tab.item[1], tab.item[2])then
doUltragod(cid,596,498)
else
talk_state = 0
end
--_C17_--
elseif msgcontains(msg, 'yes') and talk_state == 2 and getPlayerLevel(cid) >= 800 and getPlayerVocation(cid) == 56 then		
if (getPlayerItemCount(cid, tab.item[1]) >= tab.item[2]) and
			doPlayerRemoveItem(cid, tab.item[1], tab.item[2])then
doUltragod(cid,606,531)
else
talk_state = 0
end

elseif msgcontains(msg, 'yes') and talk_state == 2 then
selfSay('Desculpe, ' .. getCreatureName(cid) .. '! Voce deve estar na ultima forma e ter 100 God Essences.')


elseif msgcontains(msg, 'bye') and getDistanceToCreature(cid) < 4 then
selfSay('Adeus!')
focus = 0
talk_start = 0
end
end
end

function onThink()
doNpcSetCreatureFocus(focus)
if (os.clock() - talk_start) > 45 then
if focus > 0 then
selfSay('Próximo por favor...')
end
focus = 0
end
if focus ~= 0 then
if getDistanceToCreature(focus) > 5 then
selfSay('Adeus!')
focus = 0
end
end
end
return true
