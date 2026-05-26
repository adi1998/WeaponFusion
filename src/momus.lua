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
	if game.HeroHasTrait("LobGunAspect_Secondary") then
		projectileName = "ProjectileLobGunRift"
	end
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
		if projectileName == "ProjectileThrowCharged" then
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
		else
			derivedValues = game.GetDerivedPropertyChangeValues({
				ProjectileName = projectileName,
				WeaponName = weaponName,
				Type = "Projectile",
			})
			local dropLocation = game.SpawnObstacle({ Name = "InvisibleTarget", LocationX = startX, LocationY = startY })
			game.CreateProjectileFromUnit({ WeaponName = weaponName, Name = projectileName, Id = game.CurrentRun.Hero.ObjectId, DestinationId = dropLocation, DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges, FireFromTarget = true, Angle = angle })
			game.Destroy({Id = dropLocation })
		end
		repeats = repeats + 1
	end
	game.wait( 0.5 ) -- Wait for final attack animation to finish before playing Expiring Animation
	local id = game.SessionMapState.OriginMarkers[weaponName]
	game.SetAnimation({ Name = functionArgs.ExpiringAnimationName, DestinationId = id })
	game.thread( game.DestroyOnDelay, {id} , functionArgs.DestroyDelay )

	game.SessionMapState.OriginMarkers[weaponName] = nil
end

function mod.StartTorchPrimaryRepeatThread(startX, startY, angle, args)
	args = args or {}
    local functionArgs, triggerArgs, weaponName = args[1], args[2], args[3]
	functionArgs.Repeats = functionArgs.Repeats or 3
	functionArgs.Interval = functionArgs.Interval or 3.5
	functionArgs.PreAttackDuration = functionArgs.PreAttackDuration or 0
	local projectileName = "ProjectileTorchWave"
	if game.HeroHasTrait("TorchDetonateAspect") then
		projectileName = "ProjectileTorchGhostLarge"
	elseif game.HeroHasTrait("TorchSprintRecallAspect") then
		projectileName = "ProjectileTorchRepeatStrike"
	end
	local threadName = "RepeatWeaponThread"
	local repeats = 1
	local weaponData = game.GetWeaponData( game.CurrentRun.Hero, weaponName )
	local traitData = game.GetHeroTrait("StaffSelfHitAspect")

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
		game.waitUnmodified(functionArgs.PreAttackDuration, threadName )
		if (game.CurrentRun.Hero.IsDead and (not game.CurrentHubRoom or not game.CurrentHubRoom.AllowEnemyAIActive)) or ( game.CurrentRun.CurrentRoom.Encounter and game.CurrentRun.CurrentRoom.Encounter.BossKillPresentation ) then
			break
		end
		local dropLocation = game.SpawnObstacle({ Name = "InvisibleTarget", LocationX = startX, LocationY = startY })
		local nearestEnemyId = game.GetClosest({ Id = dropLocation, DestinationName = "EnemyTeam", IgnoreInvulnerable = true, IgnoreHomingIneligible = true, StopsProjectiles = true, Distance = 1000 })
		if nearestEnemyId and nearestEnemyId ~= 0 then
			angle = game.GetAngleBetween({Id = nearestEnemyId, DestinationId = dropLocation})
		end
		game.CreateProjectileFromUnit({ WeaponName = weaponName, Name = projectileName, Id = game.CurrentRun.Hero.ObjectId, DestinationId = dropLocation, DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges, FireFromTarget = true, Angle = angle })
		game.Destroy({Id = dropLocation })
		repeats = repeats + 1
	end
	game.wait( 0.5 ) -- Wait for final attack animation to finish before playing Expiring Animation
	local id = game.SessionMapState.OriginMarkers[weaponName]
	game.SetAnimation({ Name = functionArgs.ExpiringAnimationName, DestinationId = id })
	game.thread( game.DestroyOnDelay, {id} , functionArgs.DestroyDelay )

	game.SessionMapState.OriginMarkers[weaponName] = nil
end

function mod.StartAxePrimaryRepeatThread(startX, startY, angle, args)
	args = args or {}
    local functionArgs, triggerArgs, weaponName = args[1], args[2], args[3]
	functionArgs.Repeats = functionArgs.Repeats or 3
	functionArgs.Interval = functionArgs.Interval or 3.5
	functionArgs.PreAttackDuration = functionArgs.PreAttackDuration or 0
	local projectileName = "ProjectileAxeSpin"

	local projectileInterval = 0.22
	local scaleIncrement = 0
	local damageMultiplier = 1
	local numProjectiles = triggerArgs.NumProjectiles or 5
	numProjectiles = math.min(numProjectiles or 7)

	if game.HeroHasTrait("AxeRallyAspect") then
		projectileInterval = 0.44
		scaleIncrement = 0.15
		damageMultiplier = 2
		if numProjectiles == 1 then
			damageMultiplier = 3
		end
	end

	local threadName = "RepeatWeaponThread"
	local repeats = 1
	local scale = 1
	local weaponData = game.GetWeaponData( game.CurrentRun.Hero, weaponName )
	local traitData = game.GetHeroTrait("StaffSelfHitAspect")

	local derivedValues = game.GetDerivedPropertyChangeValues({
		ProjectileName = projectileName,
		WeaponName = weaponName,
		Type = "Projectile",
	})
	while repeats < functionArgs.Repeats do
		game.waitUnmodified(functionArgs.Interval - functionArgs.PreAttackDuration, threadName )
		if functionArgs.AttackAnimationName then
			game.SetAnimation({ Name = functionArgs.AttackAnimationName, DestinationId = game.SessionMapState.OriginMarkers[weaponName] })
		end
		game.waitUnmodified(functionArgs.PreAttackDuration, threadName )
		if (game.CurrentRun.Hero.IsDead and (not game.CurrentHubRoom or not game.CurrentHubRoom.AllowEnemyAIActive)) or ( game.CurrentRun.CurrentRoom.Encounter and game.CurrentRun.CurrentRoom.Encounter.BossKillPresentation ) then
			break
		end
		local dropLocation = game.SpawnObstacle({ Name = "InvisibleTarget", LocationX = startX, LocationY = startY })
		for i = 1, numProjectiles do
			game.SessionMapState[_PLUGIN.guid .. "MomusAxeCurrentProjectileIndex"] = i
			derivedValues.PropertyChanges.DamageRadius = 410 * scale
			derivedValues.PropertyChanges.Damage = 50 * damageMultiplier
			game.CreateProjectileFromUnit({ WeaponName = "WeaponAxeSpin",
				Name = projectileName,
				Id = game.CurrentRun.Hero.ObjectId,
				DestinationId = dropLocation,
				DataProperties = derivedValues.PropertyChanges,
				ThingProperties = derivedValues.ThingPropertyChanges,
				FireFromTarget = true,
				AttachToTarget = true,
				Angle = angle,
			})
			game.waitUnmodified(projectileInterval, threadName)
			scale = scale + scaleIncrement
		end
		game.Destroy({Id = dropLocation })
		repeats = repeats + 1
		scale = 1
	end
	game.wait( 0.5 ) -- Wait for final attack animation to finish before playing Expiring Animation
	local id = game.SessionMapState.OriginMarkers[weaponName]
	game.SetAnimation({ Name = functionArgs.ExpiringAnimationName, DestinationId = id })
	game.thread( game.DestroyOnDelay, {id} , functionArgs.DestroyDelay )
	game.SessionMapState.OriginMarkers[weaponName] = nil
end

function mod.GetClosestActiveEnemy(id, distance)
	local nearestEnemyTargetIds = game.GetClosestIds({ Id = id, DestinationName = "EnemyTeam", IgnoreUntargetable = false, IgnoreHomingIneligible = false, Distance = distance })
	for _, enemyId in pairs( nearestEnemyTargetIds ) do
		if game.ActiveEnemies[enemyId] then
			return enemyId
		end
	end
end

function mod.MarkAdditionalDaggerTarget(triggerArgs, weaponName, dropLocation, traitArgs)
	game.MapState[_PLUGIN.guid .. "AdditionalTargetIds"] = {}
	game.MapState[_PLUGIN.guid .. "AdditionalMarkIds"] = {}
	while game.MapState[_PLUGIN.guid .. "DaggerCharging"] do
		if game.MapState[_PLUGIN.guid .. "MarkDaggerEnemyId"] then
			local enemyIds = game.GetClosestIds({ Id = game.MapState[_PLUGIN.guid .. "MarkDaggerEnemyId"], DestinationName = "EnemyTeam", IgnoreSelf = true, StopsProjectiles = true, IgnoreInvulnerable = true, IgnoreHomingIneligible = true, Distance = traitArgs.Range })
			if not game.IsEmpty(enemyIds) then
				local retarget = game.IsEmpty( game.MapState[_PLUGIN.guid .. "AdditionalTargetIds"] )
				for _, id in pairs( game.MapState[_PLUGIN.guid .. "AdditionalTargetIds"] ) do
					if not game.Contains( enemyIds, id ) then
						retarget = true
					end
				end
				if retarget then
					game.Destroy({ Ids = game.MapState[_PLUGIN.guid .. "AdditionalMarkIds"] })
					game.MapState[_PLUGIN.guid .. "AdditionalTargetIds"] = {}
					game.MapState[_PLUGIN.guid .. "AdditionalMarkIds"] = {}
					local targetsUsed = 0
					for i, id in pairs(enemyIds) do
						if game.ActiveEnemies[id] and ( targetsUsed < traitArgs.AdditionalTargets or game.ActiveEnemies[id].ActiveEffects[traitArgs.IndicatorEffect]) then
							if not game.ActiveEnemies[id].ActiveEffects[traitArgs.IndicatorEffect] then
								targetsUsed = targetsUsed + 1
							end
							local markImage = game.SpawnObstacle({ Name = "BlankObstacle" })
							game.SetAnimation({ Name = _PLUGIN.guid .. "DaggerMarkStatus_Green", DestinationId = markImage })
							game.Attach({ Id = markImage, DestinationId = enemyIds[i] })
							table.insert( game.MapState[_PLUGIN.guid .. "AdditionalTargetIds"], enemyIds[i] )
							table.insert( game.MapState[_PLUGIN.guid .. "AdditionalMarkIds"], markImage )
						end
					end
				end
			end
			game.waitUnmodified(0.1, "RepeatWeaponThread")
		else
			game.Destroy({ Ids = game.MapState[_PLUGIN.guid .. "AdditionalMarkIds"] })
			game.MapState[_PLUGIN.guid .. "AdditionalTargetIds"] = {}
			game.MapState[_PLUGIN.guid .. "AdditionalMarkIds"] = {}
			game.waitUnmodified(0.1, "RepeatWeaponThread")
		end
	end
	game.Destroy({ Ids = game.MapState[_PLUGIN.guid .. "AdditionalMarkIds"] })
end

function mod.MarkDaggerTarget(triggerArgs, weaponData, dropLocation, args)
	game.MapState[_PLUGIN.guid .. "DaggerCharging"] = true
	if game.HeroHasTrait("DaggerTripleAspect") then
		game.thread( mod.MarkAdditionalDaggerTarget, triggerArgs, weaponData, dropLocation, game.GetHeroTrait("DaggerTripleAspect").DaggerAdditionalTargetData )
	end
	while game.MapState[_PLUGIN.guid .. "DaggerCharging"] do
		local targetId = mod.GetClosestActiveEnemy(dropLocation, 690)
		if targetId ~= 0 and game.ActiveEnemies[targetId] ~= nil and not game.ActiveEnemies[targetId].IsDead then
			if game.MapState[_PLUGIN.guid .. "MarkDaggerEnemyId"] ~= targetId then
				game.MapState[_PLUGIN.guid .. "MarkDaggerEnemyId"] = targetId
				if game.MapState[_PLUGIN.guid .. "MarkedDaggerTargetId"] then
					game.Destroy({ Id = game.MapState[_PLUGIN.guid .. "MarkedDaggerTargetId"]  })
				end
				game.MapState[_PLUGIN.guid .. "MarkedDaggerTargetId"] = game.SpawnObstacle({ Name = "BlankObstacle", DestinationId = targetId })
				game.SetAnimation({ Name = _PLUGIN.guid .. "DaggerMarkStatus_Green", DestinationId = game.MapState[_PLUGIN.guid .. "MarkedDaggerTargetId"], Scale = game.ActiveEnemies[targetId].DaggerExScale })
				game.Attach({ Id = game.MapState[_PLUGIN.guid .. "MarkedDaggerTargetId"], DestinationId = targetId, MarkerName = game.ActiveEnemies[targetId].DaggerExMarker })
				local notifyName = _PLUGIN.guid .. "WeaponDagger5Mark"
				game.NotifyOutsideDistance({ Id = dropLocation, Distance = 690, DestinationId = targetId, Notify = notifyName, Timeout = 0.1 })
				game.waitUntil( notifyName, "RepeatWeaponThread" )
			else
				game.waitUnmodified(0.1, "RepeatWeaponThread")
			end
		elseif game.MapState[_PLUGIN.guid .. "MarkedDaggerTargetId"] then
			game.Destroy({ Id = game.MapState[_PLUGIN.guid .. "MarkedDaggerTargetId"]  })
			game.MapState[_PLUGIN.guid .. "MarkDaggerEnemyId"] = nil
			game.waitUnmodified(0.1, "RepeatWeaponThread")
		else
			game.waitUnmodified(0.1, "RepeatWeaponThread")
		end
	end
end

function mod.StartDaggerPrimaryRepeatThread(startX, startY, angle, args)
	game.Destroy({ Id = game.MapState[_PLUGIN.guid.."MarkedDaggerTargetId"]  })
	game.Destroy({ Ids = game.MapState[_PLUGIN.guid .. "AdditionalMarkIds"]  })
	game.MapState[_PLUGIN.guid .. "MarkDaggerEnemyId"] = nil
	game.MapState[_PLUGIN.guid.."MarkedDaggerTargetId"] = nil
	game.MapState[_PLUGIN.guid .. "AdditionalTargetIds"] = {}
	game.MapState[_PLUGIN.guid .. "AdditionalMarkIds"] = {}

	args = args or {}
    local functionArgs, triggerArgs, weaponName = args[1], args[2], args[3]
	functionArgs.Repeats = functionArgs.Repeats or 3
	functionArgs.Interval = functionArgs.Interval or 3.5
	functionArgs.PreAttackDuration = functionArgs.PreAttackDuration or 0
	local projectileName = "ProjectileDaggerBackstab"
	if game.HeroHasTrait("DaggerTripleAspect") then
		projectileName = "ProjectileDaggerExecuteMorrigan"
	end
	local threadName = "RepeatWeaponThread"
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
		local autoTargetOrigin = game.SpawnObstacle({ Name = "InvisibleTarget", LocationX = startX, LocationY = startY })
		game.thread( mod.MarkDaggerTarget, triggerArgs, weaponData, autoTargetOrigin )
		game.waitUnmodified(functionArgs.Interval - functionArgs.PreAttackDuration, threadName )
		if functionArgs.AttackAnimationName then
			game.SetAnimation({ Name = functionArgs.AttackAnimationName, DestinationId = game.SessionMapState.OriginMarkers[weaponName] })
		end
		game.waitUnmodified(functionArgs.PreAttackDuration, threadName )
		if (game.CurrentRun.Hero.IsDead and (not game.CurrentHubRoom or not game.CurrentHubRoom.AllowEnemyAIActive)) or ( game.CurrentRun.CurrentRoom.Encounter and game.CurrentRun.CurrentRoom.Encounter.BossKillPresentation ) then
			break
		end
		local locX = startX
		local locY = startY
		if game.MapState[_PLUGIN.guid .. "MarkedDaggerTargetId"] then
			angle = game.GetAngleBetween({ DestinationId = game.MapState[_PLUGIN.guid .. "MarkedDaggerTargetId"], Id = autoTargetOrigin })
			local location = game.GetLocation({Id = game.MapState[_PLUGIN.guid .. "MarkedDaggerTargetId"]})
			locX = location.X
			locY = location.Y
		end
		local dropLocation = game.SpawnObstacle({ Name = "InvisibleTarget", LocationX = locX, LocationY = locY })
		game.CreateProjectileFromUnit({ WeaponName = weaponName,
			Name = projectileName,
			Id = game.CurrentRun.Hero.ObjectId,
			DestinationId = dropLocation,
			DataProperties = derivedValues.PropertyChanges,
			ThingProperties = derivedValues.ThingPropertyChanges,
			FireFromTarget = true,
			AttachToTarget = true,
			Angle = angle + 180,
		})
		game.MapState[_PLUGIN.guid .. "DaggerCharging"] = nil
		game.killTaggedThreads(_PLUGIN.guid .. "WeaponDagger5Mark")
		game.Destroy({ Id = game.MapState[_PLUGIN.guid.."MarkedDaggerTargetId"]  })
		game.Destroy({ Ids = game.MapState[_PLUGIN.guid .. "AdditionalMarkIds"]  })

		if not game.IsEmpty(game.MapState[_PLUGIN.guid .. "AdditionalMarkIds"]) then
			local additionalTargetData = game.GetHeroTrait("DaggerTripleAspect").DaggerAdditionalTargetData
			for key, id in pairs(game.MapState[_PLUGIN.guid .. "AdditionalTargetIds"]) do
				local addWait = 0.3
				if key > 2 then
					addWait = 0.1
				end
				game.waitUnmodified(addWait, threadName)
				local addAngle = game.GetAngleBetween( { Id = dropLocation, DestinationId = id })
				game.CreateProjectileFromUnit({
					WeaponName = weaponName, Name = projectileName, Id = game.CurrentRun.Hero.ObjectId, DestinationId = id, FireFromTarget = true,
					DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges,
					Angle = addAngle + 180
				})
				local streakAnchor = game.SpawnObstacle({ Name = "BlankObstacle", DestinationId = id })
				game.SetAngle({ Id = streakAnchor, Angle = addAngle })
				game.CreateAnimation({ Name = additionalTargetData.Vfx, DestinationId = streakAnchor})
				game.thread( game.DestroyOnDelay, {streakAnchor}, 0.2 )
			end
		end
		game.Destroy({ Id = dropLocation })
		game.Destroy({ Id = autoTargetOrigin })
		game.MapState[_PLUGIN.guid .. "MarkDaggerEnemyId"] = nil
		game.MapState[_PLUGIN.guid.."MarkedDaggerTargetId"] = nil
		game.MapState[_PLUGIN.guid .. "AdditionalTargetIds"] = {}
		game.MapState[_PLUGIN.guid .. "AdditionalMarkIds"] = {}
		game.waitUnmodified(0.07, "RepeatWeaponThread")
		repeats = repeats + 1
	end
	game.wait( 0.3 ) -- Wait for final attack animation to finish before playing Expiring Animation
	local id = game.SessionMapState.OriginMarkers[weaponName]
	game.SetAnimation({ Name = functionArgs.ExpiringAnimationName, DestinationId = id })
	game.thread( game.DestroyOnDelay, {id} , functionArgs.DestroyDelay )

	game.SessionMapState.OriginMarkers[weaponName] = nil
end

function mod.StartSkullPrimaryRepeatThread(startX, startY, angle, args)
	args = args or {}
    local functionArgs, triggerArgs, weaponName = args[1], args[2], args[3]
	functionArgs.Repeats = functionArgs.Repeats or 3
	functionArgs.Interval = functionArgs.Interval or 3.5
	functionArgs.PreAttackDuration = functionArgs.PreAttackDuration or 0
	local projectileName = "ProjectileLobChargedPulse"
	if game.HeroHasTrait("LobGunAspect") then
		projectileName = "ProjectileLobOverheat"
	end
	local numProjectiles = 1
	if game.HeroHasTrait("LobGunAttackDoublerTrait") then
		numProjectiles = 3
	end
	local targetX = triggerArgs.TargetX
	local targetY = triggerArgs.TargetY
	local threadName = "RepeatWeaponThread"
	local repeats = 1
	local weaponData = game.GetWeaponData( game.CurrentRun.Hero, weaponName )
	local traitData = game.GetHeroTrait("StaffSelfHitAspect")

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
		game.waitUnmodified(functionArgs.PreAttackDuration, threadName )
		if (game.CurrentRun.Hero.IsDead and (not game.CurrentHubRoom or not game.CurrentHubRoom.AllowEnemyAIActive)) or ( game.CurrentRun.CurrentRoom.Encounter and game.CurrentRun.CurrentRoom.Encounter.BossKillPresentation ) then
			break
		end
		local dropLocation = game.SpawnObstacle({ Name = "InvisibleTarget", LocationX = startX, LocationY = startY })
		for i = 1, numProjectiles do
			game.CreateProjectileFromUnit({ WeaponName = weaponName, Name = projectileName, Id = game.CurrentRun.Hero.ObjectId, DestinationId = dropLocation, DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges, FireFromTarget = true, Angle = angle })
			game.waitUnmodified(0.15, threadName)
		end
		game.Destroy({Id = dropLocation })
		repeats = repeats + 1
	end
	game.wait( 0.3 ) -- Wait for final attack animation to finish before playing Expiring Animation
	local id = game.SessionMapState.OriginMarkers[weaponName]
	game.SetAnimation({ Name = functionArgs.ExpiringAnimationName, DestinationId = id })
	game.thread( game.DestroyOnDelay, {id} , functionArgs.DestroyDelay )

	game.SessionMapState.OriginMarkers[weaponName] = nil
end

function mod.StartSuitPrimaryRepeatThread(startX, startY, angle, args)
	args = args or {}
    local functionArgs, triggerArgs, weaponName = args[1], args[2], args[3]
	functionArgs.Repeats = functionArgs.Repeats or 3
	functionArgs.Interval = functionArgs.Interval or 3.5
	functionArgs.PreAttackDuration = functionArgs.PreAttackDuration or 0
	local projectileName = "ProjectileSuitCharged"
	local threadName = "RepeatWeaponThread"
	local repeats = 1
	local weaponData = game.GetWeaponData( game.CurrentRun.Hero, weaponName )
	local traitData = game.GetHeroTrait("StaffSelfHitAspect")

	local derivedValues = game.GetDerivedPropertyChangeValues({
		ProjectileName = projectileName,
		WeaponName = weaponName,
		Type = "Projectile",
	})
	local currentStage = game.MapState.WeaponCharge[weaponName] or 10
	local stages = game.GetWeaponChargeStages(weaponData)
	local damageMultiplier = stages[currentStage].WeaponProperties.DamageMultiplier

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
		local dropLocation = game.SpawnObstacle({ Name = "InvisibleTarget", LocationX = startX, LocationY = startY })
		game.CreateProjectileFromUnit({ WeaponName = "WeaponSuit", Name = projectileName, Id = game.CurrentRun.Hero.ObjectId, DestinationId = dropLocation, DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges, FireFromTarget = true, AttachToTarget = true, Angle = angle, DamageMultiplier = damageMultiplier })
		game.Destroy({Id = dropLocation })
		repeats = repeats + 1
	end
	game.wait( 0.3 ) -- Wait for final attack animation to finish before playing Expiring Animation
	local id = game.SessionMapState.OriginMarkers[weaponName]
	game.SetAnimation({ Name = functionArgs.ExpiringAnimationName, DestinationId = id })
	game.thread( game.DestroyOnDelay, {id} , functionArgs.DestroyDelay )

	game.SessionMapState.OriginMarkers[weaponName] = nil
end

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

modutil.mod.Path.Wrap("StartCastRepeatThread", function (base, triggerArgs, functionArgs)
	local startX = triggerArgs.LocationX
	local startY = triggerArgs.LocationY
	local zOffset = 90
	if game.HeroHasTrait("SelfCastBoon")then
		zOffset = 160
	end
	game.SessionMapState.OriginMarkers = game.SessionMapState.OriginMarkers or {}
	if not game.SessionMapState.OriginMarkers["WeaponCast"] or not game.IsAlive({ Id = game.SessionMapState.OriginMarkers["WeaponCast"] }) then
		local originMarkerId = game.SpawnObstacle({ Name = "BlankObstacle", Group = "FX_Standing", LocationX = startX, LocationY = startY, OffsetZ = zOffset })
		game.SetAnimation({ Name = "MomusCastPointSpawn", DestinationId = originMarkerId })
		game.SessionMapState.OriginMarkers["WeaponCast"] = originMarkerId
		if game.HeroHasTrait("SelfCastBoon") then
			game.Attach({ Id = originMarkerId, DestinationId = game.CurrentRun.Hero.ObjectId })
		end
	end
	return base(triggerArgs, functionArgs)
end)