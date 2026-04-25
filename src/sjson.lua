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
        }
    }
    for index, value in ipairs(traitTextList) do
        table.insert(data.Texts, sjson.to_object(value, traitTextOrder))
    end
    return data
end)