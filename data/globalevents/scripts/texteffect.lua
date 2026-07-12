function onThink(interval, lastExecution)
pos = {x = 89, y = 184, z = 0} -- Coordenada de onde sairá o texto
pos2 = {x = 649, y = 388, z = 0}
pos4 = {x = 89, y = 179, z = 0}
pos5 = {x = 654, y = 392, z = 0} -- Coordenada de onde sairá o texto
doSendAnimatedText(pos, 'Yama', 180)
doSendAnimatedText(pos2, 'Evento', 180)
doSendAnimatedText(pos4, 'Trainers', 5)
doSendAnimatedText(pos5, 'Abra', 5)
return true
end