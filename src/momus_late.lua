modutil.mod.Path.Context.Wrap.Static("DoThrowEx", function (weaponName)
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
				WeaponName = weaponName,
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
				WeaponName = weaponName,
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