modutil.mod.Path.Context.Env("CheckAxeCastArm", function (triggerArgs, functionArgs)
    modutil.mod.Path.Wrap("GetInProjectilesBlast", function (base, args)
        local ids = base(args)
        if game.SessionMapState[_PLUGIN.guid .. "CheckAxeCastArmProjectileName"] == "ProjectileThrowCharged" and not game.IsEmpty(ids) then
            return (game.CheckCooldown(_PLUGIN.guid .. "CheckAxeCastArmThrow", 0.8) or nil) and ids
        end
        return ids
    end)
end)