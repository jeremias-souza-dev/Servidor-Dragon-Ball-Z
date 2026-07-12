local combat1 = createCombatObject()
setCombatParam(combat1, COMBAT_PARAM_HITCOLOR, COLOR_ORANGE)
setCombatParam(combat1, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat1, COMBAT_PARAM_EFFECT, 5)
setCombatParam(combat1, COMBAT_PARAM_DISTANCEEFFECT, 45)
setCombatFormula(combat1, COMBAT_FORMULA_LEVELMAGIC, -175.0, 0, -182.5, 0)
 
local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_HITCOLOR, COLOR_DARKRED)
setCombatParam(combat2, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat2, COMBAT_PARAM_EFFECT, 5)
setCombatParam(combat2, COMBAT_PARAM_DISTANCEEFFECT, 43)
setCombatFormula(combat2, COMBAT_FORMULA_LEVELMAGIC, -175.0, 0, -182.5, 0)
 
local function onCastSpell1(parameters)
doCombat(parameters.cid, parameters.combat1, parameters.var)
end
 
local function onCastSpell2(parameters)
doCombat(parameters.cid, parameters.combat2, parameters.var)
end
 
function onCastSpell(cid, var)
local parameters = {cid = cid, var = var, combat1 = combat1, combat2 = combat2}

for k = 1, 1 do
	addEvent(function()
		if isCreature(cid) then
			addEvent(onCastSpell1, 1, parameters)
		end
	end, 1 + ((k-1) * 200))
end
for i = 1, 1 do
	addEvent(function()
		if isCreature(cid) then
			addEvent(onCastSpell2, 200, parameters)
		end
	end, 1 + ((i-1) * 200))
end
return true
end