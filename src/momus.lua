function OffsetCoordinate(N, angle, axis, offset)
	if axis == "X" then
		return N+math.cos(math.rad(angle))*offset
	else
		return N-math.sin(math.rad(angle))*offset
	end
end

function mod.StartAxeSpecialRepeatThread(startX, startY, angle, args)
	args = args or {}
    local functionArgs, triggerArgs, weaponName = args[1], args[2], args[3]
	functionArgs.Repeats = functionArgs.Repeats or 3
	functionArgs.Interval = functionArgs.Interval or 3.5
	functionArgs.PreAttackDuration = functionArgs.PreAttackDuration or 0
	local projectileName = "ProjectileAxeBlock2"
	local threadName = "RepeatSpecialThread"
	local repeats = 1
	local weaponData = game.GetWeaponData( game.CurrentRun.Hero, weaponName )
	local traitData = game.GetHeroTrait("StaffSelfHitAspect")

	local derivedValues = game.GetDerivedPropertyChangeValues({
		ProjectileName = projectileName,
		WeaponName = weaponName,
		Type = "Projectile",
	})
	-- print(mod.dump(derivedValues))
	local logProjectileIdForMagicCrit = false
	if game.SessionMapState.DifferentOmegaVolleys[weaponName] and game.SessionMapState.DifferentOmegaVolleys[weaponName][triggerArgs.ProjectileVolley] then
		game.SessionMapState.DifferentOmegaProjectileIds[weaponName] = game.SessionMapState.DifferentOmegaProjectileIds[weaponName] or {}
		logProjectileIdForMagicCrit = true
	end

	while repeats < functionArgs.Repeats do
		game.waitUnmodified(functionArgs.Interval - functionArgs.PreAttackDuration, threadName )
		if functionArgs.AttackAnimationName then
			game.SetAnimation({ Name = functionArgs.AttackAnimationName, DestinationId = game.SessionMapState.OriginMarkers[weaponName] })
		end
		game.waitUnmodified(functionArgs.PreAttackDuration, threadName )
		if (game.CurrentRun.Hero.IsDead and (not game.CurrentHubRoom or not game.CurrentHubRoom.AllowEnemyAIActive)) or ( game.CurrentRun.CurrentRoom.Encounter and game.CurrentRun.CurrentRoom.Encounter.BossKillPresentation ) then
			break
		end
		if not game.HeroHasTrait("AxeRallyAspect_Secondary") then
			local offset = 90
			local dropLocation1 = game.SpawnObstacle({ Name = "InvisibleTarget", LocationX = OffsetCoordinate(startX, angle, "X", offset), LocationY = OffsetCoordinate(startY, angle, "Y", offset) })
			offset = offset + 460
			local dropLocation2 = game.SpawnObstacle({ Name = "InvisibleTarget", LocationX = OffsetCoordinate(startX, angle, "X", offset), LocationY = OffsetCoordinate(startY, angle, "Y", offset) })
			offset = offset + 460
			local dropLocation3 = game.SpawnObstacle({ Name = "InvisibleTarget", LocationX = OffsetCoordinate(startX, angle, "X", offset), LocationY = OffsetCoordinate(startY, angle, "Y", offset) })
			game.CreateProjectileFromUnit({ WeaponName = weaponName, Name = projectileName, Id = game.CurrentRun.Hero.ObjectId, DestinationId = dropLocation1, DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges, FireFromTarget = true, Angle = angle })
			game.waitUnmodified(0.2, threadName)
			game.CreateProjectileFromUnit({ WeaponName = weaponName, Name = projectileName, Id = game.CurrentRun.Hero.ObjectId, DestinationId = dropLocation2, DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges, FireFromTarget = true, Angle = angle })
			game.waitUnmodified(0.2, threadName)
			game.CreateProjectileFromUnit({ WeaponName = weaponName, Name = projectileName, Id = game.CurrentRun.Hero.ObjectId, DestinationId = dropLocation3, DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges, FireFromTarget = true, Angle = angle })
			game.Destroy({Id = dropLocation1 })
			game.Destroy({Id = dropLocation2 })
			game.Destroy({Id = dropLocation3 })
		else
			local dropLocation = game.SpawnObstacle({ Name = "InvisibleTarget", LocationX = startX, LocationY = startY })
			game.CreateProjectileFromUnit({ WeaponName = weaponName, Name = projectileName, Id = game.CurrentRun.Hero.ObjectId, DestinationId = dropLocation, DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges, FireFromTarget = true, Angle = angle })
			game.waitUnmodified(0.4, threadName)
			derivedValues.PropertyChanges.DamageRadius = derivedValues.PropertyChanges.DamageRadius * 1.33
			game.CreateProjectileFromUnit({ WeaponName = weaponName, Name = projectileName, Id = game.CurrentRun.Hero.ObjectId, DestinationId = dropLocation, DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges, FireFromTarget = true, Angle = angle })
			game.waitUnmodified(0.4, threadName)
			derivedValues.PropertyChanges.DamageRadius = derivedValues.PropertyChanges.DamageRadius * 1.66 / 1.33
			game.CreateProjectileFromUnit({ WeaponName = weaponName, Name = projectileName, Id = game.CurrentRun.Hero.ObjectId, DestinationId = dropLocation, DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges, FireFromTarget = true, Angle = angle })
			game.Destroy({Id = dropLocation })
			derivedValues.PropertyChanges.DamageRadius = derivedValues.PropertyChanges.DamageRadius / 1.66
		end
		repeats = repeats + 1
	end
	game.wait( 0.5 ) -- Wait for final attack animation to finish before playing Expiring Animation
	local id = game.SessionMapState.OriginMarkers[weaponName]
	game.SetAnimation({ Name = functionArgs.ExpiringAnimationName, DestinationId = id })
	game.thread( game.DestroyOnDelay, {id} , functionArgs.DestroyDelay )

	game.SessionMapState.OriginMarkers[weaponName] = nil
end

function mod.StartDaggerSpecialRepeatThread(startX, startY, angle, args)
	args = args or {}
    local functionArgs, triggerArgs, weaponName = args[1], args[2], args[3]
	functionArgs.Repeats = functionArgs.Repeats or 3
	functionArgs.Interval = functionArgs.Interval or 3.5
	functionArgs.PreAttackDuration = functionArgs.PreAttackDuration or 0
	local projectileName = "ProjectileDaggerThrowCharged"
	local threadName = "RepeatSpecialThread"
	local repeats = 1
	local weaponData = game.GetWeaponData( game.CurrentRun.Hero, weaponName )
	local traitData = game.GetHeroTrait("StaffSelfHitAspect")
	local numProjectiles = triggerArgs.NumProjectiles
	local derivedValues = game.GetDerivedPropertyChangeValues({
		ProjectileName = projectileName,
		WeaponName = weaponName,
		Type = "Projectile",
	})

	local daggerProjectileInterval = 0.08
	if game.HeroHasTrait("DaggerSpecialFanTrait") then
		daggerProjectileInterval = 0.04
	end

	local angleIncrement = 12
	if game.HeroHasTrait("DaggerTripleAspect_Secondary") or game.HeroHasTrait("DaggerTripleAspect") then
		angleIncrement = math.deg(angleIncrement)
	end
	if game.HeroHasTrait("DaggerSpecialLineTrait") then
		angleIncrement = 0
	end
	local logProjectileIdForMagicCrit = false
	if game.SessionMapState.DifferentOmegaVolleys[weaponName] and game.SessionMapState.DifferentOmegaVolleys[weaponName][triggerArgs.ProjectileVolley] then
		game.SessionMapState.DifferentOmegaProjectileIds[weaponName] = game.SessionMapState.DifferentOmegaProjectileIds[weaponName] or {}
		logProjectileIdForMagicCrit = true
	end
	while repeats < functionArgs.Repeats do
		game.waitUnmodified(functionArgs.Interval - functionArgs.PreAttackDuration, threadName )
		if functionArgs.AttackAnimationName then
			game.SetAnimation({ Name = functionArgs.AttackAnimationName, DestinationId = game.SessionMapState.OriginMarkers[weaponName] })
		end
		if (game.CurrentRun.Hero.IsDead and (not game.CurrentHubRoom or not game.CurrentHubRoom.AllowEnemyAIActive)) or ( game.CurrentRun.CurrentRoom.Encounter and game.CurrentRun.CurrentRoom.Encounter.BossKillPresentation ) then
			break
		end
		game.waitUnmodified(functionArgs.PreAttackDuration, threadName )
		local dropLocation = game.SpawnObstacle({ Name = "InvisibleTarget", LocationX = startX, LocationY = startY })
		local centerOffset = 0

		if numProjectiles % 2 == 0 then
			centerOffset = angleIncrement/2
		end

		local start = 1
		if numProjectiles % 2 == 1 then
			game.CreateProjectileFromUnit({ WeaponName = weaponName,
				Name = projectileName,
				Id = game.CurrentRun.Hero.ObjectId,
				DestinationId = dropLocation,
				FireFromTarget = true,
				DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges, Angle = angle
			})
			-- print(angle)
			game.waitUnmodified(daggerProjectileInterval, threadName)
			start = 2
		end

		for i = start, numProjectiles do
			local angleOffset = (centerOffset + (math.floor(i/2))*angleIncrement) * (-1)^i
			if numProjectiles % 2 == 0 then
				angleOffset = (centerOffset + (math.floor((i+1)/2)-1)*angleIncrement) * (-1)^i
			end
			game.CreateProjectileFromUnit({ WeaponName = weaponName,
				Name = projectileName,
				Id = game.CurrentRun.Hero.ObjectId,
				DestinationId = dropLocation,
				FireFromTarget = true,
				DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges, Angle = angle + angleOffset
			})
			-- print(angleOffset)
			game.waitUnmodified(daggerProjectileInterval, threadName)
		end
		game.Destroy({Id = dropLocation })
		repeats = repeats + 1
	end
	game.wait( 0.5 ) -- Wait for final attack animation to finish before playing Expiring Animation
	local id = game.SessionMapState.OriginMarkers[weaponName]
	game.SetAnimation({ Name = functionArgs.ExpiringAnimationName, DestinationId = id })
	game.thread( game.DestroyOnDelay, {id} , functionArgs.DestroyDelay )

	game.SessionMapState.OriginMarkers[weaponName] = nil
end

function mod.StartSuitSpecialRepeatThread(startX, startY, angle, args)
	args = args or {}
    local functionArgs, triggerArgs, weaponName = args[1], args[2], args[3]
	functionArgs.Repeats = functionArgs.Repeats or 3
	functionArgs.Interval = functionArgs.Interval or 3.5
	functionArgs.PreAttackDuration = functionArgs.PreAttackDuration or 0
	local projectileName = "ProjectileSuitBomb"
	if game.HeroHasTrait("SuitComboForwardRocketTrait") then
		projectileName = "ProjectileSuitBombStraight"
	end
	if not game.HeroHasTrait("SuitComboAspect_Secondary") then
		projectileName = "ProjectileSuitRangedUnguided"
	end
	local threadName = "RepeatSpecialThread"
	local repeats = 1
	local weaponData = game.GetWeaponData( game.CurrentRun.Hero, weaponName )
	local traitData = game.GetHeroTrait("StaffSelfHitAspect")
	local numProjectiles = 4
	local derivedValues = game.GetDerivedPropertyChangeValues({
		ProjectileName = projectileName,
		WeaponName = weaponName,
		Type = "Projectile",
	})
	local logProjectileIdForMagicCrit = false
	if game.SessionMapState.DifferentOmegaVolleys[weaponName] and game.SessionMapState.DifferentOmegaVolleys[weaponName][triggerArgs.ProjectileVolley] then
		game.SessionMapState.DifferentOmegaProjectileIds[weaponName] = game.SessionMapState.DifferentOmegaProjectileIds[weaponName] or {}
		logProjectileIdForMagicCrit = true
	end
	while repeats < functionArgs.Repeats do
		game.waitUnmodified(functionArgs.Interval - functionArgs.PreAttackDuration, threadName )
		if functionArgs.AttackAnimationName then
			game.SetAnimation({ Name = functionArgs.AttackAnimationName, DestinationId = game.SessionMapState.OriginMarkers[weaponName] })
		end
		if (game.CurrentRun.Hero.IsDead and (not game.CurrentHubRoom or not game.CurrentHubRoom.AllowEnemyAIActive)) or ( game.CurrentRun.CurrentRoom.Encounter and game.CurrentRun.CurrentRoom.Encounter.BossKillPresentation ) then
			break
		end
		game.waitUnmodified(functionArgs.PreAttackDuration, threadName )
		local dropLocation = game.SpawnObstacle({ Name = "InvisibleTarget", LocationX = startX, LocationY = startY })
		if projectileName ~= "ProjectileSuitRangedUnguided" then
			game.CreateProjectileFromUnit({ WeaponName = weaponName,
				Name = projectileName,
				Id = game.CurrentRun.Hero.ObjectId,
				DestinationId = dropLocation,
				FireFromTarget = true,
				DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges, Angle = angle
			})
		else
			for _ = 1, numProjectiles do
				game.CreateProjectileFromUnit({ WeaponName = weaponName,
					Name = projectileName,
					Id = game.CurrentRun.Hero.ObjectId,
					DestinationId = dropLocation,
					FireFromTarget = true,
					DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges, Angle = angle + math.random(-120,120),
				})
				game.waitUnmodified(0.07, threadName)
			end
		end
		game.Destroy({Id = dropLocation })
		repeats = repeats + 1
	end
	game.wait( 0.5 ) -- Wait for final attack animation to finish before playing Expiring Animation
	local id = game.SessionMapState.OriginMarkers[weaponName]
	game.SetAnimation({ Name = functionArgs.ExpiringAnimationName, DestinationId = id })
	game.thread( game.DestroyOnDelay, {id} , functionArgs.DestroyDelay )

	game.SessionMapState.OriginMarkers[weaponName] = nil
end

function mod.StartTorchSpecialRepeatThread(startX, startY, angle, args)
	args = args or {}
    local functionArgs, triggerArgs, weaponName = args[1], args[2], args[3]
	functionArgs.Repeats = functionArgs.Repeats or 3
	functionArgs.Interval = functionArgs.Interval or 3.5
	functionArgs.PreAttackDuration = functionArgs.PreAttackDuration or 0
	local projectileName = "ProjectileTorchOrbitEx"
	local threadName = "RepeatSpecialThread"
	local repeats = 1
	local weaponData = game.GetWeaponData( game.CurrentRun.Hero, weaponName )
	local traitData = game.GetHeroTrait("StaffSelfHitAspect")
	local numProjectiles = triggerArgs.NumProjectiles or 2
	local derivedValues = game.GetDerivedPropertyChangeValues({
		ProjectileName = projectileName,
		WeaponName = weaponName,
		Type = "Projectile",
		MatchProjectileName = true,
	})
	-- print(mod.dump(triggerArgs))
	-- print(mod.dump(derivedValues))
	local projectileIds = {}
	while repeats < functionArgs.Repeats do
		game.waitUnmodified(functionArgs.Interval - functionArgs.PreAttackDuration, threadName )
		if functionArgs.AttackAnimationName then
			game.SetAnimation({ Name = functionArgs.AttackAnimationName, DestinationId = game.SessionMapState.OriginMarkers[weaponName] })
		end
		if (game.CurrentRun.Hero.IsDead and (not game.CurrentHubRoom or not game.CurrentHubRoom.AllowEnemyAIActive)) or ( game.CurrentRun.CurrentRoom.Encounter and game.CurrentRun.CurrentRoom.Encounter.BossKillPresentation ) then
			break
		end
		game.waitUnmodified(functionArgs.PreAttackDuration, threadName )
		local dropLocation = game.SpawnObstacle({ Name = "BlankObstacle", LocationX = startX, LocationY = startY})

		local projectileId = game.CreateProjectileFromUnit({
			Name = "1_BaseDamagingProjectile",
			Id = game.CurrentRun.Hero.ObjectId,
			DestinationId = dropLocation,
			FireFromTarget = true,
		})
		table.insert(projectileIds, projectileId)
		for i = 1, numProjectiles do
			local torchOrbitId = game.CreateProjectileFromUnit({ WeaponName = weaponName,
				Name = projectileName,
				Id = game.CurrentRun.Hero.ObjectId,
				ProjectileDestinationId = projectileId,
				FireFromTarget = true,
				AttachToTarget = true,
				DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges, Angle = angle + i*360/numProjectiles + 90*repeats
			})
			table.insert(projectileIds, torchOrbitId)
		end
		game.Destroy({Id = dropLocation })
		repeats = repeats + 1
	end
	game.wait( 1.2, threadName ) -- Wait for final attack animation to finish before playing Expiring Animation
	local id = game.SessionMapState.OriginMarkers[weaponName]
	game.SetAnimation({ Name = functionArgs.ExpiringAnimationName, DestinationId = id })
	game.thread( game.DestroyOnDelay, {id} , functionArgs.DestroyDelay )
	game.ExpireProjectiles({ ProjectileIds = projectileIds })
	game.SessionMapState.OriginMarkers[weaponName] = nil
end

function mod.StartLobSpecialRepeatThread(startX, startY, angle, args)
	args = args or {}
    local functionArgs, triggerArgs, weaponName = args[1], args[2], args[3]
	functionArgs.Repeats = functionArgs.Repeats or 3
	functionArgs.Interval = functionArgs.Interval or 3.5
	functionArgs.PreAttackDuration = functionArgs.PreAttackDuration or 0
	local projectileName = "ProjectileThrowCharged"
	local threadName = "RepeatSpecialThread"
	local repeats = 1
	local weaponData = game.GetWeaponData( game.CurrentRun.Hero, weaponName )
	local traitData = game.GetHeroTrait("StaffSelfHitAspect")

	local derivedValues = game.GetDerivedPropertyChangeValues({
		ProjectileName = projectileName,
		WeaponName = weaponName,
		Type = "Projectile",
		MatchProjectileName = true,
	})
	while repeats < functionArgs.Repeats do
		game.waitUnmodified(functionArgs.Interval - functionArgs.PreAttackDuration, threadName )
		if functionArgs.AttackAnimationName then
			game.SetAnimation({ Name = functionArgs.AttackAnimationName, DestinationId = game.SessionMapState.OriginMarkers[weaponName] })
		end
		if (game.CurrentRun.Hero.IsDead and (not game.CurrentHubRoom or not game.CurrentHubRoom.AllowEnemyAIActive)) or ( game.CurrentRun.CurrentRoom.Encounter and game.CurrentRun.CurrentRoom.Encounter.BossKillPresentation ) then
			break
		end
		game.waitUnmodified(functionArgs.PreAttackDuration, threadName )
		local dropLocations = {}
		local index = 1
		local ex_interval = 0
		local time
		while game.SessionMapState[_PLUGIN.guid.."DoThrowExRecord"] and game.SessionMapState[_PLUGIN.guid.."DoThrowExRecord"][index] do
			local throwExRecord = game.SessionMapState[_PLUGIN.guid.."DoThrowExRecord"][index]
			if time then
				ex_interval = throwExRecord.Time-time
			end
			game.waitUnmodified(ex_interval, threadName)
			local angle_record = throwExRecord.Angle
			local location = throwExRecord.Location
			time = throwExRecord.Time
			local dropLocation = game.SpawnObstacle({ Name = "BlankObstacle", LocationX = location.X, LocationY = location.Y})
			table.insert(dropLocations, dropLocation)
			game.CreateProjectileFromUnit({
				WeaponName = weaponName,
				Name = projectileName,
				Id = game.CurrentRun.Hero.ObjectId,
				DestinationId = dropLocation,
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
				DestinationId = dropLocation,
				FireFromTarget = true,
				Angle = angle_record - 90,
				DataProperties = derivedValues.PropertyChanges,
				ThingProperties = derivedValues.ThingPropertyChanges,
				ProjectileCap = 12
			})
			index = index + 1
		end
		game.Destroy({Ids = dropLocations })
		repeats = repeats + 1
	end
	game.wait( 0.5 ) -- Wait for final attack animation to finish before playing Expiring Animation
	local id = game.SessionMapState.OriginMarkers[weaponName]
	game.SetAnimation({ Name = functionArgs.ExpiringAnimationName, DestinationId = id })
	game.thread( game.DestroyOnDelay, {id} , functionArgs.DestroyDelay )

	game.SessionMapState.OriginMarkers[weaponName] = nil
end

function mod.StartDaggerPrimaryRepeatThread() end
function mod.StartTorchPrimaryRepeatThread() end
function mod.StartAxePrimaryRepeatThread() end
function mod.StartSkullPrimaryRepeatThread() end
function mod.StartSuitPrimaryRepeatThread() end


mod.WeaponThreadMap = {
	["WeaponDagger5"] = mod.StartDaggerPrimaryRepeatThread,
	["WeaponTorch"] = mod.StartTorchPrimaryRepeatThread,
	["WeaponAxeSpin"] = mod.StartAxePrimaryRepeatThread,
	["WeaponLob"] = mod.StartSkullPrimaryRepeatThread,
	["WeaponSuitCharged"] = mod.StartSuitPrimaryRepeatThread,
}

mod.SpecialWeaponThreadMap = {
	["WeaponAxeSpecialSwing"] = mod.StartAxeSpecialRepeatThread,
	["WeaponDaggerThrow"] = mod.StartDaggerSpecialRepeatThread,
	["WeaponSuitRanged"] = mod.StartSuitSpecialRepeatThread,
	["WeaponTorchSpecial"] = mod.StartTorchSpecialRepeatThread,
	["WeaponLobSpecial"] = mod.StartLobSpecialRepeatThread,
}

modutil.mod.Path.Wrap("DropOriginMarker", function (base, weaponData, functionArgs, triggerArgs )
	if mod.SpecialWeaponThreadMap[weaponData.Name] or mod.WeaponThreadMap[weaponData.Name] then
        if game.IsExWeapon( weaponData.Name, { Combat = true }, triggerArgs ) or triggerArgs.DisjointExCast then
            -- print(mod.dump(weaponData))
            -- print(mod.dump(triggerArgs))
            local playerLocation = game.GetLocation({ Id = game.CurrentRun.Hero.ObjectId })
            local startX = triggerArgs.ProjectileX or playerLocation.X
            local startY = triggerArgs.ProjectileY or playerLocation.Y
            local weaponName = weaponData.Name
            if mod.SpecialWeaponThreadMap[weaponName] or mod.WeaponThreadMap[weaponName] then
                game.SessionMapState.OriginMarkers = game.SessionMapState.OriginMarkers or {}
                if game.SessionMapState.OriginMarkers[weaponName] then
                    game.Destroy({ Id = game.SessionMapState.OriginMarkers[weaponName] })
                end
            end
            if  mod.SpecialWeaponThreadMap[weaponName] then
                local threadName = "RepeatSpecialThread"
                if game.HasThread( threadName ) then
                    game.killTaggedThreads( threadName )
                    game.waitUnmodified(0.1)
                    local id = game.SessionMapState.OriginMarkers[weaponName]
                    game.SessionMapState.OriginMarkers[weaponName] = nil
                    game.SetAnimation({ Name = functionArgs.ExpiringAnimationName, DestinationId = id })
                    game.thread( game.DestroyOnDelay, {id} , functionArgs.DestroyDelay )
                end
                game.thread(mod.SpecialWeaponThreadMap[weaponName], startX, startY, game.GetAngle({Id = game.CurrentRun.Hero.ObjectId}), {functionArgs, triggerArgs, weaponName} )
            end
			if  mod.WeaponThreadMap[weaponName] then
				local threadName = "RepeatWeaponThread"
				if game.HasThread( threadName ) then
                    game.killTaggedThreads( threadName )
                    game.waitUnmodified(0.1)
                    local id = game.SessionMapState.OriginMarkers[weaponName]
                    game.SessionMapState.OriginMarkers[weaponName] = nil
                    game.SetAnimation({ Name = functionArgs.ExpiringAnimationName, DestinationId = id })
                    game.thread( game.DestroyOnDelay, {id} , functionArgs.DestroyDelay )
                end
                game.thread(mod.WeaponThreadMap[weaponName], startX, startY, game.GetAngle({Id = game.CurrentRun.Hero.ObjectId}), {functionArgs, triggerArgs, weaponName} )
			end
            local zOffset = 90

            local originMarkerId = game.SpawnObstacle({ Name = "BlankObstacle", Group = "FX_Standing", LocationX = startX, LocationY = startY, OffsetZ = zOffset })
            game.SetAngle({ Id = originMarkerId, Angle = game.GetAngle({Id = game.CurrentRun.Hero.ObjectId}) })
            game.SetAnimation({ Name = functionArgs.AnimationName, DestinationId = originMarkerId })
            game.SessionMapState.OriginMarkers[weaponName] = originMarkerId
        end
    elseif weaponData.Name ~= "WeaponLobChargedPulse" then
        base(weaponData, functionArgs, triggerArgs)
    end
end)

modutil.mod.Path.Wrap("DoThrowEx", function (base, weaponName)
	if game.HeroHasTrait("StaffSelfHitAspect") then
		game.SessionMapState[_PLUGIN.guid.."DoThrowExRecord"] = {}
	end
	return base(weaponName)
end)