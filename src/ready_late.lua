modutil.mod.Path.Context.Wrap.Static("CheckFinisher",function (victim, functionArgs, triggerArgs)
	modutil.mod.Path.Wrap("AddLinkedWeapons", function (base, weaponList)
		if weaponList[1] == "WeaponDagger" then
			weaponList = {
				"WeaponDagger",
				"WeaponStaffSwing",
				"WeaponAxe",
				"WeaponTorch",
                "WeaponSuit",
				"WeaponLob",
			}
		elseif weaponList[1] == "WeaponDaggerThrow" then
			weaponList = {
				"WeaponDaggerThrow",
				"WeaponStaffBall",
				"WeaponAxeSpecial",
				"WeaponTorchSpecial",
                "WeaponSuitRanged",
				"WeaponLobSpecial"
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

modutil.mod.Path.Context.Wrap.Static("SkullImpulseTransform", function (weaponData, functionArgs, triggerArgs)
	modutil.mod.Path.Wrap("GetHeroTrait", function (base, traitName)
		if traitName == "LobImpulseAspect" then
			return base(traitName) or base(traitName.."_Secondary")
		end
		return base(traitName)
	end)
end)

modutil.mod.Path.Context.Wrap.Static("ChargeSkullImpulse", function (victim, args, triggerArgs)
	modutil.mod.Path.Wrap("GetHeroTrait", function (base, traitName)
		if traitName == "LobImpulseAspect" then
			return base(traitName) or base(traitName.."_Secondary")
		end
		return base(traitName)
	end)
end)

modutil.mod.Path.Context.Wrap.Static("UpdateLobUI", function ( spellItem, args, user )
	modutil.mod.Path.Wrap("HeroHasTrait", function (base, traitName)
		return HeroHasTraitWrap(base, traitName, "LobImpulseAspect")
	end)
end)

modutil.mod.Path.Context.Wrap.Static("EmptyThrowCharge", function ( weaponName, stageReached )
	local orig_HeroHasTrait = modutil.mod.Path.Get("HeroHasTrait")
	modutil.mod.Path.Wrap("HeroHasTrait", function (base, traitName)
		return HeroHasTraitWrap(base, traitName, "LobImpulseAspect")
	end)
	modutil.mod.Path.Wrap("GetHeroTrait", function (base, traitName)
		if traitName == "LobImpulseAspect" and orig_HeroHasTrait(traitName .. "_Secondary") then
			return base(traitName .. "_Secondary")
		end
		return base(traitName)
	end)
end)

modutil.mod.Path.Context.Wrap.Static("CheckSkullImpulseStart", function ()
	modutil.mod.Path.Wrap("GetHeroTrait", function (base, traitName)
		if traitName == "LobImpulseAspect" then
			return base(traitName) or base(traitName.."_Secondary")
		end
		return base(traitName)
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
end)

modutil.mod.Path.Context.Wrap.Static("ModUtil.Hades.Triggers.OnBlinkFinished.WeaponLogic.2.Call", function (triggerArgs)
	modutil.mod.Path.Wrap("GetWeaponDataValue", function (base, args)
		local dataValue = base(args)
		if not dataValue then
			if args.WeaponName == "WeaponLob" and args.Property == "ChargeTime" then
				return 0.23
			end
			if args.WeaponName == "WeaponLob" and args.Property == "MinChargeToFire" then
				return 0.04
			end
		end
		return dataValue
	end)
	modutil.mod.Path.Wrap("HeroHasTrait", function (base, traitName)
		return HeroHasTraitWrap(base, traitName, "LobImpulseAspect")
	end)
end)

modutil.mod.Path.Context.Wrap.Static("TorchPrimaryAutofire", function ()
	modutil.mod.Path.Wrap("HasMarker", function (base, args)
		if args.Id == game.CurrentRun.Hero.ObjectId and
			  game.Contains({"WeaponHecateL_Rig:flame03_C_joint", "WeaponHecateR_Rig:flame03_C_joint"}, args.Name) and
		      not game.CurrentRun.Hero.Weapons["WeaponTorchSpecial"] then
			return true
		end
		return base(args)
	end)
end)

modutil.mod.Path.Context.Wrap.Static("CheckProjectileSpawn", function ()
	modutil.mod.Path.Wrap("CreateProjectileFromUnit", function (base, args)
		-- if string.match(args.WeaponName, "WeaponDagger") then
		-- 	args.AttachToTarget = true
		-- end
		local projectileId = base(args)
		if args.WeaponName ~= "WeaponSuitRanged" then
			game.SessionMapState.InvalidSplitIds[projectileId] = true
		end
	end)
end)