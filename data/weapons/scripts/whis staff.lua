local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_HITCOLOR, 180)
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 43)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, 51)
setCombatFormula(combat, COMBAT_FORMULA_SKILL, -1, -60000, -1, -60000)
function onUseWeapon(cid, var)
	return doCombat(cid, combat, var)
end
