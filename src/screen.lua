mod.PrimaryWeaponOutline =
{
	R = 255,
	G = 30,
	B = 50,
	Opacity = 1,
	Thickness = 5,
	Threshold = 0.6,
}

mod.SecondaryWeaponOutline =
{
	R = 30,
	G = 50,
	B = 255,
	Opacity = 1,
	Thickness = 5,
	Threshold = 0.6,
}

mod.HoverWeaponOutlin =
{
	R = game.Color.AlliedOutline[1],
	G = game.Color.AlliedOutline[2],
	B = game.Color.AlliedOutline[3],
	Opacity = 1,
	Thickness = 2.5,
	Threshold = 0.6,
}

mod.FusionScreenData = {
    Name = "WeaponFusionScreen",
    Components = {},
    OpenSound = "/SFX/Menu Sounds/MirrorMenuOpen",
	CloseSound = "/SFX/Menu Sounds/AspectMenuClose",
    GamepadNavigation =
	{
		FreeFormSelectWrapY = false,
		FreeFormSelectGridLock = true,
		FreeFormSelectStepDistance = 8,
		FreeFormSelectSuccessDistanceStep = 8,
		FreeFormSelectRepeatDelay = 0.6,
		FreeFormSelectRepeatInterval = 0.1,
		FreeFormSelecSearchFromId = 0,
	},
	TooltipOffsetX = 710,
    ItemStartX = 200,
	ItemStartY = 200,

    ItemSpacingX = 280,
	ItemSpacingY = 350,

	ButtonOffsetX = 50,
    DefaultGroup = "Combat_Menu",

	BlockPause = true,

	Highlight =
	{
		Name = "BlankObstacle",
		Group = "Combat_Menu",
	},

	EquippedIcon =
	{
		Name = "BlankObstacle",
		Animation = "ActiveAspectLoop",
		Group = "Combat_Menu_Additive",
		Alpha = 0.0,
		Scale = 1.2,
		OffsetX = -504,
		OffsetY = -54,
	},

    ButtonSlotData =
	{
		Graphic = _PLUGIN.guid .. "BlankButton",
		GroupName = "Combat_Menu",
	},

    WeaponImageData =
    {
        Graphic = "BlankObstacle3D",
        X = 250,
        Y = 300,
        Scale = 1.3,
        Alpha = 0.0,
        AlphaTarget = 1.0,
        AlphaTargetDuration = 0.4,
        Group = "Combat_Menu_Overlay",
    },

    WeaponImageOffsets =
    {
        WeaponStaffSwing = {
            OffsetX = 0,
            OffsetY = 0,
        },
        WeaponDagger = {
            OffsetX = 0,
            OffsetY = -40,
        },
        WeaponTorch = {
            OffsetX = 0,
            OffsetY = -60,
        },
        WeaponAxe = {
            OffsetX = 0,
            OffsetY = 50,
        },
        WeaponSuit = {
            OffsetX = 0,
            OffsetY = -100,
        },
		WeaponLob = {
			OffsetX = 0,
			OffsetY = 40,
		}
    },

    ComponentData = {
        DefaultGroup = "Combat_Menu",
		UseNativeScreenCenter = true,
        Order =
		{
			"BackgroundDim",
			"Background",
			"ActionBarBackground",
			"WeaponImage",
			"StatsBox",
		},

        BackgroundDim = 
		{
			Graphic = "rectangle01",
			ScaleX = 10.0,
			ScaleY = 20.0,
			X = ScreenCenterX,
			Y = ScreenCenterY,
			Color = {0.090, 0.055, 0.157, 0.6},
		},

		Background =
		{
			AnimationName = "WeaponUpgradeIn",
			X = ScreenCenterX,
			Y = ScreenCenterY,
			Alpha = 1,
			Children = 
			{
				TitleText = 
				{
					TextArgs =
					{
						Font = "P22UndergroundSCMedium",
						FontSize = 25,
						OffsetX = -747,
						OffsetY = 120,
						Justification = "Center",
						Color = Color.White,
						ShadowBlur = 0,
						ShadowColor = {0,0,0,1},
						ShadowOffset={0, 2},
					},
				},

				TitleFlavorText =
				{
					TextArgs =
					{
						UseDescription = true,
						Font = "LatoItalic",
						FontSize = 17,
						Width = 620,
						OffsetX = -747,
						OffsetY = 152,
						Justification = "Center",
						Color = {1, 1, 1, 0.6},			
						ShadowBlur = 0,
						ShadowColor = {0,0,0,0},
						ShadowOffset={0, 2},
					},
				},
			},
		},

        ActionBar =
		{
			X = game.UIData.ContextualButtonXRight,
			Y = game.UIData.ContextualButtonY,
			AutoAlignContextualButtons = true,
			AutoAlignJustification = "Right",

			ChildrenOrder =
			{
				"CloseButton",
				"CycleAspectButtonDown",
				"CycleAspectButtonUp",
				"FuseAndExitButton",
				"RandomToggle"
			},

			Children =
			{
				CloseButton =
				{
					Graphic = "ContextualActionButton",
					Data =
					{
						OnMouseOverFunctionName = "MouseOverContextualAction",
						OnMouseOffFunctionName = "MouseOffContextualAction",
						OnPressedFunctionName = _PLUGIN.guid .. "." .. "CloseWeaponFusionScreen",
						ControlHotkeys = { "Cancel", },
					},
					Text = "Menu_Exit",
					TextArgs = game.UIData.ContextualButtonFormatRight,
				},

				CycleAspectButtonDown =
				{
					Graphic = "ContextualActionButton",
					Data =
					{
						OnPressedFunctionName = _PLUGIN.guid .. "." .. "CycleAspectsDown",
						ControlHotkeys = { "MenuRight" },
						MouseControlHotkeys = { "MenuDown" }
					},
					Text = "{ML}/{MR} CYCLE ASPECT",
					TextArgs = game.UIData.ContextualButtonFormatRight,
				},

				CycleAspectButtonUp =
				{
					Graphic = "ContextualActionButton",
					Data =
					{
						OnPressedFunctionName = _PLUGIN.guid .. "." .. "CycleAspectsUp",
						ControlHotkeys = { "MenuLeft" },
						MouseControlHotkeys = { "MenuUp" }
					},
					Text = " ",
				},

				FuseAndExitButton =
				{
					Graphic = "ContextualActionButton",
					Data =
					{
						OnMouseOverFunctionName = "MouseOverContextualAction",
						OnMouseOffFunctionName = "MouseOffContextualAction",
						OnPressedFunctionName = _PLUGIN.guid .. "." .. "FuseAndExit",
						ControlHotkeys = { "ItemPin" },
					},
					Text = "{IP} FUSE AND EXIT",
					TextArgs = game.UIData.ContextualButtonFormatRight,
				},

				RandomToggle =
				{
					Graphic = "ContextualActionButton",
					Data =
					{
						OnPressedFunctionName = _PLUGIN.guid .. "." .. "ToggleRandomEachRun",
						ControlHotkeys = { "Reroll" }
					},
					Text = "{G} RANDOM EACH RUN",
					TextArgs = game.UIData.ContextualButtonFormatRight,
				}
			},
		},
    }
}

function mod.OpenWeaponFusionScreen()
	game.waitUnmodified(0.1, "KillScreenTest")
    local screen = game.DeepCopyTable( mod.FusionScreenData )

    for index, weaponName in ipairs(WeaponDisplayOrder) do
        local weaponComponent = game.DeepCopyTable(screen.WeaponImageData)
        weaponComponent.X = weaponComponent.X + (index-1)*screen.ItemSpacingX + screen.WeaponImageOffsets[weaponName].OffsetX
        weaponComponent.Y = weaponComponent.Y + screen.WeaponImageOffsets[weaponName].OffsetY
        screen.ComponentData["WeaponImageData1"..weaponName] = weaponComponent
        weaponComponent = game.DeepCopyTable(weaponComponent)
        weaponComponent.Y = weaponComponent.Y + screen.ItemSpacingY
        screen.ComponentData["WeaponImageData2"..weaponName] = weaponComponent
    end

	

    game.HideCombatUI( screen.Name )
	game.wait( 0.1 )
	game.OnScreenOpened( screen )
	game.CreateScreenFromData( screen, screen.ComponentData )

    local components = screen.Components

	-- print("compnents")
	-- print(mod.dump(screen.Components, 0, 2))

	screen.ScrollState = {}

	screen.SelectedPrimary = 1
	screen.SelectedSecondary = 1

    for index, weaponName in ipairs(WeaponDisplayOrder) do
		local state = {}
        local weaponData = game.WeaponData[weaponName]
        local traitData1 = game.TraitData[game.GameState.LastWeaponUpgradeName[weaponName]]
        local traitData2 = game.TraitData[game.ScreenData.WeaponUpgradeScreen.DisplayOrder[weaponName][1]]
		state.PrimaryIndex = game.GetIndex(game.ScreenData.WeaponUpgradeScreen.DisplayOrder[weaponName], traitData1.Name)
		state.SecondaryIndex = 1
		print(traitData2.WeaponKitGrannyModel, traitData2.Name, config.aspect, mod.dump(WeaponMinorAspectData[weaponName]))
		if game.TraitData[config.last_aspect] and game.Contains(WeaponMinorAspectData[weaponName], config.last_aspect) then
			traitData2 = game.TraitData[config.last_aspect:gsub("_Secondary$", "")]
			state.SecondaryIndex = game.GetIndex(WeaponMinorAspectData[weaponName], traitData2.Name.."_Secondary")
		end
		print(traitData2.WeaponKitGrannyModel, traitData2.Name)
        game.SetAnimation({ Name = weaponData.UpgradeScreenKitAnimation .. "_FusionScreen", GrannyModel = traitData1.WeaponKitGrannyModel, DestinationId = components["WeaponImageData1"..weaponName].Id })
		if config.last_primary == weaponName then
			local outlineData = ShallowCopyTable( mod.PrimaryWeaponOutline )
			outlineData.Id = components["WeaponImageData1"..weaponName].Id
			AddOutline( outlineData )
			screen.SelectedPrimary = index
		end
        game.SetAnimation({ Name = weaponData.UpgradeScreenKitAnimation .. "_FusionScreen", GrannyModel = traitData2.WeaponKitGrannyModel, DestinationId = components["WeaponImageData2"..weaponName].Id })
		if config.last_secondary == weaponName then
			local outlineData = ShallowCopyTable( mod.SecondaryWeaponOutline )
			outlineData.Id = components["WeaponImageData2"..weaponName].Id
			AddOutline( outlineData )
			screen.SelectedSecondary = index
		end
		table.insert(screen.ScrollState, state)
    end

	print(mod.dump(screen.ScrollState))

	screen.WeaponList = {}

	local weaponUpgrades = game.DeepCopyTable(game.ScreenData.WeaponUpgradeScreen.DisplayOrder)

	for weaponKit, upgradeList in pairs(weaponUpgrades) do
		for index, upgrade in ipairs(upgradeList) do
			if not game.GameState.WeaponsUnlocked[upgrade] then
				upgradeList[index] = nil
			end
		end
		weaponUpgrades[weaponKit] = game.CollapseTable(upgradeList)
	end

	for _, weaponName in ipairs(WeaponDisplayOrder) do
		table.insert(screen.WeaponList,{ WeaponName = weaponName, PrimaryAspects = weaponUpgrades[weaponName], SecondaryAspects = WeaponMinorAspectData[weaponName] })
	end
	mod.dump(screen.WeaponList)

	mod.CreateMinorAspectButtons(screen)

	game.TeleportCursor({ OffsetX = screen.ItemStartX + screen.ButtonOffsetX, OffsetY = screen.ItemStartY, ForceUseCheck = true })

	if config.random_fusion_each_run then
		game.ModifyTextBox({ Id = components.RandomToggle.Id, ColorTarget = { 0.50, 0.90, 0.80, 1.0 }, ColorDuration = 0.2 })
	end

    screen.KeepOpen = true
	screen.CanClose = true
	game.HandleScreenInput( screen )
end

function mod.CloseWeaponFusionScreen(screen)
    if screen == nil or not screen.CanClose then
		return
	end
    screen.CanClose = false
	game.SetAnimation({ DestinationId = screen.Components.Background.Id, Name = "WeaponUpgradeOut" })

    PlaySound({ Name = "/SFX/Menu Sounds/GeneralWhooshMENULoudLow" })

	SetConfigOption({ Name = "ExclusiveInteractGroup", Value = nil })
	SetConfigOption({ Name = "FreeFormSelectStepDistance", Value = 16.0 })


    OnScreenCloseStarted( screen )
	CloseScreen( GetAllIds( screen.Components ), 0.15 )
    OnScreenCloseFinished( screen )
	ShowCombatUI( screen.Name )
	wait( 0.3 )
end

function mod.CreateMinorAspectButtons( screen, args )
	args = args or {}
	local components = screen.Components
	for row = 1, 2 do
		for itemIndex = 1, 6 do
			local weaponData = screen.WeaponList[itemIndex]
			local weaponButtonKey = "WeaponImageData"..row..weaponData.WeaponName
			local slotData = game.DeepCopyTable( screen.ButtonSlotData )
			local locationX = screen.ItemStartX + ( (itemIndex - 1) * screen.ItemSpacingX ) + screen.ButtonOffsetX
			local locationY = screen.ItemStartY + (row - 1) * screen.ItemSpacingY
			slotData.X = locationX
			slotData.Y = locationY
			slotData.ScaleX = 1.5
			slotData.ScaleY = 3
			slotData.Alpha = 1

			print("creating button")
			local button = game.CreateComponentFromData( screen, slotData )
			components[weaponButtonKey.."Button"] = button
			button.OnPressedFunctionName = _PLUGIN.guid .. "." .. "SetAspectConfig"
			button.OnMouseOverFunctionName = _PLUGIN.guid .. "." .. "MouseOverMinorAspect"
			button.OnMouseOffFunctionName = _PLUGIN.guid .. "." .. "MouseOffMinorAspect"
			button.Screen = screen
			button.WeaponData = weaponData
			button.WeaponType = (row == 1 and "Primary") or "Secondary"
			button.WeaponKey = weaponButtonKey
			button.Index = itemIndex
			-- print(mod.dump(button))
			-- game.AttachLua({ Id = button.Id, Table = button })
		end
	end
end

function mod.SetAspectConfig(screen)
	local button = screen.SelectedItem
	if button  then
		local components = button.Screen.Components
		if button.WeaponType == "Primary" and screen.SelectedPrimary ~= button.Index then
			game.RemoveOutline( {Id = components["WeaponImageData1"..screen.WeaponList[screen.SelectedPrimary].WeaponName].Id} )
			screen.SelectedPrimary = button.Index
			local outlineData = game.ShallowCopyTable( mod.PrimaryWeaponOutline )
			outlineData.Id = components[button.WeaponKey].Id
			game.AddOutline( outlineData )
		end
		if button.WeaponType == "Secondary" and screen.SelectedSecondary ~= button.Index then
			game.RemoveOutline( {Id = components["WeaponImageData2"..screen.WeaponList[screen.SelectedSecondary].WeaponName].Id} )
			screen.SelectedSecondary = button.Index
			local outlineData = game.ShallowCopyTable( mod.SecondaryWeaponOutline )
			outlineData.Id = components[button.WeaponKey].Id
			game.AddOutline( outlineData )
		end

		game.SetScale({Id = components[button.WeaponKey].Id, Fraction = 1.2, Duration = 0.06})
		game.wait(0.06)
		game.SetScale({Id = components[button.WeaponKey].Id, Fraction = 1.5, Duration = 0.06})
	end
end

function mod.MouseOverMinorAspect(button)
	-- print(mod.dump(button))
	local screen = button.Screen
	screen.SelectedItem = button
	print(button.WeaponKey)
	local components = button.Screen.Components
	if not ( button.Index == screen.SelectedPrimary and button.WeaponType == "Primary" or
			 button.Index == screen.SelectedSecondary and button.WeaponType == "Secondary" ) then
		local outlineData = game.ShallowCopyTable( mod.HoverWeaponOutlin )
		outlineData.Id = components[button.WeaponKey].Id
		game.AddOutline( outlineData )
	end
	game.SetScale({Id = components[button.WeaponKey].Id, Fraction = 1.5, Duration = 0.15})
end

function mod.MouseOffMinorAspect(button)
	-- print(mod.dump(button))
	print(button.WeaponKey)
	local screen = button.Screen
	screen.SelectedItem = nil
	local components = button.Screen.Components
	-- local outlineData = game.ShallowCopyTable( mod.SecondaryWeaponOutline )
	-- outlineData.Id = components[button.WeaponKey].Id
	game.RemoveOutline( {Id = components[button.WeaponKey].Id} )
	if button.Index == screen.SelectedPrimary and button.WeaponType == "Primary" then
		local outlineData = game.ShallowCopyTable( mod.PrimaryWeaponOutline )
		outlineData.Id = components[button.WeaponKey].Id
		game.AddOutline( outlineData )
	end
	if button.Index == screen.SelectedSecondary and button.WeaponType == "Secondary" then
		local outlineData = game.ShallowCopyTable( mod.SecondaryWeaponOutline )
		outlineData.Id = components[button.WeaponKey].Id
		game.AddOutline( outlineData )
	end
	game.SetScale({Id = components[button.WeaponKey].Id, Fraction = 1.3, Duration = 0.15})
end

function mod.CycleAspectsDown(screen)
	if not screen.SelectedItem then
		return
	end
	local button = screen.SelectedItem
	local components = screen.Components
	local row = (button.WeaponType == "Primary" and 1) or 2
	local index = button.Index
	local weaponName = screen.WeaponList[index].WeaponName
	local weaponData = game.WeaponData[weaponName]
	if row == 2 then
		local aspectIndex = screen.ScrollState[index].SecondaryIndex
		local numAspects = #(WeaponMinorAspectData[weaponName])
		local newAspectIndex =  aspectIndex % numAspects + 1
		screen.ScrollState[index].SecondaryIndex = newAspectIndex
		local traitName = WeaponMinorAspectData[weaponName][newAspectIndex]
		local traitData2 = game.TraitData[game.ScreenData.WeaponUpgradeScreen.DisplayOrder[weaponName][1]]
		if game.TraitData[traitName] and game.Contains(WeaponMinorAspectData[weaponName], traitName) then
			traitData2 = game.TraitData[traitName:gsub("_Secondary$", "")]
		end
		game.SetAnimation({ Name = weaponData.UpgradeScreenKitAnimation .. "_FusionScreen", GrannyModel = traitData2.WeaponKitGrannyModel, DestinationId = components["WeaponImageData"..row..weaponName].Id })
	else
		local aspectIndex = screen.ScrollState[index].PrimaryIndex
		local numAspects = #(game.ScreenData.WeaponUpgradeScreen.DisplayOrder[weaponName])
		local newAspectIndex =  aspectIndex % numAspects + 1
		local traitData1 = game.TraitData[game.ScreenData.WeaponUpgradeScreen.DisplayOrder[weaponName][newAspectIndex]]
		screen.ScrollState[index].PrimaryIndex = newAspectIndex
		game.SetAnimation({ Name = weaponData.UpgradeScreenKitAnimation .. "_FusionScreen", GrannyModel = traitData1.WeaponKitGrannyModel, DestinationId = components["WeaponImageData1"..weaponName].Id })
	end
end

function mod.CycleAspectsUp(screen)
	if not screen.SelectedItem then
		return
	end
	local button = screen.SelectedItem
	local components = screen.Components
	local row = (button.WeaponType == "Primary" and 1) or 2
	local index = button.Index
	local weaponName = screen.WeaponList[index].WeaponName
	local weaponData = game.WeaponData[weaponName]
	if row == 2 then
		local aspectIndex = screen.ScrollState[index].SecondaryIndex
		local numAspects = #(WeaponMinorAspectData[weaponName])
		local newAspectIndex =  (aspectIndex - 2) % numAspects + 1
		screen.ScrollState[index].SecondaryIndex = newAspectIndex
		local traitName = WeaponMinorAspectData[weaponName][newAspectIndex]
		local traitData2 = game.TraitData[game.ScreenData.WeaponUpgradeScreen.DisplayOrder[weaponName][1]]
		if game.TraitData[traitName] and game.Contains(WeaponMinorAspectData[weaponName], traitName) then
			traitData2 = game.TraitData[traitName:gsub("_Secondary$", "")]
		end
		game.SetAnimation({ Name = weaponData.UpgradeScreenKitAnimation .. "_FusionScreen", GrannyModel = traitData2.WeaponKitGrannyModel, DestinationId = components["WeaponImageData"..row..weaponName].Id })
	else
		local aspectIndex = screen.ScrollState[index].PrimaryIndex
		local numAspects = #(game.ScreenData.WeaponUpgradeScreen.DisplayOrder[weaponName])
		local newAspectIndex =  (aspectIndex - 2) % numAspects + 1
		local traitData1 = game.TraitData[game.ScreenData.WeaponUpgradeScreen.DisplayOrder[weaponName][newAspectIndex]]
		screen.ScrollState[index].PrimaryIndex = newAspectIndex
		game.SetAnimation({ Name = weaponData.UpgradeScreenKitAnimation .. "_FusionScreen", GrannyModel = traitData1.WeaponKitGrannyModel, DestinationId = components["WeaponImageData1"..weaponName].Id })
	end
end

function mod.FuseAndExit(screen)
	if  screen.SelectedPrimary == screen.SelectedSecondary then
		return
	end
	local state = screen.ScrollState
	local primaryWeapon = screen.WeaponList[screen.SelectedPrimary].WeaponName
	local secondaryWeapon = screen.WeaponList[screen.SelectedSecondary].WeaponName
	local primaryAspect = game.ScreenData.WeaponUpgradeScreen.DisplayOrder[primaryWeapon][state[screen.SelectedPrimary].PrimaryIndex]
	local secondaryAspect = WeaponMinorAspectData[secondaryWeapon][state[screen.SelectedSecondary].SecondaryIndex]

	print(primaryAspect, primaryWeapon, secondaryAspect, secondaryWeapon)

	mod.UnequipWeapons()
    UnfuseWeapons()
    config.last_primary = primaryWeapon
    config.last_secondary = secondaryWeapon
    config.last_aspect = secondaryAspect
    FuseWeapon(config.last_primary, config.last_secondary, config.last_aspect)
    mod.EquipWeapons({PrimaryUpgrade = primaryAspect})
	mod.CloseWeaponFusionScreen(screen)
end

function mod.ToggleRandomEachRun(screen, button)
	config.random_fusion_each_run = config.random_fusion_each_run == false
	if config.random_fusion_each_run then
		game.MouseOverContextualAction(button)
	else
		game.MouseOffContextualAction(button)
	end
end