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