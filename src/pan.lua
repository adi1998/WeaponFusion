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
            Wait = 0.7,
            ResetIndicator = true,
            WeaponProperties = {
                NumProjectiles = 2,
            }
        },
        AddProjectedChargeStages = {
            NumStages = 4,
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
            Wait = 0.7,
            ResetIndicator = true,
            WeaponProperties = {
                NumProjectiles = 2,
                ProjectileInterval = 0.04,
                ProjectileAngleOffset = math.rad(15),
                ProjectileOffsetStart = "CENTER"
            }
        },
        AddProjectedChargeStages = {
            NumStages = 4,
            ProjectedChanges =
            {
                NumProjectiles = 1,
                ManaCost = 20,
            },
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