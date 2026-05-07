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
        Description = "While you {$Keywords.Hold} your {$Keywords.AttackEX}, you occasionally {$Keywords.Block}, then {$Keywords.DaggerBlockBuff} right after."
    }
}

mod.AspectDisplayNameMap = {
    ["None"] = "None",
}

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
