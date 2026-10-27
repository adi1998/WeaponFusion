local newNyxAttackProjectiles = {
    "ProjectileStaffBall",
    "ProjectileDaggerThrow",
    "ProjectileSuitGrenade",
    "ProjectileSuitGrenadeStraight",
    "ProjectileLobSpecialBounce",
    "ProjectileTorchOrbit",
}

local nyxOffSets = {
    ProjectileSuitGrenade = 250,
    ProjectileSuitGrenadeStraight = 250,
    ProjectileLobSpecialBounce = 80,
}

for index, projectileName in ipairs(newNyxAttackProjectiles) do
    if game.TraitData.SuitMarkCritAspect.OnProjectileDeathFunction then
        table.insert(game.TraitData.SuitMarkCritAspect.OnProjectileDeathFunction.ValidProjectiles, projectileName)
        game.TraitData.SuitMarkCritAspect.OnProjectileDeathFunction.Args.ProjectileNameMap[projectileName] = projectileName
        game.TraitData.SuitMarkCritAspect.OnProjectileDeathFunction.Args.ProjectileVfx[projectileName] = "NyxMissileSpawner"
        game.TraitData.SuitMarkCritAspect.OnProjectileDeathFunction.Args.ProjectileOffsets[projectileName] = nyxOffSets[projectileName]
    end
    if game.TraitData.SuitMarkCritAspect.OnProjectileCreationFunction then
        table.insert(game.TraitData.SuitMarkCritAspect.OnProjectileCreationFunction.ValidProjectiles, projectileName)
    end
end

if modutil.mod.Path.Get("TraitData.SuitMarkCritAspect.OnEnemyDamagedAction.ValidProjectiles", game) then
    table.insert(game.TraitData.SuitMarkCritAspect.OnEnemyDamagedAction.ValidProjectiles, "ProjectileTorchOrbit")
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

modutil.mod.Path.Wrap("NyxHitBuffApply", function(base, triggerArgs)
    local victim = triggerArgs.Victim
    if not triggerArgs.Reapplied and victim == game.CurrentRun.Hero then
        game.ApplyUnitPropertyChanges(game.CurrentRun.Hero, nyxPropertyChanges)
    end
    return base(triggerArgs)
end)

modutil.mod.Path.Wrap("NyxHitBuffClear", function(base, triggerArgs)
    local victim = triggerArgs.Victim
    if victim == game.CurrentRun.Hero then
        game.ApplyUnitPropertyChanges(game.CurrentRun.Hero, nyxPropertyChanges, true, true)
    end
    return base(triggerArgs)
end)

modutil.mod.Path.Wrap("CheckProjectileSpawn", function(base, triggerArgs, functionArgs)
    if triggerArgs.WeaponName == "WeaponTorchSpecial" and game.HeroHasTrait("TorchAutofireAspect_Secondary") then
        return
    end
    if triggerArgs.WeaponName == "WeaponTorch" and not functionArgs.IgnoreAdvancedSplitValidity and game.HeroHasTrait("TorchSplitAttackTrait") then
        functionArgs.SpawnArc = 40
    end
    if triggerArgs.WeaponName == "WeaponDaggerThrow" then
        triggerArgs.Angle = game.GetAngle({ Id = game.CurrentRun.Hero.ObjectId })
        functionArgs.MatchProjectileName = false
    end
    return base(triggerArgs, functionArgs)
end)

function mod.CheckTorchAutoFireNightSpawn(victim, functionArgs, triggerArgs)
    local weaponName = "WeaponTorchSpecial"
    local projectileName = "ProjectileTorchOrbit"
    local cooldown = 5.2
    if game.HeroHasTrait("TorchAutofireAspect_Secondary") and game.CurrentRun.Hero.ActiveEffects[functionArgs.EffectName] and
            game.CheckCooldown(_PLUGIN.guid .. "TorchSpecialAutoFireNightSpawn", cooldown) then
        local derivedValues = game.GetDerivedPropertyChangeValues({
            ProjectileName = projectileName,
            WeaponName = weaponName,
            Type = "Projectile",
        })
        derivedValues.PropertyChanges.Range = 380
        derivedValues.PropertyChanges.Fuse = 5
        derivedValues.PropertyChanges.ArcEnd = -10800
        local angle = math.random(1,360)

        local traitData = game.GetHeroTrait("SuitMarkCritAspect")
        local nightspawnArgs = traitData.OnProjectileDeathFunction.Args
        local damageMultiplier = nightspawnArgs.DamageMultiplier
        local alpha = 0.7
        local attachAnim = nightspawnArgs.ProjectileVfx[projectileName]

        for i = 1, 2 do
            game.CreateProjectileFromUnit({
                WeaponName = weaponName,
                Name = projectileName,
                Id = game.CurrentRun.Hero.ObjectId,
                DestinationId = game.CurrentRun.Hero.ObjectId,
                Angle = angle + 360/2*(i-1),
                DisableEffects = true,
                DataProperties = derivedValues.PropertyChanges,
                ThingProperties = derivedValues.ThingPropertyChanges,
                DamageMultiplier = damageMultiplier,
                Alpha = alpha,
                AttachAnimation = attachAnim
            })
        end
    end
end

modutil.mod.Path.Wrap("SplitSelfBuff", function (base, victim, functionArgs, triggerArgs)
    if triggerArgs.SourceProjectile == "NyxSprintBlast" then
        return base(victim, functionArgs, triggerArgs)
    else
        return mod.CheckTorchAutoFireNightSpawn(victim, functionArgs, triggerArgs)
    end
end)