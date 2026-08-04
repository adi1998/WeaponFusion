modutil.mod.Path.Context.Env("DoThrowEx", function (weaponName)
    modutil.mod.Path.Wrap("GetDerivedPropertyChangeValues", function (base, args)
        local derivedValues = base(args)
        if args.ProjectileName == "ProjectileThrowCharged" and game.HeroHasTrait("StaffSelfHitAspect") and game.SessionMapState[_PLUGIN.guid.."DoThrowExRecord"] then
            table.insert(game.SessionMapState[_PLUGIN.guid.."DoThrowExRecord"], {
                Angle = game.GetAngle({ Id = game.CurrentRun.Hero.ObjectId }),
                Location = game.GetLocation({ Id = game.CurrentRun.Hero.ObjectId }),
                Time = game._worldTime
            })
        end
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
		if traitName == "StaffSelfHitAspect" then
			return base(traitName) or base(traitName.."_Secondary")
		end
		return base(traitName)
	end)
end)

modutil.mod.Path.Context.Env("WeaponCastFired", function (owner, weaponData, args, triggerArgs)
	modutil.mod.Path.Wrap("HeroHasTrait", function (base, traitName)
		if traitName == "StaffSelfHitAspect" then
			return base(traitName) or base(traitName.."_Secondary")
		end
		return base(traitName)
	end)
	modutil.mod.Path.Wrap("GetHeroTrait", function (base, traitName)
		if traitName == "StaffSelfHitAspect" then
			return base(traitName) or base(traitName.."_Secondary")
		end
		return base(traitName)
	end)
end)