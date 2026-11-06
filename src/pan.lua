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