local traitTextOrder = {
    "Id",
    "InheritFrom",
    "DisplayName",
    "Description",
}

local traitTextEnFile = rom.path.combine(rom.paths.Content, "Game\\Text\\en\\TraitText.en.sjson")

local traitTextList = {
    {
        Id = "AxeArmCastAspect_Secondary",
        InheritFrom = "BaseBoonMultiline",
        DisplayName = "Minor Aspect of Charon",
        Description = "Your {$Keywords.Cast} erupts like a stronger {$Keywords.CastEX} if struck by your {$Keywords.SpecialEX}."
    },
    {
        Id = "AxeRallyAspect_Secondary",
        InheritFrom = "BaseBoonMultiline",
        DisplayName = "Minor Aspect of Nergal",
        Description = "You have the {$Keywords.RallyAspect}, and become {$Keywords.FrenzyBuff} after you strike enough foes."
    },
    {
        Id = "SuitComboAspect_Secondary",
        InheritFrom = "BaseBoonMultiline",
        DisplayName = "Minor Aspect of Shiva",
        Description = "You have {$Keywords.ComboAspect}, which absorbs {$Keywords.SpecialEX} blasts to grow {$Keywords.ComboBuff}.",
    },
    {
        Id = "DaggerHomingThrowAspect_Secondary",
        InheritFrom = "BaseBoonMultiline",
        DisplayName = "Minor Aspect of Pan",
        Description = "Your {$Keywords.SpecialSet} seek foes in your {$Keywords.CastSet}, and fire more shots if you {$Keywords.Hold} longer."
    },
    {
        Id = "StaffClearCastAspect_Secondary",
        InheritFrom = "BaseBoonMultiline",
        DisplayName = "Minor Aspect of Circe",
        Description = "Whenever you use {$Keywords.CastSet}, so does your {$Keywords.Familiar}, forming a {$Keywords.FamiliarBuff}."
    },
    {
        Id = "DaggerTripleAspect_Secondary",
        InheritFrom = "BaseBoonMultiline",
        DisplayName = "Minor Aspect of Morrigan",
        Description = "You have the {$Keywords.TripleAspect}, which can perform the ritual of the {$Keywords.TripleAspectStrike}."
    },
    {
        Id = "TorchAutofireAspect_Secondary",
        InheritFrom = "BaseBoonMultiline",
        DisplayName = "Minor Aspect of Supay",
        Description = "You have the {$Keywords.AutofireAspect}, which also enhance your {$Keywords.SprintBoonAlt}.",
    },
    {
        Id = "StaffRaiseDeadAspect_Secondary",
        InheritFrom = "BaseBoonMultiline",
        DisplayName = "Minor Aspect of Anubis",
        Description = "You have the {$Keywords.RaiseDeadAspect}, which raises {$Keywords.ShadeMerc} wherever you slay foes.",
    },
    {
        Id = "AxePerfectCriticalAspect_Secondary",
        InheritFrom = "BaseBoonMultiline",
        DisplayName = "Minor Aspect of Thanatos",
        Description = "Your {$Keywords.Attack} is faster, and each strike grants {$Keywords.ThanatosAspectBuff} until you take damage.",
    },
    {
        Id = "SuitMarkCritAspect_Secondary",
        InheritFrom = "BaseBoonMultiline",
        DisplayName = "Minor Aspect of Nyx",
        Description = "You have {$Keywords.NyxSprint}, which lets you produce {$Keywords.NyxAspectBuff} after you activate it.",
    },
    {
        Id = "SuitHexAspect_Secondary",
        InheritFrom = "BaseBoonMultiline",
        DisplayName = "Minor Aspect of Selene",
        Description = "You start with {$TraitData.SpellMoonBeamTrait.Name}, a hidden {$Keywords.Spell} that strikes multiple foes and applies {$Keywords.MoonBeamVulnerability}.",
    },
    {
        Id = "DaggerBlockAspect_Secondary",
        InheritFrom = "BaseBoonMultiline",
        DisplayName = "Minor Aspect of Artemis",
        Description = "While you {$Keywords.Hold} your {$Keywords.AttackEX}, you occasionally {$Keywords.Block}, then {$Keywords.DaggerBlockBuff} right after.",
    },
    {
        Id = "LobImpulseAspect_Secondary",
        InheritFrom = "BaseBoonMultiline",
        DisplayName = "Minor Aspect of Persephone",
        Description = "Your {$Keywords.SpecialEX} is {$Keywords.Fuel}, and lets you change direction; {$Keywords.GodBoonPlural} start with {$Keywords.PomLevel}",
    },
    {
        Id = "StaffSelfHitAspect_Secondary",
        InheritFrom = "BaseBoonMultiline",
        DisplayName = "Minor Aspect of Momus",
        Description = "Whenever you use {$Keywords.Omega}, each fires in place up to {$TooltipData.ExtractData.StrikeCount} times until you use it again."
    },
    {
        Id = "BaseStaffAspect_Secondary",
        InheritFrom = "BaseBoonMultiline",
        DisplayName = "Minor Aspect of Melinoë",
        Description = "Gain {!Icons.ManaUp} and greater {$Keywords.BaseDamage} for your {$Keywords.SpecialSet}."
    },
    {
        Id = "DaggerBackstabAspect_Secondary",
        InheritFrom = "BaseBoonMultiline",
        DisplayName = "Minor Aspect of Melinoë",
        Description = "Your {$Keywords.AttackSet} and {$Keywords.SpecialSet} deal more damage by striking foes from behind."
    },
    {
        Id = "TorchSpecialDurationAspect_Secondary",
        InheritFrom = "BaseBoonMultiline",
        DisplayName = "Minor Aspect of Melinoë",
        Description = "Your {$Keywords.AttackSet} and {$Keywords.SpecialSet} may deal {$Keywords.Crit} damage."
    },
    {
        Id = "AxeRecoveryAspect_Secondary",
        InheritFrom = "BaseBoonMultiline",
        DisplayName = "Minor Aspect of Melinoë",
        Description = "Gain bonus {$Keywords.Attack} {$Keywords.BaseDamage} and {!Icons.HealthUp}."
    },
    {
        Id = "BaseSuitAspect_Secondary",
        InheritFrom = "BaseBoonMultiline",
        DisplayName = "Minor Aspect of Melinoë",
        Description = "Your {$Keywords.AttackSet}, {$Keywords.Sprint}, and move speed are faster."
    },
    {
        Id = "LobAmmoBoostAspect_Secondary",
        InheritFrom = "BaseBoonMultiline",
        DisplayName = "Minor Aspect of Melinoë",
        Description = "Your {$Keywords.AttackSet} have more {$Keywords.BaseDamage} for each {$Keywords.Shell} fired and not yet retrieved."
    },
    {
        Id = "LobGunAspect_Secondary",
        InheritFrom = "BaseBoonMultiline",
        DisplayName = "Minor Aspect of Hel",
        Description = "You have {$Keywords.GunAspect}, which grants the way of the {$Keywords.Overheat} after your {$Keywords.SpecialEX}.",
    },

    {
        Id = "StaffAspectofYoungMelinoe_Secondary",
        InheritFrom = "BaseBoonMultiline",
        DisplayName = "Minor Aspect of Young Melinoë",
        Description = "While you have no more than {#UpgradeFormat}{$TooltipData.ExtractData.HealthThreshold}%{!Icons.Health}{#Prev}, absorb your {$Keywords.SpecialEX} blast to restore {#BoldFormatGraft}{$TooltipData.ExtractData.HealAmount}{!Icons.Health}{#Prev}."
    }
}

mod.AspectDisplayNameMap = {}

for index, value in ipairs(traitTextList) do
    mod.AspectDisplayNameMap[value.Id] = value.DisplayName
end

sjson.hook(traitTextEnFile, function (data)
    for index, value in ipairs(traitTextList) do
        table.insert(data.Texts, sjson.to_object(value, traitTextOrder))
    end
    return data
end)

WeaponDisplayOrder = {
    "WeaponStaffSwing",
    "WeaponDagger",
    "WeaponTorch",
    "WeaponAxe",
    "WeaponSuit",
    "WeaponLob"
}

local weaponAnimationFile = rom.path.combine(rom.paths.Content, "Game\\Animations\\Model\\Weapon_Animation.sjson")

local animList = {}
for index, value in ipairs(WeaponDisplayOrder) do
    table.insert(animList, game.WeaponData[value].UpgradeScreenKitAnimation)
end

sjson.hook(weaponAnimationFile, function (data)
    local newData = {}
    for index, value in ipairs(data.Animations) do
        if game.Contains(animList, value.Name) then
            local newEntry = game.DeepCopyTable(value)
            newEntry.Name = newEntry.Name .. "_FusionScreen"
            newEntry.ZWobbleSpeed = 0
            newEntry.ZWobbleDistance = 0
            table.insert(newData, newEntry)
        end
    end
    for index, value in ipairs(newData) do
        table.insert(data.Animations, value)
    end
    return data
end)

local guiFile = rom.path.combine(rom.paths.Content, "Game\\Obstacles\\GUI.sjson")

sjson.hook(guiFile, function (data)
    local blankButton = {
      Name = _PLUGIN.guid .. "BlankButton",
      InheritFrom = "BaseInteractableButton",
      DisplayInEditor = true,
      Thing =
      {
        EditorOutlineDrawBounds = false,
        Graphic = _PLUGIN.guid .. "Button_Default",
        Interact =
        {
          DisabledUseSound = "/Leftovers/SFX/OutOfAmmo2",
          HighlightOffAnimation = _PLUGIN.guid .. "Button_HighlightOff",
          HighlightOnAnimation = _PLUGIN.guid .. "Button_HighlightOn",
        }
      }
    }

    table.insert(data.Obstacles, blankButton)
    return data
end)

local guiAnimationFile = rom.path.combine(rom.paths.Context, "Game\\Animations\\GUI_Screens_VFX.sjson")

local buttonGraphic = {
    {
        Name = _PLUGIN.guid .. "Button_Default",
        FilePath = _PLUGIN.guid .. "\\Square100",
        EndFrame = 1,
        HoldLastFrame = true,
        NumFrames = 1,
        StartFrame = 1,
        Material = "Unlit",
    },

    {
		Name = _PLUGIN.guid .. "Button_HighlightOn",
		FilePath = _PLUGIN.guid .. "\\Square100",
		EndFrame = 1,
		HoldLastFrame = true,
		NumFrames = 1,
		StartFrame = 1,
	},

	{
		Name = _PLUGIN.guid .. "Button_HighlightOff",
		FilePath = _PLUGIN.guid .. "\\Square100",
		EndFrame = 1,
		NumFrames = 1,
		StartFrame = 1,
	},

    {
		Name = _PLUGIN.guid .. "WeaponUpgradeSwitchFx",
		FilePath = "Fx\\TintableRadialFlare\\TintableRadialFlare",
		NumFrames = 45,
		Material = "Unlit",
		AddColor = true,
		GroupName = "Combat_Menu_Overlay_Additive",
		StartRed = 0.1,
		StartGreen = 0.5,
		StartBlue = 0.35,
		EndRed = 0,
		EndGreen = 0.3,
		EndBlue = 0.5,
		UseOwnAngle = false,
		AngleFromOwner = "Ignore",
		Scale = 1.5,
		VisualFx = "WeaponUpgradeSwitchFxColorStreaks",
		VisualFxIntervalMin = 0.01,
		VisualFxIntervalMax = 0.01,
		VisualFxCap = 8,
		StartScale = 1,
		EndScale = 0.5,
		EaseIn = 0,
		EaseOut = 0.001,
		CreateAnimations = {
			{ Name = "WeaponUpgradeSwitchFxGlow" },
			{ Name = "WeaponUpgradeSwitchFxSpectral" },
			{ Name = "WeaponUpgradeSwitchFxDarkA" },
			{ Name = "WeaponUpgradeSwitchFxDarkB" },
			{ Name = "WeaponUpgradeSwitchFxDarkC" },
			{ Name = "WeaponUpgradeSwitchFxDarkD" },
        },
	},

}

sjson.hook(guiAnimationFile, function (data)
    for index, value in ipairs(buttonGraphic) do
        table.insert(data.Animations, value)
    end
    return data
end)

local daggerTargetGreen = {
    {
		Name = _PLUGIN.guid .. "DaggerMarkStatus_Green",
		CreateAnimation = _PLUGIN.guid .. "DaggerMarkStatusBack_Green",
		FilePath = "Fx\\DaggerMarkStatus\\DaggerMarkStatus_Front",
		GroupName = "Combat_UI",
		AngleFromOwner = "Ignore",
		ColorFromOwner = "Ignore",
		Hue = 0.5,
		PingPongColor = true,
		Duration = 0.5,
		EaseOut = 1.0,
		EndFrame = 1,
		Loop = true,
		NumFrames = 1,
		StartFrame = 1,
		OffsetZ = 30.0,
		SortMode = "FromParent",
		EndScale = 0.9,
		PingPongScale = true,
		Scale = 0.66,
		ScaleFromOwner = "Ignore",
		Ambient = 0.0,
		UseAttachedFlasher = false,
	},
	{
		Name = _PLUGIN.guid .. "DaggerMarkStatusBack_Green",
		InheritFrom = _PLUGIN.guid .. "DaggerMarkStatus_Green",
		CreateAnimation = "null",
		FilePath = "Fx\\DaggerMarkStatus\\DaggerMarkStatus_Back",
		GroupName = "FX_Dark",
		DieWithOwner = true,
		DrawBehindOwner = true,
	},
}

local daggerVfxFile = rom.path.combine(rom.paths.Context, "Game\\Animations\\Melinoe_Dagger_VFX.sjson")

sjson.hook(daggerVfxFile, function (data)
    for index, value in ipairs(daggerTargetGreen) do
        table.insert(data.Animations, value)
    end
    return data
end)

local perfectString = sjson.to_object({
    Id = "Boon_Perfect",
    DisplayName = "Perfect"
}, { "Id", "DisplayName" })

local screenTextPath = rom.path.combine(rom.paths.Content, 'Game\\Text\\en\\ScreenText.en.sjson')

sjson.hook(screenTextPath, function(data)
    local boonPerfectFound
    for _, text in pairs(data.Texts) do
        if text.Id == "Boon_Perfect" then
            boonPerfectFound = true
        end
    end
    if not boonPerfectFound then
        table.insert(data.Texts, perfectString)
    end
end)