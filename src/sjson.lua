local traitTextOrder = {
    "Id",
    "InheritFrom",
    "DisplayName",
    "Description",
}

local traitTextEnFile = rom.path.combine(rom.paths.Content, "Game\\Text\\en\\TraitText.en.sjson")

sjson.hook(traitTextEnFile, function (data)
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
        }
    }
    for index, value in ipairs(traitTextList) do
        table.insert(data.Texts, sjson.to_object(value, traitTextOrder))
    end
    return data
end)