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
    ItemStartX = 200,
	ItemStartY = 200,

    ItemSpacingX = 300,
	ItemSpacingY = 350,

	IconOffsetX = -320,
	IconOffsetY = 0,
    BlockPause = true,
    DefaultGroup = "Combat_Menu",

    

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
        game.SetAnimation({ Name = weaponData.UpgradeScreenKitAnimation .. "_FusionScreen", GrannyModel = traitData1.WeaponKitGrannyModel, DestinationId = components["WeaponImageData1"..weaponName].Id })
        game.SetAnimation({ Name = weaponData.UpgradeScreenKitAnimation .. "_FusionScreen", GrannyModel = traitData2.WeaponKitGrannyModel, DestinationId = components["WeaponImageData2"..weaponName].Id })
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