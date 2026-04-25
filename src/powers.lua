
modutil.mod.Path.Wrap("DropOriginMarker", function (base, weaponData, functionArgs, triggerArgs )
    if game.Contains({"WeaponDaggerThrow", "WeaponAxeSpecial", "WeaponAxeSpecialSwing", "WeaponTorchSpecial", "WeaponSuitRanged", }, weaponData.Name) then
        if IsExWeapon( weaponData.Name, { Combat = true }, triggerArgs ) or triggerArgs.DisjointExCast then
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
            if  game.Contains({"WeaponDaggerThrow"}, weaponData.Name) then
                local threadName = "RepeatSpecialThread"
                if HasThread( threadName ) then
                    killTaggedThreads( threadName )
                    waitUnmodified(0.1)
                    local id = SessionMapState.OriginMarkers.WeaponCast
                    SessionMapState.OriginMarkers.WeaponCast = nil
                    SetAnimation({ Name = functionArgs.ExpiringAnimationName, DestinationId = id })
                    thread( DestroyOnDelay, {id} , functionArgs.DestroyDelay )
                end
                thread(mod.StartSpecialRepeatThread, startX, startY, GetAngle({Id = CurrentRun.Hero.ObjectId}), {functionArgs, triggerArgs, weaponName, projectileName} )
            end
            local zOffset = 90
            if HeroHasTrait("SelfCastBoon") and weaponName == "WeaponCast" then
                zOffset = 160
            end
            local originMarkerId = SpawnObstacle({ Name = "BlankObstacle", Group = "FX_Standing", LocationX = startX, LocationY = startY, OffsetZ = zOffset })
            SetAngle({ Id = originMarkerId, Angle = GetAngle({Id = CurrentRun.Hero.ObjectId}) })
            SetAnimation({ Name = functionArgs.AnimationName, DestinationId = originMarkerId })
            SessionMapState.OriginMarkers[weaponName] = originMarkerId
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