local combat1 = createCombatObject()
setCombatParam(combat1, COMBAT_PARAM_HITCOLOR, COLOR_DARKRED)
setCombatParam(combat1, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat1, COMBAT_PARAM_EFFECT, 24)
setCombatParam(combat1, COMBAT_PARAM_DISTANCEEFFECT, 51)
setCombatFormula(combat1, COMBAT_FORMULA_LEVELMAGIC, -350.0, 0, -365.0, 0)

local function onCastSpell1(parameters)
doCombat(parameters.cid, parameters.combat1, parameters.var)
end
 
function onCastSpell(cid, var)
local parameters = { cid = cid, var = var, combat1 = combat1 }
addEvent(onCastSpell1, 0, parameters)
return true
end