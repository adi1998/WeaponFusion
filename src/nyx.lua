local nyxPropertyChanges = {
    {
        WeaponName = "WeaponTorch",
        TraitName = "TorchDetonateAspect",
        ChangeValue = false,
        ExcludeLinked = true,
        ProjectileProperty = "UnlimitedUnitPenetration",
        ChangeType = "Absolute",
    }
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