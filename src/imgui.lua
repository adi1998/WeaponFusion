
rom.gui.add_imgui(function()
    if rom.ImGui.Begin("Weapon Fusion") then
        DrawMenu()
        rom.ImGui.End()
    end
end)

rom.gui.add_to_menu_bar(function()
    if rom.ImGui.BeginMenu("Weapon Fusion") then
        DrawMenu()
        rom.ImGui.EndMenu()
    end
end)

local WeaponNameDisplayNameMap = {
    ["WeaponStaffSwing"] = "Descura",
    ["WeaponDagger"] = "Lim and Oros",
    ["WeaponTorch"] = "Ygnium",
    ["WeaponAxe"] = "Zorephet",
    ["WeaponSuit"] = "Xinth",
    ["WeaponLob"] = "Argent Skull",
}

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

function mod.EquipWeapons()
    local weaponKit = game.WeaponData[config.last_primary]
    local args = {}
	game.AddInputBlock({ Name = "PickupWeaponKit" })
	if game.GameState.ActiveObjectiveSet == nil or game.ObjectiveSetData[game.GameState.ActiveObjectiveSet] == nil or not game.ObjectiveSetData[game.GameState.ActiveObjectiveSet].BlockWeaponObjectives then
		game.ClearObjectives()
	end
	game.Halt({ Id = game.CurrentRun.Hero.ObjectId })
	game.EndRamWeapons({ Id = game.CurrentRun.Hero.ObjectId })
	local weaponUntouched = game.IsWeaponUntouched( weaponKit.Name )
	game.UnequipWeaponUpgrade()
	game.EquipPlayerWeapon( weaponKit, args )
	game.EquipWeaponUpgrade( game.CurrentRun.Hero )

	local weaponData = game.GetWeaponData( game.CurrentRun.Hero, weaponKit.Name)
	game.RunEventsGeneric( weaponData.StartRoomEvents, weaponData )
	if weaponUntouched then
		game.FirstTimeWeaponPickupPresentation( weaponKit )
	end

	game.thread( game.UpdateWeaponKits )
	game.thread( game.SpawnSkelly, 1.0 )

	game.RemoveInputBlock({ Name = "PickupWeaponKit" })
end

function DrawMenu()
    if game.CurrentHubRoom and game.CurrentHubRoom.Name == "Hub_PreRun" then
        rom.ImGui.Text("Try to not have either of the two       \nweapons equipped while fusing.")
        rom.ImGui.Text("If the weapons feel like they haven'       \nbeen swapped properly try exiting and         \nentering the room or starting a new run")

        rom.ImGui.Separator()
        rom.ImGui.Text("Currently fused weapon")

        local width = rom.ImGui.CalcTextSize("Secondary: ") + 60

        rom.ImGui.Text("Primary"); rom.ImGui.SameLine()
        rom.ImGui.SetCursorPosX(width)
        rom.ImGui.Text(WeaponNameDisplayNameMap[config.last_primary])

        rom.ImGui.Text("Secondary"); rom.ImGui.SameLine()
        rom.ImGui.SetCursorPosX(width)
        rom.ImGui.Text(WeaponNameDisplayNameMap[config.last_secondary])

        rom.ImGui.Text("Second Aspect"); rom.ImGui.SameLine()
        rom.ImGui.SetCursorPosX(width)
        rom.ImGui.Text((mod.AspectDisplayNameMap[config.last_aspect] or "None"))

        rom.ImGui.Separator()
        rom.ImGui.Text("Select Weapons to fuse")

        rom.ImGui.Text("Primary"); rom.ImGui.SameLine()
        -- rom.ImGui.SetCursorPosX(width)

        if rom.ImGui.BeginCombo("###primary", WeaponNameDisplayNameMap[config.primary]) then
            for _, weaponName in ipairs(WeaponDisplayOrder) do
                local displayName = WeaponNameDisplayNameMap[weaponName]
                if rom.ImGui.Selectable(displayName, weaponName == config.primary) then
                    if weaponName ~= config.primary then
                        config.primary = weaponName
                    end
                    rom.ImGui.SetItemDefaultFocus()
                end
            end
            rom.ImGui.EndCombo()
        end

        rom.ImGui.Text("Secondary"); rom.ImGui.SameLine()
        -- rom.ImGui.SetCursorPosX(width)

        if rom.ImGui.BeginCombo("###secondary", WeaponNameDisplayNameMap[config.secondary]) then
            for _, weaponName in ipairs(WeaponDisplayOrder) do
                local displayName = WeaponNameDisplayNameMap[weaponName]
                if rom.ImGui.Selectable(displayName, weaponName == config.secondary) then
                    if weaponName ~= config.secondary then
                        config.secondary = weaponName
                        config.aspect = WeaponMinorAspectData[weaponName][1] or "None"
                    end
                    rom.ImGui.SetItemDefaultFocus()
                end
            end
            rom.ImGui.EndCombo()
        end

        rom.ImGui.Text("Second Aspect"); rom.ImGui.SameLine()
        -- rom.ImGui.SetCursorPosX(width)

        if rom.ImGui.BeginCombo("###aspect", mod.AspectDisplayNameMap[config.aspect] or "None") then
            for _, aspectName in ipairs(WeaponMinorAspectData[config.secondary]) do
                local displayName = mod.AspectDisplayNameMap[aspectName] or "None"
                if rom.ImGui.Selectable(displayName, aspectName == config.aspect) then
                    if aspectName ~= config.aspect then
                        config.aspect = aspectName
                    end
                    rom.ImGui.SetItemDefaultFocus()
                end
            end 
            rom.ImGui.EndCombo()
        end

        local clicked = rom.ImGui.Button("Fuse")
        if clicked then
            mod.UnequipWeapons()
            UnfuseWeapons()
            config.last_primary = config.primary
            config.last_secondary = config.secondary
            config.last_aspect = config.aspect
            FuseWeapon(config.primary, config.secondary, config.aspect)
            mod.EquipWeapons()
            game.RequestPreRunLoadoutChangeSave()
        end

        rom.ImGui.SameLine(); clicked = rom.ImGui.Button("Unfuse")
        if clicked then
            mod.UnequipWeapons()
            config.last_primary = "WeaponStaffSwing"
            config.last_secondary = "WeaponStaffSwing"
            config.last_aspect = "None"
            UnfuseWeapons()
            mod.EquipWeapons()
            game.RequestPreRunLoadoutChangeSave()
        end
    else
        rom.ImGui.Text("Fusion only allowed in the\nCrossroads Training Grounds.")
    end
end
