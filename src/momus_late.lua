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

local blockDualMoonShot = false

modutil.mod.Path.Context.Env("StartSpecialRepeatThread", function ()
	modutil.mod.Path.Wrap("GetDerivedPropertyChangeValues", function (base, ...)
		local derivedValues = base(...)
		if game.HeroHasTrait("StaffRaiseDeadAspect_Secondary") or game.HeroHasTrait("StaffRaiseDeadAspect") then
			derivedValues.PropertyChanges.DamageRadius = 435
			derivedValues.PropertyChanges.Damage = 110
		end
		if game.HeroHasTrait("DaggerHomingThrowAspect") and game.HeroHasTrait("StaffSelfHitAspect_Secondary") and game.HeroHasTrait("StaffTripleShotTrait") then
			derivedValues.PropertyChanges.Range = 528
		end
		return derivedValues
	end)
	modutil.mod.Path.Wrap("CreateProjectileFromUnit", function (base, args)
		local locals = modutil.mod.Locals.Stacked(3)
		local triggerArgs = locals.triggerArgs
		local angle = args.Angle
		if game.HeroHasTrait("DaggerHomingThrowAspect") and game.HeroHasTrait("StaffSelfHitAspect_Secondary") then
			local projId
			if not blockDualMoonShot or not game.HeroHasTrait("StaffTripleShotTrait") then
				local numProjectiles = triggerArgs.NumProjectiles
				local angleIncrement = 15
				local centerOffset = 0
				if numProjectiles % 2 == 0 then
					centerOffset = angleIncrement/2
				end
				local start = 1
				if numProjectiles % 2 == 1 then
					args.Angle = angle
					projId = base(args)
					game.wait(0.03)
					start = 2
				end

				for i = start, numProjectiles do
					local angleOffset = (centerOffset + (math.floor(i/2))*angleIncrement) * (-1)^i
					if numProjectiles % 2 == 0 then
						angleOffset = (centerOffset + (math.floor((i+1)/2)-1)*angleIncrement) * (-1)^i
					end
					args.Angle = angle + angleOffset
					projId = base(args)
					game.wait(0.03)
				end
			end
			blockDualMoonShot = not blockDualMoonShot
			return projId
		end
		return base(args)
	end)
end)