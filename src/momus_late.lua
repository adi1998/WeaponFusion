modutil.mod.Path.Context.Env("DoThrowEx", function (weaponName)
    modutil.mod.Path.Wrap("GetDerivedPropertyChangeValues", function (base, args)
        local derivedValues = base(args)
		-- record projectile co-ords for momus duplication
        if args.ProjectileName == "ProjectileThrowCharged" and game.HeroHasTrait("StaffSelfHitAspect") and game.SessionMapState[_PLUGIN.guid.."DoThrowExRecord"] then
            table.insert(game.SessionMapState[_PLUGIN.guid.."DoThrowExRecord"], {
                Angle = game.GetAngle({ Id = game.CurrentRun.Hero.ObjectId }),
                Location = game.GetLocation({ Id = game.CurrentRun.Hero.ObjectId }),
                Time = game._worldTime
            })
        end
		-- trigger eos duplication on base projectile creation (they're created just after this call)
        if args.ProjectileName == "ProjectileThrowCharged" and game.HeroHasTrait("TorchSprintRecallAspect") and game.SessionMapState.CurrentExProjectile then
            local angle_record = game.GetAngle({ Id = game.CurrentRun.Hero.ObjectId })
            local projectileName = "ProjectileThrowCharged"
            game.CreateProjectileFromUnit({
				WeaponName = "WeaponLobSpecial",
				Name = projectileName,
				Id = game.CurrentRun.Hero.ObjectId,
				ProjectileDestinationId = game.SessionMapState.CurrentExProjectile,
				FireFromTarget = true,
				Angle = angle_record + 90,
				DataProperties = derivedValues.PropertyChanges,
				ThingProperties = derivedValues.ThingPropertyChanges,
				ProjectileCap = 12
			})
			game.CreateProjectileFromUnit({
				WeaponName = "WeaponLobSpecial",
				Name = projectileName,
				Id = game.CurrentRun.Hero.ObjectId,
				ProjectileDestinationId = game.SessionMapState.CurrentExProjectile,
				FireFromTarget = true,
				Angle = angle_record - 90,
				DataProperties = derivedValues.PropertyChanges,
				ThingProperties = derivedValues.ThingPropertyChanges,
				ProjectileCap = 12
			})
        end
        return derivedValues
    end)
end)

modutil.mod.Path.Context.Env("StartCastRepeatThread", function (triggerArgs, functionArgs)
	modutil.mod.Path.Wrap("GetHeroTrait", function (base, traitName)
		return GetHeroTraitWrap(base, traitName, "StaffSelfHitAspect")
	end)
end)

modutil.mod.Path.Context.Env("WeaponCastFired", function (owner, weaponData, args, triggerArgs)
	modutil.mod.Path.Wrap("HeroHasTrait", function (base, traitName)
		return HeroHasTraitWrap(base, traitName, "StaffSelfHitAspect")
	end)
	modutil.mod.Path.Wrap("GetHeroTrait", function (base, traitName)
		return GetHeroTraitWrap(base, traitName, "StaffSelfHitAspect")
	end)
end)

modutil.mod.Path.Context.Env("StartSpecialRepeatThread", function (startX, startY, angle, functionArgs, triggerArgs)
	modutil.mod.Path.Wrap("GetDerivedPropertyChangeValues", function (base, ...)
		local derivedValues = base(...)
		if game.HeroHasTrait("StaffRaiseDeadAspect_Secondary") or game.HeroHasTrait("StaffRaiseDeadAspect") then
			derivedValues.PropertyChanges.DamageRadius = 435
			derivedValues.PropertyChanges.Damage = 110
		end
		return derivedValues
	end)
end)