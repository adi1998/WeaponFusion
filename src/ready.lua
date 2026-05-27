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
        },
        SecondaryHammers = {
            "StaffSecondStageTrait",
            "StaffPowershotTrait",
            "StaffFastSpecialTrait",
            "StaffJumpSpecialTrait",
            "StaffTripleShotTrait",

            "StaffLoneShadeRallyTrait",

            -- aspect young mel
            "StaffDoubleHealTraitYM",
            "StaffSpecialHomingTraitYM"
        },
        CommonHammers = {
            "StaffLoneShadeRespawnTrait",
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

            "DaggerTripleHomingSpecialTrait",
        },
        CommonHammers = {
            "DaggerTripleBuffTrait",
            "DaggerTripleRepeatWomboTrait"
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
        },
        SecondaryHammers = {
            "AxeSecondStageTrait",
            "AxeBlockEmpowerTrait",
            "AxeArmorTrait",
            "AxeChargedSpecialTrait",

            -- aspect young mel
            "AxeShieldDeflectTraitYM",
            "AxeExtendedRetaliateTraitYM",
        },
        CommonHammers = {
            "AxeRallyFrenzyTrait"
        }
    },

    WeaponTorch = {
        Primary = { },
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
        CommonHammers = {
            "TorchAutofireSprintTrait",
        },
    },

    WeaponLob = {
        Primary = {
            "WeaponLobChargedPulse",
        },
        Secondary = {
            "WeaponLobSpecial", "WeaponSkullImpulse"
        },
        PrimaryHammers = {
            "LobAmmoTrait",
            "LobAmmoMagnetismTrait",
            "LobSpreadShotTrait",
            "LobPulseAmmoCollectTrait",
            "LobPulseAmmoTrait", -- funky requirements
            "LobGrowthTrait",
            "LobStraightShotTrait",

            "LobGunBounceTrait",
            "LobGunAttackRangeTrait",
            "LobGunAttackDoublerTrait"
        },
        SecondaryHammers = {
            "LobRushArmorTrait",
            "LobOneSideTrait",
            "LobSturdySpecialTrait",
            "LobSpecialSpeedTrait",
            "LobInOutSpecialExTrait",

            "LobGunSpecialBounceTrait"
        },
        CommonHammers = {
            "LobGunOverheatTrait",
        }
    },

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

            "SuitComboForwardRocketTrait",
            "SuitComboDoubleSpecialTrait",
        },
    }
}

function MorosSpecialDetonatePatches()
    local specialWeaponProjectileMap = {
        ["WeaponStaffBall"] = {
            "ProjectileStaffBall",
            "ProjectileStaffBallCharged"
        },
        ["WeaponAxeSpecialSwing"] = {
            "ProjectileAxeBlock2",
        },
        ["WeaponAxeSpecial"] = {
            "ProjectileAxeSpecial",
        },
        ["WeaponDaggerThrow"] = {
            "ProjectileDaggerThrowCharged",
            "ProjectileDaggerThrow"
        },
        ["WeaponSuitRanged"] = {
            "ProjectileSuitRangedGuided",
            "ProjectileSuitRangedUnguided",
            "ProjectileSuitRangedCharged",
            "ProjectileSuitRangedChargedUnguided",
            "ProjectileSuitRangedGuidedSplit",
            "ProjectileSuitRangedChargedSplit",

            "ProjectileSuitGrenade",
            "ProjectileSuitBomb",
            "ProjectileSuitGrenadeStraight",
            "ProjectileSuitBombStraight"
        },
        ["WeaponLobSpecial"] = {
            "ProjectileThrowBlink",
            "ProjectileThrowCharged",
            "ProjectileLobGunRift",
            "ProjectileLobSpecialBounce"
        }
    }
    local detonateSkip = game.ToLookup({
        "ProjectileStaffBallCharged",

        "ProjectileSuitRangedGuided",
        "ProjectileSuitRangedUnguided",
        "ProjectileSuitRangedCharged",
        "ProjectileSuitRangedChargedUnguided",
        "ProjectileSuitRangedGuidedSplit",
        "ProjectileSuitRangedChargedSplit",

        "ProjectileSuitGrenade",
        "ProjectileSuitBomb",
        "ProjectileSuitGrenadeStraight",
        "ProjectileSuitBombStraight"
    })

    for weaponName, projectiles in pairs(specialWeaponProjectileMap) do
        for _, projectileName in ipairs(projectiles) do
            table.insert(game.TraitData.TorchDetonateAspect.PropertyChanges, {
				WeaponName = weaponName,
				ProjectileName = projectileName,
				ProjectileProperty = "CollisionLayer",
				ChangeValue = "Lyre",
				ChangeType = "Absolute",
			})
            table.insert(game.TraitData.TorchDetonateAspect.PropertyChanges, {
				WeaponName = weaponName,
				ProjectileName = projectileName,
				ProjectileProperty = "DetonatesProjectilesOnLayer",
				ChangeValue = true,
				ChangeType = "Absolute",
			})
            if not detonateSkip[projectileName] then
                table.insert(game.TraitData.TorchDetonateAspect.PropertyChanges, {
                    WeaponName = weaponName,
                    ProjectileName = projectileName,
                    ProjectileProperty = "DetonateOnImpact",
                    ChangeValue = false,
                    ChangeType = "Absolute",
                })
            end
        end
    end
end
MorosSpecialDetonatePatches()

function PatchHammerAspectRequirement(requirement)
    local newRequirement = requirement
    if requirement.IsAny then
        newRequirement =
        {
            Path = {"CurrentRun", "Hero", "TraitDictionary"},
            HasAny = { }
        }
        for _, traitName in ipairs(requirement.IsAny) do
            table.insert(newRequirement.HasAny, traitName)
            table.insert(newRequirement.HasAny, traitName.."_Secondary")
        end
    end
    if requirement.IsNone or requirement.HasNone then
        newRequirement =
        {
            Path = {"CurrentRun", "Hero", "TraitDictionary"},
            HasNone = { },
        }
        for _, traitName in ipairs(requirement.IsNone or requirement.HasNone) do
            table.insert(newRequirement.HasNone, traitName)
            table.insert(newRequirement.HasNone, traitName.."_Secondary")
        end
    end
    return newRequirement
end

function PatchSecondaryHammerRequirements(hammerName, weaponName)
    local hammerData = game.TraitData[hammerName]
    if hammerData then
        hammerData.GameStateRequirements[1] =
        {
            Path = { "CurrentRun", "Hero", "Weapons", },
            HasAll = { weaponName, },
        }
        local secondRequirement = hammerData.GameStateRequirements[2]
        if secondRequirement then
            hammerData.GameStateRequirements[2] = PatchHammerAspectRequirement(secondRequirement)
        end
    end
end

function PatchCommonHammerRequirements(hammerName, weaponName, secondWeaponName)
    local hammerData = game.TraitData[hammerName]
    if hammerData then
        hammerData.GameStateRequirements[1] =
        {
            Path = { "CurrentRun", "Hero", "Weapons", },
            HasAny = { weaponName, secondWeaponName},
        }
        local secondRequirement = hammerData.GameStateRequirements[2]
        if secondRequirement then
            hammerData.GameStateRequirements[2] = PatchHammerAspectRequirement(secondRequirement)
        end
    end
end

local secondaryWeaponMinorAspectMap = {}

for weaponName, aspectNameList in pairs(game.ScreenData.WeaponUpgradeScreen.DisplayOrder) do
    if mod.WeaponData[weaponName] then
        local secondaryWeaponName = mod.WeaponData[weaponName].Secondary[1]
        secondaryWeaponMinorAspectMap[secondaryWeaponName] = { }
        for _, aspectName in ipairs(aspectNameList) do
            if mod.AspectTraitData[aspectName .. "_Secondary"] then
                secondaryWeaponMinorAspectMap[secondaryWeaponName][aspectName .. "_Secondary"] = true
            end
        end
        local mapCopy = secondaryWeaponMinorAspectMap[secondaryWeaponName]
        for index, linkedWeaponName in ipairs(mod.WeaponData[weaponName].Secondary) do
            secondaryWeaponMinorAspectMap[linkedWeaponName] = mapCopy
        end
    end
end

function PatchSecondaryHammerPropertyChanges(hammerName, weaponName)
    local traitData = game.TraitData[hammerName]
    if traitData then
        local newPropertyChanges = {}
        local replacePropertyChanges = {}
        for propertyIndex, property in ipairs(traitData.PropertyChanges or {}) do
            local weaponName = property.WeaponName
            local minorAspectMap = secondaryWeaponMinorAspectMap[weaponName]
            if minorAspectMap then
                local duplicate = 0
                if property.TraitName and minorAspectMap[property.TraitName .. "_Secondary"] then
                    local newProperty = game.DeepCopyTable(property)
                    newProperty.TraitName = property.TraitName .. "_Secondary"
                    table.insert(newPropertyChanges, newProperty)
                    duplicate = duplicate + 1
                end
                if property.FalseTraitName and minorAspectMap[property.FalseTraitName .. "_Secondary"] then
                    local newProperty = game.DeepCopyTable(property)
                    newProperty.FalseTraitName = nil
                    newProperty.FalseTraitNames = { property.FalseTraitName, property.FalseTraitName .. "_Secondary" }
                    replacePropertyChanges[propertyIndex] = newProperty
                    duplicate = duplicate + 1
                end
                if property.TraitNames then
                    local newProperty
                    for index, traitName in ipairs(property.TraitNames) do
                        if minorAspectMap[traitName .. "_Secondary"] then
                            newProperty = game.DeepCopyTable(property)
                            newProperty.TraitNames[index] = traitName .. "_Secondary"
                            table.insert(newPropertyChanges, newProperty)
                            duplicate = duplicate + 1
                        end
                    end
                end
                if property.FalseTraitNames then
                    local newProperty = game.DeepCopyTable(property)
                    for _, traitName in ipairs(property.FalseTraitNames) do
                        if minorAspectMap[traitName .. "_Secondary"] then
                            table.insert(newProperty.FalseTraitNames, traitName.."_Secondary")
                            replacePropertyChanges[propertyIndex] = newProperty
                            duplicate = duplicate + 1
                        end
                    end
                end
                if duplicate > 1 then
                    print("multiple property changes detected for", hammerName, propertyIndex, mod.dump(property))
                end
            end
        end
        for index, property in pairs(replacePropertyChanges) do
            traitData.PropertyChanges[index] = property
        end
        for _, property in ipairs(newPropertyChanges) do
            table.insert(traitData.PropertyChanges, property)
        end
    end
end

for weapon, modWeaponData in pairs(mod.WeaponData) do
    for _, hammerName in ipairs(modWeaponData.SecondaryHammers) do
        PatchSecondaryHammerRequirements(hammerName, modWeaponData.Secondary[1])
        PatchSecondaryHammerPropertyChanges(hammerName, modWeaponData.Secondary[1])
    end
    for _, hammerName in ipairs(modWeaponData.CommonHammers or {}) do
        PatchCommonHammerRequirements(hammerName, weapon, modWeaponData.Secondary[1])
    end
end

function mod.PatchBoonVfx()
    local specialBoonList = {
        "ApolloSpecialBoon",
        "AphroditeSpecialBoon",
        "AresSpecialBoon",
        "DemeterSpecialBoon",
        "HeraSpecialBoon",
        "HephaestusSpecialBoon",
        "PoseidonSpecialBoon",
        "ZeusSpecialBoon",
        "HestiaSpecialBoon"
    }
    for _, specialBoon in ipairs(specialBoonList) do
        local traitData = game.TraitData[specialBoon]
        local newPropertyChanges = {}
        local replacePropertyChanges = {}
        for propertyIndex, property in ipairs(traitData.PropertyChanges) do
            local weaponName = property.WeaponName
            local minorAspectMap = secondaryWeaponMinorAspectMap[weaponName]
            if minorAspectMap then
                local duplicate = 0
                if property.TraitName and minorAspectMap[property.TraitName .. "_Secondary"] then
                    local newProperty = game.DeepCopyTable(property)
                    newProperty.TraitName = property.TraitName .. "_Secondary"
                    table.insert(newPropertyChanges, newProperty)
                    duplicate = duplicate + 1
                end
                if property.FalseTraitName and minorAspectMap[property.FalseTraitName .. "_Secondary"] then
                    local newProperty = game.DeepCopyTable(property)
                    newProperty.FalseTraitName = nil
                    newProperty.FalseTraitNames = { property.FalseTraitName, property.FalseTraitName .. "_Secondary" }
                    replacePropertyChanges[propertyIndex] = newProperty
                    duplicate = duplicate + 1
                end
                if property.TraitNames then
                    local newProperty
                    for index, traitName in ipairs(property.TraitNames) do
                        if minorAspectMap[traitName .. "_Secondary"] then
                            newProperty = game.DeepCopyTable(property)
                            newProperty.TraitNames[index] = traitName .. "_Secondary"
                            table.insert(newPropertyChanges, newProperty)
                            duplicate = duplicate + 1
                        end
                    end
                end
                if property.FalseTraitNames then
                    local newProperty = game.DeepCopyTable(property)
                    for _, traitName in ipairs(property.FalseTraitNames) do
                        if minorAspectMap[traitName .. "_Secondary"] then
                            table.insert(newProperty.FalseTraitNames, traitName.."_Secondary")
                            replacePropertyChanges[propertyIndex] = newProperty
                            duplicate = duplicate + 1
                        end
                    end
                end
                if duplicate > 1 then
                    print("multiple property changes detected for", specialBoon, propertyIndex, mod.dump(property))
                end
            end
        end
        for _, property in ipairs(newPropertyChanges) do
            table.insert(traitData.PropertyChanges, property)
        end
        for index, property in pairs(replacePropertyChanges) do
            traitData.PropertyChanges[index] = property
        end
    end
end

mod.PatchBoonVfx()

function mod.PatchHeroWeaponSets(primarySource, secondarySource)
    local primaryData = mod.WeaponData[primarySource]
    local secondaryData = mod.WeaponData[secondarySource]

    game.WeaponSets.HeroWeaponSets[primarySource] = game.CombineTablesIPairs(primaryData.Primary, secondaryData.Secondary)
    game.WeaponSets.HeroWeaponSets[secondarySource] = game.CombineTablesIPairs(secondaryData.Primary, primaryData.Secondary)
end

function FuseWeapon(primarySource, secondarySource, secondaryAspect)
    mod.PatchHeroWeaponSets(primarySource, secondarySource)

    game.WeaponData[primarySource].SecondaryWeapon, game.WeaponData[secondarySource].SecondaryWeapon = mod.WeaponData[secondarySource].Secondary[1], mod.WeaponData[primarySource].Secondary[1]

    print("Fusing", primarySource, secondarySource, secondaryAspect)

    if primarySource ~= secondarySource and mod.AspectTraitData[secondaryAspect] then
        for _, traitName in ipairs(game.ScreenData.WeaponUpgradeScreen.DisplayOrder[primarySource]) do
            game.TraitData[traitName][_PLUGIN.guid .. "SecondaryAspect"] = secondaryAspect
        end
    end

    game.SetupRunData()
end

function UnfuseWeapons()
    for _, aspectList in pairs(game.ScreenData.WeaponUpgradeScreen.DisplayOrder) do
        for _, aspectName in ipairs(aspectList) do
            game.TraitData[aspectName][_PLUGIN.guid .. "SecondaryAspect"] = nil
        end
    end
    for weapon, _ in pairs(mod.WeaponData) do
        FuseWeapon(weapon, weapon)
    end
end

UnfuseWeapons()

if mod.WeaponData[config.last_primary] and mod.WeaponData[config.last_secondary] then
    FuseWeapon(config.last_primary, config.last_secondary, config.last_aspect)
end

modutil.mod.Path.Wrap("SetupMap", function(base, ...)
    game.LoadPackages({Names = {"WeaponStaffSwing", "WeaponAxe", "WeaponDagger", "WeaponTorch", "WeaponSuit", "WeaponLob"}})
    return base(...)
end)

modutil.mod.Path.Wrap("EquipWeaponUpgrade", function (base, hero, args)
    local val = base(hero, args)
    args = args or {}
	local currentWeaponName = game.GetEquippedWeapon()
	local currentWeaponData = game.WeaponData[currentWeaponName]
	local traitName = game.GameState.LastWeaponUpgradeName[currentWeaponName] or game.ScreenData.WeaponUpgradeScreen.DisplayOrder[currentWeaponName][1]
    if traitName then
        local traitData = game.TraitData[traitName]
        local aspectTraitName = traitData[_PLUGIN.guid .. "SecondaryAspect"]
        print("equipping minor aspect", aspectTraitName)
        if traitData and aspectTraitName and (not game.HeroHasTrait( aspectTraitName )) then
            print("adding secondary aspect trait")
            local origAspectTraitName = string.gsub(aspectTraitName, "_Secondary", "")
            local level = game.GetWeaponUpgradeLevel(origAspectTraitName)
            print("applying trait with level", origAspectTraitName, level)
            local rarity = game.GetRarityKey( level, game.TraitRarityData.WeaponRarityUpgradeOrder )
            print("Rarity", rarity)
            game.AddTraitToHero({ TraitName = aspectTraitName, Rarity = rarity })
            local aspectTraitData = game.TraitData[aspectTraitName]
            if aspectTraitData.ReplacementGrannyModels ~= nil then
				for originalModel, attachmentModel in pairs(aspectTraitData.ReplacementGrannyModels) do
					game.SetThingProperty({ Property = "GrannyAlternateModelAttachment", Value = attachmentModel, OriginalAttachmentModel = originalModel, DestinationId = game.CurrentRun.Hero.ObjectId })
				end
			end
            if aspectTraitData.LinkedSpell then
                print("equipping Spell", aspectTraitData.LinkedSpell)
                local spellName = aspectTraitData.LinkedSpell
                local spellTraitName = game.SpellData[spellName].TraitName
                local spellTraitData = game.AddTraitToHero({ TraitName = spellTraitName, SkipUIUpdate = args.SkipUIUpdate, SkipNewTraitHighlight = args.SkipTraitHighlight, SkipQuestStatusCheck = args.SkipQuestStatusCheck })
                if spellTraitData.CheckChargeFunctionName then
                    game.thread( game.CallFunctionName, spellTraitData.CheckChargeFunctionName, game.CurrentRun.Hero )
                end
                game.CurrentRun.Hero.SlottedSpell = game.DeepCopyTable( game.SpellData[spellName] )
                game.CurrentRun.Hero.SlottedSpell.Talents = game.DeepCopyTable( game.CreateTalentTree( game.SpellData[spellName] ) )
                local spellData = game.CurrentRun.Hero.SlottedSpell
                game.UpdateTalentPointInvestedCache()
                game.UpdateSpellActiveStatus()
                game.UpdateHeroTraitDictionary()
            end
        end
    end
    return val
end)

modutil.mod.Path.Wrap("UpgradeAspect", function (base, args, origTraitData)
    base(args, origTraitData)

    args = args or {}
	local currentWeaponName = game.GetEquippedWeapon()

	local traitName = game.GameState.LastWeaponUpgradeName[currentWeaponName]
	if traitName == nil then
		traitName = game.ScreenData.WeaponUpgradeScreen.FreeUnlocks[currentWeaponName]
	end
	if not traitName then
		return
	end
    local traitData = game.TraitData[traitName] or {}
    local minorTraitName = traitData[_PLUGIN.guid .. "SecondaryAspect"]
    local minorTraitData = game.TraitData[minorTraitName]
    if minorTraitData then
        if minorTraitName and game.HeroHasTrait( minorTraitName ) then
		    game.RemoveTrait( game.CurrentRun.Hero, minorTraitName )
	    end
        local numRanks = game.GetWeaponUpgradeLevel( string.gsub(minorTraitName, "_Secondary", "") ) + args.UpgradeLevels
        local rarity = game.TraitRarityData.WeaponRarityUpgradeOrder[numRanks]
        game.AddTraitToHero({ SkipNewTraitHighlight = args.SkipTraitHighlight, TraitName = minorTraitName, Rarity = rarity })
    end
end)

modutil.mod.Path.Wrap("UnequipWeaponUpgrade", function (base, args)
    for traitName, _ in pairs(mod.AspectTraitData) do
        print("unequipping minor aspect", traitName)
        local traitData = game.TraitData[traitName]
        if traitData.LinkedSpell and game.HeroHasTrait( traitName ) then
            print("unequipping Spell", traitData.LinkedSpell)
            game.UnequipLinkedSpell( traitData )
        end
        while game.HeroHasTrait( traitName ) do
            game.RemoveTrait( game.CurrentRun.Hero, traitName )
        end
        if traitData.ReplacementGrannyModels ~= nil then
            for originalModel, _ in pairs(traitData.ReplacementGrannyModels) do
                game.SetThingProperty({ Property = "GrannyAlternateModelAttachment", Value = originalModel, OriginalAttachmentModel = originalModel, DestinationId = game.CurrentRun.Hero.ObjectId })
            end
        end
    end
    local val = base(args)
    return val
end)

modutil.mod.Path.Wrap("TorchSpecialAutofire", function (base, ...)
    if not game.CurrentRun.Hero.Weapons["WeaponTorchSpecial"] then
        return
    end
    return base(...)
end)

modutil.mod.Path.Wrap("TorchPrimaryAutofire", function (base, ...)
    if not game.CurrentRun.Hero.Weapons["WeaponTorch"] then
        return
    end
    return base(...)
end)

modutil.mod.Path.Wrap("SetupMap", function (base, ...)
    game.LoadPackages({Names = {_PLUGIN.guid}})
    return base(...)
end)

-- game.OnControlPressed({'Gift', function()
-- 	return mod.OpenWeaponFusionScreen()
-- end})

modutil.mod.Path.Wrap("addDamageMultiplier", function (base, data, multiplier)
    if multiplier ~= multiplier and data.SuccessiveProjectileMultiplier then
        if game.SessionMapState[_PLUGIN.guid .. "MomusAxeCurrentProjectileIndex"] then
            return base(data, 1 + ( game.SessionMapState[_PLUGIN.guid .. "MomusAxeCurrentProjectileIndex"] - 1 ) * data.SuccessiveProjectileMultiplier)
        end
        return
    end
    return base(data, multiplier)
end)