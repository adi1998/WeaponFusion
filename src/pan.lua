local origChargeStage = game.TraitData.DaggerHomingThrowAspect.ChargeStageModifiers

game.TraitData.DaggerHomingThrowAspect.ChargeStageModifiers = nil

game.TraitData.DaggerHomingThrowAspect.ChargeStageModifiersArray = {origChargeStage}

local newChargeStageModifiers = {
    {
        FalseTraitNames = {"StaffSecondStageTrait", "StaffTripleShotTrait"},
        ValidWeapons = {"WeaponStaffBall"},
        AddWeaponProperties =
        {
            -- NumProjectiles = 1,
            ProjectileInterval = 0.04,
            ProjectileAngleOffset = math.rad(12),
            ProjectileOffsetStart = "CENTER"
        },
        AddChargeStage = {
            ManaCost = 20,
            Wait = 0.65,
            ResetIndicator = true,
            WeaponProperties = {
                NumProjectiles = 2,
            }
        },
        AddProjectedChargeStages = {
            NumStages = {BaseValue = 0.5},
            ProjectedChanges =
            {
                NumProjectiles = 1,
                ManaCost = 10,
            },
        }
    },
    {
        FalseTraitNames = {"StaffTripleShotTrait"},
        TraitNames = {"StaffSecondStageTrait"},
        ValidWeapons = {"WeaponStaffBall"},
        AddChargeStage = {
            ManaCost = 60,
            Wait = 0.65,
            ResetIndicator = true,
            WeaponProperties = {
                NumProjectiles = 2,
                ProjectileInterval = 0.04,
                ProjectileAngleOffset = math.rad(15),
                ProjectileOffsetStart = "CENTER"
            }
        },
        AddProjectedChargeStages = {
            NumStages = {BaseValue = 0.5},
            ProjectedChanges =
            {
                NumProjectiles = 1,
                ManaCost = 20,
            },
        }
    },
    {
        TraitNames = {"StaffTripleShotTrait"},
        FalseTraitNames = {"StaffSecondStageTrait"},
        ValidWeapons = {"WeaponStaffBall"},
        AddChargeStage = {
            ManaCost = 20,
            Wait = 0.55,
            ResetIndicator = true,
            WeaponProperties = {
                NumProjectiles = 3,
                ProjectileInterval = 0.04,
                ProjectileAngleOffset = math.rad(15),
                ProjectileOffsetStart = "CENTER"
            }
        },
        AddProjectedChargeStages = {
            NumStages = { BaseValue = 0.8 },
            ProjectedChanges =
            {
                NumProjectiles = 1,
                ManaCost = 10,
            },
        },
        AddProjectileProperties = {
            Range = 528
        }
    },
    {
        TraitNames = {"StaffTripleShotTrait", "StaffSecondStageTrait"},
        ValidWeapons = {"WeaponStaffBall"},
        AddChargeStage = {
            ManaCost = 60,
            Wait = 0.55,
            ResetIndicator = true,
            WeaponProperties = {
                NumProjectiles = 3,
                ProjectileInterval = 0.04,
                ProjectileAngleOffset = math.rad(15),
                ProjectileOffsetStart = "CENTER"
            }
        },
        AddProjectedChargeStages = {
            NumStages = { BaseValue = 0.8 },
            ProjectedChanges =
            {
                NumProjectiles = 1,
                ManaCost = 20,
            },
        },
        AddProjectileProperties = {
            Range = 528
        }
    },
}

game.TraitData.DaggerHomingThrowAspect.ChargeStageModifiersArray = game.CombineTablesIPairs(game.TraitData.DaggerHomingThrowAspect.ChargeStageModifiersArray, newChargeStageModifiers)

modutil.mod.Path.Wrap("GetWeaponChargeStages", function (base, ...)
    local retval = base(...)
    print(mod.dump(retval))
    return retval
end)

modutil.mod.Path.Wrap("ApplyWeaponPropertyChange", function (base, unit, weaponName, propertyChange, reverse, skipWeaponUpdates)
    if unit == game.CurrentRun.Hero then
        print(weaponName, mod.dump(propertyChange))
    end
    return base(unit, weaponName, propertyChange, reverse, skipWeaponUpdates)
end)

modutil.mod.Path.Wrap("SuitSeekThread", function (base, weaponData, stageData)
    if game.HeroHasTrait("DaggerHomingThrowAspect") then
        weaponData.MaxTargets = 6 + 5
    else
        weaponData.MaxTargets = 6
    end
    return base(weaponData, stageData)
end)

function mod.FirePanLobGun(triggerArgs, functionArgs)
    local startAngle = game.GetAngle({ Id = game.CurrentRun.Hero.ObjectId })

    local propertyWeapon = "WeaponLobSpecial"

    local derivedValues = game.GetDerivedPropertyChangeValues({
        ProjectileName = functionArgs.ProjectileName,
        WeaponName = propertyWeapon,
        Type = "Projectile",
    })

    local spread = 80

    for i=1, functionArgs.NumProjectiles do
        game.CreateProjectileFromUnit({ WeaponName = propertyWeapon, Name = functionArgs.ProjectileName, Id = game.CurrentRun.Hero.ObjectId,
            Angle = startAngle - spread/2 + (i - 1) * spread/(math.ceil(functionArgs.NumProjectiles) - 1 ), DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges })
        game.wait(0.2)
    end
end

function mod.RefreshPanTorch(projectileId)
	local threadName = _PLUGIN.guid .. "RefreshPanTorchThread"
	local range = 100
	local direction = 1
	local ready_for_swap = true
	while true do
		game.SetProjectileProperty({ ProjectileId = projectileId, Property = "Range", Value = range})
		range = range + 15*direction
		if range > 900 and ready_for_swap then
			direction = -1
			ready_for_swap = false
		end
		if range == 400 then
			ready_for_swap = true
		end
		if range < 100 and ready_for_swap then
			direction = 1
			ready_for_swap = false
		end
		game.wait(0.01, threadName)
	end
end

function mod.FirePanTorchSpecial(weaponData, functionArgs, triggerArgs)
    if game.IsExWeapon( weaponData.Name, { Combat = true }, triggerArgs ) then
		game.SetWeaponProperty({ WeaponName = "WeaponTorchSpecial", DestinationId = game.CurrentRun.Hero.ObjectId, Property = "ActiveProjectileCap2", Value = 10})
        game.SessionMapState[_PLUGIN.guid .. "PanTorchSpecialIds"] = game.SessionMapState[_PLUGIN.guid .. "PanTorchSpecialIds"] or {}
        game.ExpireProjectiles({ProjectileIds = game.SessionMapState[_PLUGIN.guid .. "PanTorchSpecialIds"]})
        game.SessionMapState[_PLUGIN.guid .. "PanTorchSpecialIds"] = {}
		game.killTaggedThreads(_PLUGIN.guid .. "RefreshPanTorchThread")
		game.wait(0.1)
        local weaponName = weaponData.Name
        local numProjectiles = functionArgs.NumProjectiles
        local projectileName = "ProjectileTorchOrbitEx"

        local derivedValues = game.GetDerivedPropertyChangeValues({
            ProjectileName = projectileName,
            WeaponName = weaponName,
            Type = "Projectile",
            MatchProjectileName = true,
        })

        game.OverwriteTableKeys(derivedValues.PropertyChanges, {
            Range = 800,
            Speed = 250,
            ArcEnd = -10800,
            ReturnToOwnerAfterInactiveSeconds = 0,
            MinRange = 0,
            MaxRange = 0,
        })

        local angle = math.random(0,360)

        for i = 1, numProjectiles do
			local torchOrbitId = game.CreateProjectileFromUnit({ WeaponName = weaponName,
				Name = projectileName,
				Id = game.CurrentRun.Hero.ObjectId,
                DestinationId = game.CurrentRun.Hero.ObjectId,
				DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges, Angle = angle + i*360/numProjectiles
			})
			game.thread(mod.RefreshPanTorch, torchOrbitId)
			table.insert(game.SessionMapState[_PLUGIN.guid .. "PanTorchSpecialIds"], torchOrbitId)
		end
		game.wait(7, _PLUGIN.guid .. "RefreshPanTorchThread")
		game.killTaggedThreads(_PLUGIN.guid .. "RefreshPanTorchThread")
    end
end