
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

function DrawMenu()
    if game.CurrentHubRoom then
        rom.ImGui.Text("Primary")
        rom.ImGui.Text("Weapon"); rom.ImGui.SameLine()

        if rom.ImGui.BeginCombo("###primary", WeaponNameDisplayNameMap[config.last_primary]) then
            for displayName, weaponName in pairs(DisplayNameWeaponNameMap) do
                if rom.ImGui.Selectable(displayName, weaponName == config.last_primary) then
                    if weaponName ~= config.last_primary then
                        config.last_primary = weaponName
                    end
                    rom.ImGui.SetItemDefaultFocus()
                end
            end
            rom.ImGui.EndCombo()
        end

        rom.ImGui.Text("Secondary")
        rom.ImGui.Text("Weapon"); rom.ImGui.SameLine()
        if rom.ImGui.BeginCombo("###secondary", WeaponNameDisplayNameMap[config.last_secondary]) then
            for displayName, weaponName in pairs(DisplayNameWeaponNameMap) do
                if rom.ImGui.Selectable(displayName, weaponName == config.last_secondary) then
                    if weaponName ~= config.last_secondary then
                        config.last_secondary = weaponName
                    end
                    rom.ImGui.SetItemDefaultFocus()
                end
            end
            rom.ImGui.EndCombo()
        end

        rom.ImGui.Text("Aspect"); rom.ImGui.SameLine()
        if rom.ImGui.BeginCombo("###aspect", "unimplemented") then
            for displayName, aspectName in pairs({}) do
                if rom.ImGui.Selectable(displayName, aspectName == config.last_aspect) then
                    if aspectName ~= config.last_aspect then
                        config.last_aspect = aspectName
                    end
                    rom.ImGui.SetItemDefaultFocus()
                end
            end
            rom.ImGui.EndCombo()
        end

        local clicked = rom.ImGui.Button("Fuse")
        if clicked then
            FuseWeapon(config.last_primary, config.last_secondary)
        end

        clicked = rom.ImGui.Button("Unfuse All")
        if clicked then
            UnfuseWeapons()
        end
    else
        rom.ImGui.Text("Fusion only allowed at the Crossroads.")
    end
end