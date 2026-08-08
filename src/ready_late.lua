modutil.mod.Path.Context.Env("CheckFinisher",function (victim, functionArgs, triggerArgs)
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

function GetHeroTraitWrap(base, traitName, minorAspectTraitName)
	if traitName == minorAspectTraitName then
		return base(traitName) or base(traitName .. "_Secondary")
	end
	return base(traitName)
end

modutil.mod.Path.Context.Env("CheckDifferentOmegaCrit", function ( weaponData, functionArgs, triggerArgs )
	modutil.mod.Path.Wrap("HeroHasTrait", function (base, traitName)
		return HeroHasTraitWrap(base, traitName, "SuitComboAspect")
	end)
end)

-- seems to no longer be in use
-- modutil.mod.Path.Context.Env("CheckSprintBonusVolley", function ( weaponData, functionArgs, triggerArgs )
-- 	modutil.mod.Path.Wrap("HeroHasTrait", function (base, traitName)
-- 		return HeroHasTraitWrap(base, traitName, "SuitComboAspect")
-- 	end)
-- end)

modutil.mod.Path.Context.Env("CheckDrinkCritCharges", function ( weaponData, functionArgs, triggerArgs )
	modutil.mod.Path.Wrap("HeroHasTrait", function (base, traitName)
		return HeroHasTraitWrap(base, traitName, "SuitComboAspect")
	end)
end)

modutil.mod.Path.Context.Env("CheckLeapCritCharges", function ( weaponData, functionArgs, triggerArgs )
	modutil.mod.Path.Wrap("HeroHasTrait", function (base, traitName)
		return HeroHasTraitWrap(base, traitName, "SuitComboAspect")
	end)
end)

modutil.mod.Path.Context.Env("EmptyTorchSpecialCharge", function ( weaponName, stageReached )
	modutil.mod.Path.Wrap("HeroHasTrait", function (base, traitName)
		return HeroHasTraitWrap(base, traitName, "TorchAutofireAspect")
	end)
	modutil.mod.Path.Wrap("GetHeroTrait", function (base, traitName)
		return GetHeroTraitWrap(base, traitName, "TorchAutofireAspect")
	end)
end)

modutil.mod.Path.Context.Env("CleanupShadeMerc", function ( triggerArgs )
	modutil.mod.Path.Wrap("GetHeroTrait", function (base, traitName)
		return GetHeroTraitWrap(base, traitName, "StaffRaiseDeadAspect")
	end)
end)

modutil.mod.Path.Context.Env("ResetPerfectAxeCrit", function ( attacker, args, triggerArgs )
	modutil.mod.Path.Wrap("GetHeroTrait", function (base, traitName)
		return GetHeroTraitWrap(base, traitName, "AxePerfectCriticalAspect")
	end)
end)

modutil.mod.Path.Context.Env("EmptySuitCharge", function ( weaponName, stageReached )
	modutil.mod.Path.Wrap("HeroHasTrait", function (base, traitName)
		return HeroHasTraitWrap(base, traitName, "SuitMarkCritAspect")
	end)
	modutil.mod.Path.Wrap("GetHeroTrait", function (base, traitName)
		return GetHeroTraitWrap(base, traitName, "SuitMarkCritAspect")
	end)
end)

modutil.mod.Path.Context.Env("PoseidonIntermittentClearCast", function ( weaponData, functionArgs, triggerArgs )
	modutil.mod.Path.Wrap("HeroHasTrait", function (base, traitName)
		return HeroHasTraitWrap(base, traitName, "SuitMarkCritAspect")
	end)
end)

modutil.mod.Path.Context.Env("HoldSprintUntilInput", function ()
	modutil.mod.Path.Wrap("HeroHasTrait", function (base, traitName)
		return HeroHasTraitWrap(base, traitName, "SuitMarkCritAspect")
	end)
end)

modutil.mod.Path.Context.Env("WeaponSuitAmmoTransform", function (triggerArgs, weaponDataArgs)
	modutil.mod.Path.Wrap("HeroHasTrait", function (base, traitName)
		return HeroHasTraitWrap(base, traitName, "SuitMarkCritAspect")
	end)
end)

modutil.mod.Path.Context.Env("OpenSpellScreen", function ( spellItem, args, user )
	modutil.mod.Path.Wrap("HeroHasTrait", function (base, traitName)
		return HeroHasTraitWrap(base, traitName, "SuitHexAspect")
	end)
end)

modutil.mod.Path.Context.Env("RestockWorldItem", function ( replacedIndex, kitId, args )
	modutil.mod.Path.Wrap("HeroHasTrait", function (base, traitName)
		return HeroHasTraitWrap(base, traitName, "SuitHexAspect")
	end)
end)

modutil.mod.Path.Context.Env("TraitUIActivateTraits", function ( args )
	modutil.mod.Path.Wrap("HeroHasTrait", function (base, traitName)
		return HeroHasTraitWrap(base, traitName, "DaggerBlockAspect")
	end)
	modutil.mod.Path.Wrap("GetHeroTrait", function (base, traitName)
		return GetHeroTraitWrap(base, traitName, "DaggerBlockAspect")
	end)
end)

modutil.mod.Path.Context.Env("UpdateDaggerUI", function ()
	modutil.mod.Path.Wrap("GetHeroTrait", function (base, traitName)
		return GetHeroTraitWrap(base, traitName, "DaggerBlockAspect")
	end)
end)

modutil.mod.Path.Context.Env("CheckDaggerCritCharges", function (weaponData, functionArgs, triggerArgs)
	modutil.mod.Path.Wrap("GetHeroTrait", function (base, traitName)
		return GetHeroTraitWrap(base, traitName, "DaggerBlockAspect")
	end)
	modutil.mod.Path.Wrap("IncrementTableValue", function (base, tableArg, key, amount)
		if key == nil then
			print("nil argument 'key' detected in IncrementTableValue call from CheckDaggerCritCharges")
			print(mod.dump(tableArg), key, amount)
			return
		end
		return base(tableArg, key, amount)
	end)
end)

modutil.mod.Path.Context.Env("SkullImpulseTransform", function (weaponData, functionArgs, triggerArgs)
	modutil.mod.Path.Wrap("GetHeroTrait", function (base, traitName)
		return GetHeroTraitWrap(base, traitName, "LobImpulseAspect")
	end)
end)

modutil.mod.Path.Context.Env("ChargeSkullImpulse", function (victim, args, triggerArgs)
	modutil.mod.Path.Wrap("GetHeroTrait", function (base, traitName)
		return GetHeroTraitWrap(base, traitName, "LobImpulseAspect")
	end)
end)

modutil.mod.Path.Context.Env("UpdateLobUI", function ( spellItem, args, user )
	modutil.mod.Path.Wrap("HeroHasTrait", function (base, traitName)
		return HeroHasTraitWrap(base, traitName, "LobImpulseAspect")
	end)
end)

modutil.mod.Path.Context.Env("EmptyThrowCharge", function ( weaponName, stageReached )
	modutil.mod.Path.Wrap("HeroHasTrait", function (base, traitName)
		return HeroHasTraitWrap(base, traitName, "LobImpulseAspect")
	end)
	modutil.mod.Path.Wrap("GetHeroTrait", function (base, traitName)
		return GetHeroTraitWrap(base, traitName, "LobImpulseAspect")
	end)
end)

modutil.mod.Path.Context.Env("CheckSkullImpulseStart", function ()
	modutil.mod.Path.Wrap("GetHeroTrait", function (base, traitName)
		return GetHeroTraitWrap(base, traitName, "LobImpulseAspect")
	end)
end)

modutil.mod.Path.Context.Env("ModUtil.Hades.Triggers.OnHit.CombatLogic.1.Call", function ()
	modutil.mod.Path.Wrap("GetHeroTrait", function (base, traitName)
		return GetHeroTraitWrap(base, traitName, "DaggerBlockAspect")
	end)
	modutil.mod.Path.Wrap("HeroHasTrait", function (base, traitName)
		return HeroHasTraitWrap(base, traitName, "DaggerBlockAspect")
	end)
end)

modutil.mod.Path.Context.Env("ModUtil.Hades.Triggers.OnBlinkFinished.WeaponLogic.2.Call", function (triggerArgs)
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

modutil.mod.Path.Context.Env("TorchPrimaryAutofire", function ()
	modutil.mod.Path.Wrap("HasMarker", function (base, args)
		if args.Id == game.CurrentRun.Hero.ObjectId and
			  game.Contains({"WeaponHecateL_Rig:flame03_C_joint", "WeaponHecateR_Rig:flame03_C_joint"}, args.Name) and
		      not game.CurrentRun.Hero.Weapons["WeaponTorchSpecial"] then
			return true
		end
		return base(args)
	end)
end)

modutil.mod.Path.Context.Env("CheckProjectileSpawn", function ()
	modutil.mod.Path.Wrap("CreateProjectileFromUnit", function (base, args)
		-- if string.match(args.WeaponName, "WeaponDagger") then
		-- 	args.AttachToTarget = true
		-- end
		if game.Contains({"ProjectileSuitGrenade", "ProjectileSuitGrenadeStraight"}, args.Name) then
			args.AttachToTarget = true
		end
		if args.Name == "ProjectileLobSpecialBounce" then
			args.ImpactIgnoresFromId = nil
			args.Angle = math.random(0,360)
		end
		local projectileId = base(args)
		if args.WeaponName ~= "WeaponSuitRanged" or game.Contains({"ProjectileSuitGrenade", "ProjectileSuitGrenadeStraight"}, args.Name) then
			game.SessionMapState.InvalidSplitIds[projectileId] = true
		end
		return projectileId
	end)
end)