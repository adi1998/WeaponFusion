local artemisValidWeapons = game.CombineTables( game.WeaponSets.HeroPrimarySecondaryWeapons, {"WeaponTransformAttack", "WeaponTransformSpecial"} )
game.RemoveValueAndCollapse(artemisValidWeapons, "WeaponAxeSpin")

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
		AddOutgoingDamageModifiers =
		{
			ValidProjectileIdMultiplier =
			{
				BaseValue = 1.1,
				SourceIsMultiplier = true,
			},
			ReportValues =
			{
				ReportedDamageBonus = "ValidProjectileIdMultiplier"
			},
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
		StatLines =
		{
			"AxeArmStatDisplay1",
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
		OnExpire =
		{
			FunctionName = "EndNergalBuff"
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
			Args =
			{
				RequiredCount = { BaseValue = 21 },
				EffectName = "Frenzy",
				FirstHitOnly = true,
				MultihitProjectileWhitelist =
				{
					"ProjectileStaffSingle",
				},
				MultihitProjectileConditions =
				{
					ProjectileStaffSingle = { Cooldown = 0.5 },
				},
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
			ValidWeapons = { "WeaponAxeSpin", "WeaponStaffSwing5", "WeaponDagger5", "WeaponTorch", "WeaponLob", "WeaponSuitCharged"},
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
			{
				FalseTraitName = "AxeFreeSpinTrait",
				WeaponName = "WeaponAxeSpin",
				WeaponProperty = "RemoveControlOnCharge2",
				ChangeValue = "WeaponSuitRanged",
			},
			{
				WeaponName = "WeaponAxeSpin",
				WeaponProperty = "AddControlOnFireEnd2",
				ChangeValue = "WeaponSuitRanged",
			}
		},
		OnWeaponFiredFunctions =
		{
			ValidWeapons = {"WeaponSuitCharged", "WeaponSuitRanged", "WeaponAxeSpin", "WeaponStaffSwing5", "WeaponDagger5", "WeaponLob", "WeaponTorch" },
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
			ValidProjectiles = {
				"ProjectileSwing5", "ProjectileStaffWall", --[["ProjectileAxeSpin",]] "ProjectileTorchWave", "ProjectileTorchGhostLarge", "ProjectileTorchSupayBallEx", "ProjectileTorchBallEos",
				"ProjectileLobCharged", "ProjectileLobOverheat"
			},
			Name = _PLUGIN.guid .. "." .. "CheckSuitComboAttackBuff",
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
			{
				FalseTraitName = "AxeFreeSpinTrait",
				WeaponName = "WeaponAxeSpin",
				WeaponProperty = "RemoveControlOnCharge2",
				ChangeValue = "WeaponDaggerThrow",
			},
			{
				WeaponName = "WeaponAxeSpin",
				WeaponProperty = "AddControlOnFireEnd2",
				ChangeValue = "WeaponDaggerThrow",
			}
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
		PropertyChanges =
		{
			{
				FalseTraitName = "AxeFreeSpinTrait",
				WeaponName = "WeaponAxeSpin",
				WeaponProperty = "RemoveControlOnCharge2",
				ChangeValue = "WeaponStaffBall",
			},
			{
				WeaponName = "WeaponAxeSpin",
				WeaponProperty = "AddControlOnFireEnd2",
				ChangeValue = "WeaponStaffBall",
			}
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
	},

	DaggerTripleAspect_Secondary =
	{
		InheritFrom = {"BaseTrait"},
		Icon = "Hammer_Daggers_42",
		NumHits = 3, -- used only for text
		ReplacementGrannyModels =
		{
			WeaponDaggerA_Mesh = "WeaponDaggerA_Morrigan_Mesh",
			WeaponDaggerB_Mesh = "WeaponDaggerB_Morrigan_Mesh"
		},
		RarityLevels =
		{
			Common =
			{
				Multiplier = 3,
			},
			Rare =
			{
				Multiplier = 4,
			},
			Epic =
			{
				Multiplier = 5,
			},
			Heroic =
			{
				Multiplier = 6,
			},
			Legendary =
			{
				Multiplier = 7,
			},
			Perfect =
			{
				Multiplier = 9,
			},
		},
		WeaponDataOverride =
		{
			WeaponDaggerThrow =
			{
				MinWeaponChargeTime = 0.16,
				ChargeWeaponStages =
				{
					{
						ManaCost = 15,
						WeaponProperties =
						{
							Projectile = "ProjectileDaggerThrowCharged",
							NumProjectiles = 3, 
							AdditionalProjectileWaveChance = 0
						},
						ApplyEffects =
						{
							"WeaponDaggerMorriganThrowEXDisable",
							"WeaponDaggerMorriganThrowEXDisableCancellable",
							"WeaponDaggerMorriganThrowEXDisableMoveHold"
						},
						Wait = 0.45,
						ChannelSlowEventOnEnter = true,
						HideStageReachedFx = true,
					},
				},
				Sounds =
				{
					ChargeSounds =
					{
						{
							Name = "/SFX/Player Sounds/MelMagicalChargeLoop",
							StoppedBy = { "ChargeCancel", "Fired" }
						},
					},
					FireSounds =
					{
						PerfectChargeSounds =
						{
							{ Name = "/SFX/Player Sounds/ZagreusCriticalFire" },
						},
						{ Name = "/SFX/Player Sounds/BowFire" },
						{ Name = "/VO/MelinoeEmotes/MorriganEmoteAttacking2" },
					},
					FireStageSounds =
					{
						{ Name = "/VO/MelinoeEmotes/EmotePowerAttackingStaff" },
						{ Name = "/SFX/Player Sounds/MelDaggerKnifeThrowSwishGROUP" },
					},
					ImpactSounds =
					{
						Invulnerable = "/SFX/Player Sounds/ZagreusShieldRicochet",
						Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
						Bone = "/SFX/ArrowMetalBoneSmash",
						Brick = "/SFX/ArrowMetalStoneClang",
						Stone = "/SFX/ArrowMetalStoneClang",
						Organic = "/SFX/DaggerThrowImpact",
						StoneObstacle = "/SFX/ArrowWallHitClankSmall",
						BrickObstacle = "/SFX/ArrowWallHitClankSmall",
						MetalObstacle = "/SFX/ArrowWallHitClankSmall",
						BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
						Shell = "/SFX/ShellImpact",
					},
				},
			},
		},
		SetupFunction =
		{
			Threaded = true,
			Name = "SetBaseChargeTimes",
			Args = {
				WeaponNames =
				{
					"WeaponDaggerThrow",
				}
			}
		},
		CustomExDefinitions =
		{
			ProjectileDaggerThrow = false,
			ProjectileDaggerThrowMorrigan = true
		},
		OnEnemyDamagedAction = 
		{
			ValidWeapons = game.WeaponSets.HeroAllWeapons,
			FunctionName = "CheckFinisher",
			Args =
			{
				ProjectileName = "WomboStrike",
				DamageMultiplier = { BaseValue = 1 },
				ReportValues = { ReportedMultiplier = "DamageMultiplier" },
				EffectNames = { "ComboSpecialIndicator", "ComboExIndicator", "ComboAttackIndicator" }, -- for packaging
				CompleteObjectivesOnFire = { "WeaponDaggerWombo" },
			}
		},
		PropertyChanges =
		{
			{
				WeaponName = "WeaponDaggerThrow",
				WeaponProperties =
				{
					ChargeTime = 0.3,
					MinChargeToFire = 0.34,
					Cooldown = 1.5,
					ProjectileAngleOffset = 12,
					ChargeStartAnimation = "Melinoe_Dagger_Special_Start_Slow",
					ClipSize = 1,
					ClipRegenInterval = 0.8,
					LockTriggerForMinCharge = true,
				},
				ProjectileProperties =
				{
					MaxAdjustRate = 0,
					ImmunityDuration = 0.20,
					RepeatHitOnReturn = true,
					MultiDetonate = true,
					MultipleUnitCollisions = true,
					ReturnToOwnerAfterInactiveSeconds = 0.6,
					Speed = 900,
					Graphic = "DaggerThrowMorrigan",
					Damage = 20,
				},
			},
			{
				FalseTraitName = "AxeFreeSpinTrait",
				WeaponName = "WeaponAxeSpin",
				WeaponProperty = "RemoveControlOnCharge2",
				ChangeValue = "WeaponDaggerThrow",
			},
			{
				WeaponName = "WeaponAxeSpin",
				WeaponProperty = "AddControlOnFireEnd2",
				ChangeValue = "WeaponDaggerThrow",
			}
		},
		StatLines =
		{
			"ComboDamageStatDisplay",
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "WomboStrike",
				BaseProperty = "Damage",
			},
		},
		FlavorText = "DaggerTripleAspect_FlavorText",
	},

	TorchAutofireAspect_Secondary =
	{
		InheritFrom = {"BaseTrait"},
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
				Multiplier = 2.0,
			},
			Heroic =
			{
				Multiplier = 2.5,
			},
			Legendary =
			{
				Multiplier = 3.0,
			},
			Perfect =
			{
				Multiplier = 4.5,
			},
		},
		Icon = "Hammer_Torch_42",
		ReplacementGrannyModels = 
		{
			WeaponTorchR_Mesh = "WeaponTorchR_Supay_Mesh",
			WeaponTorchL_Mesh = "WeaponTorchL_Supay_Mesh"
		},
		OnExpire = {
			FunctionName = "EndAutofire",
		},
		WeaponDataOverride = 
		{
			WeaponTorchSpecial = 
			{
				ChannelSlowIneligible = false,
				CancelCameraShake = true,
				CancelSlowFrames = true,
				ChargeStageModifiers = 
				{
					ValidWeapons = { "WeaponTorchSpecial"},
					ExcludeLinked = true,
					AddWeaponProperties = 
					{
						FireFx = "TorchOrbitStartSwirl_Supay",
					}
				},
				ChargeWeaponStages = 
				{
					{
						ManaCost = 30,
						Wait = 0.925,
						ChannelSlowEventOnStart = true,
						ForceRelease = true,
						WeaponProperties =
						{
							Projectile = "ProjectileTorchOrbitEx",
							ProjectileAngleStartOffset = math.rad(-90),
							ProjectileAngleOffset = math.rad(60),
							FireGraphic = "Melinoe_Torch_Special1Ex_Fire",
							FireFx = "TorchOrbitStartSwirl_Base",
							AdditionalProjectileWaveChance = 0,
						},
						ProjectileProperties = 
						{
							ArcEnd = -1080,
						},
						CompleteObjective = "WeaponTorchSpecialCharged",
					},
				},
				SkipManaDisableCheck = true,
				IsExWithMapStateVariable = "TorchExSpecial",

				Sounds =
				{
					ChargeSounds =
					{
						{ Name = "/EmptyCue" },
						{
							Name = "/SFX/Player Sounds/MelMagicalCharge",
							StoppedBy = { "ChargeCancel", "Fired" }
						},
					},
					FireSounds =
					{
						{ Name = "/SFX/Player Sounds/MelTorchSpecialPreSpin" },

					},
					FireStageSounds = 
					{
						{ Name = "/VO/MelinoeEmotes/EmoteAttackingBombLob" },
					},
					ImpactSounds =
					{
						Invulnerable = "/SFX/Player Sounds/ZagreusShieldRicochet",
						Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
						Bone = "/SFX/BurnDamageTorches",
						Brick = "/SFX/BurnDamageTorches",
						Stone = "/SFX/BurnDamageTorches",
						Organic = "/SFX/BurnDamageTorches",
						StoneObstacle = "/SFX/BurnDamageTorches",
						BrickObstacle = "/SFX/BurnDamageTorches",
						MetalObstacle = "/SFX/BurnDamageTorches",
						BushObstacle = "/SFX/BurnDamage",
						Shell = "/SFX/ShellImpact",
					},
				},

			},
		},
		PropertyChanges = {
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbit",
				ExcludeLinked = true,
				ProjectileProperties = 
				{
					Damage = 10,
					Speed = 220,
				},
			},
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbitEx",
				ExcludeLinked = true,
				WeaponProperties = 
				{
					ChargeStartAnimation = "Melinoe_Torch_Supay_AttackEx1_FireAlt",
					FireGraphic = "null",
					ChargeCancelGraphic = "Melinoe_Torch_Supay_AttackEx1_End",
					TriggerReleaseGraphic = "null",
					SetTargetAngleOnRequest = false,
				},
				ProjectileProperties = 
				{
					Fuse = 5,
					ReturnToOwnerAfterInactiveSeconds = 4,
					SizeDuration = 0.1,
					MaxSize = 1.4,
					MinRange = 150,
					Range = 300,
					MaxRange = 600,
					ArcEnd = 9000,
					Speed = 440,
					Damage = 15,
				},
			},
			{
				WeaponName = "WeaponTorchSpecial",
				WeaponProperty = "AllowFire",
				ChangeValue = false,
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorchSpecial",
				WeaponProperty = "UseAttackTurbo",
				ChangeValue = false,
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchOrbitIn_Supay",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbit",
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchOrbitOut_Supay",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileProperty = "AmbientSound",
				ChangeValue = "null",
				ChangeType = "Absolute",
			},			
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileNames = { "ProjectileTorchOrbit", "ProjectileTorchOrbitEx", },
				ProjectileProperty = "DissipateFx",
				ChangeValue = "TorchOrbitOut_Supay",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileNames = { "ProjectileTorchOrbit", "ProjectileTorchOrbitEx" },
				ProjectileProperty = "AttachedAnim",
				ChangeValue = "TorchOrbitShadow_Supay",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				ProjectileName = "ProjectileTorchOrbitEx",
				ProjectileProperty = "Graphic",
				ChangeValue = "TorchOrbitInEX_Supay",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponTorchSpecial",
				WeaponProperty = "FireFx",
				ChangeValue = "TorchOrbitStartSwirl_Single_Supay",
				ChangeType = "Absolute",
			},
			{
				FalseTraitName = "AxeFreeSpinTrait",
				WeaponName = "WeaponAxeSpin",
				WeaponProperty = "RemoveControlOnCharge2",
				ChangeValue = "WeaponTorchSpecial",
			},
			{
				WeaponName = "WeaponAxeSpin",
				WeaponProperty = "AddControlOnFireEnd2",
				ChangeValue = "WeaponTorchSpecial",
			}
		},
		SetupFunction =
		{
			Name = "SetupTorchAutofire",
			Args = 
			{
				PrimaryInterval = 0.75,
				BurstCount = 1,
				FlameStagger = 0.75,
				PrimaryExIntervalOverride = 0,	-- If set at above 0, overrides the stagger/interval with this value during EX moves
				PrimaryExIntervalMultiplier = 1.0,
				--PrimaryCastIntervalMultiplier = { BaseValue = 0.9, SourceIsMultiplier = true }, -- Might be worth revisiting
				PrimaryExInterval = 4,
				PrimaryExVfx = "SupayEXStart",
				SpecialRefreshInterval = 0.25,
				SpecialSounds = 
				{
					SpecialSound = "/SFX/Player Sounds/MelTorchSpecialTail",
					SpecialExSound = "/SFX/Player Sounds/MelTorchSpecialOmegaLoop",
					AresSpecialBoon = 
					{
						SpecialSound = "/SFX/Player Sounds/MelTorchSpecialTail",
						SpecialExSound = "/SFX/Player Sounds/MelTorchSpecialOmegaLoop",
					},
					AphroditeSpecialBoon = 
					{
						SpecialSound = "/SFX/Player Sounds/MelTorchSpecialTail",
						SpecialExSound = "/SFX/Player Sounds/MelTorchSpecialOmegaLoop",
					},
					ApolloSpecialBoon = 
					{
						SpecialSound = "/SFX/Player Sounds/MelTorchSpecialTail",
						SpecialExSound = "/SFX/Player Sounds/MelTorchSpecialOmegaLoop",
					},
					DemeterSpecialBoon = 
					{
						SpecialSound = "/SFX/Player Sounds/MelTorchSpecialTail",
						SpecialExSound = "/SFX/Player Sounds/MelTorchSpecialOmegaLoop",
					},
					HephaestusSpecialBoon = 
					{
						SpecialSound = "/SFX/Player Sounds/MelTorchSpecialTail",
						SpecialExSound = "/SFX/Player Sounds/MelTorchSpecialOmegaLoop",
					},
					HestiaSpecialBoon = 
					{
						SpecialSound = "/SFX/Player Sounds/MelTorchSpecialTail",
						SpecialExSound = "/SFX/Player Sounds/MelTorchSpecialOmegaLoop",
					},
					HeraSpecialBoon = 
					{
						SpecialSound = "/SFX/Player Sounds/MelTorchSpecialTail",
						SpecialExSound = "/SFX/Player Sounds/MelTorchSpecialOmegaLoop",
					},
					PoseidonSpecialBoon = 
					{
						SpecialSound = "/SFX/Player Sounds/MelTorchSpecialTail",
						SpecialExSound = "/SFX/Player Sounds/MelTorchSpecialOmegaLoop",
					},
					ZeusSpecialBoon = 
					{
						SpecialSound = "/SFX/Player Sounds/MelTorchSpecialTail",
						SpecialExSound = "/SFX/Player Sounds/MelTorchSpecialOmegaLoop",
					},
				},
				ReportValues = 
				{ 
					--ReportedSpeed = "PrimaryCastIntervalMultiplier",
					ReportedDuration = "PrimaryExInterval",
				}
			},
		},
		OnProjectileDeathFunction = 
		{
			Name = "UpdateProjectileLedger",
			ValidProjectiles = {"ProjectileTorchBall", "ProjectileTorchSupayBallEx", "ProjectileTorchOrbit", "ProjectileTorchOrbitEx", "ProjectileCast"},
		},
		AddOutgoingDamageModifiers =
		{
			ValidProjectiles = game.WeaponSets.SprintProjectileNames,
			ValidWeaponMultiplier =
			{
				BaseValue = 1.10,
				SourceIsMultiplier = true,
			},
			ReportValues = { ReportedMultiplier = "ValidWeaponMultiplier"},
		},
		StatLines =
		{
			"RaiseDeadStatLine1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "SprintDamageBonus",
				Format = "PercentDelta",
			},
			{
				Key = "ReportedDuration",
				ExtractAs = "TooltipAutofireDuration",
				SkipAutoExtract = true,
			},
		},
		FlavorText = "TorchAutofireAspect_FlavorText",
	},

	StaffRaiseDeadAspect_Secondary =
	{
		InheritFrom = {"BaseTrait"},
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
			},
		},
		Icon = "Hammer_Staff_42",
		ReplacementGrannyModels =
		{
			WeaponStaff_Mesh = "WeaponStaff_Anubis_Mesh"
		},
		AddOutgoingDamageModifiers =
		{
			ValidWeapons = game.WeaponSets.HeroAllWeapons,
			ExMultiplier = { BaseValue = 1.1, SourceIsMultiplier = true},
			ReportValues = 
			{
				ReportedDamage = "ExMultiplier",
			}
		},
		WeaponSpeedMultiplier =
		{
			WeaponNames = game.WeaponSets.HeroAllWeaponsAndSprint,
			Value =
			{
				BaseValue = 0.9,
				SourceIsMultiplier = true,
			},
			ReportValues = { ReportedWeaponMultiplier = "Value" }
		},
		SetupFunction =
		{
			Threaded = true,
			Name = "SetupAnubisAnimationSwaps",
		},
		OnExpire =
		{
			FunctionName = "EndAnubisAnimationSwaps"
		},
		WeaponDataOverride =
		{
			WeaponStaffBall =
			{
				FireScreenshake = { },
				HitScreenshake = { Distance = 6, Speed = 300, FalloffSpeed = 0, Duration = 0.34, Angle = 90, DistanceThreshold = 200 },
				RumbleDistanceThreshold = 480,
				HitRumbleParameters =
				{
					{ ScreenPreWait = 0.02, LeftFraction = 0.125, Duration = 0.15 },
				},

				CompleteObjectivesOnNonStagedFire = { "WeaponStaffBall_Anubis" },
				
				ExParameters = 
				{
					HitScreenshake = { Distance = 6, Speed = 1000, Duration = 0.35, FalloffSpeed = 3000 },
					HitRumbleParameters =
					{
						RumbleDistanceThreshold = 480,
						{ ScreenPreWait = 0.06, Fraction = 0.21, Duration = 0.21 },
					},
				},
				ChargeWeaponStages = 
				{
					{ 
						ManaCost = 10, 
						Wait = 0.85,
						WeaponProperties =
						{
							Projectile = "ProjectileStaffBallCharged",
							AdditionalProjectileWaveChance = 0,
							Cooldown = 0.31,
							ClipRegenInterval = 0,
							FireGraphic = "Melinoe_Staff_SpecialEx1_Fire",
							SelfVelocity = 0,
						},
						ProjectileProperties =
						{
							DamageRadius = 435,
							Damage = 110,
						},
						ApplyEffects = { "Special1DisableMoveHold", },
						FxOnStart = "StaffBoltCharge", 
						ChannelSlowEventOnStart = true,

					},
				},
				Sounds =
				{
					ChargeSounds =
					{
						-- { Name = "/VO/MelinoeEmotes/EmoteCharging" },
						{
							Name = "/SFX/Player Sounds/MelMagicalChargeLoop",
							StoppedBy = { "ChargeCancel", "Fired" }
						},
					},
					ChargeStageSounds =
					{
						{ Name = "/VO/MelinoeEmotes/EmoteCharging",
							StoppedBy = { "ChargeCancel", "Fired", "ChargeStage" }
						},
						{
							Name = "/SFX/Player Sounds/ZagreusWeaponChargeup",
							StoppedBy = { "ChargeCancel", "Fired", }
						}
					},
					FireSounds =
					{
						PerfectChargeSounds =
						{
							{ Name = "/Leftovers/SFX/AuraPerfectThrow" },
						},
						{ Name = "/VO/MelinoeEmotes/EmoteLaunchingSuit" },
					},
					FireStageSounds = 
					{
						{ Name = "/VO/MelinoeEmotes/AnubisEmoteSpecial" },
						{ Name = "/Leftovers/SFX/AuraThrowSmall" },
					},
					-- ImpactSounds handled in ProjectileData
				},

			},
		},
		ManaCostModifiers =
		{
			WeaponNames = game.WeaponSets.HeroSecondaryWeapons,
			ExWeapons = true,
			ManaCostAdd = 20,
		},
		PropertyChanges =
		{
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBallCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffBallProjectileCharged_Anubis",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBall",
				ProjectileProperty = "Graphic",
				ChangeValue = "StaffBallProjectileIn_Anubis",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBallCharged",
				ProjectileProperty = "StartFx",
				ChangeValue = "StaffProjectileFireFx3_Anubis",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBallCharged",
				ProjectileProperty = "DetonateFx",
				ChangeValue = "RadialNovaPentagramCharged_Anubis",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponStaffBall",
				ExcludeLinked = true,
				WeaponProperties =
				{
					ChargeStartAnimation = "Melinoe_Staff_Anubis_Special1_Start",
					FireGraphic = "Melinoe_Staff_Anubis_Special1_Fire",
					ChargeCancelGraphic = "Melinoe_Staff_Anubis_Special1_End",
					SelfVelocity = 0,
					Cooldown = 0.33,
					ChargeTime = 0.1,
					ClipRegenInterval = 0.32,
				},
			},
			{
				WeaponName = "WeaponStaffBall",
				ExcludeLinked = true,
				ProjectileName = "ProjectileStaffBall",
				ProjectileProperties = 
				{
					UnlimitedUnitPenetration = false,
					Damage = 20,
				}
			},
			{
				WeaponName = "WeaponStaffBall",
				ExcludeLinked = true,
				EffectName = "Special1Disable",
				EffectProperty = "Duration",
				ChangeValue = 7/60,
			},
			{
				WeaponName = "WeaponStaffBall",
				ExcludeLinked = true,
				EffectName = "Special1DisableCancellable",
				EffectProperty = "Duration",
				ChangeValue = 12/60,
			},
			{
				WeaponName = "WeaponStaffBall",
				ExcludeLinked = true,
				EffectName = "Special1DisableMoveHold",
				EffectProperty = "Duration",
				ChangeValue = 23/60,
			},
			{
				WeaponName = "WeaponStaffBall",
				EffectName = "Special1AspectTriggerLock",
				EffectProperty = "Active",
				ChangeValue = true,
				ExcludeLinked = true,
			},
			{
				WeaponName = "WeaponStaffBall",
				ProjectileName = "ProjectileStaffBall",
				EffectName = "StaffAspectStun",
				EffectProperty = "Active",
				ChangeValue = true,
				ExcludeLinked = true,
			},
			{
				FalseTraitName = "AxeFreeSpinTrait",
				WeaponName = "WeaponAxeSpin",
				WeaponProperty = "RemoveControlOnCharge2",
				ChangeValue = "WeaponStaffBall",
			},
			{
				WeaponName = "WeaponAxeSpin",
				WeaponProperty = "AddControlOnFireEnd2",
				ChangeValue = "WeaponStaffBall",
			}
		},
		OnEnemyDamagedAction =
		{
			ValidWeapons = {"WeaponStaffBall",},
			FirstHitOnly = true,
			FunctionName = "CheckStaffProjectilePull",
			Args =
			{
				Radius = 500,
				RadiusEx = 900,
				ScaleY = 0.55,
				PlayerDistance = 400,
				PlayerDistanceEx = 550,
				DeadZoneRadius = 10,			-- Radius within which the pull has no effect
				DistanceMultiplier = 1.7,		-- How strong the pull is relative to distance
				PullVfx = "AnubisVacuumFxFront_Base",
				ExPullVfx = "AnubisExVacuumFxFront_Base",
				TraitPullVfxOverride  =
				{
					AphroditeSpecialBoon = 
					{
						PullVfx = "AnubisVacuumFxFront_Aphrodite",
						ExPullVfx = "AnubisExVacuumFxFront_Aphrodite",	
					},
					ApolloSpecialBoon = 
					{
						PullVfx = "AnubisVacuumFxFront_Apollo",
						ExPullVfx = "AnubisExVacuumFxFront_Apollo",	
					},
					DemeterSpecialBoon = {

						PullVfx = "AnubisVacuumFxFront_Demeter",
						ExPullVfx = "AnubisExVacuumFxFront_Demeter",	
					} ,
					HephaestusSpecialBoon = 
					{
						PullVfx = "AnubisVacuumFxFront_Hephaestus",
						ExPullVfx = "AnubisExVacuumFxFront_Hephaestus",	
					},
					HestiaSpecialBoon = 
					{
						PullVfx = "AnubisVacuumFxFront_Hestia",
						ExPullVfx = "AnubisExVacuumFxFront_Hestia",	
					},
					HeraSpecialBoon = 
					{
						PullVfx = "AnubisVacuumFxFront_Hera",
						ExPullVfx = "AnubisExVacuumFxFront_Hera",	
					},
					PoseidonSpecialBoon = 
					{
						PullVfx = "AnubisVacuumFxFront_Poseidon",
						ExPullVfx = "AnubisExVacuumFxFront_Poseidon",
					},
					ZeusSpecialBoon = 
					{
						PullVfx = "AnubisVacuumFxFront_Zeus",
						ExPullVfx = "AnubisExVacuumFxFront_Zeus",	
					},
					AresSpecialBoon = 
					{
						PullVfx = "AnubisVacuumFxFront_Ares",
						ExPullVfx = "AnubisExVacuumFxFront_Ares",	
					},
				},
			}
		},
		EncounterEndFunctionName = "EndEncounterShadeDissipate",
		EncounterEndFunctionArgs =
		{
			Name = "ShadeMercAspect",
			SmileChance = 0.05,
		},
		OnEnemyDeathFunction =
		{
			Name = "CreateShadeMerc",
			FunctionArgs =
			{
				MaxCount = 8,
				Chance = 1.0,
				Name = "ShadeMercAspect",
				AngleMin = 190,
				AngleMax = 350,
			}
		},
		OnProjectileDeathFunction =
		{
			Name = "CleanupShadeMerc",
			ValidProjectiles = {"ShadeMercAspectSpiritball"},
		},
		StatLines =
		{
			"RaiseDeadOmegaBuffStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedDamage",
				ExtractAs = "TooltipSpeed",
				Format = "PercentDelta",
			},
		},
		FlavorText = "StaffRaiseDeadAspect_FlavorText",
	},

	AxePerfectCriticalAspect_Secondary =
	{
		InheritFrom = {"BaseTrait"},
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1.0,
			},
			Rare =
			{
				Multiplier = 1.25,
			},
			Epic =
			{
				Multiplier = 1.5,
			},
			Heroic =
			{
				Multiplier = 1.75,
			},
			Legendary =
			{
				Multiplier = 2.0,
			},
			Perfect =
			{
				Multiplier = 2.75,
			},
		},
		Icon = "Hammer_Axe_42",
		ReplacementGrannyModels =
		{
			Melinoe_Axe_Mesh1 = "Melinoe_Axe_Thanatos_Mesh"
		},
		AddOutgoingCritModifiers =
		{
			ValidWeapons = game.WeaponSets.HeroAllWeapons,
			IsEx = true,
			HeroTraitValue = "PerfectCritChance",
		},
		PerfectCritChance = 0,
		SetupFunction =
		{
			Threaded = true,
			Name = "SetupPerfectCritUI",
		},
		OnExpire =
		{
			FunctionName = _PLUGIN.guid .. "." .. "StopThanatosMaxMortalityFx",
		},
		OnEnemyDamagedAction =
		{
			ValidWeapons = game.WeaponSets.HeroAllWeapons,
			FunctionName = _PLUGIN.guid .. "." .. "CheckPerfectAxeCrit",
			Args =
			{
				Increment = 0.02,
				MaxCrit = 0.20,
				FirstHitOnly = true,
				MultihitProjectileWhitelist =
				{
					"ProjectileStaffSingle",
				},
				MultihitProjectileConditions =
				{
					ProjectileStaffSingle = { Cooldown = 0.5 },
				},
				ReportValues =
				{
					ReportedIncrement = "Increment",
					ReportedMaxCrit = "MaxCrit",
				}
			}
		},
		OnSelfDamagedFunction =
		{
			Name = "ResetPerfectAxeCrit",
			NotDamagingRetaliate = true,
		},
		PropertyChanges =
		{
			{
				WeaponNames = game.WeaponSets.HeroPrimaryWeapons,
				BaseValue = 0.8,
				SourceIsMultiplier = true,
				SpeedPropertyChanges = true,
				ReportValues = { ReportedSpeed = "ChangeValue" }
			},
		},
		StatLines =
		{
			"AttackSpeedStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedIncrement",
				ExtractAs = "TooltipIncrement",
				Format = "Percent",
				DecimalPlaces = 1,
				SkipAutoExtract = true
			},
			{
				Key = "ReportedMaxCrit",
				ExtractAs = "TooltipMax",
				Format = "LuckModifiedPercent",
				SkipAutoExtract = true
			},
			{
				Key = "ReportedSpeed",
				ExtractAs = "TooltipSpeedIncrease",
				Format = "NegativePercentDelta",
			},
		},
		FlavorText = "AxePerfectCriticalAspect_FlavorText",
	},

	SuitMarkCritAspect_Secondary =
	{
		InheritFrom = { "BaseTrait" },
		PreEquipWeapons = { "WeaponSprintEx" },
		Icon = "Hammer_Suit_03",
		ReplacementGrannyModels =
		{
			WeaponSuitR_Base_Mesh = "WeaponSuitR_Nyx_Mesh",
			WeaponSuitL_Base_Mesh = "WeaponSuitL_Nyx_Mesh",
			WeaponSuitB_Base_Mesh = "WeaponSuitB_Nyx_Mesh",
		},
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1,
			},
			Rare =
			{
				Multiplier = 2,
			},
			Epic =
			{
				Multiplier = 3,
			},
			Heroic =
			{
				Multiplier = 4,
			},
			Legendary =
			{
				Multiplier = 5,
			},
			Perfect =
			{
				Multiplier = 7,
			},

		},
		WeaponDataOverride =
		{
			WeaponSprint =
			{
				SkipManaIndicatorIfOutOfMana = true,
				OnChargeFunctionNames = { "DoWeaponCharge", },
				ChargeWeaponData =
				{
					OnStageReachedFunctionName = "SprintChargeStage",
					EmptyChargeFunctionName = "EmptySprintCharge",
				},
				ShowManaIndicator = true,
				ChargeWeaponStages =
				{
					{
						ManaCost = 30,
						SkipManaSpendOnFire = true,
						Wait = 1.0,
						WeaponName = "WeaponSprintEx",
						EffectName = "NyxBlastReady",
						ReportValues =
						{
							ReportedChargeDuration = "Wait",
							ReportedCost = "ManaCost",
						},
					},
				},
			},
		},
		PropertyChanges =
		{
			{
				FalseTraitName = "AxeFreeSpinTrait",
				WeaponName = "WeaponAxeSpin",
				WeaponProperty = "RemoveControlOnCharge2",
				ChangeValue = "WeaponSuitRanged",
			},
			{
				WeaponName = "WeaponAxeSpin",
				WeaponProperty = "AddControlOnFireEnd2",
				ChangeValue = "WeaponSuitRanged",
			}
		},
		OnWeaponFiredFunctions =
		{
			ValidWeapons = { "WeaponSprint"},
			FunctionName = "CheckSprintCollision",
			FunctionArgs =
			{
				Range = 165,
			}
		},
		SprintStrikeDamageMultiplier = 1,
		OnProjectileDeathFunction =
		{
			Name = "CheckProjectileSpawn",
			ValidProjectiles = {
				"ProjectileSuitRangedGuided",
				"ProjectileStaffSwing1",
				"ProjectileStaffSwing2",
				"ProjectileStaffSwing3",
				"ProjectileStaffDash",
				-- "ProjectileDagger",
				-- "ProjectileDaggerSliceRight",
				-- "ProjectileDaggerSliceLeft",
				-- "ProjectileDaggerSliceDouble",
				"ProjectileTorchBall",
				"ProjectileTorchGhost",
				"ProjectileLobBullet",
				"ProjectileLob",
				"ProjectileSuit",
				"ProjectileSuit2",
				"ProjectileSuitDouble",
			},
			Args =
			{
				UseOriginalProjectileForPropertyChanges = true,
				IgnoreImpactId = true,
				MatchProjectileName = true,
				SpawnCount = 2,
				SpawnArc = 60,
				Alpha = 0.6,
				RetargetChance = 0,	-- Chance split missiles can hit the same target
				ProjectileOffsets =
				{
					ProjectileSuit = 200,
					ProjectileSuit2 = 250,
					ProjectileSuitDouble = 200,
					--ProjectileSuitCharged = 300,
					ProjectileStaffSwing1 = 120,
					ProjectileStaffSwing2 = 120,
					ProjectileStaffSwing3 = 120,
					-- ProjectileDagger = 150,
					-- ProjectileDaggerSliceRight = 150,
					-- ProjectileDaggerSliceLeft = 150,
					-- ProjectileDaggerSliceDouble = 150,
					ProjectileDaggerThrow = 30,
				},
				ProjectileVfx =
				{
					ProjectileSuitRangedGuided = "NyxMissileSpawner",
					ProjectileLobBullet = "NyxMissileSpawner",
					ProjectileLob = "NyxMissileSpawner",
					ProjectileStaffSwing1 = "NyxMissileSpawner",
					ProjectileStaffSwing2 = "NyxMissileSpawner",
					ProjectileStaffSwing3 = "NyxMissileSpawner",
					--ProjectileSuitRangedCharged = "NyxMissileSpawner",
				},
				ProjectileNameMapIgnores = 
				{
					ProjectileLob = "LobCloseAttackAspect",
				},
				ProjectileNameMap =
				{
					ProjectileSuitRangedGuided = "ProjectileSuitRangedGuidedSplit",
					--ProjectileSuitRangedCharged = "ProjectileSuitRangedChargedSplit",
					ProjectileSuit = "ProjectileSuitSplit",
					ProjectileSuit2 = "ProjectileSuitSplit2",
					ProjectileSuitDouble = "ProjectileSuitDouble",
					--ProjectileSuitCharged = "ProjectileSuitChargedSplit",
					ProjectileStaffSwing1 = "ProjectileStaffSwing1",
					ProjectileStaffSwing2 = "ProjectileStaffSwing2",
					ProjectileStaffSwing3 = "ProjectileStaffSwing3",
					-- ProjectileDagger = "ProjectileDagger",
					-- ProjectileDaggerSliceRight = "ProjectileDaggerSliceRight",
					-- ProjectileDaggerSliceLeft = "ProjectileDaggerSliceLeft",
					-- ProjectileDaggerSliceDouble = "ProjectileDaggerSliceDouble",
					ProjectileTorchBall = "ProjectileTorchBallSplit",
					ProjectileTorchGhost = "ProjectileTorchGhostSplit",
					ProjectileLobBullet = "ProjectileLobBullet",
					ProjectileLob = "ProjectileLob",
				},
				DamageMultiplier = { BaseValue = 0.15 },
				ReportValues =
				{
					ReportedCount = "SpawnCount",
					ReportedMultiplier = "DamageMultiplier"
				}
			}
		},
		OnEnemyDamagedAction =
		{
			FunctionName = "SplitSelfBuff",
			ValidProjectiles = { "NyxSprintBlast" },
			Args =
			{
				EffectName = "NyxHitBuff",
				Duration = 5,
				ReportValues =
				{
					ReportedDuration = "Duration",
				}
			},
		},
		OnProjectileCreationFunction =
		{
			ValidProjectiles = {
				"ProjectileSuitRangedUnguided",
				"ProjectileSuit",
				"ProjectileSuit2",
				"ProjectileSuitDouble",
				"ProjectileStaffSwing1",
				"ProjectileStaffSwing2",
				"ProjectileStaffSwing3",
				"ProjectileStaffDash",
				"ProjectileDagger",
				"ProjectileDaggerSliceRight",
				"ProjectileDaggerSliceLeft",
				"ProjectileDaggerSliceDouble",
				"ProjectileTorchBall",
				"ProjectileTorchGhost",
				"ProjectileLobBullet",
				"ProjectileLob",
			},
			Name = "CheckSplitValidity",
			Args =
			{
				RequiredEffect = "NyxHitBuff",
			},
		},
		SetupFunction =
		{
			Threaded = true,
			Name = "SetupSuitUI",
		},
		StatLines =
		{
			"SplitDamageStatDisplay",
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "SplitDamage",
				Format = "Percent",
				HideSigns = true,
			},
			{
				Key = "ReportedCount",
				ExtractAs = "AspectSplitCount",
				SkipAutoExtract = true,
			},
			{
				Key = "ReportedChargeDuration",
				ExtractAs = "ChargeDuration",
				SkipAutoExtract = true,
			},
			{
				Key = "ReportedCost",
				ExtractAs = "ManaCost",
				SkipAutoExtract = true,
			},
			{
				Key = "ReportedDuration",
				ExtractAs = "Duration",
				SkipAutoExtract = true,
			},
			{
				Key = "SprintStrikeDamageMultiplier",
				ExtractAs = "Damage",
				Format = "MultiplyByBase",
				BaseType = "Projectile",
				BaseName = "NyxSprintBlast",
				BaseProperty = "Damage",
				SkipAutoExtract = true,
			},
		},
		FlavorText = "SuitMarkCritAspect_FlavorText",
	},

	SuitHexAspect_Secondary =
	{
		InheritFrom = { "BaseTrait" },
		Icon = "Hammer_Suit_02",
		ReplacementGrannyModels =
		{
			WeaponSuitR_Base_Mesh = "WeaponSuitR_Selene_Mesh",
			WeaponSuitL_Base_Mesh = "WeaponSuitL_Selene_Mesh",
			WeaponSuitB_Base_Mesh = "WeaponSuitB_Selene_Mesh",
		},
		RarityLevels =
		{
			Common =
			{
				Multiplier = 0,
			},
			Rare =
			{
				Multiplier = 1,
			},
			Epic =
			{
				Multiplier = 2,
			},
			Heroic =
			{
				Multiplier = 3,
			},
			Legendary =
			{
				Multiplier = 4,
			},
			Perfect =
			{
				Multiplier = 6,
			},
		},
		LinkedSpell = "MoonBeam",
		StatLines =
		{
			"SuitSpellCostStatLine",
		},
		TalentPointCount = 2,	-- First Selene drop will give 1, so this boosts it to 3 on first pick-up baseline
		ManaSpendCostModifiers =
		{
			Add = { BaseValue = -10 },
			ReportValues = { ReportedManaCost = "Add" }
		},
		PropertyChanges =
		{
			{
				FalseTraitName = "AxeFreeSpinTrait",
				WeaponName = "WeaponAxeSpin",
				WeaponProperty = "RemoveControlOnCharge2",
				ChangeValue = "WeaponSuitRanged",
			},
			{
				WeaponName = "WeaponAxeSpin",
				WeaponProperty = "AddControlOnFireEnd2",
				ChangeValue = "WeaponSuitRanged",
			}
		},
		ExtractValues =
		{
			{
				Format = "AdjustedBaseManaSpendCost",
				WeaponName = "WeaponSpellMoonBeam",
				ExtractAs = "ManaCost",
				Key = "ReportedManaCost",
			},
			{
				External = true,
				BaseType = "WeaponData",
				BaseProperty = "FiredFunctionArgs",
				BaseName = "WeaponSpellMoonBeam",
				FiredFunctionArg = "Count",
				ExtractAs = "MoonBeamCount",
				SkipAutoExtract = true,
			},
			{
				External = true,
				BaseType = "ProjectileBase",
				BaseName = "ProjectileMoonBeam",
				BaseProperty = "Damage",
				ExtractAs = "MoonBeamDamage",
				SkipAutoExtract = true,
			},
			{
				External = true,
				BaseType = "EffectData",
				BaseName = "MoonBeamVulnerability",
				BaseProperty = "Modifier",
				Format = "PercentDelta",
				ExtractAs = "MoonBeamVulnerability",
				SkipAutoExtract = true,
			},
			{
				External = true,
				BaseType = "EffectData",
				BaseName = "MoonBeamVulnerability",
				BaseProperty = "Duration",
				ExtractAs = "MoonBeamDuration",
				SkipAutoExtract = true,
			},
		},
		FlavorText = "SuitHexAspect_FlavorText",
	},

	DaggerBlockAspect_Secondary =
	{
		InheritFrom = { "BaseTrait" },
		Icon = "Hammer_Daggers_39",
		ReplacementGrannyModels = 
		{
			WeaponDaggerA_Mesh = "WeaponDaggerA_Artemis_Mesh",
			WeaponDaggerB_Mesh = "WeaponDaggerB_Artemis_Mesh"
		},
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1
			},
			Rare =
			{
				Multiplier = 1.3
			},
			Epic =
			{
				Multiplier = 1.7
			},
			Heroic =
			{
				Multiplier = 2
			},
			Legendary =
			{
				Multiplier = 2.666
			},
			Perfect =
			{
				Multiplier = 3.3333,
			},
		},
		AddOutgoingCritModifiers =
		{
			ValidVolleyChance = 0.5,
			ReportValues = { ReportedChance = "ValidVolleyChance"},
		},
		SetupFunction =
		{
			Threaded = true,
			Name = "DaggerBlockSetup",
		},
		OnProjectileDeathFunction =
		{
			Name = "RemoveCritVolley",
		},
		OnWeaponChargeFunctions =
		{
			ValidWeapons = {"WeaponStaffSwing5", "WeaponAxeSpin", "WeaponTorch", "WeaponSuitCharged", "WeaponLob"},
			FunctionName = "CheckDaggerBlock",
			FunctionArgs =
			{
				Cooldown = 10,
				CritCount = 9,
				InvulnerableEffectName = "DaggerBlockInvincibubble",
				InvulnerableDuration = 1,
				Vfx = "ArtemisParryShield",
				BackVfx = "ArtemisParryShieldBack",
				ActivatedVfx = "DaggerBlockActiveFx",
				ReportValues =
				{
					ReportedCooldown = "Cooldown",
					ReportedHits = "CritCount",
					ReportedDuration = "InvulnerableDuration",
					ReportedSpeedIncrease = "ExAttackSpeed",
				},
			}
		},
		OnWeaponFiredFunctions =
		{
			ValidWeapons = artemisValidWeapons,
			FunctionName = "CheckDaggerCritCharges",
		},
		OnProjectileCreationFunction =
		{
			ValidProjectiles = {"ProjectileAxeSpin", "ProjectileTorchBall", "ProjectileTorchSupayBallEx", "ProjectileStaffWall", "ProjectileStaffSingle"},
			Name = _PLUGIN.guid .. "." .. "CheckDaggerCritChargesProjectile"
		},
		OnEnemyDamagedAction =
		{
			ValidProjectiles = {"ProjectileAxeSpin", "ProjectileStaffWall", "ProjectileStaffSingle"},
			FunctionName = _PLUGIN.guid .. "." .. "CheckMultihitProjectileDaggerCrit",
		},
		WeaponSpeedMultiplier =
		{
			WeaponNames = {"WeaponStaffSwing5", "WeaponAxeSpin", "WeaponTorch", "WeaponSuitCharged", "WeaponLob"},
			Value =
			{
				BaseValue = 0.85,
				SourceIsMultiplier = true,
			},
			ReportValues = { ReportedSpeedIncrease = "Value" }
		},
		PropertyChanges =
		{
			{
				WeaponNames = {"WeaponStaffSwing5", "WeaponAxeSpin", "WeaponSuitCharged", "WeaponLobChargedPulse"},
				BaseValue = 0.85,
				SourceIsMultiplier = true,
				SpeedPropertyChanges = true,
			},
			{
				FalseTraitName = "AxeFreeSpinTrait",
				WeaponName = "WeaponAxeSpin",
				WeaponProperty = "RemoveControlOnCharge2",
				ChangeValue = "WeaponDaggerThrow",
			},
			{
				WeaponName = "WeaponAxeSpin",
				WeaponProperty = "AddControlOnFireEnd2",
				ChangeValue = "WeaponDaggerThrow",
			}
		},
		StatLines =
		{
			"EXAttackSpeedStatDisplay",
		},
		ExtractValues =
		{
			{
				Key = "ReportedSpeedIncrease",
				ExtractAs = "SpeedIncrease",
				Format = "NegativePercentDelta"
			},
			{
				Key = "ReportedCooldown",
				ExtractAs = "Cooldown",
				SkipAutoExtract = true,
			},
			{
				Key = "ReportedHits",
				ExtractAs = "Duration",
				SkipAutoExtract = true,
			},
			{
				Key = "ReportedDuration",
				ExtractAs = "InvulnerableDuration",
				SkipAutoExtract = true,
			},
			{
				Key = "ReportedChance",
				ExtractAs = "CritChance",
				SkipAutoExtract = true,
				Format = "LuckModifiedPercent",
			},
		},
		FlavorText = "DaggerBlockAspect_FlavorText",
	},

	LobImpulseAspect_Secondary =
	{
		InheritFrom = {"BaseTrait"},
		PreEquipWeapons = {"WeaponSkullImpulse"},
		Icon = "Hammer_Lob_15",
		ReplacementGrannyModels = 
		{
			WeaponLob_Mesh = "WeaponLob_Persephone_Mesh"
		},
		Charge = 0,
		PropertyChanges = {
			{
				WeaponName = "WeaponLobSpecial",
				ProjectileName = "ProjectileThrowCharged",
				ProjectileProperty = "Graphic",
				ChangeValue = "LobSpecialFx_Persephone",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponLobSpecial",
				ProjectileName = "ProjectileThrowBlink",
				ProjectileProperty = "Graphic",
				ChangeValue = "DashLobTrailEmitter_Persephone",
				ChangeType = "Absolute",
			},
			{
				WeaponName = "WeaponSkullImpulse",
				ProjectileName = "ProjectileSkullImpulse",
				ProjectileProperty = "Graphic",
				ChangeValue = "DashLobTrailEmitter_Persephone",
				ChangeType = "Absolute",
			},
			{
				FalseTraitName = "AxeFreeSpinTrait",
				WeaponName = "WeaponAxeSpin",
				WeaponProperty = "RemoveControlOnCharge2",
				ChangeValue = "WeaponLobSpecial",
			},
			{
				WeaponName = "WeaponAxeSpin",
				WeaponProperty = "AddControlOnFireEnd2",
				ChangeValue = "WeaponLobSpecial",
			}
		},
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
				Multiplier = 5/2,
			},
			Legendary =
			{
				Multiplier = 6/2,
			},
			Perfect =
			{
				Multiplier = 9/2,
			},
		},
		SetupFunction =
		{
			Threaded = true,
			Name = "SetupSkullImpulseUI",
		},
		OnWeaponFiredFunctions = 
		{
			ValidWeapons = {"WeaponLobSpecial", "WeaponSkullImpulse"},
			FunctionName = "SkullImpulseTransform",
			FunctionArgs = 
			{
				BaseDuration = 0.5,			-- Duration of ex attack w/ no charge
				Interval = 200,
			}
		},
		MaxBonusBoonRankWeighted =
		{
			BaseValue = 2,
		},
		MaxBonusBoonRankDistribution =
		{
			[2] =
			{
				-- Weighted list, so all values should add up to 1 for best distribution
				-- Don't add entries for 1 because that's the same as 0 boon and causes 'level 1' to show up on boon menus
				[0] = 0.70,
				[2] = 0.30,
			},
			[3] =
			{
				[0] = 0.65,
				[2] = 0.30,
				[3] = 0.05,
			},
			[4] =
			{
				[0] = 0.60,
				[2] = 0.25,
				[3] = 0.10,
				[4] = 0.05,
			},
			[5] =
			{
				[0] = 0.55,
				[2] = 0.20,
				[3] = 0.15,
				[4] = 0.10,
				[5] = 0.05,
			},
			[6] =
			{
				[0] = 0.50,
				[2] = 0.16,
				[3] = 0.14,
				[4] = 0.12,
				[5] = 0.06,
				[6] = 0.02,
			},
			[9] =
			{
				[0] = 0.28,
				[2] = 0.16,
				[3] = 0.14,
				[4] = 0.12,
				[5] = 0.10,
				[6] = 0.08,
				[7] = 0.06,
				[8] = 0.04,
				[9] = 0.02,
			}
		},
		OnEnemyDamagedAction = 
		{
			AllEffectsTrigger = true,
			FunctionName = "ChargeSkullImpulse",
			Args = 
			{
				-- One "charge" is equal to full one second of skull car
				-- 0.001 means 100 damage = 0.1 seconds of skull car charge
				ValidProjectiles = game.WeaponSets.OlympianProjectileNames,
				ValidEffectNames = game.WeaponSets.OlympianEffectNames,
				ChargePerDamage = 0.00100,
				MaxCharge = 2,
				MinChargeToFire = 0.5,
				ReportValues =
				{
					ReportedMinChargeToFire = "MinChargeToFire",
					ReportedMaxCharge = "MaxCharge",
				}
			}
		},
		StatLines =
		{
			"ExDamageStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "MaxBonusBoonRankWeighted",
				ExtractAs = "BoonRank",
				IncludeSigns = true,
			},
			{
				Key = "ReportedMaxCharge",
				ExtractAs = "Duration",
				SkipAutoExtract = true,
			},
			{
				Key = "ReportedMinChargeToFire",
				ExtractAs = "MinCharge",
				SkipAutoExtract = true,
			},
		},
		FlavorText = "LobImpulseAspect_FlavorText",
	},

	StaffSelfHitAspect_Secondary =
	{
		InheritFrom = {"BaseTrait"},
		RarityLevels =
		{
			Common =
			{
				Multiplier = 1,
			},
			Rare =
			{
				Multiplier = 3.5/4,
			},
			Epic =
			{
				Multiplier = 3.0/4,
			},
			Heroic =
			{
				Multiplier = 2.5/4,
			},
			Legendary =
			{
				Multiplier = 2.0/4,
			},
			Perfect =
			{
				Multiplier = 1.0/4,
			},
		},
		Icon = "Hammer_Staff_41",
		ReplacementGrannyModels =
		{
			WeaponStaff_Mesh = "WeaponStaff_Asclepius_Mesh"
		},
		PropertyChanges =
		{
			{
				WeaponNames = { "WeaponStaffSwing5"},
				ExcludeLinked = true,
				WeaponProperties = 
				{
					NumProjectileWaves = 3,
				},
			},
			{
				WeaponName = "WeaponStaffSwing5",
				WeaponProperty = "ProjectileWaveInterval",
				ChangeValue = 10,	--Handled via StartPrimaryRepeatThread
			},
			{
				FalseTraitName = "AxeFreeSpinTrait",
				WeaponName = "WeaponAxeSpin",
				WeaponProperty = "RemoveControlOnCharge2",
				ChangeValue = "WeaponStaffBall",
			},
			{
				WeaponName = "WeaponAxeSpin",
				WeaponProperty = "AddControlOnFireEnd2",
				ChangeValue = "WeaponStaffBall",
			}
		},
		OnWeaponFiredFunctions =
		{
			ValidWeapons = game.WeaponSets.HeroAllWeapons,
			FunctionName = "DropOriginMarker",
			FunctionArgs =
			{
				AnimationName = "MomusCastPointSpawn",
				AttackAnimationName = "MomusCastPointAttack",
				PreAttackDuration = 0.25,
				ExpiringAnimationName = "MomusCastPointOut",
				DestroyDelay = 0.5,
				Repeats = 3,
				Interval = { BaseValue = 4.0 },
				ReportValues = { ReportedStrikeCount = "Repeats"},
			},
		},
		OnProjectileDeathFunction =
		{
			Name = "ClearOriginMarker",
			Args =
			{
				AttackAnimationName = "MomusCastPointAttack",
				PreAttackDuration = 0.25,
				ExpiringAnimationName = "MomusCastPointOut",
				DestroyDelay = 0.5,
				CastRepeats = 3,
				Interval = { BaseValue = 4 },
				ReportValues = { ReportedPulseInterval = "Interval"},
			},
		},
		OnExpire =
		{
			FunctionName = "ClearAllOriginMarkers"
		},
		StatLines =
		{
			"PulseIntervalStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedPulseInterval",
				ExtractAs = "PulseInterval",
				DecimalPlaces = 1,
			},
			{
				Key = "ReportedStrikeCount",
				ExtractAs = "StrikeCount",
				SkipAutoExtract = true
			}
		},
		FlavorText = "StaffSelfHitAspect_FlavorText",
	},

	BaseStaffAspect_Secondary =
	{
		InheritFrom = {"BaseTrait"},
		Icon = "Hammer_Staff_39",
		ReplacementGrannyModels = 
		{
			WeaponStaff_Mesh = "WeaponStaff_Mesh"
		},
		AddOutgoingDamageModifiers = 
		{
			ValidWeapons = game.WeaponSets.HeroSecondaryWeapons,
			ValidBaseDamageAddition = { BaseValue = 10 },
			ReportValues = { ReportedBonus = "ValidBaseDamageAddition" }
		},
		PropertyChanges =
		{
			{
				LuaProperty = "MaxMana",
				BaseValue = 10,
				ChangeType = "Add",
			},
			{
				FalseTraitName = "AxeFreeSpinTrait",
				WeaponName = "WeaponAxeSpin",
				WeaponProperty = "RemoveControlOnCharge2",
				ChangeValue = "WeaponStaffBall",
			},
			{
				WeaponName = "WeaponAxeSpin",
				WeaponProperty = "AddControlOnFireEnd2",
				ChangeValue = "WeaponStaffBall",
			}
		},
		StatLines =
		{
			"SpecialAndManaStatDisplay1",
		},
		RarityLevels =
		{
			Common =
			{
				MinMultiplier = 0,
				MaxMultiplier = 0,
			},
			Rare =
			{
				Multiplier = 1,
			},
			Epic =
			{
				Multiplier = 2,
			},
			Heroic =
			{
				Multiplier = 3,
			},
			Legendary =
			{
				Multiplier = 4,
			},
			Perfect =
			{
				Multiplier = 5,
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedBonus",
				ExtractAs = "DamageBonus",
				IncludeSigns = true,
			},
		},
		FlavorText = "BaseStaffAspect_FlavorText",
	},

	DaggerBackstabAspect_Secondary =
	{
		InheritFrom = {"BaseTrait"},
		Icon = "Hammer_Daggers_38",
		ReplacementGrannyModels = 
		{
			WeaponDaggerA_Mesh = "WeaponDaggerA_Mesh",
			WeaponDaggerB_Mesh = "WeaponDaggerB_Mesh"
		},
		RarityLevels =
		{
			Common =
			{
				Multiplier = 0,
			},
			Rare =
			{
				Multiplier = 1,
			},
			Epic =
			{
				Multiplier = 1.5,
			},
			Heroic =
			{
				Multiplier = 2.0,
			},
			Legendary =
			{
				Multiplier = 2.5,
			},
			Perfect =
			{
				Multiplier = 5,
			},
		},
		AddOutgoingDamageModifiers =
		{
			ValidWeapons = game.WeaponSets.HeroPrimarySecondaryWeapons,
			HitVulnerabilityMultiplier =
			{
				BaseValue = 1.40,
				SourceIsMultiplier = true,
			},
			ReportValues = { ReportedMultiplier = "HitVulnerabilityMultiplier"},
		},
		PropertyChanges =
		{
			{
				FalseTraitName = "AxeFreeSpinTrait",
				WeaponName = "WeaponAxeSpin",
				WeaponProperty = "RemoveControlOnCharge2",
				ChangeValue = "WeaponDaggerThrow",
			},
			{
				WeaponName = "WeaponAxeSpin",
				WeaponProperty = "AddControlOnFireEnd2",
				ChangeValue = "WeaponDaggerThrow",
			}
		},
		StatLines =
		{
			"BackstabStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedMultiplier",
				ExtractAs = "Damage",
				Format = "PercentDelta",
			},
		},
		FlavorText = "DaggerBackstabAspect_FlavorText",
	},

	TorchSpecialDurationAspect_Secondary =
	{
		InheritFrom = {"BaseTrait"},
		RarityLevels =
		{
			Common =
			{
				Multiplier = 0,
			},
			Rare =
			{
				Multiplier = 1,
			},
			Epic =
			{
				Multiplier = 1.5,
			},
			Heroic =
			{
				Multiplier = 2,
			},
			Legendary =
			{
				Multiplier = 2.5,
			},
			Perfect =
			{
				Multiplier = 4,
			},
		},
		Icon = "Hammer_Torch_39",
		ReplacementGrannyModels =
		{
			WeaponTorchR_Mesh = "WeaponTorchR_Mesh",
			WeaponTorchL_Mesh = "WeaponTorchL_Mesh"
		},
		PropertyChanges =
		{
			{
				FalseTraitName = "AxeFreeSpinTrait",
				WeaponName = "WeaponAxeSpin",
				WeaponProperty = "RemoveControlOnCharge2",
				ChangeValue = "WeaponTorchSpecial",
			},
			{
				WeaponName = "WeaponAxeSpin",
				WeaponProperty = "AddControlOnFireEnd2",
				ChangeValue = "WeaponTorchSpecial",
			}
		},
		AddOutgoingCritModifiers =
		{
			ValidWeapons = game.WeaponSets.HeroPrimarySecondaryWeapons,
			Chance = { BaseValue = 0.04 },
			ReportValues = {ReportedChance = "Chance"}
		},
		StatLines =
		{
			"SpecialDurationStatDisplay1",
		},
		ExtractValues =
		{
			{
				Key = "ReportedChance",
				ExtractAs = "Bonus",
				Format = "LuckModifiedPercent",
			},
		},
		FlavorText = "TorchSpecialDurationAspect_FlavorText",
	},

	AxeRecoveryAspect_Secondary =
	{
		InheritFrom = {"BaseTrait"},
		RarityLevels =
		{
			Common =
			{
				Multiplier = 0,
			},
			Rare =
			{
				Multiplier = 1,
			},
			Epic =
			{
				Multiplier = 1.17,
			},
			Heroic =
			{
				Multiplier = 1.34,
			},
			Legendary =
			{
				Multiplier = 1.67,
			},
			Perfect =
			{
				Multiplier = 2.00,
			},
		},
		Icon = "Hammer_Axe_40",
		ReplacementGrannyModels = 
		{
			Melinoe_Axe_Mesh1 = "Melinoe_Axe_Mesh1"
		},
		AddOutgoingDamageModifiers = 
		{
			ValidWeapons = game.WeaponSets.HeroPrimaryWeapons,
			NonExBaseDamageAddition = { BaseValue = 30 },
			ReportValues = 
			{ 
				ReportedDamage = "NonExBaseDamageAddition"
			},
		},
		PropertyChanges =
		{
			{
				LuaProperty = "MaxHealth",
				BaseValue = 30,
				ChangeType = "Add",
			},
		},
		StatLines =
		{
			"AxeDamageHealthStatDisplay",
		},
		ExtractValues =
		{
			{
				Key = "ReportedDamage",
				ExtractAs = "Damage",
				IncludeSigns = true,
			},
		},
		FlavorText = "AxeRecoveryAspect_FlavorText",
	},

	BaseSuitAspect_Secondary =
	{
		InheritFrom = {"BaseTrait"},
		Icon = "Hammer_Suit_01",
		ReplacementGrannyModels =
		{
			WeaponSuitR_Base_Mesh = "WeaponSuitR_Base_Mesh",
			WeaponSuitL_Base_Mesh = "WeaponSuitL_Base_Mesh",
			WeaponSuitB_Base_Mesh = "WeaponSuitB_Base_Mesh",
		},

		WeaponSpeedMultiplier =
		{
			WeaponNames = game.WeaponSets.HeroPrimaryWeapons,
			Value =
			{
				BaseValue = 0.95,
				SourceIsMultiplier = true,
			},
		},
		PropertyChanges =
		{
			{
				WeaponNames = game.WeaponSets.HeroPrimaryWeapons,
				BaseValue = 0.95,
				SourceIsMultiplier = true,
				SpeedPropertyChanges = true,
				ExcludeLinked = true,
			},
			{
				UnitProperty = "Speed",
				BaseValue = 1.05,
				SourceIsMultiplier = true,
				ChangeType = "Multiply",
				ReportValues = { ReportedChange = "ChangeValue" }
			},
			{
				WeaponNames = { "WeaponSprint" },
				WeaponProperty = "SelfVelocity",
				BaseValue = 99,
				ChangeType = "Add",
				ExcludeLinked = true,
			},
			{
				WeaponNames = { "WeaponSprint" },
				WeaponProperty = "SelfVelocityCap",
				BaseValue = 44.5,
				ChangeType = "Add",
				ExcludeLinked = true,
			},
			{
				FalseTraitName = "AxeFreeSpinTrait",
				WeaponName = "WeaponAxeSpin",
				WeaponProperty = "RemoveControlOnCharge2",
				ChangeValue = "WeaponSuitRanged",
			},
			{
				WeaponName = "WeaponAxeSpin",
				WeaponProperty = "AddControlOnFireEnd2",
				ChangeValue = "WeaponSuitRanged",
			}
		},
		StatLines =
		{
			"MoveSprintAttackSpeedStatDisplay",
		},
		RarityLevels =
		{
			Common =
			{
				MinMultiplier = 0,
				MaxMultiplier = 0,
			},
			Rare =
			{
				Multiplier = 1,
			},
			Epic =
			{
				Multiplier = 2,
			},
			Heroic =
			{
				Multiplier = 3,
			},
			Legendary =
			{
				Multiplier = 4,
			},
			Perfect =
			{
				Multiplier = 7,
			},
		},
		ExtractValues =
		{
			{
				Key = "ReportedChange",
				ExtractAs = "SpeedBonus",
				Format = "PercentDelta"
			},
		},
		FlavorText = "BaseSuitAspect_FlavorText",
	},

	LobAmmoBoostAspect_Secondary =
	{
		InheritFrom = {"BaseTrait"},
		RarityLevels =
		{
			Common =
			{
				Multiplier = 0,
			},
			Rare =
			{
				Multiplier = 1,
			},
			Epic =
			{
				Multiplier = 2,
			},
			Heroic =
			{
				Multiplier = 3,
			},
			Legendary =
			{
				Multiplier = 4,
			},
			Perfect =
			{
				Multiplier = 7,
			},
		},
		Icon = "Hammer_Lob_13",
		ReplacementGrannyModels =
		{
			WeaponLob_Mesh = "WeaponLob_Mesh"
		},
		PropertyChanges =
		{
			{
				FalseTraitName = "AxeFreeSpinTrait",
				WeaponName = "WeaponAxeSpin",
				WeaponProperty = "RemoveControlOnCharge2",
				ChangeValue = "WeaponLobSpecial",
			},
			{
				WeaponName = "WeaponAxeSpin",
				WeaponProperty = "AddControlOnFireEnd2",
				ChangeValue = "WeaponLobSpecial",
			}
		},
		FlavorText = "LobAmmoBoostAspect_FlavorText",
	},

	LobGunAspect_Secondary =
	{
		InheritFrom = {"BaseTrait"},
		Icon = "Hammer_Lob_16",
		RarityLevels =
		{
			-- Chance the 130/140/150 number to be the percent increase at each rarity
			Common =
			{
				Multiplier = (1-(100/105))/0.5,
			},
			Rare =
			{
				Multiplier = (1-(100/110))/0.5,
			},
			Epic =
			{
				Multiplier = (1-(100/115))/0.5,
			},
			Heroic =
			{
				Multiplier = (1-(100/120))/0.5,
			},
			Legendary =
			{
				Multiplier = (1-(100/125))/0.5,
			},
			Perfect =
			{
				Multiplier = (1-(100/135))/0.5,
			},
		},
		ReplacementGrannyModels =
		{
			WeaponLob_Mesh = "WeaponLob_Hel_Mesh"
		},
		WeaponDataOverride =
		{
			WeaponLobSpecial = 
			{
				ScaledFireEndEffects = {},
				CustomThrowEx = true,
				CompleteObjectivesOnNonStagedFire = { "WeaponLobSpecial_Hel" },
				HitSimSlowParameters = "nil",
				HitSimSlowCooldown = "nil",
				ChargeWeaponStages = 
				{
					{
						ManaCost = 50,
						Wait = 1.1,
						WeaponProperties =
						{
							Projectile = "ProjectileLobGunRift",
							BlinkDetonateOnInterval = 0,
							BlinkDetonateAtOrigin = true,
							WeaponRange = 1,
							BlinkMaxRange = 1,
							BlinkSpeed = 3500,
							ShowFreeAimLine = true,
							AimLineDistanceOverride = 1200,
							UnblockedBlinkFx = "null",
							ProjectileAngleStartOffset = 0,
						},
						ChannelSlowEventOnStart = true,
						--DeferRevert = true,
						SkipManaSpendOnFire = true,
					},
				},

				Sounds =
				{
					ChargeSounds =
					{
						{
							Name = "/SFX/Player Sounds/ZagreusWeaponChargeup" ,
							StoppedBy = { "TriggerRelease" }
						},
						{
							Name = "/VO/MelinoeEmotes/AnubisEmoteCharging2" ,
							StoppedBy = { "TriggerRelease" }
						},
					},
					FireSounds =
					{
						PerfectChargeSounds =
						{
							{ Name = "/Leftovers/SFX/AuraPerfectThrow" },
						},
						{ Name = "/SFX/Player Sounds/MelSkullsDash" },
						{
							Name = "/VO/MelinoeEmotes/HelEmoteAttacking2",
							Cooldown = 0.5
						},
					},
					FireStageSounds =
					{
						{ Name = "/SFX/Player Sounds/MelSkullsOmegaSpecialFire" },
						{ Name = "/VO/MelinoeEmotes/HelEmoteSpecial2" },
					},
					ImpactSounds =
					{
						Invulnerable = "/SFX/SwordWallHitClank",
						Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
						Bone = "/SFX/MetalBoneSmash",
						Brick = "/SFX/MetalStoneClang",
						Stone = "/SFX/MetalStoneClang",
						Organic = "/SFX/FistImpactBig",
						StoneObstacle = "/SFX/SwordWallHitClank",
						BrickObstacle = "/SFX/SwordWallHitClank",
						MetalObstacle = "/SFX/SwordWallHitClank",
						BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
						Shell = "/SFX/ShellImpact",
					},
				},
			}
		},
		OnProjectileCreationFunction =
		{
			ValidProjectiles = { "ProjectileLobOverheat" },
			Name = "OnGunOverheatCreated",
		},
		OnWeaponFiredFunctions =
		{
			ValidWeapons = game.WeaponSets.HeroAllWeapons,
			FunctionName = _PLUGIN.guid .. "." .. "HandleGunBehavior",
			FunctionArgs =
			{
				EffectName = "HelOverheat",
				EffectData =
				{
					Modifier = { BaseValue = 0.5, SourceIsMultiplier = true, DecimalPlaces = 4,},
					Duration = 3,
					ReportValues =
					{
						ReportedDuration = "Duration",
						ReportedSpeed = "Modifier",
					},
				},
				ExAttackApplyEffects = { "WeaponLobHelAttackEXDisable", "WeaponLobHelAttackEXDisableCancellable", },
				ClipSize = 3,
				ClipReload = 0.48,
				ClipRegenInterval = 0.48,
			}
		},
		SetupFunction =
		{
			Threaded = true,
			Name = "HideGunUI"
		},
		PropertyChanges =
		{
			{
				WeaponName = "WeaponLobSpecial",
				WeaponProperties =
				{
					Projectile = "ProjectileLobSpecialBounce",
					BlinkDetonateOnInterval = 0,
					BlinkDetonateAtOrigin = true,
					BlinkDisableBehavior = true,
					ShowFreeAimLine = true,
					UnblockedBlinkFx = "null",
					ProjectileAngleStartOffset = 0,
					ChargeRangeMultiplier = 0,
					RemoveControlOnFire = "WeaponLobSpecial",
					AutoLock = true,
					AutoLockRange = 650,
					AutoLockArcDistance = math.rad(40),
				},
			},
			{
				WeaponName = "WeaponLobSpecial",
				ProjectileName = "ProjectileThrowCharged",
				ProjectileProperties =
				{
					Graphic = "LobSpecialFx_Hel",
				},
			},
			{
				FalseTraitName = "AxeFreeSpinTrait",
				WeaponName = "WeaponAxeSpin",
				WeaponProperty = "RemoveControlOnCharge2",
				ChangeValue = "WeaponLobSpecial",
			},
			{
				WeaponName = "WeaponAxeSpin",
				WeaponProperty = "AddControlOnFireEnd2",
				ChangeValue = "WeaponLobSpecial",
			}
		},
		StatLines =
		{
			"OverheatDamageStatDisplay1",
		},
		ExtractValues =
		{
			{
				CheckAutomaticPropertyChanges = true,
				Key = "ReportedDuration",
				ExtractAs = "OverheatDuration",
				SkipAutoExtract = true,
			},
			{
				Key = "ReportedSpeed",
				ExtractAs = "AspectModifier",
				Format = "PercentReciprocalDelta",
			},
		},
		FlavorText = "LobGunAspect_FlavorText",
	}
}

AspectYoungMel = "JarlUlsfark-AspectYoungMel"

if rom.mods[AspectYoungMel] then
	game.OverwriteTableKeys(mod.AspectTraitData, {
		StaffAspectofYoungMelinoe_Secondary = {
			InheritFrom = {"BaseTrait"},
			Icon = "JarlUlsfark-AspectYoungMel\\StaffAspectYoungMelIcon",
			ReplacementGrannyModels =
			{
				WeaponStaff_Mesh = "WeaponStaff_Mesh"
			},
			RarityLevels =
			{
				Common =
				{
					Multiplier = 1,
				},
				Rare =
				{
					Multiplier = 1.333,
				},
				Epic =
				{
					Multiplier = 1.666,
				},
				Heroic =
				{
					Multiplier = 2,
				},
				Legendary =
				{
					Multiplier = 2.333,
				},
				Perfect =
				{
					Multiplier = 2.666,
				},
			},
			OnProjectileDeathFunction =
			{
				Name = AspectYoungMel .. "." .. "CheckStaffSelfHit",
				ValidProjectiles = {"ProjectileStaffBallCharged"},
				Args = 
				{
					ProjectileName = "ProjectileStaffBallCharged",
					Threshold = { BaseValue = 0.3 },
					HealAmount = 5,
					ReportValues = 
					{ 
						ReportedThreshold = "Threshold" ,
						ReportedHeal = "HealAmount"
					},
				}
			},
			ExtractValues =
			{
				{
					Key = "ReportedThreshold",
					ExtractAs = "HealthThreshold",
					Format = "Percent",
					SkipAutoExtract = true
				},
				{
					Key = "ReportedHeal",
					ExtractAs = "HealAmount",
					SkipAutoExtract = true
				},
			},
			StatLines =
			{
				"HealthThresholdStatDisplay"
			},
			PropertyChanges =
			{
				{
					WeaponName = "WeaponStaffBall",
					WeaponProperty = "Projectile",
					ChangeValue = "ProjectileStaffBoltEA",
				},
				{
					WeaponName = "WeaponStaffBall",
					WeaponProperty = "InitialCooldown",
					ChangeValue = 0,
					ChangeType = "Absolute",
				},
				{
					WeaponName = "WeaponStaffBall",
					WeaponProperty = "Cooldown",
					ChangeValue = 0.4,
					ChangeType = "Absolute",
				},
			},
			FlavorText = "StaffAspectofYoungMelinoe_FlavorText",
		},

		AxeAspectofYoungMelinoe_Secondary = {
			InheritFrom = {"BaseTrait"},
			RarityLevels =
			{
				Common =
				{
					Multiplier = 1.4,
				},
				Rare =
				{
					Multiplier = 1.8,
				},
				Epic =
				{
					Multiplier = 2.2,
				},
				Heroic =
				{
					Multiplier = 2.6,
				},
				Legendary =
				{
					Multiplier = 3,
				},
				Perfect =
				{
					Multiplier = 3.4,
				},
			},
			Icon = "JarlUlsfark-AspectYoungMel\\AxeAspectYoungMelIcon",
			ReplacementGrannyModels =
			{
				Melinoe_Axe_Mesh1 = "Melinoe_Axe_Mesh1",
			},
			OnBlockDamageFunction =
			{
				Name = AspectYoungMel .. "." .. "BlockAxeBuff",
				Args = 
				{
					MaxRetaliateBuff = { BaseValue = 1 },
					EffectName = "CastGripEffect",
					Duration = 3,
					ReportValues =
					{
						MaxBuff = "MaxRetaliateBuff",

					}
				}
			},
			AddOutgoingDamageModifiers = {
				ValidWeapons = game.WeaponSets.HeroPrimaryWeapons,
				UseTraitValue = "RetaliateBuff",
				IsMultiplier = true,
			},
			RetaliateBuff = 1,
			WeaponDataOverride =
			{
				WeaponAxeSpecial =
				{
					Sounds =
					{
						FireSounds =
						{
							{ Name = "/SFX/Player Sounds/ZagreusFistWhoosh" },
						},
						ImpactSounds =
						{
							Invulnerable = "/SFX/Player Sounds/ZagreusShieldRicochet",
							Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
							Bone = "/SFX/Player Sounds/ShieldObstacleHit",
							Brick = "/SFX/Player Sounds/ShieldObstacleHit",
							Stone = "/SFX/Player Sounds/ShieldObstacleHit",
							Organic = "/SFX/Player Sounds/ShieldObstacleHit",
							StoneObstacle = "/SFX/SwordWallHitClankSmall",
							BrickObstacle = "/SFX/SwordWallHitClankSmall",
							MetalObstacle = "/SFX/SwordWallHitClankSmall",
							BushObstacle = "/Leftovers/World Sounds/LeavesRustle",
							Shell = "/SFX/ShellImpact",
						},
					},
				},
			},
			-- Changing special to Block
			PropertyChanges =
			{
				{
					WeaponName = "WeaponAxeSpecial",
					WeaponProperties = {
						Projectile = "ProjectileAxeBlockSpin",
						ExpireProjectilesOnFire = "ProjectileAxeSpin",
						DoProjectileBlockPresentation = true,
						DefaultKnockbackForce = 480,
						DefaultKnockbackScale = 0.6,
						ActiveProjectileCap = 1,
						FizzleOldSpawns = true,
						BlockedByAllOtherFireRequest = false,
						RootOwnerWhileFiring = true,
						FireFx = "null",
						FullyAutomatic = true,
						Cooldown = 0.4,
						AddOnFire = "WeaponAxeSpecialSwing",
					},
					ExcludeLinked = true,
				},
				{
					WeaponName = "WeaponAxeSpecialSwing",
					WeaponProperty = "Projectile",
					ChangeValue = "ProjectileAxeBlock2",
				},
				{
					WeaponName = "WeaponAxeSpecial",
					EffectName = "AxeSpecialBlockSelfTriggerLock",
					EffectProperty = "Active",
					ChangeValue = false,
					ChangeType = "Absolute",
					ExcludeLinked = true,
				},
				{
					WeaponName = "WeaponAxeSpecial",
					EffectName = "AxeSpecialDisable",
					EffectProperty = "Active",
					ChangeValue = false,
					ChangeType = "Absolute",
					ExcludeLinked = true,
				},
				{
					WeaponName = "WeaponAxeSpecial",
					EffectName = "AxeSpecialDisable",
					EffectProperty = "Active",
					ChangeValue = false,
					ChangeType = "Absolute",
					ExcludeLinked = true,
				},
				{
					WeaponName = "WeaponAxeSpecial",
					EffectName = "AxeSpecialDisableCancelable",
					EffectProperty = "Active",
					ChangeValue = false,
					ChangeType = "Absolute",
					ExcludeLinked = true,
				},
				{
					WeaponName = "WeaponAxeSpecial",
					EffectName = "AxeSpecialDisableMovementCancelable",
					EffectProperty = "Active",
					ChangeValue = false,
					ChangeType = "Absolute",
					ExcludeLinked = true,
				},
				{
					WeaponName = "WeaponAxeSpecial",
					EffectName = "ShieldSelfSpeed",
					EffectProperty = "Active",
					ChangeValue = true,
					ChangeType = "Absolute",
					ExcludeLinked = true,
				},
				{
					WeaponName = "WeaponAxeSpecial",
					EffectName = "ShieldSelfInvulnerableRush",
					EffectProperty = "Active",
					ChangeValue = true,
					ChangeType = "Absolute",
					ExcludeLinked = true,
				},
				{
					WeaponName = "WeaponAxeSpecial",
					EffectName = "ShieldSelfInvulnerableRush2",
					EffectProperty = "Active",
					ChangeValue = true,
					ChangeType = "Absolute",
					ExcludeLinked = true,
				},
				{
					WeaponName = "WeaponAxeSpecial",
					EffectName = "ShieldFireDisableAttack",
					EffectProperty = "Active",
					ChangeValue = true,
					ChangeType = "Absolute",
					ExcludeLinked = true,
				},
				{
					WeaponName = "WeaponAxeSpecial",
					EffectName = "ShieldChargeDisableMove",
					EffectProperty = "Active",
					ChangeValue = true,
					ChangeType = "Absolute",
					ExcludeLinked = true,
				},
				{
					WeaponName = "WeaponAxeSpecial",
					EffectName = "ShieldFireDisableMove2",
					EffectProperty = "Active",
					ChangeValue = true,
					ChangeType = "Absolute",
					ExcludeLinked = true,
				},
			},
			StatLines =
			{
				"AxeAspectYoungMelStat",
			},
			ExtractValues =
			{
				{
					Key = "MaxBuff",
					ExtractAs = "RetaliateDamage",
					Format = "PercentDelta",
				},
			},
			FlavorText = "AxeAspectofYoungMelinoe_FlavorText",
		}
	})
end

game.OverwriteTableKeys( game.TraitData, mod.AspectTraitData )

for traitName, traitData in pairs(mod.AspectTraitData) do
    game.ProcessDataInheritance( traitData, game.TraitData )
end

if game.TraitData["StaffRaiseDeadAspect"].ManaCostModifiers then
	game.TraitData["StaffRaiseDeadAspect"].ManaCostModifiers.WeaponNames = {"WeaponStaffBall"}
end

game.ProjectileData.WomboStrike.HitScreenshake = nil
game.ProjectileData.WomboStrike.HitSimSlowCustomName = nil
game.ProjectileData.WomboStrike.HitSimSlowCooldown = nil
game.ProjectileData.WomboStrike.HitSimSlowParameters = nil
game.ProjectileData.WomboStrike.FireRumbleParameters = nil

game.WeaponData.WeaponDagger5.HitSimSlowParameters = nil
game.WeaponData.WeaponDagger5.HitRumbleParameters = nil
game.WeaponData.WeaponDagger5.HitScreenshake = nil

if game.TraitData.AxeFreeSpinTrait.ChargeStageModifiers then
	game.TraitData.AxeFreeSpinTrait.ChargeStageModifiers.ValidWeapons = {"WeaponAxeSpin"}
end

local shivaValidProjectiles = modutil.mod.Path.Get("TraitData.SuitComboAspect.OnProjectileDeathFunction.ValidProjectiles")
if shivaValidProjectiles then
	table.insert(shivaValidProjectiles, "ProjectileAxeBlock2")
	table.insert(shivaValidProjectiles, "ProjectileStaffBallCharged")
	table.insert(shivaValidProjectiles, "ProjectileThrowCharged")
end

game.OverwriteTableKeys(game.TraitData.SuitComboAspect,
{
	OnEnemyDamagedAction =
	{
		ValidProjectiles = {"ProjectileTorchOrbitEx", "ProjectileTorchSupayBallEx", "ProjectileDaggerThrowCharged"},
		FunctionName = _PLUGIN.guid .. "." .. "CheckSelfBuffBlast",
		Args =
		{
			EffectName = "ShivaAttackBoost",
			Cooldown = 0.3,
		}
	},
	OnProjectileCreationFunction =
	{
		ValidProjectiles = {"ProjectileThrowCharged"},
		Name = _PLUGIN.guid .. "." .. "CheckSelfBuffBlastSkull",
		Args =
		{
			Cooldown = 0.25,
			EffectName = "ShivaAttackBoost"
		}
	}
})