mod.AspectTraitData = {
    AxeArmCastAspect_Secondary = {
        Name = "AxeArmCastAspect_Secondary",
        InheritFrom = {"BaseTrait"},
        BlockInRunRarify = true,
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
        StatLines =
		{
			"AxeArmStatDisplay1",
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
    }
}

game.OverwriteTableKeys( game.TraitData, mod.AspectTraitData )

for traitName, traitData in pairs(mod.AspectTraitData) do
    game.ProcessDataInheritance( traitData, game.TraitData )
end