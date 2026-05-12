
function mod.UnequipWeapons()
    game.UnequipWeaponUpgrade()
    local toUnequip = {}
    local heroId = game.CurrentRun.Hero.ObjectId
	for k, weaponName in ipairs( game.WeaponSets.HeroPrimaryWeapons ) do
        game.CurrentRun.Hero.Weapons[weaponName] = nil
        local unequipWeaponData = game.WeaponData[weaponName]
        if unequipWeaponData.SecondaryWeapon ~= nil then
            game.CurrentRun.Hero.Weapons[unequipWeaponData.SecondaryWeapon] = nil
        end
        table.insert( toUnequip, weaponName )
        game.ConcatTableValues( toUnequip, game.WeaponSets.HeroWeaponSets[weaponName] )
        if unequipWeaponData.DummyTraitName ~= nil then
            game.RemoveTrait( game.CurrentRun.Hero, unequipWeaponData.DummyTraitName )
        end
        if unequipWeaponData.UnequipFunctionName then
            game.thread( game.CallFunctionName, unequipWeaponData.UnequipFunctionName )
        end
	end
    game.UnequipWeapon({ DestinationId = heroId, Names = toUnequip, UnloadPackages = false })
	game.RemoveTableValues( game.MapState.EquippedWeapons, toUnequip )
end

function mod.EquipWeapons(args)
    local weaponKit = game.WeaponData[config.last_primary]
    args = args or {}
	game.AddInputBlock({ Name = "PickupWeaponKit" })
	if game.GameState.ActiveObjectiveSet == nil or game.ObjectiveSetData[game.GameState.ActiveObjectiveSet] == nil or not game.ObjectiveSetData[game.GameState.ActiveObjectiveSet].BlockWeaponObjectives then
		game.ClearObjectives()
	end
	game.Halt({ Id = game.CurrentRun.Hero.ObjectId })
	game.EndRamWeapons({ Id = game.CurrentRun.Hero.ObjectId })
	local weaponUntouched = game.IsWeaponUntouched( weaponKit.Name )
	game.UnequipWeaponUpgrade()
	game.EquipPlayerWeapon( weaponKit, args )
    if args.PrimaryUpgrade then
        game.GameState.LastWeaponUpgradeName[weaponKit.Name] = args.PrimaryUpgrade
    end
	game.EquipWeaponUpgrade( game.CurrentRun.Hero )

	local weaponData = game.GetWeaponData( game.CurrentRun.Hero, weaponKit.Name)
	game.RunEventsGeneric( weaponData.StartRoomEvents, weaponData )
	if weaponUntouched then
		game.FirstTimeWeaponPickupPresentation( weaponKit )
	end

	game.thread( game.UpdateWeaponKits )

	game.RemoveInputBlock({ Name = "PickupWeaponKit" })
end

WeaponMinorAspectData = {}

for weaponName, aspectNameList in pairs(game.ScreenData.WeaponUpgradeScreen.DisplayOrder) do
    WeaponMinorAspectData[weaponName] = {"None"}
    print(weaponName)
    for _, aspectName in ipairs(aspectNameList) do
        if mod.AspectTraitData[aspectName .. "_Secondary"] then
            table.insert(WeaponMinorAspectData[weaponName], aspectName .. "_Secondary")
        end
    end
end

function PickRandomFusion()
    local weaponKits = game.DeepCopyTable(game.BountyData.BasePackageBountyRandom.RandomWeaponKitNames)
    for index, value in ipairs(weaponKits) do
        if not game.IsWeaponUnlocked(value) then
            weaponKits[index] = nil
        end
    end
    weaponKits = game.CollapseTable(weaponKits)
    local weaponUpgrades = game.DeepCopyTable(game.ScreenData.WeaponUpgradeScreen.DisplayOrder)
    for weaponKit, upgradeList in pairs(weaponUpgrades) do
        for index, upgrade in ipairs(upgradeList) do
            if not game.GameState.WeaponsUnlocked[upgrade] then
                upgradeList[index] = nil
            end
        end
        weaponUpgrades[weaponKit] = game.CollapseTable(upgradeList)
    end
    local randomWeaponKit = game.GetRandomArrayValue(weaponKits)
    local randomWeaponUpgrade = game.GetRandomArrayValue(weaponUpgrades[randomWeaponKit])
    print("selected random weapon", randomWeaponKit, randomWeaponUpgrade)
    game.RemoveValueAndCollapse(weaponKits, randomWeaponKit)
    local secondRandomWeapon = game.GetRandomArrayValue(weaponKits)
    local secondRandomUpgrade = game.GetRandomArrayValue(WeaponMinorAspectData[secondRandomWeapon])
    print("selected second random weapon", secondRandomWeapon, secondRandomUpgrade)

    mod.UnequipWeapons()
    UnfuseWeapons()
    config.last_primary = randomWeaponKit
    config.last_secondary = secondRandomWeapon
    config.last_aspect = secondRandomUpgrade
    FuseWeapon(config.last_primary, config.last_secondary, config.last_aspect)
    mod.EquipWeapons({PrimaryUpgrade = randomWeaponUpgrade})
end

modutil.mod.Path.Wrap("StartOver", function (base, args)
    args = args or {}
    if config.random_fusion_each_run and not args.ActiveBounty then
        PickRandomFusion()
    end
    if args.ActiveBounty then
        local weaponKit = "WeaponStaffSwing"
        for weapon, _ in pairs(mod.WeaponData) do
            if game.CurrentRun.Hero.Weapons[weapon] then
                weaponKit = weapon
            end
        end
        mod.UnequipWeapons()
        config.last_primary = weaponKit
        config.last_secondary = weaponKit
        config.last_aspect = "None"
        UnfuseWeapons()
        mod.EquipWeapons({PrimaryUpgrade = game.GameState.LastWeaponUpgradeName[weaponKit]})
    end
    return base(args)
end)