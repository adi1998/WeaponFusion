modutil.mod.Path.Context.Wrap.Static("CheckFinisher",function (victim, functionArgs, triggerArgs)
	modutil.mod.Path.Wrap("AddLinkedWeapons", function (base, weaponList)
		if weaponList[1] == "WeaponDagger" then
			weaponList = {
				"WeaponDagger",
				"WeaponStaffSwing",
				"WeaponAxe",
				"WeaponTorch",
                "WeaponSuit",
			}
		elseif weaponList[1] == "WeaponDaggerThrow" then
			weaponList = {
				"WeaponDaggerThrow",
				"WeaponStaffBall",
				"WeaponAxeSpecial",
				"WeaponTorchSpecial",
                "WeaponSuitRanged"
			}
		end
		return base(weaponList)
	end)
end)

function HeroHasTraitWrap(base, traitName, minorAspectTraitName)
	if traitName == minorAspectTraitName then
		return base(traitName) or base(traitName .. "_Secondary")
	end
	return base(traitName)
end

modutil.mod.Path.Context.Wrap.Static("CheckDifferentOmegaCrit", function ( weaponData, functionArgs, triggerArgs )
	modutil.mod.Path.Wrap("HeroHasTrait", function (base, traitName)
		return HeroHasTraitWrap(base, traitName, "SuitComboAspect")
	end)
end)

modutil.mod.Path.Context.Wrap.Static("CheckSprintBonusVolley", function ( weaponData, functionArgs, triggerArgs )
	modutil.mod.Path.Wrap("HeroHasTrait", function (base, traitName)
		return HeroHasTraitWrap(base, traitName, "SuitComboAspect")
	end)
end)

modutil.mod.Path.Context.Wrap.Static("CheckDrinkCritCharges", function ( weaponData, functionArgs, triggerArgs )
	modutil.mod.Path.Wrap("HeroHasTrait", function (base, traitName)
		return HeroHasTraitWrap(base, traitName, "SuitComboAspect")
	end)
end)

modutil.mod.Path.Context.Wrap.Static("CheckLeapCritCharges", function ( weaponData, functionArgs, triggerArgs )
	modutil.mod.Path.Wrap("HeroHasTrait", function (base, traitName)
		return HeroHasTraitWrap(base, traitName, "SuitComboAspect")
	end)
end)

modutil.mod.Path.Context.Wrap.Static("EmptyTorchSpecialCharge", function ( weaponName, stageReached )
	local orig_HeroHasTrait = modutil.mod.Path.Get("HeroHasTrait")
	modutil.mod.Path.Wrap("HeroHasTrait", function (base, traitName)
		return HeroHasTraitWrap(base, traitName, "TorchAutofireAspect")
	end)
	modutil.mod.Path.Wrap("GetHeroTrait", function (base, traitName)
		if traitName == "TorchAutofireAspect" and orig_HeroHasTrait(traitName .. "_Secondary") then
			return base(traitName .. "_Secondary")
		end
		return base(traitName)
	end)
end)