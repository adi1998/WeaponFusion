game.TraitData.DaggerTripleAspect.PropertyChanges[1].FalseTraitName = "DaggerHomingThrowAspect_Secondary"

table.insert(game.TraitData.DaggerTripleAspect.PropertyChanges,
{
	WeaponName = "WeaponDaggerThrow",
	TraitName = "DaggerHomingThrowAspect_Secondary",
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
		AdjustRateAcceleration = math.rad(10000 / 3),
		MaxAdjustRate = math.rad(2160 / 2),
		ImmunityDuration = 0.20,
		RepeatHitOnReturn = true,
		MultiDetonate = true,
		MultipleUnitCollisions = true,
		ReturnToOwnerAfterInactiveSeconds = 0.6,
		Speed = 1200,
		Graphic = "DaggerThrowMorrigan",
		Damage = 20,
	},
})