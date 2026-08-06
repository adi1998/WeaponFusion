modutil.mod.Path.Context.Env("TorchSpecialAutofire", function ()
    modutil.mod.Path.Wrap("CreateProjectileFromUnit", function (base, args)
        local args_copy = game.DeepCopyTable(args)
        if game.SessionMapState.CurrentExProjectile then
            args_copy.ProjectileDestinationId = game.SessionMapState.CurrentExProjectile
            args_copy.DestinationId = nil
            args_copy.FireFromTarget = true
            args_copy.AttachToTarget = true
            local projectileId = base(args_copy)
            game.SessionMapState[_PLUGIN.guid .. "EosTorchOrbitIds"] = game.SessionMapState[_PLUGIN.guid .. "EosTorchOrbitIds"] or {}
            table.insert(game.SessionMapState[_PLUGIN.guid .. "EosTorchOrbitIds"], projectileId)
        end
        return base(args)
    end)

    modutil.mod.Path.Wrap("RefreshProjectile", function (base, args)
        local weaponName = "WeaponTorchSpecial"
        local projectileName = "ProjectileTorchOrbit"
        local derivedValues = game.GetDerivedPropertyChangeValues({
            ProjectileName = projectileName,
            WeaponName = weaponName,
            Type = "Projectile",
        })
        if game.SessionMapState.CurrentExProjectile and game.IsEmpty(game.SessionMapState[_PLUGIN.guid .. "EosTorchOrbitIds"]) then
            local count = 2
            local angle = game.GetAngle({ Id = game.CurrentRun.Hero.ObjectId })
            for i=1,count do
                local projectileId = game.CreateProjectileFromUnit({
                    WeaponName = weaponName,
                    Name = projectileName,
                    Id = game.CurrentRun.Hero.ObjectId,
                    ProjectileDestinationId = game.SessionMapState.CurrentExProjectile,
                    Angle = angle + 360/count * (i-1),
                    DisableEffects = true,
                    DataProperties = derivedValues.PropertyChanges,
                    ThingProperties = derivedValues.ThingPropertyChanges,
                    FireFromTarget = true,
                    AttachToTarget = true,
                })
                game.SessionMapState[_PLUGIN.guid .. "EosTorchOrbitIds"] = game.SessionMapState[_PLUGIN.guid .. "EosTorchOrbitIds"] or {}
                table.insert(game.SessionMapState[_PLUGIN.guid .. "EosTorchOrbitIds"], projectileId)
            end
        elseif not game.IsEmpty(game.SessionMapState[_PLUGIN.guid .. "EosTorchOrbitIds"]) and game.SessionMapState.CurrentExProjectile then
            local baseSpeed = game.GetBaseDataValue({ Type = "Projectile", Name = "ProjectileTorchOrbit", Property = "Speed" })
            local baseRange = game.GetBaseDataValue({ Type = "Projectile", Name = "ProjectileTorchOrbit", Property = "Range" })
            local speed = derivedValues.PropertyChanges.Speed or baseSpeed
            local range = derivedValues.PropertyChanges.Range or baseRange
            local baseChargeTime = game.GetBaseDataValue({ Type = "Weapon", Name = weaponName, Property = "ChargeTime" })
            local currentChargeTime = game.GetWeaponDataValue({ Id = game.CurrentRun.Hero.ObjectId, WeaponName = weaponName, Property = "ChargeTime" })
            game.RefreshProjectile({ Ids = game.SessionMapState[_PLUGIN.guid .. "EosTorchOrbitIds"] })
            for _, id in pairs( game.SessionMapState[_PLUGIN.guid .. "EosTorchOrbitIds"] ) do
                game.SetProjectileProperty({ ProjectileId = id, Property = "MaxRange", Value = 0 })
                game.SetProjectileProperty({ ProjectileId = id, Property = "Range", Value = range })
                game.SetProjectileProperty({ ProjectileId = id, Property = "Speed", Value = speed * (baseChargeTime / currentChargeTime) })
            end
        elseif not game.SessionMapState.CurrentExProjectile then
            game.ExpireProjectiles({ ProjectileIds = game.SessionMapState[_PLUGIN.guid .. "EosTorchOrbitIds"] })
            game.SessionMapState[_PLUGIN.guid .. "EosTorchOrbitIds"] = {}
        end
        return base(args)
    end)

    modutil.mod.Path.Wrap("ExpireProjectiles", function (base, args)
        if not game.IsEmpty(game.SessionMapState[_PLUGIN.guid .. "EosTorchOrbitIds"]) then
            base({ ProjectileIds = game.SessionMapState[_PLUGIN.guid .. "EosTorchOrbitIds"] })
            game.SessionMapState[_PLUGIN.guid .. "EosTorchOrbitIds"] = {}
        end
        return base(args)
    end)
end)