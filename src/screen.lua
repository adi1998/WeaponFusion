mod.PrimaryWeaponOutline =
{
	R = 220,
	G = 10,
	B = 30,
	Opacity = 0.9,
	Thickness = 5,
	Threshold = 0,
}

mod.SecondaryWeaponOutline =
{
	R = 10,
	G = 20,
	B = 220,
	Opacity = 0.9,
	Thickness = 5,
	Threshold = 0,
}

mod.HoverWeaponOutlin =
{
	R = Color.AlliedOutline[1],
	G = Color.AlliedOutline[2],
	B = Color.AlliedOutline[3],
	Opacity = 0.8,
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

    ItemSpacingX = 300,
	ItemSpacingY = 350,

	IconOffsetX = -320,
	IconOffsetY = 0,
    BlockPause = true,
    DefaultGroup = "Combat_Menu",

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

	BoonItemStartX = 960,
	BoonItemStartY = 800,

    StartingBoonIndex = 1,
	NumBoonsPerPage = 1,

    ButtonSlotData =
	{
		Graphic = ScreenData.UpgradeChoice.PurchaseButton.Name,
		GroupName = "Combat_Menu",

		ChildrenOrder =
		{
			"InfoBoxIcon",
			"InfoBoxFrame",
		},

		Children =
		{
			InfoBoxIcon = 
			{
				Graphic = "BlankObstacle",
				Scale = ScreenData.UpgradeChoice.Icon.Scale,
				OffsetX = ScreenData.UpgradeChoice.IconOffsetX,
				OffsetY = ScreenData.UpgradeChoice.IconOffsetY,
				Alpha = 0.0,
				AlphaTarget = 1.0,
				AlphaTargetDuration = 0.4,

			},

			InfoBoxFrame = 
			{
				Graphic = "BlankObstacle",
				Animation = "Frame_Boon_Menu_Common",
				Scale = ScreenData.UpgradeChoice.Frame.Scale,
				OffsetX = ScreenData.UpgradeChoice.IconOffsetX,
				OffsetY = ScreenData.UpgradeChoice.IconOffsetY,
				Alpha = 0.0,
				AlphaTarget = 1.0,
				AlphaTargetDuration = 0.4,
			},

			InfoBoxName =
			{
				TextArgs = ScreenData.UpgradeChoice.TitleText,
			},
			InfoBoxRarity =
			{
				TextArgs = ScreenData.UpgradeChoice.RarityText,
			},

			InfoBoxDescription =
			{ 
				TextArgs = ScreenData.UpgradeChoice.DescriptionText,
			},
			InfoBoxStatLineLeft =
			{ 
				TextArgs = ScreenData.UpgradeChoice.StatLineLeft,
			},
			InfoBoxStatLineRight =
			{ 
				TextArgs = ScreenData.UpgradeChoice.StatLineRight,
			},
			InfoBoxFlavor =
			{
				TextArgs = ScreenData.UpgradeChoice.FlavorText
			},
		}
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
			X = UIData.ContextualButtonXRight,
			Y = UIData.ContextualButtonY,
			AutoAlignContextualButtons = true,
			AutoAlignJustification = "Right",

			ChildrenOrder =
			{
				"CloseButton",
				"SelectButton",
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
					TextArgs = UIData.ContextualButtonFormatRight,
				},
			},
		},
    }
}

function mod.OpenWeaponFusionScreen()
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

    for index, weaponName in ipairs(WeaponDisplayOrder) do
        local weaponData = game.WeaponData[weaponName]
        local traitData1 = game.TraitData[game.GameState.LastWeaponUpgradeName[weaponName]]
        local traitData2 = game.TraitData[game.ScreenData.WeaponUpgradeScreen.DisplayOrder[weaponName][1]]
		print(traitData2.WeaponKitGrannyModel, traitData2.Name, config.aspect, mod.dump(WeaponMinorAspectData[weaponName]))
		if game.TraitData[config.aspect] and game.Contains(WeaponMinorAspectData[weaponName], config.aspect) then
			traitData2 = game.TraitData[config.aspect:gsub("_Secondary$", "")]
		end
		print(traitData2.WeaponKitGrannyModel, traitData2.Name)
        game.SetAnimation({ Name = weaponData.UpgradeScreenKitAnimation .. "_FusionScreen", GrannyModel = traitData1.WeaponKitGrannyModel, DestinationId = components["WeaponImageData1"..weaponName].Id })
		if config.primary == weaponName then
			local outlineData = ShallowCopyTable( mod.PrimaryWeaponOutline )
			outlineData.Id = components["WeaponImageData1"..weaponName].Id
			AddOutline( outlineData )
		end
        game.SetAnimation({ Name = weaponData.UpgradeScreenKitAnimation .. "_FusionScreen", GrannyModel = traitData2.WeaponKitGrannyModel, DestinationId = components["WeaponImageData2"..weaponName].Id })
		if config.secondary == weaponName then
			local outlineData = ShallowCopyTable( mod.SecondaryWeaponOutline )
			outlineData.Id = components["WeaponImageData2"..weaponName].Id
			AddOutline( outlineData )
		end
    end

	screen.TraitList = {}

	for _, aspectName in ipairs(WeaponMinorAspectData[config.secondary]) do
		local rawTraitData = game.TraitData[aspectName]
		if rawTraitData then
			local traitData = game.GetProcessedTraitData({ Unit = game.CurrentRun.Hero, TraitName = aspectName, Rarity = "Common", })
			game.SetTraitTextData( traitData )
			table.insert(screen.TraitList, traitData)
		end
	end

	mod.CreateMinorAspectButtons(screen)

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
	for itemIndex = screen.StartingBoonIndex, math.min(screen.StartingBoonIndex + screen.NumBoonsPerPage - 1, #screen.TraitList), 1 do
		local traitData = screen.TraitList[itemIndex]
		local rawTraitData = TraitData[traitData.Name]
		local purchaseButtonKey = "PurchaseButton"..itemIndex
		local slotData = DeepCopyTable( screen.ButtonSlotData )
		local locationX = screen.BoonItemStartX
		local locationY = screen.BoonItemStartY + ( (itemIndex - screen.StartingBoonIndex) * screen.ItemSpacingY )
		slotData.X = locationX
		slotData.Y = locationY
		slotData.Alpha = 0.0
		slotData.AlphaTarget = 1.0
		slotData.AlphaTargetDuration = 0.4
		slotData.Animation = rawTraitData.InfoBackingAnimation

		print("creating button")
		local button = CreateComponentFromData( screen, slotData )
		components[purchaseButtonKey] = button
		button.OnPressedFunctionName = _PLUGIN.guid .. "." .. "SetAspectConfig"
		button.OnMouseOverFunctionName = _PLUGIN.guid .. "." .. "MouseOverMinorAspect"
		button.OnMouseOffFunctionName = _PLUGIN.guid .. "." .. "MouseOffMinorAspect"
		button.Screen = screen
		button.TraitData = traitData
		SetInteractProperty({ DestinationId = button.Id, Property = "TooltipOffsetX", Value = screen.TooltipOffsetX })
		AttachLua({ Id = button.Id, Table = button })
		local highlight = ShallowCopyTable( screen.Highlight )
		highlight.X = button.X
		highlight.Y = button.Y
		print("creating highlight")
		components[purchaseButtonKey.."Highlight"] = CreateScreenComponent( highlight )
		button.Highlight = components[purchaseButtonKey.."Highlight"]
		
		-- Hidden description for tooltip
		CreateTextBox({ Id = components[purchaseButtonKey].Id,
			Text = traitData.Name,
			UseDescription = true,
			Color = Color.Transparent,
			LuaKey = "TooltipData",
			LuaValue = traitData,
		})
		if traitData.StatLines then
			CreateTextBox({ Id = components[purchaseButtonKey].Id,
				Text = traitData.StatLines[1],
				Color = Color.Transparent,
				LuaKey = "TooltipData",
				LuaValue = traitData,
			})
		end

		local equippedIcon = CreateScreenComponent( screen.EquippedIcon )
		components[purchaseButtonKey.."EquippedIcon"] = equippedIcon
		button.EquippedIcon = equippedIcon
		Attach({ Id = equippedIcon.Id, DestinationId = components[purchaseButtonKey].Id, OffsetX = screen.EquippedIcon.OffsetX, OffsetY = screen.EquippedIcon.OffsetY })

		local childrenNames = GetAllKeys( slotData.Children )
		for _, name in pairs( childrenNames ) do
			if Contains( slotData.ChildrenOrder, name ) then
				slotData.ChildrenOrder[GetKey(slotData.ChildrenOrder, name)] = name..itemIndex
			end
			slotData.Children[name..itemIndex] = slotData.Children[name]
			slotData.Children[name] = nil
		end

		AttachChildrenFromData( screen, components[purchaseButtonKey], slotData, screen )
	
		if traitData.Icon ~= nil then
			SetAnimation({ Name = traitData.Icon, DestinationId = components["InfoBoxIcon"..itemIndex].Id })
			SetAlpha({ Id = components["InfoBoxIcon"..itemIndex].Id, Fraction = 1.0, Duration = 0.2 })
			SetAlpha({ Id = components["InfoBoxFrame"..itemIndex].Id, Fraction = 1.0, Duration = 0.2 })
		end

		local rarityColor = Color.White
		if traitData.Rarity then
			rarityColor = Color["BoonPatch"..traitData.Rarity]
			SetAnimation({ DestinationId = components["InfoBoxFrame"..itemIndex].Id, Name = "Frame_Boon_Menu_"..traitData.Rarity })
		end
		ModifyTextBox({ Id = components["InfoBoxName"..itemIndex].Id,
			Text = traitData.Title,
			LuaKey = "TooltipData",
			LuaValue = traitData,
			Color = rarityColor,
		})
		local rarityLevel = GetRarityValue( traitData.Rarity )
		ModifyTextBox({ Id = components["InfoBoxRarity"..itemIndex].Id,
			Text = TraitRarityData.AspectRarityText[rarityLevel],
			Color = rarityColor,
		})

		ModifyTextBox({ Id = components["InfoBoxDescription"..itemIndex].Id,
			Text = traitData.Name,
			UseDescription = true,
			LuaKey = "TooltipData",
			LuaValue = traitData,
		})

		local statLine = traitData.StatLines[1]
		ModifyTextBox({ Id = components["InfoBoxStatLineLeft"..itemIndex].Id, AppendToId = components["InfoBoxDescription"..itemIndex].Id, Text = statLine, LuaKey = "TooltipData", LuaValue = traitData, FadeTarget = 1.0 })
		ModifyTextBox({ Id = components["InfoBoxStatLineRight"..itemIndex].Id, AppendToId = components["InfoBoxDescription"..itemIndex].Id, Text = statLine, UseDescription = true, LuaKey = "TooltipData", LuaValue = traitData, FadeTarget = 1.0 })

		ModifyTextBox({ Id = components["InfoBoxFlavor"..itemIndex].Id,
			Text = traitData.FlavorText,
		})
	end
end

function mod.SetAspectConfig(screen, button)
	
end

function mod.MouseOverMinorAspect(button)
	
end

function mod.MouseOffMinorAspect(button)
	
end