local traitData = {
    AxeArmCastAspect_Secondary = {
        InheritFrom = {"BaseTrait"},
        BlockInRunRarify = true,
        Icon = "Hammer_Axe_41",
        ReplacementGrannyModels = 
		{
			Melinoe_Axe_Mesh1 = "Melinoe_Axe_Charon_Mesh"
		},
        CastFlatFuseModifier = true,
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
    }
}

game.OverwriteTableKeys( game.TraitData, traitData )