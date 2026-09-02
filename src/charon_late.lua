local cooldownLookup =
{
    ProjectileTorchOrbitEx = true,
    ProjectileThrowCharged = true
}

modutil.mod.Path.Context.Env("CheckAxeCastArm", function (triggerArgs, functionArgs)
    modutil.mod.Path.Wrap("GetInProjectilesBlast", function (base, args)
        local ids = base(args)
        if game.SessionMapState[_PLUGIN.guid .. "CheckAxeCastArmProjectileName"] and cooldownLookup[game.SessionMapState[_PLUGIN.guid .. "CheckAxeCastArmProjectileName"]] and not game.IsEmpty(ids) then
            return (game.CheckCooldown(_PLUGIN.guid .. "CheckAxeCastArmThrow", 0.8) or nil) and ids
        end
        return ids
    end)
end)