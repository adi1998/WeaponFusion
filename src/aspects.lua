mod.AspectTraitData = {
    AxeArmCastAspect_Secondary =
	{
        Name = "AxeArmCastAspect_Secondary",
        InheritFrom = {"BaseTrait"},
        Icon = "Hammer_Axe_41",
        ReplacementGrannyModels =
		{
			Melinoe_Axe_Mesh1 = "Melinoe_Axe_Charon_Mesh"
		},
        CastFlatFuseModifier = true,
        RarityLevels =
		{
			Common =
			{
				Multiplier = 1,
			},
			Rare =
			{
				Multiplier = 1.5,
			},
			Epic =
			{
				Multiplier = 2,
			},
			Heroic =
			{
				Multiplier = 2.5,
			},
			Legendary =
			{
				Multiplier = 3,
			},
			Perfect = 
			{
				Multiplier = 4.5,
			}
		},
        OnProjectileCreationFunction =
		{
			ValidProjectiles = { "ProjectileAxeBlock2" },
			Name = "CheckAxeCastArm",
			Args =
			{
				ProjectileName = "ProjectileAxeBlock2",
				BlastMultiplier = { BaseValue = 1.15, SourceIsMultiplier = true },
				Animation = "CharonAspectDetonateFx",
			},
		},
        ExtractValues =
		{
			{
				Key = "ReportedDamageBonus",
				ExtractAs = "TooltipDamage",
				Format = "PercentDelta",
			},
		},
		FlavorText = "AxeArmCastAspect_FlavorText",
    },

	AxeRallyAspect_Secondary =
	{
		Name = "AxeRallyAspect_Secondary",
		InheritFrom = { "BaseTrait" },
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.0,
			},
			Rare =
			{
				Multiplier = 18/21,
			},
			Epic =
			{
				Multiplier = 15/21,
			},
			Heroic =
			{
				Multiplier = 12/21,
			},
			Legendary =
			{
				Multiplier = 9/21,
			},
			Perfect =
			{
				Multiplier = 4/21,
			},
		},
		Icon = "Hammer_Axe_43",
		ReplacementGrannyModels = 
		{
			Melinoe_Axe_Mesh1 = "Melinoe_Axe_Nergal_Mesh"
		},
		WeaponDataOverride =
		{
			WeaponAxeSpecial =
			{
				Sounds =
				{
					ChargeSounds =
					{
						{ Name = "/VO/MelinoeEmotes/AnubisEmoteCharging1" },
						{ Name = "/SFX/Player Sounds/MelinoeAxePhysicalChargeUp",
							StoppedBy = { "ChargeCancel", "TriggerRelease", "Fired"} }
					},
					FireSounds =
					{
						{ Name = "/VO/MelinoeEmotes/NergalEmoteAttacking4" },
					},
					ImpactSounds =
					{
						Invulnerable = "/SFX/SwordWallHitClank",
						Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
						Bone = "/SFX/MetalBoneSmash",
						Brick = "/SFX/MetalStoneClang",
						Stone = "/SFX/MetalStoneClang",
						Organic = "/SFX/DaggerImpactOrganic",
						StoneObstacle = "/SFX/SwordWallHitClank",
						BrickObstacle = "/SFX/SwordWallHitClank",
						MetalObstacle = "/SFX/SwordWallHitClank",
						BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
						Shell = "/SFX/ShellImpact",
					},

				},
			},

			WeaponAxeSpecialSwing =
			{
				CustomManaIndicatorOffsetY = -340,
				Sounds =
				{
					ImpactSounds =
					{
						Invulnerable = "/SFX/SwordWallHitClank",
						Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
						Bone = "/SFX/MetalBoneSmashSHIELD",
						Brick = "/SFX/MetalStoneClangSHIELD",
						Stone = "/SFX/MetalStoneClangSHIELD",
						Organic = "/SFX/MetalOrganicHitSHIELD",
						StoneObstacle = "/SFX/Player Sounds/ShieldObstacleHit",
						BrickObstacle = "/SFX/Player Sounds/ShieldObstacleHit",
						MetalObstacle = "/SFX/Player Sounds/ShieldObstacleHit",
						BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
						Shell = "/SFX/ShellImpact",
					},
				},
			},
		},
		PropertyChanges =
		{
			{
				WeaponName = "WeaponAxeSpecial",
				WeaponProperties = 
				{
					NumProjectiles = 1,
					ChargeTime = 0.15,
					ChargeStartAnimation = "Melinoe_Axe_Nergal_Special_Start",
					FireGraphic = "Melinoe_Axe_Nergal_Special_Fire",
					FireFx = "null",

					RootOwnerWhileFiring = false,
					BlockMoveInput = false,
					CancelMovement = false,
					ChargeCancelMovement = false,
				},
				ProjectileProperties = 
				{
					Damage = 60,
					MultipleUnitCollisions = false,
					StartDelay = 0.12,
					StartFx = "AxeSwipeUpper",
				},
				ExcludeLinked = true,
			},
			{
				WeaponNames = { "WeaponAxeSpecial" },
				EffectName = "AxeSpecialDisable",
				EffectProperty = "Duration",
				ChangeValue = 0.23,
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponNames = { "WeaponAxeSpecial" },
				EffectName = "AxeSpecialDisable",
				EffectProperty = "DisableMove",
				ChangeValue = false,
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponNames = { "WeaponAxeSpecial" },
				EffectName = "AxeSpecialDisable",
				EffectProperty = "DisableRotate",
				ChangeValue = false,
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponNames = { "WeaponAxeSpecial" },
				EffectName = "AxeSpecialDisableCancelable",
				EffectProperty = "Duration",
				ChangeValue = 0.23,
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponNames = { "WeaponAxeSpecial" },
				EffectName = "AxeSpecialDisableCancelable",
				EffectProperty = "DisableMove",
				ChangeValue = false,
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponNames = { "WeaponAxeSpecial" },
				EffectName = "AxeSpecialDisableCancelable",
				EffectProperty = "DisableRotate",
				ChangeValue = false,
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponNames = { "WeaponAxeSpecial" },
				EffectName = "AxeSpecialDisableMovementCancelable",
				EffectProperty = "DisableMove",
				ChangeValue = false,
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponNames = { "WeaponAxeSpecial" },
				EffectName = "AxeSpecialDisableMovementCancelable",
				EffectProperty = "DisableRotate",
				ChangeValue = false,
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponNames = { "WeaponAxeSpecial" },
				EffectName = "AspectSlowCharge",
				EffectProperty = "Active",
				ChangeValue = true,
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponNames = { "WeaponAxeSpecial" },
				EffectName = "AspectSlowFire",
				EffectProperty = "Active",
				ChangeValue = true,
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponAxeSpecialSwing",
				WeaponProperties = 
				{
					ChargeStartAnimation = "Melinoe_Axe_Nergal_SpecialEx_Start",
					FireGraphic = "Melinoe_Axe_Nergal_SpecialEx_Fire",
					ChargeCancelGraphic = "Melinoe_Axe_Nergal_SpecialEx_Cancel",
					BarrelLength = 70,
					ProjectileSpacing = 0,
					ProjectileInterval = 0.40,
					ProjectileBlastIncrement = 0.33,
					ChargeTime = 0.72,

					ChargeCancelMovement = false,
					BlockMoveInput = false,
					CancelMovement = false,
					RootOwnerWhileFiring = false,
				},
				ProjectileProperties = 
				{	
					DamageRadius = 460/1.4,
					Damage = 70,
					DetonateSound = "/SFX/Player Sounds/MelinoeAxeSwingFinisherNergal",
				},
				ExcludeLinked = true,
			},

			{
				WeaponNames = { "WeaponAxeSpecialSwing" },
				EffectName = "BigDisable",
				EffectProperty = "Duration",
				ChangeValue = 0.66,
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponNames = { "WeaponAxeSpecialSwing" },
				EffectName = "BigDisableCancellable",
				EffectProperty = "Duration",
				ChangeValue = 0.88,
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
			{
				WeaponNames = { "WeaponAxeSpecialSwing" },
				EffectName = "BigSelfSlowCharge",
				EffectProperty = "Active",
				ChangeValue = false,
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},

			{
				WeaponNames = { "WeaponAxeSpecial" },
				EffectName = "AspectSlowCharge2",
				EffectProperty = "Active",
				ChangeValue = true,
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},
		},
		SetupFunction =
		{
			Threaded = true,
			Name = "SetupFrenzyUI",
		},
		OnEnemyDamagedAction =
		{
			FunctionName = _PLUGIN.guid .. "." .. "CheckFrenzyCount",
			ValidWeapons = game.WeaponSets.HeroPrimarySecondaryWeapons,
			FirstHitOnly = true,
			Args =
			{
				RequiredCount = { BaseValue = 21 },
				EffectName = "Frenzy",
				DataProperties =
				{
					Duration = 10,
					ReportValues = { ReportedDuration = "Duration"},
				},
				ReportValues = { ReportedCount = "RequiredCount"}
			},
		},
		AddOutgoingLifestealModifiers =
		{
			ValidWeapons = game.WeaponSets.HeroPrimarySecondaryWeapons,
			Unmultiplied = true,
			RequiredEffect = "Frenzy",
			AddHeroTraitValue = "FrenzyLifestealBonus",
			ValidMultiplier = 0.01,
			MinLifesteal = 1,
			MaxLifesteal = 1,
			ReportValues =
			{
				ReportedLifeStealAmount = "MinLifesteal",
			},
		},
		StatLines =
		{
			"RallyHealthStatDisplay"
		},
		ExtractValues = 
		{
			{
				Key = "ReportedCount",
				ExtractAs = "Count",
			},
			{
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectLuaData",
				BaseName = "Frenzy",
				BaseProperty = "BaseLifeSteal",
				ExtractAs = "FrenzyLifeStealAmount",
			},
			{
				ExtractAs = "FrenzyDuration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "Frenzy",
				BaseProperty = "Duration",
			},
			{
				ExtractAs = "ReportedSpeed",
				SkipAutoExtract = true,
				External = true,
				BaseType = "EffectData",
				BaseName = "Frenzy",
				Format = "PercentReciprocalDelta",
				BaseProperty = "Modifier",
			},
		},
		FlavorText = "AxeRallyAspect_FlavorText",
	},

	SuitComboAspect_Secondary =
	{	
		Name = "SuitComboAspect_Secondary",
		InheritFrom = { "BaseTrait" },
		Icon = "Hammer_Suit_16",
		ReplacementGrannyModels =
		{
			WeaponSuitR_Base_Mesh = "WeaponSuitR_Shiva_Mesh",
			WeaponSuitL_Base_Mesh = "WeaponSuitL_Shiva_Mesh",
			WeaponSuitB_Base_Mesh = "WeaponSuitB_Shiva_Mesh",
		},
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1
			},
			Rare =
			{
				Multiplier = 1.5
			},
			Epic =
			{
				Multiplier = 2
			},
			Heroic =
			{
				Multiplier = 2.5
			},
			Legendary =
			{
				Multiplier = 3
			},
			Perfect =
			{
				Multiplier = 4
			},
		},
		SetupFunction =
		{
			Threaded = true,
			Name = "SetupSuitUI",
		},
		AddOutgoingDamageModifiers =
		{
			ValidWeapons = { "WeaponAxeSpin", "WeaponStaffSwing5", "WeaponDagger5"},
			ValidSuitProjectile = true,
		},
		OnProjectileDeathFunction =
		{
			Name = "CheckSelfBuffBlast",
			ValidProjectiles = { "ProjectileSuitBomb", "ProjectileSuitBombStraight" },
			Args =
			{
				NumBounces = 2,
				EffectName = "ShivaAttackBoost",
			},
		},
		WeaponDataOverride =
		{
			WeaponSuitRanged =
			{
				DisableSeek = true,
				SkipFunctionFire = true,
				ManualCheckDamageOnFire = false,
				ManualCheckOnWeaponFired = false,
				OnChargeFunctionNames = { "DoWeaponCharge" },
				OnProjectileDeathFunction = "nil",
				Sounds =
				{
					ChargeSounds =
					{
						{
							Name = "/SFX/Player Sounds/MelShivaChargingLoop",
							StoppedBy = { "ChargeCancel", "Fired" }
						},
					},	
					ChargeStageSounds =
					{
						{
							Name = "/VO/MelinoeEmotes/ShivaEmoteCharging2",
							StoppedBy = { "ChargeCancel", "Fired", }
						}
					},
					FireSounds =
					{
						{ Name = "/SFX/Player Sounds/MelinoeSuitShivaSpecial" },
						{ Name = "/VO/MelinoeEmotes/ShivaEmoteSpecial1" },
					},
					FireStageSounds = 
					{
						{ Name = "/SFX/Player Sounds/MelinoeSuitShivaOmegaSpecial" },
						{ Name = "/VO/MelinoeEmotes/ShivaEmoteAttacking3" },
					},
				},
				ChargeWeaponStages = 
				{
					{ 
						ManaCost = 45,
						Wait = 0.35,
						EarlyPropertySwaps = 
						{
							Delay = 0.30,
							SwapProperties = 
							{
								WeaponProperties =
								{
									TargetReticleAnimation = "ShivaReticle",
									AutoLock = false,
									ManualAiming = true,
      								ShowFreeAimLine = true,
									WeaponRange = 505,
									AutoLockRange = 900,
									AutoLockArcDistance = 120,
									ManualAimingInitialOffset = 540,
								},
							},
						},
						WeaponProperties = 
						{ 
							NumProjectiles = 1,
							Projectile = "ProjectileSuitBomb",
      						SelfVelocity = 0,
							AdditionalProjectileWaveChance = 0,
						},
						CompleteObjective = "WeaponSuitRangedCharged_Shiva",
						ChannelSlowEventOnStart = true
					},
				},
			},
		},
		PropertyChanges = 
		{
			{
				WeaponName = "WeaponSuitRanged",
				WeaponProperties = 
				{
					Projectile = "ProjectileSuitGrenade",
					ChargeStartAnimation = "Melinoe_Suit_Shiva_SpecialMissile_Start",
					FireGraphic = "Melinoe_Suit_Shiva_SpecialMissile_Fire",
					ChargeCancelGraphic = "Melinoe_Suit_Shiva_SpecialMissile_End",
					NumProjectiles = 1,
					Spread = 0,
					LockTriggerForMinCharge = true,
					Cooldown = 0.6,
					ClipSize = 1,
					ChargeTime = 0.1,
					ClipRegenInterval = 0.4,
					AcceptTriggerLockRequests = true,
				},
				ExcludeLinked = true,
			},
		},
		OnWeaponFiredFunctions =
		{
			ValidWeapons = {"WeaponSuitCharged", "WeaponSuitRanged", "WeaponAxeSpin", "WeaponStaffSwing5", "WeaponDagger5" },
			FunctionName = "CheckSuitComboAttackBuff",
			FunctionArgs =
			{
				EffectName = "ShivaAttackBoost",
				SelfEffectStackMultiplier = 0.50,
				SelfEffectMaxStacks = { BaseValue = 2 },
				ReportValues =
				{
					ReportedMaxStacks = "SelfEffectMaxStacks",
					ReportedStackMultiplier = "SelfEffectStackMultiplier",
				}
			}
		},
		OnProjectileCreationFunction =
		{
			ValidProjectiles = { "ProjectileSwing5", "ProjectileAxeSpin" },
			Name = _PLUGIN.guid .. "." .. "CheckSuitComboAttackBuff",
			Args =
			{
				EffectName = "ShivaAttackBoost",
				SelfEffectStackMultiplier = 0.50,
				SelfEffectMaxStacks = 2,
				ReportValues =
				{
					ReportedMaxStacks = "SelfEffectMaxStacks",
					ReportedStackMultiplier = "SelfEffectStackMultiplier",
				}
			}
		},
		OnExpire =
		{
			FunctionName = "EndShivaBuff",
		},
		StatLines =
		{
			"ExecuteThresholdStatDisplay",
		},
		ExtractValues =
		{
			{
				Key = "ReportedMaxStacks",
				ExtractAs = "StackCount",
			},
			{
				Key = "ReportedStackMultiplier",
				ExtractAs = "ExecuteBonus",
				Format = "Percent",
				SkipAutoExtract = true,
			},

		},
		FlavorText = "SuitComboAspect_FlavorText",
	},

	DaggerHomingThrowAspect_Secondary =
	{
		Name = "DaggerHomingThrowAspect_Secondary",
		InheritFrom = { "BaseTrait" },
		RarityLevels =
		{
			Common =
			{
				MinMultiplier = 1.0,
				MaxMultiplier = 1.0,
			},
			Rare =
			{
				MinMultiplier = 2.0,
				MaxMultiplier = 2.0,
			},
			Epic =
			{
				MinMultiplier = 3.0,
				MaxMultiplier = 3.0,
			},
			Heroic =
			{
				MinMultiplier = 4.0,
				MaxMultiplier = 4.0,
			},
			Legendary =
			{
				MinMultiplier = 5.0,
				MaxMultiplier = 5.0,
			},
			Perfect =
			{
				Multiplier = 8
			}
		},
		Icon = "Hammer_Daggers_40",
		ReplacementGrannyModels =
		{
			WeaponDaggerA_Mesh = "WeaponDaggerA_Pan_Mesh",
			WeaponDaggerB_Mesh = "WeaponDaggerB_Pan_Mesh"
		},
		ChargeStageModifiers =
		{
			ValidWeapons = {"WeaponDaggerThrow"},
			AddProjectedChargeStages =
			{
				NumStages = { BaseValue = 1 },
				ProjectedChanges =
				{
					NumProjectiles = 1,
					ManaCost = 3,
				},
				ReportValues = { ReportedProjectiles = "NumStages" }
			},
			AddWeaponPropertiesStageRequirementMin = 5,
			AddWeaponProperties =
			{
				FireGraphic = "Melinoe_Dagger_SpecialEx_Fire_Slow",
			},
			HideStageReachedFxExceptForFinal = true ,
		},
		OnEnemyDamagedAction =
		{
			FunctionName = "CheckDaggerPenetration",
			ValidProjectiles = { "ProjectileDaggerThrowCharged" },
		},
		StatLines =
		{
			"ExThrowStatDisplay1",
		},
		PropertyChanges =
		{
			{
				WeaponNames = { "WeaponDaggerThrow" },
				ExcludeLinked = true,
				ProjectileProperties = 
				{
					AdjustRateAcceleration = math.rad(10000),
					MaxAdjustRate = math.rad(2160),
					RequireTargetsHaveEffect = "ImpactSlow",
				}

			},

			{
				WeaponName = "WeaponDaggerThrow",
				ProjectileName = "ProjectileDaggerThrowCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "DaggerProjectileFx_Pan",
				ChangeType = "Absolute",
			},

		},
		ExtractValues =
		{
			{
				Key = "ReportedProjectiles",
				ExtractAs = "Projectiles",
				IncludeSigns = true,
			},
		},
		FlavorText = "DaggerHomingThrowAspect_FlavorText",
	},

	StaffClearCastAspect_Secondary =
	{
		InheritFrom = { "BaseTrait" },
		Icon = "Hammer_Staff_40",
		ReplacementGrannyModels = 
		{
			WeaponStaff_Mesh = "WeaponStaff_Circe_Mesh"
		},

		RarityLevels =
		{
			Common =
			{
				Multiplier = 1,
			},
			Rare =
			{
				Multiplier = 15/10,
			},
			Epic =
			{
				Multiplier = 20/10,
			},
			Heroic =
			{
				Multiplier = 25/10,
			},
			Legendary =
			{
				Multiplier = 30/10,
			},
			Perfect =
			{
				Multiplier = 45/10,
			},
		},
		OnWeaponFiredFunctions =
		{
			ValidWeapons = game.WeaponSets.HeroRangedWeapons,
			FunctionName = "CheckFamiliarLink",
			FunctionArgs =
			{
				ProjectileName = "FamiliarLinkLaser",
				DamageMultiplier = { BaseValue = 1.0 },
				ReportValues = { ReportedDamage = "DamageMultiplier" }
			},
			ExcludeLinked = true,
		},
		StatLines =
		{
			"ClearCastDurationDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedDamage",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "FamiliarLinkLaser",
				BaseProperty = "Damage",
			},
			{
				ExtractAs = "Duration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "ProjectileBase",
				BaseName = "FamiliarLinkLaser",
				BaseProperty = "Fuse",
			},
			{
				ExtractAs = "Interval",
				SkipAutoExtract = true,
				External = true,
				BaseType = "ProjectileBase",
				BaseName = "FamiliarLinkLaser",
				BaseProperty = "ImmunityDuration",
				DecimalPlaces = 1,
			},
		},
		FlavorText = "StaffClearCastAspect_FlavorText",
	}
}

game.OverwriteTableKeys( game.TraitData, mod.AspectTraitData )

for traitName, traitData in pairs(mod.AspectTraitData) do
    game.ProcessDataInheritance( traitData, game.TraitData )
end

function mod.CheckFrenzyCount(victim, functionArgs, triggerArgs)
	if game.IsEmpty( game.CurrentRun.Hero.ActiveEffects ) or not game.CurrentRun.Hero.ActiveEffects.Frenzy then
		local startingCount = game.MapState.FrenzyHits or 0
		game.IncrementTableValue( game.MapState, "FrenzyHits" )
		local requiredCount = 21
		local traitData = game.GetHeroTrait("AxeRallyAspect_Secondary")
		if traitData.OnEnemyDamagedAction and traitData.OnEnemyDamagedAction.Args then
			requiredCount = traitData.OnEnemyDamagedAction.Args.RequiredCount or requiredCount
		end
		if game.ScreenAnchors.AxeUIChargeAmount then
			game.SetAnimationFrameTarget({ Name = "StaffReloadTimer", DestinationId = game.ScreenAnchors.AxeUIChargeAmount, Fraction = game.MapState.FrenzyHits / requiredCount, Instant = true })
		end
	end

	if game.MapState.FrenzyHits >= functionArgs.RequiredCount then
		game.MapState.FrenzyHits = 0
		local dataProperties = game.MergeTables(game.EffectData[functionArgs.EffectName].DataProperties, functionArgs.DataProperties)
		dataProperties.Duration = dataProperties.Duration + game.GetTotalHeroTraitValue("FrenzyDurationBonus")
		game.ApplyEffect( game.MergeTables({ DestinationId = game.CurrentRun.Hero.ObjectId, Id = game.CurrentRun.Hero.ObjectId, EffectName = functionArgs.EffectName, DataProperties = dataProperties }))
	end
end

modutil.mod.Path.Wrap("ShowAxeUI", function (base)
	base()

	if not game.HeroHasTrait("AxeRallyAspect_Secondary") or not game.ShowingCombatUI then
		return
	end

	if game.ScreenAnchors.AxeUI ~= nil then
		return
	end

	game.ScreenAnchors.AxeUI = game.CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray_Overlay_Additive", X = game.HUDScreen.AmmoX, Y = game.ScreenHeight - game.HUDScreen.AmmoBottomOffset - 50 })
	game.ScreenAnchors.AxeUIChargeAmount = game.CreateScreenObstacle({ Name = "BlankObstacle", Group = game.HUDScreen.ComponentData.DefaultGroup, X = game.HUDScreen.AmmoX, Y = game.ScreenHeight - game.HUDScreen.AmmoBottomOffset - 50 })

	if game.HeroHasTrait("AxeRallyAspect_Secondary") then
		game.SetAnimation({ Name = "StaffReloadTimer", DestinationId = game.ScreenAnchors.AxeUIChargeAmount })
		local currentHits = game.MapState.FrenzyHits or 0
		local requiredCount = 12
		local traitData = game.GetHeroTrait("AxeRallyAspect_Secondary")
		if traitData.OnWeaponFiredFunctions and traitData.OnWeaponFiredFunctions.FunctionArgs then
			requiredCount = traitData.OnWeaponFiredFunctions.FunctionArgs.RequiredCount or requiredCount
		end
		game.SetAnimationFrameTarget({ Name = "StaffReloadTimer", DestinationId = game.ScreenAnchors.AxeUIChargeAmount, Fraction = currentHits / requiredCount, Instant = true })
		if currentHits >= requiredCount then
			game.SetAnimation({Name = "StaffReloadTimerReady", SuppressSounds = true, DestinationId = game.ScreenAnchors.AxeUI })
		end
		game.SetAlpha({ Id = game.ScreenAnchors.AxeUI, Duration = 0, Fraction = 0 })
		game.SetAlpha({ Id = game.ScreenAnchors.AxeUI, Duration = game.HUDScreen.FadeInDuration, Fraction = game.ConfigOptionCache.HUDOpacity })
		game.SetAlpha({ Id = game.ScreenAnchors.AxeUIChargeAmount, Duration = 0, Fraction = 0 })
		game.SetAlpha({ Id = game.ScreenAnchors.AxeUIChargeAmount, Duration = game.HUDScreen.FadeInDuration, Fraction = game.ConfigOptionCache.HUDOpacity })
	end
end)

modutil.mod.Path.Wrap("ShowSuitUI", function (base, args)
	base(args)
	args = args or {}
	if not game.HeroHasTrait("SuitComboAspect_Secondary") or not game.ShowingCombatUI then
		return
	end
	if game.ScreenAnchors.SuitUI ~= nil then
		game.SetAlpha({ Ids = { game.ScreenAnchors.SuitUI, game.ScreenAnchors.SuitUIChargeAmount }, Duration = args.FadeDuration or game.HUDScreen.FadeInDuration, Fraction = args.Fraction or game.ConfigOptionCache.HUDOpacity })
		return
	end

	game.ScreenAnchors.SuitUI = game.CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray_Overlay_Additive", X = game.HUDScreen.AmmoX, Y = game.ScreenHeight - game.HUDScreen.AmmoBottomOffset - 50 })
	game.ScreenAnchors.SuitUIChargeAmount = game.CreateScreenObstacle({ Name = "BlankObstacle", Group = game.HUDScreen.ComponentData.DefaultGroup, X = game.HUDScreen.AmmoX, Y = game.ScreenHeight - game.HUDScreen.AmmoBottomOffset - 50 })
	game.SetAnimation({ Name = "StaffReloadTimer", DestinationId = game.ScreenAnchors.SuitUIChargeAmount })
	game.SetAnimationFrameTarget({ Name = "StaffReloadTimer", DestinationId = game.ScreenAnchors.SuitUIChargeAmount, Fraction = 0, Instant = true })
	game.SetAlpha({ Id = game.ScreenAnchors.SuitUI, Duration = 0, Fraction = 0 })
	game.SetAlpha({ Id = game.ScreenAnchors.SuitUI, Duration = game.HUDScreen.FadeInDuration, Fraction = game.ConfigOptionCache.HUDOpacity })
	game.SetAlpha({ Id = game.ScreenAnchors.SuitUIChargeAmount, Duration = 0, Fraction = 0 })
	game.SetAlpha({ Id = game.ScreenAnchors.SuitUIChargeAmount, Duration = game.HUDScreen.FadeInDuration, Fraction = game.ConfigOptionCache.HUDOpacity })
	game.CreateTextBox({
		Id = game.ScreenAnchors.SuitUI,
		OffsetX = 26, OffsetY = -2,
		TextSymbolScale = 0.88,
		Font = "NumericP22UndergroundSCHeavy", FontSize = 24,
		ShadowRed = 0.1, ShadowBlue = 0.1, ShadowGreen = 0.1,
		OutlineColor = {0.113, 0.113, 0.113, 1}, OutlineThickness = 1,
		ShadowAlpha = 1.0, ShadowBlur = 0, ShadowOffsetY = 2, ShadowOffsetX = 0,
		Justification = "Left",
		})
	game.UpdateSuitUI()
end)

modutil.mod.Path.Wrap("UpdateSuitUI", function (base)
	base()
	if game.HeroHasTrait("SuitComboAspect_Secondary") then
		local trait = game.GetHeroTrait("SuitComboAspect_Secondary")
		local effectName = trait.OnWeaponFiredFunctions.FunctionArgs.EffectName
		local stacks = 0
		local maxStacks = trait.OnWeaponFiredFunctions.FunctionArgs.SelfEffectMaxStacks

		if not game.IsEmpty(game.CurrentRun.Hero.ActiveEffects) and game.CurrentRun.Hero.ActiveEffects[effectName] then
			stacks = game.CurrentRun.Hero.ActiveEffects[effectName]
		end

		local text = "UI_StackText"
		local font = "NumericP22UndergroundSCHeavy"
		if stacks >= trait.OnWeaponFiredFunctions.FunctionArgs.SelfEffectMaxStacks then
			text = "UI_StackText_Max"
			font = "P22UndergroundSCHeavy"
		end
		game.SetAnimationFrameTarget({ Name = "StaffReloadTimer", DestinationId = game.ScreenAnchors.SuitUIChargeAmount, Fraction = stacks/maxStacks, Instant = true })
		if stacks >= maxStacks then
			game.SetAnimation({ Name = "StaffReloadTimerReady", DestinationId = game.ScreenAnchors.SuitUI })
		else
			game.StopAnimation({ Name = "StaffReloadTimerReady", DestinationId = game.ScreenAnchors.SuitUI })
		end
		game.ModifyTextBox({ Id = game.ScreenAnchors.SuitUI, Text =  text, Font = font, LuaKey = "TempTextData", LuaValue = { Amount = stacks}})
	end
end)

modutil.mod.Path.Wrap("ShivaAttackBoostApply", function (base, triggerArgs)
	base(triggerArgs)
	if not game.HeroHasTrait("SuitComboAspect_Secondary") then
		return
	end
	local victim = triggerArgs.Victim
	game.IncrementTableValue( victim.ActiveEffects, triggerArgs.EffectName )

	game.UpdateSuitUI()

	local trait = game.GetHeroTrait("SuitComboAspect_Secondary")
	local maxStacks = trait.OnWeaponFiredFunctions.FunctionArgs.SelfEffectMaxStacks
	game.PlaySound({ Name = "/SFX/Player Sounds/ShivaPowerUp", Id = game.CurrentRun.Hero.ObjectId })
	game.SetAnimationFrameTarget({ Name = "StaffReloadTimer", DestinationId = game.ScreenAnchors.SuitUIChargeAmount, Fraction = victim.ActiveEffects[triggerArgs.EffectName]/maxStacks, Instant = true })
	if victim.ActiveEffects[triggerArgs.EffectName] >= maxStacks then
		game.SessionMapState.ShivaMaxStackPresentation = true
		game.SetAnimation({ Name = "StaffReloadTimerReady", DestinationId = game.ScreenAnchors.SuitUI })
	end
end)

modutil.mod.Path.Wrap("ShivaAttackBoostClear", function (base, triggerArgs)
	base(triggerArgs)
	if not game.HeroHasTrait("SuitComboAspect_Secondary") then
		return
	end

	local victim = triggerArgs.Victim
	local trait = game.GetHeroTrait("SuitComboAspect_Secondary")

	game.SetAnimationFrameTarget({ Name = "StaffReloadTimer", DestinationId = game.ScreenAnchors.SuitUIChargeAmount, Fraction = 0, Instant = true })
	if game.SessionMapState.ShivaMaxStackPresentation then
		game.SetAnimation({ Name = "StaffReloadTimerOut", DestinationId = game.ScreenAnchors.SuitUI })
		game.SessionMapState.ShivaMaxStackPresentation = nil
	end
	game.UpdateSuitUI()
end)

modutil.mod.Path.Wrap("CheckSuitComboAttackBuff", function (base, weaponData, functionArgs, triggerArgs)
	if game.Contains({"WeaponStaffSwing5", "WeaponAxeSpin"}, weaponData.Name) then
		if weaponData.Name == "WeaponStaffSwing5" then
			game.waitUntil(_PLUGIN.guid .. "ProjectileCreation")
			game.waitUntil(_PLUGIN.guid .. "ProjectileCreation")
			if game.HeroHasTrait("StaffExAoETrait") then
				game.waitUntil(_PLUGIN.guid .. "ProjectileCreation")
				game.waitUntil(_PLUGIN.guid .. "ProjectileCreation")
			end
		elseif weaponData.Name == "WeaponAxeSpin" then
			game.waitUntil(_PLUGIN.guid .. "ProjectileCreation")
		end

		local projectileIds = game.SessionMapState[_PLUGIN.guid .. "ProjectileIds"] or {}
		local stacks = game.CurrentRun.Hero.ActiveEffects[functionArgs.EffectName]
		if not stacks then
			return
		end
		if functionArgs.SelfEffectMaxStacks and stacks > functionArgs.SelfEffectMaxStacks then
			stacks = functionArgs.SelfEffectMaxStacks
		end
		for _, id in ipairs(projectileIds) do
			game.SessionMapState.SuitBonusProjectileId[id] = 1 + functionArgs.SelfEffectStackMultiplier * stacks
		end
		game.ClearEffect({Id = game.CurrentRun.Hero.ObjectId, Name = "ShivaAttackBoost"})
		game.SessionMapState[_PLUGIN.guid .. "ProjectileIds"] = nil
		return
	end
	game.SessionMapState[_PLUGIN.guid .. "ProjectileIds"] = nil
	base(weaponData, functionArgs, triggerArgs)
end)

function mod.CheckSuitComboAttackBuff(triggerArgs, functionArgs)
	game.SessionMapState[_PLUGIN.guid .. "ProjectileIds"] = game.SessionMapState[_PLUGIN.guid .. "ProjectileIds"] or {}
	table.insert(game.SessionMapState[_PLUGIN.guid .. "ProjectileIds"], triggerArgs.ProjectileId)
	game.notifyExistingWaiters(_PLUGIN.guid .. "ProjectileCreation")
end