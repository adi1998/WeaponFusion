function mod.dump(o, depth)
    depth = depth or 0
    if type(o) == 'table' then
        local s = "\n" .. string.rep("\t", depth) .. '{\n'
        for k,v in pairs(o) do
            if type(k) ~= 'number' then k = '"'..k..'"' end
            s = s .. string.rep("\t",(depth+1)) .. '['..k..'] = ' .. mod.dump(v, depth + 1) .. ',\n'
        end
        return s .. string.rep("\t", depth) .. '}'
    elseif type(o) == "string" then
        return "\"" .. o .. "\""
    else
        return tostring(o)
    end
end

mod.WeaponData = {
    WeaponStaffSwing = {
        Primary = {
            "WeaponStaffSwing2", "WeaponStaffSwing3", "WeaponStaffSwing5", "WeaponStaffDash"
        },
        Secondary = {
            "WeaponStaffBall"
        },
        PrimaryHammers = {
            "StaffExHealTrait",
            "StaffDoubleAttackTrait",
            "StaffLongAttackTrait",
            "StaffDashAttackTrait",
            "StaffAttackRecoveryTrait",
            "StaffExAoETrait",
            "StaffOneWayAttackTrait",
            "StaffRaiseDeadBigTrait",
            "StaffRaiseDeadDoubleTrait",
            "StaffLoneShadeRespawnTrait",

        },
        SecondaryHammers = {
            "StaffSecondStageTrait",
            "StaffPowershotTrait",
            "StaffFastSpecialTrait",
            "StaffJumpSpecialTrait",
            "StaffTripleShotTrait",
        }
    },

    WeaponDagger = {
        Primary = {
            "WeaponDagger2", "WeaponDagger5", "WeaponDaggerDash", "WeaponDaggerDouble", "WeaponDaggerMultiStab", "WeaponDaggerBlink"
        },
        Secondary = {
            "WeaponDaggerThrow"
        },
        PrimaryHammers = {
            "DaggerBlinkAoETrait",
            "DaggerDashAttackTripleTrait",
            "DaggerRapidAttackTrait",
            "DaggerAttackFinisherTrait",
            "DaggerFinalHitTrait",
            "DaggerBackstabTrait",
        },
        SecondaryHammers = {
            "DaggerSpecialLineTrait",
            "DaggerSpecialFanTrait",
            "DaggerSpecialConsecutiveTrait",
            "DaggerSpecialJumpTrait",
            "DaggerChargeStageSkipTrait",
            "DaggerSpecialReturnTrait",

        }
    },

    WeaponAxe = {
        Primary = {
            "WeaponAxe2", "WeaponAxe3", "WeaponAxeDash", "WeaponAxeSpin"
        },
        Secondary = {
            "WeaponAxeSpecial", "WeaponAxeSpecialSwing"
        },
        PrimaryHammers = {
            "AxeSturdyTrait",
            "AxeDashAttackTrait",
            "AxeFreeSpinTrait",
            "AxeRangedWhirlwindTrait",
            "AxeSpinSpeedTrait",
            "AxeAttackRecoveryTrait",
            "AxeThirdStrikeTrait",
            "AxeMassiveThirdStrikeTrait",
            "AxeRallyFirstStrikeTrait",
            "AxeRallyFrenzyTrait",
        },
        SecondaryHammers = {
            "AxeSecondStageTrait",
            "AxeBlockEmpowerTrait",
            "AxeArmorTrait",
            "AxeChargedSpecialTrait",
        },
    },

    WeaponTorch = {
        Primary = {

        },
        Secondary = {
            "WeaponTorchSpecial"
        },
        PrimaryHammers = {
            "TorchEnhancedAttackTrait",
            "TorchDiscountExAttackTrait",
            "TorchSplitAttackTrait",
            "TorchSpinAttackTrait",
            "TorchMoveSpeedTrait",
            "TorchAttackSpeedTrait",

        },
        SecondaryHammers = {
            "TorchSpecialImpactTrait",
            "TorchExSpecialCountTrait",
            "TorchSpecialSpeedTrait",
            "TorchLongevityTrait",
            "TorchOrbitPointTrait",
            "TorchSpecialLineTrait",

        },
    },

    -- WeaponLob = {
    --     Primary = {
    --         "WeaponLobChargedPulse",
    --     },
    --     Secondary = {
    --         "WeaponLobSpecial", "WeaponSkullImpulse"
    --     },
    --     PrimaryHammers = {
    --         "LobAmmoTrait",
    --         "LobAmmoMagnetismTrait",
    --         "LobSpreadShotTrait",
    --         "LobPulseAmmoCollectTrait",
    --         "LobPulseAmmoTrait",
    --         "LobGrowthTrait",
    --         "LobStraightShotTrait",

    --     },
    --     SecondaryHammers = {
    --         "LobRushArmorTrait",
    --         "LobOneSideTrait",
    --         "LobSturdySpecialTrait",
    --         "LobSpecialSpeedTrait",
    --         "LobInOutSpecialExTrait",

    --     }
    -- },

    WeaponSuit = {
        Primary = {
            "WeaponSuit2", "WeaponSuitDouble", "WeaponSuitCharged", "WeaponSuitDash",
        },
        Secondary = {
            "WeaponSuitRanged"
        },
        PrimaryHammers = {
            "SuitArmorTrait",
            "SuitAttackSpeedTrait",
            "SuitAttackSizeTrait",
            "SuitAttackRangeTrait",
            "SuitFullChargeTrait",
            "SuitDashAttackTrait",
            "SuitSpecialBlockTrait",
            "SuitComboBlockBuffTrait",
            "SuitComboDashAttackTrait",
            "SuitPowershotTrait",

        },
        SecondaryHammers = {
            "SuitSpecialJumpTrait",
            "SuitSpecialStartUpTrait",
            "SuitSpecialAutoTrait",
            "SuitSpecialDiscountTrait",
            "SuitSpecialConsecutiveHitTrait",

        },
    }
}

function PatchHammerRequirements(hammerName, weaponName)
    local hammerData = game.TraitData[hammerName]
    hammerData.GameStateRequirements[1] =
    {
        Path = { "CurrentRun", "Hero", "Weapons", },
        HasAll = { weaponName, },
    }
end

for weapon, modWeaponData in pairs(mod.WeaponData) do
    for _, hammerName in ipairs(modWeaponData.SecondaryHammers) do
        PatchHammerRequirements(hammerName, modWeaponData.Secondary[1])
    end
end

function mod.PatchHeroWeaponSets(primarySource, secondarySource)
    local primaryData = mod.WeaponData[primarySource]
    local secondaryData = mod.WeaponData[secondarySource]

    game.WeaponSets.HeroWeaponSets[primarySource] = game.CombineTablesIPairs(primaryData.Primary, secondaryData.Secondary)
    game.WeaponSets.HeroWeaponSets[secondarySource] = game.CombineTablesIPairs(secondaryData.Primary, primaryData.Secondary)
end

function FuseWeapon(primarySource, secondarySource, secondaryAspect)
    mod.PatchHeroWeaponSets(primarySource, secondarySource)

    game.WeaponData[primarySource].SecondaryWeapon, game.WeaponData[secondarySource].SecondaryWeapon = mod.WeaponData[secondarySource].Secondary[1], mod.WeaponData[primarySource].Secondary[1]

    if primarySource ~= secondarySource then
        for i = 1, 4 do
            game.TraitData[game.ScreenData.WeaponUpgradeScreen.DisplayOrder[primarySource][i]][_PLUGIN.guid .. "SecondaryAspect"] = "AxeArmCastAspect_Secondary"
        end
    end

    game.SetupRunData()
end

function UnfuseWeapons()
    for weapon, _ in pairs(mod.WeaponData) do
        FuseWeapon(weapon, weapon)
    end
end

UnfuseWeapons()

if mod.WeaponData[config.last_primary] and mod.WeaponData[config.last_secondary] then
    FuseWeapon(config.last_primary, config.last_secondary)
end

modutil.mod.Path.Wrap("SetupMap", function(base, ...)
    game.LoadPackages({Names = {"WeaponStaffSwing", "WeaponAxe", "WeaponDagger", "WeaponTorch", "WeaponSuit"}})
    return base(...)
end)

modutil.mod.Path.Wrap("EquipWeaponUpgrade", function (base, hero, args)
    local val = base(hero, args)
    args = args or {}
	local currentWeaponName = game.GetEquippedWeapon()
	local currentWeaponData = game.WeaponData[currentWeaponName]
	local traitName = game.GameState.LastWeaponUpgradeName[currentWeaponName]
    if traitName then
        local traitData = game.TraitData[traitName]
        local aspectTraitName = traitData[_PLUGIN.guid .. "SecondaryAspect"]
        print("equipping minor aspect", aspectTraitName)
        if traitData and aspectTraitName and (not game.HeroHasTrait( aspectTraitName )) then
            print("adding secondary aspect trait")
            game.AddTraitToHero({ TraitName = traitData[_PLUGIN.guid .. "SecondaryAspect"], SkipUIUpdate = true, SkipPriorityTray = true})
        end
    end
    return val
end)

modutil.mod.Path.Wrap("UnequipWeaponUpgrade", function (base, args)
    for traitName, _ in pairs(mod.AspectTraitData) do
        print("unequipping minor aspect")
        local traitData = game.TraitData[traitName]
        while game.HeroHasTrait( traitName ) do
            game.RemoveTrait( game.CurrentRun.Hero, traitName )
        end
    end
    local val = base(args)
    return val
end)

modutil.mod.Path.Override("BiomeMapPresentation", function (base, ...)
    return
end)