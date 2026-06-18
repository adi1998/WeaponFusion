if game.TraitData.SuitMarkCritAspect.OnProjectileDeathFunction then
    table.insert(game.TraitData.SuitMarkCritAspect.OnProjectileDeathFunction.ValidProjectiles, "ProjectileStaffBall")
    game.TraitData.SuitMarkCritAspect.OnProjectileDeathFunction.Args.ProjectileNameMap["ProjectileStaffBall"] = "ProjectileStaffBall"
    game.TraitData.SuitMarkCritAspect.OnProjectileDeathFunction.Args.ProjectileVfx["ProjectileStaffBall"] = "NyxMissileSpawner"
end

if game.TraitData.SuitMarkCritAspect.OnProjectileCreationFunction then
    table.insert(game.TraitData.SuitMarkCritAspect.OnProjectileCreationFunction.ValidProjectiles, "ProjectileStaffBall")
end

local nyxPropertyChanges = {
    {
        WeaponName = "WeaponTorch",
        TraitName = "TorchDetonateAspect",
        ChangeValue = false,
        ExcludeLinked = true,
        ProjectileProperty = "UnlimitedUnitPenetration",
        ChangeType = "Absolute",
    },
    {
        WeaponName = "WeaponStaffBall",
        ProjectileName = "ProjectileStaffBall",
        ChangeValue = false,
        ExcludeLinked = true,
        ProjectileProperty = "UnlimitedUnitPenetration",
        ChangeType = "Absolute",
    },
    {
        WeaponName = "WeaponLob",
        ChangeValue = false,
        ExcludeLinked = true,
        ProjectileProperty = "UnlimitedUnitPenetration",
        ChangeType = "Absolute",
    },
}

modutil.mod.Path.Wrap("NyxHitBuffApply", function (base, triggerArgs)
    local victim = triggerArgs.Victim
	if not triggerArgs.Reapplied and victim == game.CurrentRun.Hero then
        game.ApplyUnitPropertyChanges(game.CurrentRun.Hero, nyxPropertyChanges)
    end
    return base(triggerArgs)
end)

modutil.mod.Path.Wrap("NyxHitBuffClear", function (base, triggerArgs)
    local victim = triggerArgs.Victim
	if victim == game.CurrentRun.Hero then
		game.ApplyUnitPropertyChanges( game.CurrentRun.Hero, nyxPropertyChanges, true, true)
	end
    return base(triggerArgs)
end)

modutil.mod.Path.Wrap("CheckProjectileSpawn", function (base, triggerArgs, functionArgs)
    if triggerArgs.WeaponName == "WeaponTorch" and not functionArgs.IgnoreAdvancedSplitValidity and game.HeroHasTrait("TorchSplitAttackTrait") then
        functionArgs.SpawnArc = 40
    end
    return base(triggerArgs, functionArgs)
end)