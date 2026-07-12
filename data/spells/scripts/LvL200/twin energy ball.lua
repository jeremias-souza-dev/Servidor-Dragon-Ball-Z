local combat1 = createCombatObject()
setCombatParam(combat1, COMBAT_PARAM_HITCOLOR, COLOR_TEAL)
setCombatParam(combat1, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat1, COMBAT_PARAM_DISTANCEEFFECT, 0)
setCombatFormula(combat1, COMBAT_FORMULA_LEVELMAGIC, -38.0, 0, -38.5, 0)
 
local function onCastSpell1(parameters)
    if isCreature(parameters.cid) then
        doCombat(parameters.cid, parameters.combat1, parameters.var)
    end
end
 
function twb1(cid)
    if isCreature(cid) and isCreature(getCreatureTarget(cid)) then
        local position1 = {x = getThingPosition(getCreatureTarget(cid)).x + 1, y = getThingPosition(getCreatureTarget(cid)).y + 1, z = getThingPosition(getCreatureTarget(cid)).z}
        doSendMagicEffect(position1, 53)
    end
end
 
function onCastSpell(cid, var)
    local parameters = {cid = cid, var = var, combat1 = combat1}
    for k = 1, 10 do
        addEvent(function()
            if isCreature(cid) then
                onCastSpell1(parameters)
                twb1(cid)
            end
        end, 1 + ((k-1) * 225))
    end
    return true
end