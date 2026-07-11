mod.PrimaryWeaponOutline =
{
	R = 255,
	G = 80,
	B = 100,
	Opacity = 1,
	Thickness = 5,
	Threshold = 0.6,
}

mod.SecondaryWeaponOutline =
{
	R = 100,
	G = 150,
	B = 255,
	Opacity = 1,
	Thickness = 5,
	Threshold = 0.6,
}

mod.HoverWeaponOutline =
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

	ToggleOnSound = "/SFX/Menu Sounds/IrisMenuConfirm",
    ToggleOffSound = "/SFX/Menu Sounds/IrisMenuBack",

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
            OffsetY = -20,
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
			"UnfuseHoldButtonGraphic",
			"ActionBarBackground",
			"WeaponImage",
			"ActionBar",
			"UnfuseButtonControlIcon"
		},

        BackgroundDim =
		{
			Graphic = "rectangle01",
			ScaleX = 10.0,
			ScaleY = 20.0,
			X = game.ScreenCenterX,
			Y = game.ScreenCenterY,
			Color = {0.090, 0.055, 0.157, 0.6},
		},

		Background =
		{
			AnimationName = "WeaponUpgradeIn",
			X = game.ScreenCenterX,
			Y = game.ScreenCenterY,
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
						Color = game.Color.White,
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
				"FuseAndExitButton",
				"UnfuseAndExitButton",
				"RandomToggle",
				"CycleAspectButtonUp",
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
					Text = "{CN} EXIT",
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
					Text = "  {MR} CYCLE ASPECT",
					AltText = "  {MD} CYCLE ASPECT",
					TextArgs = game.UIData.ContextualButtonFormatRight,
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
					Text = "{IP} FUSE",
					TextArgs = game.UIData.ContextualButtonFormatRight,
				},

				UnfuseAndExitButton =
				{
					Graphic = "ContextualActionButton",
					Data =
					{
						OnMouseOverFunctionName = "MouseOverContextualAction",
						OnMouseOffFunctionName = "MouseOffContextualAction",
						-- OnPressedFunctionName = _PLUGIN.guid .. "." .. "FuseAndExit",
					},
					Text = " HOLD {IP} UNFUSE",
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
					Text = "",
				},
			},
		},

		UnfuseButtonControlIcon = {
			X = 972,
			Y = game.UIData.ContextualButtonY,
			Text = "{IP}",
			TextArgs = {
				FontSize = 20,
				Width = 415,
				LineSpacingBottom = 0,
				Color = { 0.58, 0.34, 0.78, 1.0 },
				Font = "LatoBold",
				ShadowBlur = 0, ShadowColor = {0,0,0,0}, ShadowOffset={0, 3},
				Justification = "CENTER",
				VerticalJustification = "CENTER",
				TextSymbolScale = 0.8,
			}
		},

		UnfuseHoldButtonGraphic = {
			AnimationName = _PLUGIN.guid .. "HoldButtonAnimationEmpty",
			X = 972,
			Y = game.UIData.ContextualButtonY,
			Scale = 0.23,
			Alpha = 1,
		}
    }
}

function DisableYmMesh()
	rom.data.draw_set_mesh_visible("WeaponStaff_Mesh", "WeaponStaffYM_MeshShapeDeformed", false)
	rom.data.draw_set_mesh_visible("WeaponStaff_Mesh", "WeaponStaff_Rig:WeaponStaff_MeshShapeDeformed", true)

	rom.data.draw_set_mesh_visible("WeaponSuitMultiple_Base_Mesh", "WeaponSuitBYM_MeshShape", false)
	rom.data.draw_set_mesh_visible("WeaponSuitMultiple_Base_Mesh", "WeaponSuitBOutlineYM_MeshShape", false)

	rom.data.draw_set_mesh_visible("WeaponSuitMultiple_Base_Mesh", "WeaponSuitBmultYM_MeshShape", false)
	rom.data.draw_set_mesh_visible("WeaponSuitMultiple_Base_Mesh", "WeaponSuitBmultOutlineYM_MeshShape", false)

	rom.data.draw_set_mesh_visible("WeaponSuitMultiple_Base_Mesh", "WeaponSuitMultiple_Rig:WeaponSuitB_MeshShape", true)
	rom.data.draw_set_mesh_visible("WeaponSuitMultiple_Base_Mesh", "WeaponSuitMultiple_Rig:WeaponSuitBOutline_MeshShape", true)

	rom.data.draw_set_mesh_visible("WeaponSuitB_Base_Mesh", "WeaponSuitBYM_MeshShape", false)
	rom.data.draw_set_mesh_visible("WeaponSuitB_Base_Mesh", "WeaponSuitBOutlineYM_MeshShape", false)

	rom.data.draw_set_mesh_visible("WeaponSuitB_Base_Mesh", "WeaponSuitBYM_MeshShape", false)
	rom.data.draw_set_mesh_visible("WeaponSuitB_Base_Mesh", "WeaponSuitBOutlineYM_MeshShape", false)

	rom.data.draw_set_mesh_visible("WeaponSuitB_Base_Mesh", "WeaponSuitB_Rig:WeaponSuitB_MeshShape", true)
	rom.data.draw_set_mesh_visible("WeaponSuitB_Base_Mesh", "WeaponSuitB_Rig:WeaponSuitBOutline_MeshShape", true)

	rom.data.draw_set_mesh_visible("Melinoe_Axe_Mesh1", "WeaponAxeYM_MeshShapeDeformed", false)
	rom.data.draw_set_mesh_visible("Melinoe_Axe_Mesh1", "WeaponAxe_Rig_01:WeaponAxe_MeshShapeDeformed", true)

	rom.data.draw_set_mesh_visible("WeaponLob_Mesh", "WeaponLobYM_MeshShape", false)
	rom.data.draw_set_mesh_visible("WeaponLob_Mesh", "WeaponLob_Rig:WeaponLob_MeshShape", true)

	rom.data.draw_set_mesh_visible("WeaponDaggerA_Mesh", "WeaponDaggerA_Rig:WeaponDaggerA_MeshShapeDeformed", true)
	rom.data.draw_set_mesh_visible("WeaponDaggerB_Mesh", "WeaponDaggerB_Rig:WeaponDaggerB_MeshShapeDeformed", true)
	rom.data.draw_set_mesh_visible("WeaponDaggerA_Mesh", "WeaponDaggerAYM_MeshShapeDeformed", false)
	rom.data.draw_set_mesh_visible("WeaponDaggerB_Mesh", "WeaponDaggerBYM_MeshShapeDeformed", false)

	rom.data.draw_set_mesh_visible("WeaponDaggerB_Mesh", "WeaponDaggerAYM_MeshShapeDeformed", false)
	rom.data.draw_set_mesh_visible("WeaponDaggerA_Mesh", "WeaponDaggerBYM_MeshShapeDeformed", false)
	rom.data.draw_set_mesh_visible("WeaponDagger_Mesh", "WeaponDaggerAYM_MeshShapeDeformed", false)
	rom.data.draw_set_mesh_visible("WeaponDagger_Mesh", "WeaponDaggerBYM_MeshShapeDeformed", false)

	rom.data.draw_set_mesh_visible("WeaponDagger_Mesh", "WeaponDaggerMultipleFree_Rig:WeaponDaggerA_WeaponDaggerA_MeshShapeDeformed", true)
	rom.data.draw_set_mesh_visible("WeaponDagger_Mesh", "WeaponDaggerB_WeaponDaggerB_MeshShapeDeformed", true)
	rom.data.draw_set_mesh_visible("WeaponDagger_Mesh", "WeaponDaggerA_WeaponDaggerAYM_MeshShapeDeformed", false)
	rom.data.draw_set_mesh_visible("WeaponDagger_Mesh", "WeaponDaggerB_WeaponDaggerBYM_MeshShapeDeformed", false)

	rom.data.draw_set_mesh_visible("WeaponDaggerA_Mesh", "WeaponDaggerA_WeaponDaggerAYM_MeshShapeDeformed", false)
	rom.data.draw_set_mesh_visible("WeaponDaggerA_Mesh", "WeaponDaggerB_WeaponDaggerBYM_MeshShapeDeformed", false)
	rom.data.draw_set_mesh_visible("WeaponDaggerB_Mesh", "WeaponDaggerA_WeaponDaggerAYM_MeshShapeDeformed", false)
	rom.data.draw_set_mesh_visible("WeaponDaggerB_Mesh", "WeaponDaggerB_WeaponDaggerBYM_MeshShapeDeformed", false)
end

function EnableYmMesh()
	if (game.HeroHasTrait("StaffAspectofYoungMelinoe") or game.HeroHasTrait("StaffAspectofYoungMelinoe_Secondary")) then
		rom.data.draw_set_mesh_visible("WeaponStaff_Mesh", "WeaponStaffYM_MeshShapeDeformed", true)
		rom.data.draw_set_mesh_visible("WeaponStaff_Mesh", "WeaponStaff_Rig:WeaponStaff_MeshShapeDeformed", false)
	elseif (game.HeroHasTrait("BaseStaffAspect") or game.HeroHasTrait("BaseStaffAspect_Secondary"))then
	-- elseif game.HeroHasTrait("BaseStaffAspect") then
		rom.data.draw_set_mesh_visible("WeaponStaff_Mesh", "WeaponStaffYM_MeshShapeDeformed", false)
		rom.data.draw_set_mesh_visible("WeaponStaff_Mesh", "WeaponStaff_Rig:WeaponStaff_MeshShapeDeformed", true)
	--elseif (game.HeroHasTrait("SkullAspectofYoungMelinoe") or game.HeroHasTrait("SkullAspectofYoungMelinoe_Secondary")) then
	elseif game.HeroHasTrait("SkullAspectofYoungMelinoe") then
		rom.data.draw_set_mesh_visible("WeaponLob_Mesh", "WeaponLobYM_MeshShape", true)
		rom.data.draw_set_mesh_visible("WeaponLob_Mesh", "WeaponLob_Rig:WeaponLob_MeshShape", false)
	elseif (game.HeroHasTrait("LobAmmoBoostAspect") or game.HeroHasTrait("LobAmmoBoostAspect_Secondary")) then
	-- elseif game.HeroHasTrait("LobAmmoBoostAspect") then
		rom.data.draw_set_mesh_visible("WeaponLob_Mesh", "WeaponLobYM_MeshShape", false)
		rom.data.draw_set_mesh_visible("WeaponLob_Mesh", "WeaponLob_Rig:WeaponLob_MeshShape", true)
	elseif (game.HeroHasTrait("SuitAspectofYoungMelinoe")) then
		rom.data.draw_set_mesh_visible("WeaponSuitMultiple_Base_Mesh", "WeaponSuitBmultYM_MeshShape", true)
		rom.data.draw_set_mesh_visible("WeaponSuitMultiple_Base_Mesh", "WeaponSuitBmultOutlineYM_MeshShape", true)

		rom.data.draw_set_mesh_visible("WeaponSuitMultiple_Base_Mesh", "WeaponSuitBYM_MeshShape", false)
		rom.data.draw_set_mesh_visible("WeaponSuitMultiple_Base_Mesh", "WeaponSuitBOutlineYM_MeshShape", false)

		rom.data.draw_set_mesh_visible("WeaponSuitMultiple_Base_Mesh", "WeaponSuitMultiple_Rig:WeaponSuitB_MeshShape", false)
		rom.data.draw_set_mesh_visible("WeaponSuitMultiple_Base_Mesh", "WeaponSuitMultiple_Rig:WeaponSuitBOutline_MeshShape", false)

		rom.data.draw_set_mesh_visible("WeaponSuitB_Base_Mesh", "WeaponSuitBmultYM_MeshShape", false)
		rom.data.draw_set_mesh_visible("WeaponSuitB_Base_Mesh", "WeaponSuitBmultOutlineYM_MeshShape", false)

		rom.data.draw_set_mesh_visible("WeaponSuitB_Base_Mesh", "WeaponSuitBYM_MeshShape", true)
		rom.data.draw_set_mesh_visible("WeaponSuitB_Base_Mesh", "WeaponSuitBOutlineYM_MeshShape", true)

		rom.data.draw_set_mesh_visible("WeaponSuitB_Base_Mesh", "WeaponSuitB_Rig:WeaponSuitB_MeshShape", false)
		rom.data.draw_set_mesh_visible("WeaponSuitB_Base_Mesh", "WeaponSuitB_Rig:WeaponSuitBOutline_MeshShape", false)
	elseif (game.HeroHasTrait("BaseSuitAspect") or game.HeroHasTrait("BaseSuitAspect_Secondary")) then
		rom.data.draw_set_mesh_visible("WeaponSuitMultiple_Base_Mesh", "WeaponSuitBYM_MeshShape", false)
		rom.data.draw_set_mesh_visible("WeaponSuitMultiple_Base_Mesh", "WeaponSuitBOutlineYM_MeshShape", false)

		rom.data.draw_set_mesh_visible("WeaponSuitMultiple_Base_Mesh", "WeaponSuitBmultYM_MeshShape", false)
		rom.data.draw_set_mesh_visible("WeaponSuitMultiple_Base_Mesh", "WeaponSuitBmultOutlineYM_MeshShape", false)

		rom.data.draw_set_mesh_visible("WeaponSuitMultiple_Base_Mesh", "WeaponSuitMultiple_Rig:WeaponSuitB_MeshShape", true)
		rom.data.draw_set_mesh_visible("WeaponSuitMultiple_Base_Mesh", "WeaponSuitMultiple_Rig:WeaponSuitBOutline_MeshShape", true)

		rom.data.draw_set_mesh_visible("WeaponSuitB_Base_Mesh", "WeaponSuitBYM_MeshShape", false)
		rom.data.draw_set_mesh_visible("WeaponSuitB_Base_Mesh", "WeaponSuitBOutlineYM_MeshShape", false)

		rom.data.draw_set_mesh_visible("WeaponSuitB_Base_Mesh", "WeaponSuitBYM_MeshShape", false)
		rom.data.draw_set_mesh_visible("WeaponSuitB_Base_Mesh", "WeaponSuitBOutlineYM_MeshShape", false)

		rom.data.draw_set_mesh_visible("WeaponSuitB_Base_Mesh", "WeaponSuitB_Rig:WeaponSuitB_MeshShape", true)
		rom.data.draw_set_mesh_visible("WeaponSuitB_Base_Mesh", "WeaponSuitB_Rig:WeaponSuitBOutline_MeshShape", true)
	elseif game.HeroHasTrait("DaggerAspectofYoungMelinoe") then
		rom.data.draw_set_mesh_visible("WeaponDaggerA_Mesh", "WeaponDaggerA_Rig:WeaponDaggerA_MeshShapeDeformed", false)
		rom.data.draw_set_mesh_visible("WeaponDaggerB_Mesh", "WeaponDaggerB_Rig:WeaponDaggerB_MeshShapeDeformed", false)
		rom.data.draw_set_mesh_visible("WeaponDaggerA_Mesh", "WeaponDaggerAYM_MeshShapeDeformed", true)
		rom.data.draw_set_mesh_visible("WeaponDaggerB_Mesh", "WeaponDaggerBYM_MeshShapeDeformed", true)

		rom.data.draw_set_mesh_visible("WeaponDaggerB_Mesh", "WeaponDaggerAYM_MeshShapeDeformed", false)
		rom.data.draw_set_mesh_visible("WeaponDaggerA_Mesh", "WeaponDaggerBYM_MeshShapeDeformed", false)
		rom.data.draw_set_mesh_visible("WeaponDagger_Mesh", "WeaponDaggerAYM_MeshShapeDeformed", false)
		rom.data.draw_set_mesh_visible("WeaponDagger_Mesh", "WeaponDaggerBYM_MeshShapeDeformed", false)

		rom.data.draw_set_mesh_visible("WeaponDagger_Mesh", "WeaponDaggerMultipleFree_Rig:WeaponDaggerA_WeaponDaggerA_MeshShapeDeformed", false)
		rom.data.draw_set_mesh_visible("WeaponDagger_Mesh", "WeaponDaggerB_WeaponDaggerB_MeshShapeDeformed", false)
		rom.data.draw_set_mesh_visible("WeaponDagger_Mesh", "WeaponDaggerA_WeaponDaggerAYM_MeshShapeDeformed", true)
		rom.data.draw_set_mesh_visible("WeaponDagger_Mesh", "WeaponDaggerB_WeaponDaggerBYM_MeshShapeDeformed", true)

		rom.data.draw_set_mesh_visible("WeaponDaggerA_Mesh", "WeaponDaggerA_WeaponDaggerAYM_MeshShapeDeformed", false)
		rom.data.draw_set_mesh_visible("WeaponDaggerA_Mesh", "WeaponDaggerB_WeaponDaggerBYM_MeshShapeDeformed", false)
		rom.data.draw_set_mesh_visible("WeaponDaggerB_Mesh", "WeaponDaggerA_WeaponDaggerAYM_MeshShapeDeformed", false)
		rom.data.draw_set_mesh_visible("WeaponDaggerB_Mesh", "WeaponDaggerB_WeaponDaggerBYM_MeshShapeDeformed", false)
	elseif game.HeroHasTrait("DaggerBackstabAspect") or game.HeroHasTrait("DaggerBackstabAspect_Secondary") then
		rom.data.draw_set_mesh_visible("WeaponDaggerA_Mesh", "WeaponDaggerA_Rig:WeaponDaggerA_MeshShapeDeformed", true)
		rom.data.draw_set_mesh_visible("WeaponDaggerB_Mesh", "WeaponDaggerB_Rig:WeaponDaggerB_MeshShapeDeformed", true)
		rom.data.draw_set_mesh_visible("WeaponDaggerA_Mesh", "WeaponDaggerAYM_MeshShapeDeformed", false)
		rom.data.draw_set_mesh_visible("WeaponDaggerB_Mesh", "WeaponDaggerBYM_MeshShapeDeformed", false)

		rom.data.draw_set_mesh_visible("WeaponDaggerB_Mesh", "WeaponDaggerAYM_MeshShapeDeformed", false)
		rom.data.draw_set_mesh_visible("WeaponDaggerA_Mesh", "WeaponDaggerBYM_MeshShapeDeformed", false)
		rom.data.draw_set_mesh_visible("WeaponDagger_Mesh", "WeaponDaggerAYM_MeshShapeDeformed", false)
		rom.data.draw_set_mesh_visible("WeaponDagger_Mesh", "WeaponDaggerBYM_MeshShapeDeformed", false)

		rom.data.draw_set_mesh_visible("WeaponDagger_Mesh", "WeaponDaggerMultipleFree_Rig:WeaponDaggerA_WeaponDaggerA_MeshShapeDeformed", true)
		rom.data.draw_set_mesh_visible("WeaponDagger_Mesh", "WeaponDaggerB_WeaponDaggerB_MeshShapeDeformed", true)
		rom.data.draw_set_mesh_visible("WeaponDagger_Mesh", "WeaponDaggerA_WeaponDaggerAYM_MeshShapeDeformed", false)
		rom.data.draw_set_mesh_visible("WeaponDagger_Mesh", "WeaponDaggerB_WeaponDaggerBYM_MeshShapeDeformed", false)

		rom.data.draw_set_mesh_visible("WeaponDaggerA_Mesh", "WeaponDaggerA_WeaponDaggerAYM_MeshShapeDeformed", false)
		rom.data.draw_set_mesh_visible("WeaponDaggerA_Mesh", "WeaponDaggerB_WeaponDaggerBYM_MeshShapeDeformed", false)
		rom.data.draw_set_mesh_visible("WeaponDaggerB_Mesh", "WeaponDaggerA_WeaponDaggerAYM_MeshShapeDeformed", false)
		rom.data.draw_set_mesh_visible("WeaponDaggerB_Mesh", "WeaponDaggerB_WeaponDaggerBYM_MeshShapeDeformed", false)
	end

	if (game.HeroHasTrait("AxeAspectofYoungMelinoe") or game.HeroHasTrait("AxeAspectofYoungMelinoe_Secondary")) then
	-- if game.HeroHasTrait("AxeAspectofYoungMelinoe") then
		rom.data.draw_set_mesh_visible("Melinoe_Axe_Mesh1", "WeaponAxeYM_MeshShapeDeformed", true)
		rom.data.draw_set_mesh_visible("Melinoe_Axe_Mesh1", "WeaponAxe_Rig_01:WeaponAxe_MeshShapeDeformed", false)
	elseif (game.HeroHasTrait("AxeRecoveryAspect") or game.HeroHasTrait("AxeRecoveryAspect_Secondary")) then
	-- elseif game.HeroHasTrait("AxeRecoveryAspect") then
		rom.data.draw_set_mesh_visible("Melinoe_Axe_Mesh1", "WeaponAxeYM_MeshShapeDeformed", false)
		rom.data.draw_set_mesh_visible("Melinoe_Axe_Mesh1", "WeaponAxe_Rig_01:WeaponAxe_MeshShapeDeformed", true)
	end
end

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

	screen.WeaponList = {}

	local weaponUpgrades = game.DeepCopyTable(game.ScreenData.WeaponUpgradeScreen.DisplayOrder)

	for weaponKit, upgradeList in pairs(weaponUpgrades) do
		for index, upgrade in ipairs(upgradeList) do
			if not game.GameState.WeaponsUnlocked[upgrade] and index ~= 1 then
				upgradeList[index] = nil
			end
		end
		weaponUpgrades[weaponKit] = game.CollapseTable(upgradeList)
	end

	for _, weaponName in ipairs(WeaponDisplayOrder) do
		table.insert(screen.WeaponList,{ WeaponName = weaponName, PrimaryAspects = weaponUpgrades[weaponName], SecondaryAspects = WeaponMinorAspectData[weaponName] })
	end

	screen.ScrollState = {}

	screen.SelectedPrimary = 1
	screen.SelectedSecondary = 1

    for index, weaponName in ipairs(WeaponDisplayOrder) do
		local state = {}
        local weaponData = game.WeaponData[weaponName]
        local traitData1 = game.TraitData[game.GameState.LastWeaponUpgradeName[weaponName]] or game.TraitData[game.ScreenData.WeaponUpgradeScreen.DisplayOrder[weaponName][1]]
        local traitData2 = game.TraitData[game.ScreenData.WeaponUpgradeScreen.DisplayOrder[weaponName][1]]
		state.PrimaryIndex = game.GetIndex(screen.WeaponList[index].PrimaryAspects, traitData1.Name)
		state.SecondaryIndex = 1
		if game.TraitData[config.last_aspect] and game.Contains(WeaponMinorAspectData[weaponName], config.last_aspect) then
			traitData2 = game.TraitData[config.last_aspect:gsub("_Secondary$", "")]
			state.SecondaryIndex = game.GetIndex(WeaponMinorAspectData[weaponName], traitData2.Name.."_Secondary")
		end
        game.SetAnimation({ Name = weaponData.UpgradeScreenKitAnimation .. "_FusionScreen", GrannyModel = traitData1.WeaponKitGrannyModel, DestinationId = components["WeaponImageData1"..weaponName].Id })
		if config.last_primary == weaponName then
			local outlineData = game.ShallowCopyTable( mod.PrimaryWeaponOutline )
			outlineData.Id = components["WeaponImageData1"..weaponName].Id
			game.AddOutline( outlineData )
			game.SetColor({Id = components["WeaponImageData1"..weaponName].Id, Color = { 220, 100, 100, 255 }})
			screen.SelectedPrimary = index
		end
        game.SetAnimation({ Name = weaponData.UpgradeScreenKitAnimation .. "_FusionScreen", GrannyModel = traitData2.WeaponKitGrannyModel, DestinationId = components["WeaponImageData2"..weaponName].Id })
		if config.last_secondary == weaponName then
			local outlineData = game.ShallowCopyTable( mod.SecondaryWeaponOutline )
			outlineData.Id = components["WeaponImageData2"..weaponName].Id
			game.AddOutline( outlineData )
			game.SetColor({Id = components["WeaponImageData2"..weaponName].Id, Color = { 150, 100, 100, 255 }})
			screen.SelectedSecondary = index
		end
		table.insert(screen.ScrollState, state)
    end

	mod.CreateMinorAspectButtons(screen)

	game.TeleportCursor({ OffsetX = screen.ItemStartX + screen.ButtonOffsetX, OffsetY = screen.ItemStartY, ForceUseCheck = true })

	if config.random_fusion_each_run then
		local modify = game.ModifyTextBox({ Id = components.RandomToggle.Id, ColorTarget = { 0.50, 0.90, 0.80, 1.0 }, ColorDuration = 0.2 })
	end

	if rom.mods[AspectYoungMel] then
		DisableYmMesh()
	end

	components.CycleAspectButtonDown.Text = "{ML} {MR} CYCLE ASPECT"
	components.CycleAspectButtonDown.AltText = "{MU} {MD} CYCLE ASPECT"
	components.UnfuseAndExitButton.Text = "HOLD         UNFUSE"  -- 9 spaces for icons to fit in

	game.ModifyTextBox({Id = components.CycleAspectButtonDown.Id, Text = components.CycleAspectButtonDown.Text})
	game.ModifyTextBox({Id = components.UnfuseAndExitButton.Id, Text = components.UnfuseAndExitButton.Text})

    screen.KeepOpen = true
	screen.CanClose = true

	screen.RandomButtonCache = config.random_fusion_each_run

	game.HandleScreenInput( screen )
end

function mod.CreateAspectInfoItem(button)
	local componentIds = game.GetAllIds( button.Screen.BoonInfoBox or {} )
	game.Destroy({ Ids = componentIds })

	local screen = button.Screen
	local components = {}
	local backingAnim = "WeaponSlotBase"
	local index = button.Index
	local weaponName = screen.WeaponList[index].WeaponName
	local traitData
	local groupName = "Combat_Menu"
	local offset = {X = 960, Y = 840}
	local textOffset = -70 - 350
	local titleBoxYOffset = -20


	if button.WeaponType == "Primary" then
		local aspectIndex = screen.ScrollState[index].PrimaryIndex
		local rawTraitData = game.TraitData[screen.WeaponList[index].PrimaryAspects[aspectIndex]]
		traitData = game.GetProcessedTraitData({ Unit = game.CurrentRun.Hero, TraitName = rawTraitData.Name, Rarity = game.GetRarityKey( game.GetWeaponUpgradeLevel( rawTraitData.Name ), game.TraitRarityData.WeaponRarityUpgradeOrder ) })
		game.SetTraitTextData( traitData )
	else
		local aspectIndex = screen.ScrollState[index].SecondaryIndex
		local traitName = WeaponMinorAspectData[weaponName][aspectIndex]
		local rawTraitData = game.TraitData[traitName] or game.TraitData[game.ScreenData.GameStats.WeaponBaseAspectMapping[game.ScreenData.WeaponUpgradeScreen.DisplayOrder[weaponName][1]]]
		traitData = game.GetProcessedTraitData({ Unit = game.CurrentRun.Hero, TraitName = rawTraitData.Name, Rarity = game.GetRarityKey( game.GetWeaponUpgradeLevel( string.gsub(rawTraitData.Name, "_Secondary", "") ), game.TraitRarityData.WeaponRarityUpgradeOrder ) })
		game.SetTraitTextData( traitData )
	end
	components.DetailsBacking = game.CreateScreenComponent({ Name = "BoonSlotBase", Group = "Combat_Menu", X = offset.X, Y = offset.Y, Animation = backingAnim })
	game.SetInteractProperty({ DestinationId = components.DetailsBacking.Id, Property = "FreeFormSelectable", Value = false })
	local detailsData = game.DeepCopyTable( game.ScreenData.UpgradeChoice.DescriptionText )
	detailsData.Id = components.DetailsBacking.Id
	detailsData.TextSymbolScale = traitData.DescriptionTextSymbolScale or detailsData.TextSymbolScale
	game.CreateTextBoxWithFormat( detailsData )

	components.StatlineBackings = {}
	for lineNum = 1, 2 do

		screen.LineHeight = game.ScreenData.UpgradeChoice.LineHeight

		local columnOffset = math.abs( (game.ScreenData.UpgradeChoice.StatLineRight.OffsetX or 0) - (game.ScreenData.UpgradeChoice.StatLineLeft.OffsetX or 0) )
		local offsetY = (lineNum - 1) * screen.LineHeight
		local statLineKey = "StatlineBackings"..lineNum
		components[statLineKey.."Left"] = game.CreateScreenComponent({ Name = "BlankObstacle", Group = groupName, X = offset.X + textOffset, Y = offset.Y })

		local statLineLeft = game.ShallowCopyTable( game.ScreenData.UpgradeChoice.StatLineLeft )
		if traitData ~= nil and traitData.FlavorText ~= nil and traitData.StatLines and #(traitData.StatLines) > 1 then
			offsetY = offsetY + game.GetLocalizedValue( 0, statLineLeft.LangDoubleStatLineAndFlavorTextOffsetY )
		end
		statLineLeft.Id = components[statLineKey.."Left"].Id
		statLineLeft.OffsetX = 0
		statLineLeft.OffsetY = offsetY
		game.CreateTextBoxWithFormat( statLineLeft )

		components[statLineKey.."Right"] = game.CreateScreenComponent({ Name = "BlankObstacle", Group = groupName, X = offset.X + textOffset, Y = offset.Y })
		local statLineRight = game.ShallowCopyTable( game.ScreenData.UpgradeChoice.StatLineRight )
		statLineRight.Id = components[statLineKey.."Right"].Id
		statLineRight.OffsetX = (statLineRight.OffsetX or 0) + columnOffset
		statLineRight.OffsetY = offsetY
		game.CreateTextBoxWithFormat( statLineRight )
		table.insert( components.StatlineBackings, { components[statLineKey.."Left"].Id, components[statLineKey.."Right"].Id } )
	end
	components.TitleBox = game.CreateScreenComponent({ Name = "BlankObstacle", Group = groupName, X = offset.X + textOffset, Y = offset.Y - 30 })
	game.CreateTextBox({
		Id = components.TitleBox.Id,
		FontSize = 25,
		OffsetY = -17 + titleBoxYOffset,
		Font = "P22UndergroundSCMedium",
		ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
		Justification = "Left",
	})

	components.RarityBox = game.CreateScreenComponent({ Name = "BlankObstacle", Group = groupName, X = offset.X, Y = offset.Y - 10 })
	local rarityTextBox = game.ShallowCopyTable( game.ScreenData.UpgradeChoice.RarityText )

	rarityTextBox.Id = components.RarityBox.Id
	rarityTextBox.DataProperties =
	{
		TextSymbolOffsetY = traitData.RarityTextSymbolOffset or 0.0
	}
	game.CreateTextBox( rarityTextBox )

	components.FlavorText = game.CreateScreenComponent({ Name = "BlankObstacle", Group = groupName, X = offset.X, Y = offset.Y})

	local flavorTextData = game.MergeTables(
		{
			Id = components.FlavorText.Id,
		},
		game.ScreenData.UpgradeChoice.FlavorText )
	flavorTextData.LineSpacingBottom = game.GetLocalizedValue(0, game.ScreenData.UpgradeChoice.FlavorText.LangLineSpacingBottom )
	flavorTextData.OffsetY = game.GetLocalizedValue( game.ScreenData.UpgradeChoice.FlavorText.OffsetY, game.ScreenData.UpgradeChoice.FlavorText.LangOffsetY )

	game.CreateTextBox( flavorTextData )
	game.Attach({ Id = components.FlavorText.Id, DestinationId = components.DetailsBacking.Id })

	local iconOffset = { X = -500, Y = -50 }

	if traitData.Icon ~= nil then
		components.Icon = game.CreateScreenComponent({ Name = "BlankObstacle", Group = groupName, X = offset.X + iconOffset.X, Y = offset.Y + iconOffset.Y, Scale = 0.6 })
		game.SetAnimation({ DestinationId = components.Icon.Id, Name = button.Icon or traitData.Icon })
	end

	if not traitData.MetaUpgrade then
		components.Frame = game.CreateScreenComponent({ Name = "BlankObstacle", Group = groupName, X = offset.X + iconOffset.X, Y = offset.Y + iconOffset.Y, Scale = 0.6 })
		local frameAnim = game.GetTraitFrame( traitData )
		if frameAnim ~= nil then
			game.SetAnimation({ DestinationId = components.Frame.Id, Name = frameAnim })
		end
	end

	game.SetTraitTrayDetails(
	{
		Button = {},
		DetailsBox = components.DetailsBacking,
		BlessingsBox = components.BlessingBacking,
		RarityBox = components.RarityBox,
		TitleBox = components.TitleBox,
		--Patch = components.Patch, 
		Icon = components.Icon,
		StatLines = components.StatlineBackings,
		ElementalIcon = components.ElementalIcon,
		FlavorText = components.FlavorText,
		TraitData = traitData
	})

	screen.BoonInfoBox = components
end

function mod.CloseWeaponFusionScreen(screen)
    if screen == nil or not screen.CanClose then
		return
	end
    screen.CanClose = false
	game.SetAnimation({ DestinationId = screen.Components.Background.Id, Name = "WeaponUpgradeOut" })

    game.PlaySound({ Name = "/SFX/Menu Sounds/GeneralWhooshMENULoudLow" })

	game.SetConfigOption({ Name = "ExclusiveInteractGroup", Value = nil })
	game.SetConfigOption({ Name = "FreeFormSelectStepDistance", Value = 16.0 })

	local componentIds = game.GetAllIds( screen.BoonInfoBox or {} )
	game.Destroy({ Ids = componentIds })

    game.OnScreenCloseStarted( screen )
	game.CloseScreen( game.GetAllIds( screen.Components ), 0.15 )
    game.OnScreenCloseFinished( screen )
	game.ShowCombatUI( screen.Name )
	game.wait( 0.3 )

	if rom.mods[AspectYoungMel] then
		EnableYmMesh()
	end

	if config.random_fusion_each_run ~= screen.RandomButtonCache then
		local fusionStatus = config.random_fusion_each_run and "{#AltUpgradeFormat}ON" or "{#AltPenaltyFormat}OFF"
		game.thread( game.InCombatTextArgs, { TargetId= game.CurrentRun.Hero.ObjectId, Text = "Random fusion turned "..fusionStatus, SkipRise = false, SkipFlash = false, Duration = 1.5, ShadowScaleX = 1.2})
	end
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
		end
	end
end

function mod.SetAspectConfig(screen)
	local button = screen.SelectedItem
	local components = screen.Components
	local index = button.Index
	local row = (button.WeaponType == "Primary" and 1) or 2
	if button then
		local playAnim
		if button.WeaponType == "Primary" and screen.SelectedPrimary ~= button.Index then
			game.RemoveOutline( {Id = components["WeaponImageData1"..screen.WeaponList[screen.SelectedPrimary].WeaponName].Id} )
			game.SetColor({Id = components["WeaponImageData1"..screen.WeaponList[screen.SelectedPrimary].WeaponName].Id, Color = game.Color.White})
			screen.SelectedPrimary = button.Index
			local outlineData = game.ShallowCopyTable( mod.PrimaryWeaponOutline )
			outlineData.Id = components[button.WeaponKey].Id
			game.AddOutline( outlineData )
			game.SetColor({Id = outlineData.Id, Color = { 220, 100, 100, 255 }})
			playAnim = true
		end
		if button.WeaponType == "Secondary" and screen.SelectedSecondary ~= button.Index then
			game.RemoveOutline( {Id = components["WeaponImageData2"..screen.WeaponList[screen.SelectedSecondary].WeaponName].Id} )
			game.SetColor({Id = components["WeaponImageData2"..screen.WeaponList[screen.SelectedSecondary].WeaponName].Id, Color = game.Color.White})
			screen.SelectedSecondary = button.Index
			local outlineData = game.ShallowCopyTable( mod.SecondaryWeaponOutline )
			outlineData.Id = components[button.WeaponKey].Id
			game.AddOutline( outlineData )
			game.SetColor({Id = outlineData.Id, Color = { 100, 100, 255, 255 }})
			playAnim = true
		end

		if playAnim then
			local weaponUpgradeSwitchFx = game.CreateScreenObstacle({ Name = "BlankObstacle", X = screen.ItemStartX + (index-1)*screen.ItemSpacingX + 50, Y = screen.ItemStartY + (row-1)*screen.ItemSpacingY, Group = "Combat_Menu_Overlay_Additive", Scale = 0.6})
			game.SetAnimation({ Name = _PLUGIN.guid .. "WeaponUpgradeSwitchFx", DestinationId = weaponUpgradeSwitchFx })
			game.DestroyOnDelay({ Id = weaponUpgradeSwitchFx, 3 })
			game.PlaySound({ Name = "/Leftovers/SFX/PerfectTiming" })
		end

		game.SetScale({Id = components[button.WeaponKey].Id, Fraction = 1.2, Duration = 0.06})
		game.wait(0.06)
		game.SetScale({Id = components[button.WeaponKey].Id, Fraction = 1.5, Duration = 0.06, EaseIn = 0.9, EaseOut = 1.0})
	end
end

function mod.MouseOverMinorAspect(button)
	game.GenericMouseOverPresentation(button)
	local screen = button.Screen
	screen.SelectedItem = button
	local components = button.Screen.Components
	if not ( button.Index == screen.SelectedPrimary and button.WeaponType == "Primary" or
			 button.Index == screen.SelectedSecondary and button.WeaponType == "Secondary" ) then
		local outlineData = game.ShallowCopyTable( mod.HoverWeaponOutline )
		outlineData.Id = components[button.WeaponKey].Id
		game.AddOutline( outlineData )
	end
	mod.CreateAspectInfoItem(button)
	game.SetScale({Id = components[button.WeaponKey].Id, Fraction = 1.5, Duration = 0.15})
	if game.GetConfigOptionValue({ Name = "UseMouse" }) then
		game.ModifyTextBox({Id = components.CycleAspectButtonDown.Id, Text =  components.CycleAspectButtonDown.AltText})
	else
		game.ModifyTextBox({Id = components.CycleAspectButtonDown.Id, Text =  components.CycleAspectButtonDown.Text})
	end
end

function mod.MouseOffMinorAspect(button)
	local componentIds = game.GetAllIds( button.Screen.BoonInfoBox or {} )
	game.Destroy({ Ids = componentIds })
	local screen = button.Screen
	screen.SelectedItem = nil
	local components = button.Screen.Components
	game.RemoveOutline( {Id = components[button.WeaponKey].Id} )
	-- game.SetColor({Id = components[button.WeaponKey].Id, Color = game.Color.White})
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
	if game.GetConfigOptionValue({ Name = "UseMouse" }) then
		game.ModifyTextBox({Id = components.CycleAspectButtonDown.Id, Text =  components.CycleAspectButtonDown.AltText})
	else
		game.ModifyTextBox({Id = components.CycleAspectButtonDown.Id, Text =  components.CycleAspectButtonDown.Text})
	end
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
		local numAspects = #(screen.WeaponList[index].PrimaryAspects)
		local newAspectIndex =  (aspectIndex - 1 + 1) % numAspects + 1
		local traitData1 = game.TraitData[screen.WeaponList[index].PrimaryAspects[newAspectIndex]]
		screen.ScrollState[index].PrimaryIndex = newAspectIndex
		game.SetAnimation({ Name = weaponData.UpgradeScreenKitAnimation .. "_FusionScreen", GrannyModel = traitData1.WeaponKitGrannyModel, DestinationId = components["WeaponImageData1"..weaponName].Id })
	end
	game.PlaySound({ Name = "/SFX/Menu Sounds/GeneralWhooshMENU" })
	mod.CreateAspectInfoItem(button)
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
		local numAspects = #(screen.WeaponList[index].PrimaryAspects)
		local newAspectIndex =  (aspectIndex - 1 - 1) % numAspects + 1
		local traitData1 = game.TraitData[screen.WeaponList[index].PrimaryAspects[newAspectIndex]]
		screen.ScrollState[index].PrimaryIndex = newAspectIndex
		game.SetAnimation({ Name = weaponData.UpgradeScreenKitAnimation .. "_FusionScreen", GrannyModel = traitData1.WeaponKitGrannyModel, DestinationId = components["WeaponImageData1"..weaponName].Id })
	end
	game.PlaySound({ Name = "/SFX/Menu Sounds/GeneralWhooshMENU" })
	mod.CreateAspectInfoItem(button)
end

function mod.FuseAndExit(screen)
	game.wait(0.2)

	if game.IsControlDown({ Name = "ItemPin" }) then
		local notifyName = _PLUGIN.guid .. "HoldFuseNotify"
		local threshold  = 1
		game.NotifyOnControlReleased({
			Names   = { "ItemPin" },
			Notify  = notifyName,
			Timeout = threshold,
		})
		game.SetAnimation({DestinationId = screen.Components.UnfuseHoldButtonGraphic.Id, Name = _PLUGIN.guid .. "HoldButtonAnimation"})
		game.Shake({ Id = screen.Components.UnfuseHoldButtonGraphic.Id, Distance = 1, Speed = 200, Duration = 1 })
		local chargeSoundId = game.PlaySound({Name = "/SFX/Player Sounds/MelinoeAxePhysicalChargeUp"})
		game.waitUntil( notifyName )
		game.StopSound({Id = chargeSoundId})
		local timedOut = game._eventTimeoutRecord and game._eventTimeoutRecord[ notifyName ]
		if game._eventTimeoutRecord then game._eventTimeoutRecord[ notifyName ] = nil end
		if timedOut then
			local completeSoundId =  game.PlaySound({Name = "/SFX/Player Sounds/NyxTurboBoost"})
			game.SetVolume({Id = completeSoundId, Value = 0.8})
			game.Flash({ Id = screen.Components.UnfuseHoldButtonGraphic.Id, Speed = 0.8, MinFraction = 0.1, MaxFraction = 0.3, Color = game.Color.White })
			mod.UnequipWeapons()
			config.last_primary = "WeaponStaffSwing"
			config.last_secondary = "WeaponStaffSwing"
			config.last_aspect = ""
			UnfuseWeapons()
			mod.EquipWeapons()
			game.RequestPreRunLoadoutChangeSave()
			mod.CloseWeaponFusionScreen(screen)
			return
		end
		game.SetAnimation({DestinationId = screen.Components.UnfuseHoldButtonGraphic.Id, Name = _PLUGIN.guid .. "HoldButtonAnimationEmpty"})
		return
	end

	local state = screen.ScrollState
	local selectedPrimary = screen.SelectedPrimary
	local selectedSecondary = screen.SelectedSecondary
	local primaryIndex = state[selectedPrimary].PrimaryIndex
	local secondaryIndex = state[selectedSecondary].SecondaryIndex
	local primaryWeapon = screen.WeaponList[selectedPrimary].WeaponName
	local secondaryWeapon = screen.WeaponList[selectedSecondary].WeaponName
	local primaryAspect = screen.WeaponList[selectedPrimary].PrimaryAspects[primaryIndex]
	local secondaryAspect = WeaponMinorAspectData[secondaryWeapon][secondaryIndex]

	local sameAspect = primaryAspect == string.gsub(secondaryAspect, "_Secondary", "")
	local sameWeapon = (primaryWeapon == secondaryWeapon and not config.allow_same_weapon_fusion)

	if sameAspect or sameWeapon then
		game.Shake({ Id = screen.Components["WeaponImageData1"..primaryWeapon].Id, Distance = 7, Speed = 700, Duration = 0.3 })
		game.Shake({ Id = screen.Components["WeaponImageData2"..primaryWeapon].Id, Distance = 7, Speed = 700, Duration = 0.3 })
		game.PlaySound({ Name = "/SFX/WrathOver", Id = game.CurrentRun.Hero.ObjectId })
		return
	end

	print("Fusing", primaryAspect, primaryWeapon, secondaryAspect, secondaryWeapon)

	mod.UnequipWeapons()
    UnfuseWeapons()
    config.last_primary = primaryWeapon
    config.last_secondary = secondaryWeapon
    config.last_aspect = secondaryAspect
    FuseWeapon(config.last_primary, config.last_secondary, config.last_aspect)
    mod.EquipWeapons({PrimaryUpgrade = primaryAspect})
	game.RequestPreRunLoadoutChangeSave()
	mod.CloseWeaponFusionScreen(screen)
end

function mod.ToggleRandomEachRun(screen, button)
	config.random_fusion_each_run = config.random_fusion_each_run == false
	if config.random_fusion_each_run then
		game.MouseOverContextualAction(button)
		game.PlaySound({ Name = screen.ToggleOffSound, Id = button.Id })
	else
		game.MouseOffContextualAction(button)
		game.PlaySound({ Name = screen.ToggleOnSound, Id = button.Id })
	end
end

game.HubRoomData.Hub_PreRun.ObstacleData[558210].UseTextTalkAndSpecial = "{I} Inspect \n {SI} Weapon Fusion"
game.HubRoomData.Hub_PreRun.ObstacleData[558210].SpecialInteractFunctionName = _PLUGIN.guid .. "." .. "OpenWeaponFusionScreen"
game.HubRoomData.Hub_PreRun.ObstacleData[558210].SpecialInteractGameStateRequirements =
{
	{
		Path = { "GameState", "WeaponsUnlocked", },
		HasAll =
		{
			"WeaponStaffSwing",
			"WeaponDagger",
			"WeaponTorch",
			"WeaponAxe",
			"WeaponLob",
			"WeaponSuit",
		}
	}
}