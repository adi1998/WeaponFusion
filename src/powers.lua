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
	print(mod.dump(derivedValues))
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
	if game.HeroHasTrait("DaggerSpecialLineTrait") then
		angleIncrement = 0
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
			print(angle)
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
			print(angleOffset)
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
	while repeats < functionArgs.Repeats do
		game.waitUnmodified(functionArgs.Interval - functionArgs.PreAttackDuration, threadName )
		if functionArgs.AttackAnimationName then
			game.SetAnimation({ Name = functionArgs.AttackAnimationName, DestinationId = game.SessionMapState.OriginMarkers[weaponName] })
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

mod.WeaponThreadMap = {
	["WeaponAxeSpecialSwing"] = mod.StartAxeSpecialRepeatThread,
	["WeaponDaggerThrow"] = mod.StartDaggerSpecialRepeatThread,
	["WeaponSuitRanged"] = mod.StartSuitSpecialRepeatThread,
}

local dropOriginWeapons = {"WeaponDaggerThrow", "WeaponAxeSpecial", "WeaponAxeSpecialSwing", "WeaponTorchSpecial", "WeaponSuitRanged", }

modutil.mod.Path.Wrap("DropOriginMarker", function (base, weaponData, functionArgs, triggerArgs )
    if game.Contains(dropOriginWeapons, weaponData.Name) then
        if game.IsExWeapon( weaponData.Name, { Combat = true }, triggerArgs ) or triggerArgs.DisjointExCast then
            -- print(mod.dump(weaponData))
            -- print(mod.dump(triggerArgs))
            local playerLocation = GetLocation({ Id = CurrentRun.Hero.ObjectId })
            local startX = triggerArgs.ProjectileX or playerLocation.X
            local startY = triggerArgs.ProjectileY or playerLocation.Y
            local weaponName = weaponData.Name
            if game.Contains({"WeaponDaggerThrow"}, weaponData.Name) then
                SessionMapState.OriginMarkers = SessionMapState.OriginMarkers or {}
                if SessionMapState.OriginMarkers[weaponName] then
                    Destroy({ Id = SessionMapState.OriginMarkers[weaponName] })
                end
            end
            if  game.Contains(dropOriginWeapons, weaponData.Name) then
                local threadName = "RepeatSpecialThread"
                if HasThread( threadName ) then
                    killTaggedThreads( threadName )
                    waitUnmodified(0.1)
                    local id = SessionMapState.OriginMarkers[weaponName]
                    SessionMapState.OriginMarkers[weaponName] = nil
                    SetAnimation({ Name = functionArgs.ExpiringAnimationName, DestinationId = id })
                    thread( DestroyOnDelay, {id} , functionArgs.DestroyDelay )
                end
                game.thread(mod.WeaponThreadMap[weaponName] or mod.StartSpecialRepeatThread, startX, startY, game.GetAngle({Id = game.CurrentRun.Hero.ObjectId}), {functionArgs, triggerArgs, weaponName} )
            end
            local zOffset = 90

            local originMarkerId = game.SpawnObstacle({ Name = "BlankObstacle", Group = "FX_Standing", LocationX = startX, LocationY = startY, OffsetZ = zOffset })
            game.SetAngle({ Id = originMarkerId, Angle = game.GetAngle({Id = game.CurrentRun.Hero.ObjectId}) })
            game.SetAnimation({ Name = functionArgs.AnimationName, DestinationId = originMarkerId })
            game.SessionMapState.OriginMarkers[weaponName] = originMarkerId
        end
    else
        base(weaponData, functionArgs, triggerArgs)
    end
end)

function mod.StartSpecialRepeatThread(startX, startY, angle, args )
    args = args or {}
    local functionArgs, triggerArgs, weaponName, projectileName = args[1], args[2], args[3], args[4]
	functionArgs = functionArgs or {}
	functionArgs.Repeats = functionArgs.Repeats or 3
	functionArgs.Interval = functionArgs.Interval or 3.5
	functionArgs.PreAttackDuration = functionArgs.PreAttackDuration or 0
	local threadName = "RepeatSpecialThread"
	projectileName = projectileName or "ProjectileDaggerThrowCharged"
	local repeats = 1
	local useSecondStageCharacteristics = false
	local weaponData = GetWeaponData( CurrentRun.Hero, weaponName )
	
	local derivedValues = GetDerivedPropertyChangeValues({
		ProjectileName = projectileName,
		WeaponName = weaponName,
		Type = "Projectile",
	})
	local traitData = GetHeroTrait("StaffSelfHitAspect")
	local animationName = "WitchGrenadeRecallSphere"
	if traitData and traitData.OnWeaponFiredFunctions and traitData.OnWeaponFiredFunctions.FunctionArgs and traitData.OnWeaponFiredFunctions.FunctionArgs.AnimationName then
		animationName = traitData.OnWeaponFiredFunctions.FunctionArgs.AnimationName
	end
	
	if HeroHasTrait("StaffSecondStageTrait") and (SessionMapState.ProjectileChargeStageReached[triggerArgs.ProjectileVolley] or 0) >= 2 then
		useSecondStageCharacteristics = true
			-- TODO: extract these from a version of derive property change values on the weapon
		derivedValues.PropertyChanges.DamageRadius = 550
		derivedValues.PropertyChanges.BlastSpeed = 2500
	end		
	local logProjectileIdForMagicCrit = false
	if SessionMapState.DifferentOmegaVolleys[weaponName] and SessionMapState.DifferentOmegaVolleys[weaponName][triggerArgs.ProjectileVolley] then
		SessionMapState.DifferentOmegaProjectileIds[weaponName] = SessionMapState.DifferentOmegaProjectileIds[weaponName] or {}
		logProjectileIdForMagicCrit = true
	end	
	while repeats < functionArgs.Repeats do
		waitUnmodified(functionArgs.Interval - functionArgs.PreAttackDuration, threadName )
		if functionArgs.AttackAnimationName then
			SetAnimation({ Name = functionArgs.AttackAnimationName, DestinationId = SessionMapState.OriginMarkers[weaponName] })
		end
		waitUnmodified(functionArgs.PreAttackDuration, threadName )
		local dropLocation = SpawnObstacle({ Name = "InvisibleTarget", LocationX = startX, LocationY = startY })
		if (CurrentRun.Hero.IsDead and (not CurrentHubRoom or not CurrentHubRoom.AllowEnemyAIActive)) or ( CurrentRun.CurrentRoom.Encounter and CurrentRun.CurrentRoom.Encounter.BossKillPresentation ) then
			break
		end
		if HeroHasTrait("StaffTripleShotTrait") then
			-- TODO: extract these from a version of derive property change values on the weapon
			local numProjectiles = 2
			local delay = 0.12
			if weaponData.RepeatFireSound then
				PlaySound({ Name = weaponData.RepeatFireSound, Id = SessionMapState.OriginMarkers[weaponName] })
			end
			local projectileId = CreateProjectileFromUnit({ WeaponName = weaponName, Name = projectileName, Id = CurrentRun.Hero.ObjectId, DestinationId = dropLocation, FireFromTarget = true, DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges, Angle = angle })
			if logProjectileIdForMagicCrit then
				SessionMapState.DifferentOmegaProjectileIds[weaponName] = SessionMapState.DifferentOmegaProjectileIds[weaponName] or {}
				SessionMapState.DifferentOmegaProjectileIds[weaponName][projectileId] = true
			end
			waitUnmodified( delay, threadName )
		end
		if (CurrentRun.Hero.IsDead and (not CurrentHubRoom or not CurrentHubRoom.AllowEnemyAIActive)) or ( CurrentRun.CurrentRoom.Encounter and CurrentRun.CurrentRoom.Encounter.BossKillPresentation ) then
			break
		end
		local animationName = GetWeaponDataValue({ Id = CurrentRun.Hero.ObjectId, WeaponName = weaponName, Property = "FireFx"})
		if animationName then
			CreateAnimation({ Name = animationName, DestinationId = SessionMapState.OriginMarkers[weaponName] })
		end
		if weaponData.RepeatFireSound then
			PlaySound({ Name = weaponData.RepeatFireSound, Id = SessionMapState.OriginMarkers[weaponName] })
		end
		local projectileId = CreateProjectileFromUnit({ WeaponName = weaponName, Name = projectileName, Id = CurrentRun.Hero.ObjectId, DestinationId = dropLocation, FireFromTarget = true, DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges, Angle = angle })
		if logProjectileIdForMagicCrit then
			SessionMapState.DifferentOmegaProjectileIds[weaponName] = SessionMapState.DifferentOmegaProjectileIds[weaponName] or {}
			SessionMapState.DifferentOmegaProjectileIds[weaponName][projectileId] = true
		end
		if useSecondStageCharacteristics then
			local currentVolley = GetWeaponProperty({ Id = CurrentRun.Hero.ObjectId, WeaponName = weaponName, Property = "Volley" })
			SessionMapState.ProjectileChargeStageReached[currentVolley] = 2
		end
		Destroy({Id = dropLocation })
		repeats = repeats + 1
	end
	wait( 0.5 ) -- Wait for final attack animation to finish before playing Expiring Animation
	local id = SessionMapState.OriginMarkers[weaponName]
	SetAnimation({ Name = functionArgs.ExpiringAnimationName, DestinationId = id })
	thread( DestroyOnDelay, {id} , functionArgs.DestroyDelay )
	
	SessionMapState.OriginMarkers[weaponName] = nil
end