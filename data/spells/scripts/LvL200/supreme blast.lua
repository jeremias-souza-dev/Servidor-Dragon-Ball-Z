local combat1 = createCombatObject()
setCombatParam(combat1, COMBAT_PARAM_HITCOLOR, COLOR_DARKYELLOW)
setCombatParam(combat1, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat1, COMBAT_PARAM_EFFECT, 32)
setCombatParam(combat1, COMBAT_PARAM_DISTANCEEFFECT, 39)
setCombatFormula(combat1, COMBAT_FORMULA_LEVELMAGIC, -38.0, 0, -38.5, 0)
 
local function onCastSpell1(parameters)
doCombat(parameters.cid, parameters.combat1, parameters.var)
end
 
function onCastSpell(cid, var)
local parameters = {cid = cid, var = var, combat1 = combat1}

for k = 1, 10 do
	addEvent(function()
		if isCreature(cid) then
			addEvent(onCastSpell1, 0, parameters)
		end
	end, 1 + ((k-1) * 300))
end
return true
end