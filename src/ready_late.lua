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

modutil.mod.Path.Context.Wrap.Static("CheckDifferentOmegaCrit", function ( weaponData, functionArgs, triggerArgs )
	modutil.mod.Path.Wrap("HeroHasTrait", function (base, traitName)
		if traitName == "SuitComboAspect" then
			return base(traitName) or base(traitName.."_Secondary")
		end
		return base(traitName)
	end)
end)