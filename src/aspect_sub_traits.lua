local subTraits = {
    DaggerHomingThrowAspect = {
        SubAspectTrait_DaggerHomingThrowAspect_Suit = {
            InheritFrom = {"BaseTrait"},
            Hidden = true,
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
            ChargeStageModifiers = {
                TraitNames = {"SuitComboAspect_Secondary"},
                ValidWeapons = {"WeaponSuitRanged"},
                AddProjectedChargeStages =
                {
                    NumStages = { BaseValue = 0.8 },
                    ProjectedChanges =
                    {
                        NumProjectiles = 1,
                        ManaCost = 10,
                    },
                },
                AddWeaponProperties = {
                    ProjectileAngleOffset = math.rad(12),
                    FireGraphic = "Melinoe_Dagger_SpecialEx_Fire_Slow",
                },
                HideStageReachedFxExceptForFinal = true,
            }
        },
        SubAspectTrait_DaggerHomingThrowAspect_LobGun = {
            InheritFrom = {"BaseTrait"},
            Hidden = true,
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
            OnProjectileCreationFunction = {
                ValidProjectiles = { "ProjectileLobGunRift" },
                Name = _PLUGIN.guid .. "." .. "FirePanLobGun",
                Args =
                {
                    ProjectileName = "ProjectileLobSpecialBounce",
                    NumProjectiles = { BaseValue = 0.8, },
                },
            }
        },
        SubAspectTrait_DaggerHomingThrowAspect_Staff = {
            InheritFrom = {"BaseTrait"},
            Hidden = true,
            PropertyChanges = {
                {
                    WeaponName = "WeaponStaffBall",
                    TraitName = "StaffTripleShotTrait",
                    ProjectileName = "ProjectileStaffBallCharged",
                    ProjectileProperty = "Fuse",
                    ChangeValue = 1.66666,
                    ChangeType = "Multiply"
                },
                {
                    WeaponName = "WeaponStaffBall",
                    TraitName = "StaffTripleShotTrait",
                    ProjectileName = "ProjectileStaffBallCharged",
                    ProjectileProperty = "Range",
                    ChangeValue = 1.66666,
                    ChangeType = "Multiply"
                },
            }
        },
        SubAspectTrait_DaggerHomingThrowAspect_Torch = {
            InheritFrom = {"BaseTrait"},
            Hidden = true,
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
            OnWeaponFiredFunctions =
            {
                ValidWeapons = {"WeaponTorchSpecial"},
                FunctionName = _PLUGIN.guid .. "." .. "FirePanTorchSpecial",
                FunctionArgs =
                {
                    NumProjectiles = { BaseValue = 1 },
                },
            },
            ManaCostModifiers =
            {
                WeaponNames = {"WeaponTorchSpecial", "WeaponLobSpecial"},
                ExWeapons = true,
                ManaCostAdd = 15,
            },
            PropertyChanges =
            {
                {
                    WeaponName = "WeaponTorchSpecial",
                    WeaponProperty = "ActiveProjectileCap2",
                    ChangeValue = 10,
                    ChangeType = "Add",
                    ExcludeLinked = true
                },
                {
                    WeaponName = "WeaponTorchSpecial",
                    WeaponProperty = "ActiveProjectileCap",
                    ChangeValue = 5,
                    ChangeType = "Add",
                    ExcludeLinked = true
                },
            }
        }
    }
}

mod.SubTraitMap = {}
for aspect_name, traits in pairs(subTraits) do
    game.OverwriteTableKeys(game.TraitData, traits)
    mod.SubTraitMap[aspect_name] = game.GetAllKeys(traits)
end