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

modutil.mod.Path.Context.Wrap.Static("CleanupShadeMerc", function ( triggerArgs )
	modutil.mod.Path.Wrap("GetHeroTrait", function (base, traitName)
		if traitName == "StaffRaiseDeadAspect" and game.HeroHasTrait(traitName .. "_Secondary") then
			return base(traitName .. "_Secondary")
		end
		return base(traitName)
	end)
end)

modutil.mod.Path.Context.Wrap.Static("CheckPerfectAxeCrit", function ( victim, args, triggerArgs )
	modutil.mod.Path.Wrap("GetHeroTrait", function (base, traitName)
		if traitName == "AxePerfectCriticalAspect" and game.HeroHasTrait(traitName .. "_Secondary") then
			return base(traitName .. "_Secondary")
		end
		return base(traitName)
	end)
end)

modutil.mod.Path.Context.Wrap.Static("ResetPerfectAxeCrit", function ( attacker, args, triggerArgs )
	modutil.mod.Path.Wrap("GetHeroTrait", function (base, traitName)
		if traitName == "AxePerfectCriticalAspect" and game.HeroHasTrait(traitName .. "_Secondary") then
			return base(traitName .. "_Secondary")
		end
		return base(traitName)
	end)
end)

modutil.mod.Path.Context.Wrap.Static("EmptySuitCharge", function ( weaponName, stageReached )
	local orig_HeroHasTrait = modutil.mod.Path.Get("HeroHasTrait")
	modutil.mod.Path.Wrap("HeroHasTrait", function (base, traitName)
		return HeroHasTraitWrap(base, traitName, "SuitMarkCritAspect")
	end)
	modutil.mod.Path.Wrap("GetHeroTrait", function (base, traitName)
		if traitName == "SuitMarkCritAspect" and orig_HeroHasTrait(traitName .. "_Secondary") then
			return base(traitName .. "_Secondary")
		end
		return base(traitName)
	end)
end)

modutil.mod.Path.Context.Wrap.Static("PoseidonIntermittentClearCast", function ( weaponData, functionArgs, triggerArgs )
	modutil.mod.Path.Wrap("HeroHasTrait", function (base, traitName)
		return HeroHasTraitWrap(base, traitName, "SuitMarkCritAspect")
	end)
end)

modutil.mod.Path.Context.Wrap.Static("HoldSprintUntilInput", function ()
	modutil.mod.Path.Wrap("HeroHasTrait", function (base, traitName)
		return HeroHasTraitWrap(base, traitName, "SuitMarkCritAspect")
	end)
end)

modutil.mod.Path.Context.Wrap.Static("WeaponSuitAmmoTransform", function (triggerArgs, weaponDataArgs)
	modutil.mod.Path.Wrap("HeroHasTrait", function (base, traitName)
		return HeroHasTraitWrap(base, traitName, "SuitMarkCritAspect")
	end)
end)

modutil.mod.Path.Context.Wrap.Static("OpenSpellScreen", function ( spellItem, args, user )
	modutil.mod.Path.Wrap("HeroHasTrait", function (base, traitName)
		return HeroHasTraitWrap(base, traitName, "SuitHexAspect")
	end)
end)

modutil.mod.Path.Context.Wrap.Static("RestockWorldItem", function ( replacedIndex, kitId, args )
	modutil.mod.Path.Wrap("HeroHasTrait", function (base, traitName)
		return HeroHasTraitWrap(base, traitName, "SuitHexAspect")
	end)
end)

modutil.mod.Path.Context.Wrap.Static("TraitUIActivateTraits", function ( args )
	local orig_HeroHasTrait = modutil.mod.Path.Get("HeroHasTrait")
	modutil.mod.Path.Wrap("HeroHasTrait", function (base, traitName)
		return HeroHasTraitWrap(base, traitName, "DaggerBlockAspect")
	end)
	modutil.mod.Path.Wrap("GetHeroTrait", function (base, traitName)
		if traitName == "DaggerBlockAspect" and orig_HeroHasTrait(traitName .. "_Secondary") then
			return base(traitName .. "_Secondary")
		end
		return base(traitName)
	end)
end)

modutil.mod.Path.Context.Wrap.Static("UpdateDaggerUI", function ()
	modutil.mod.Path.Wrap("GetHeroTrait", function (base, traitName)
		if traitName == "DaggerBlockAspect" then
			return base(traitName) or base(traitName.."_Secondary")
		end
		return base(traitName)
	end)
end)

modutil.mod.Path.Context.Wrap.Static("CheckDaggerCritCharges", function (weaponData, functionArgs, triggerArgs)
	modutil.mod.Path.Wrap("GetHeroTrait", function (base, traitName)
		if traitName == "DaggerBlockAspect" then
			return base(traitName) or base(traitName.."_Secondary")
		end
		return base(traitName)
	end)
	modutil.mod.Path.Wrap("IncrementTableValue", function (base, tableArg, key, amount)
		if key == nil then
			print("nil argument 'key' detected in IncrementTableValue call from CheckDaggerCritCharges")
			print(mod.dump(tableArg), key, amount)
			return
		end
		return base(tableArg,key,amount)
	end)
end)

modutil.mod.Path.Context.Wrap.Static("ModUtil.Hades.Triggers.OnHit.CombatLogic.1.Call", function ()
	modutil.mod.Path.Wrap("GetHeroTrait", function (base, traitName)
		if traitName == "DaggerBlockAspect" then
			return base(traitName) or base(traitName.."_Secondary")
		end
		return base(traitName)
	end)
	modutil.mod.Path.Wrap("HeroHasTrait", function (base, traitName)
		return HeroHasTraitWrap(base, traitName, "DaggerBlockAspect")
	end)
end )