local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TARGETCASTERORTOPMOST, true)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 98)

local condition = createConditionObject(CONDITION_PARALYZE)
setConditionParam(condition, CONDITION_PARAM_TICKS, 10000)
setConditionFormula(condition, -0.90, 0, -0.90, 0)
setCombatCondition(combat, condition)

function onCastSpell(cid, var)
	if exhaustion.check(cid, 13132) == TRUE then
		doPlayerSendCancel(cid, "You are exhauted.")
		doSendMagicEffect(getCreaturePosition(cid), 2)
		return false
	end
	if(not doCombat(cid, combat, var)) then
		return false
	end
	doSendMagicEffect(getThingPosition(cid), 91)
	exhaustion.set(cid, 13132, 1.0)
	return true
end
