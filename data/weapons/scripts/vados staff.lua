local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_HITCOLOR, 190)
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 40)
setCombatParam(combat, COMBAT_PARAM_DISTANCEEFFECT, 67)
setCombatFormula(combat, COMBAT_FORMULA_SKILL, -1, -30000, -1, -30000)
function onUseWeapon(cid, var)
	return doCombat(cid, combat, var)
end
