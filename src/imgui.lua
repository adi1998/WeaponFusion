
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
}

local DisplayNameWeaponNameMap = {}

for key, value in pairs(WeaponNameDisplayNameMap) do
    DisplayNameWeaponNameMap[value] = key
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
print(mod.dump(mod.AspectDisplayNameMap))
print(mod.dump(WeaponMinorAspectData))
function DrawMenu()
    if game.CurrentHubRoom then
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
            UnfuseWeapons()
            config.last_primary = config.primary
            config.last_secondary = config.secondary
            config.last_aspect = config.aspect
            FuseWeapon(config.primary, config.secondary, config.aspect)
        end

        rom.ImGui.SameLine(); clicked = rom.ImGui.Button("Unfuse")
        if clicked then
            config.last_primary = "WeaponStaffSwing"
            config.last_secondary = "WeaponStaffSwing"
            config.last_aspect = "None"
            UnfuseWeapons()
        end
    else
        rom.ImGui.Text("Fusion only allowed at the Crossroads.")
    end
end