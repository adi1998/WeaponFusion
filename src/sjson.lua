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