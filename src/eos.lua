if game.TraitData.TorchSprintRecallAspect.ChargeStageModifiers then
	game.TraitData.TorchSprintRecallAspect.ChargeStageModifiers.ValidWeapons = {"WeaponTorchSpecial"}
end

function mod.HandleAttachRecord(weaponData, functionArgs, triggerArgs)
    local isEx = game.IsExWeapon( weaponData.Name, { Combat = true }, triggerArgs )
	if game.SessionMapState.CurrentExProjectile then
		if weaponData.Name == "WeaponStaffBall" then
			local weaponName = weaponData.Name
			local projectileName = (isEx and "ProjectileStaffBallCharged") or "ProjectileStaffBall"
			local derivedValues = game.GetDerivedPropertyChangeValues({
				ProjectileName = projectileName,
				WeaponName = weaponName,
				Type = "Projectile",
				MatchProjectileName = true,
			})
			local angle = game.GetAngle({ Id = game.CurrentRun.Hero.ObjectId })
			game.CreateProjectileFromUnit({
				WeaponName = weaponName,
				Name = projectileName,
				Angle = angle,
				Id = game.CurrentRun.Hero.ObjectId,
				ProjectileDestinationId = game.SessionMapState.CurrentExProjectile,
				FireFromTarget = true,
				DataProperties = derivedValues.PropertyChanges,
				ThingProperties = derivedValues.ThingPropertyChanges,
			})
		end
		if weaponData.Name == "WeaponDaggerThrow" then
			local weaponName = weaponData.Name
			local projectileName = (isEx and "ProjectileDaggerThrowCharged") or "ProjectileDaggerThrow"
			local derivedValues = game.GetDerivedPropertyChangeValues({
				ProjectileName = projectileName,
				WeaponName = weaponName,
				Type = "Projectile",
			})
			local angle = game.GetAngle({ Id = game.CurrentRun.Hero.ObjectId })
			if isEx then
				local numProjectiles = triggerArgs.NumProjectiles
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
				local centerOffset = 0

				if numProjectiles % 2 == 0 then
					centerOffset = angleIncrement/2
				end

				local start = 1
				if numProjectiles % 2 == 1 then
					game.CreateProjectileFromUnit({ WeaponName = weaponName,
						Name = projectileName,
						Id = game.CurrentRun.Hero.ObjectId,
						ProjectileDestinationId = game.SessionMapState.CurrentExProjectile,
						FireFromTarget = true,
						DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges, Angle = angle
					})
					-- print(angle)
					game.waitUnmodified(daggerProjectileInterval)
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
						ProjectileDestinationId = game.SessionMapState.CurrentExProjectile,
						FireFromTarget = true,
						DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges, Angle = angle + angleOffset
					})
					-- print(angleOffset)
					game.waitUnmodified(daggerProjectileInterval)
				end
			else
				game.CreateProjectileFromUnit({
					WeaponName = weaponName,
					Name = projectileName,
					Angle = angle,
					Id = game.CurrentRun.Hero.ObjectId,
					ProjectileDestinationId = game.SessionMapState.CurrentExProjectile,
					FireFromTarget = true,
					DataProperties = derivedValues.PropertyChanges,
					ThingProperties = derivedValues.ThingPropertyChanges,
				})
			end
		end
		if weaponData.Name == "WeaponAxeSpecial" and not isEx then
			local weaponName = weaponData.Name
			local projectileName = "ProjectileAxeSpecial"
			local derivedValues = game.GetDerivedPropertyChangeValues({
				ProjectileName = projectileName,
				WeaponName = weaponName,
				Type = "Projectile",
			})
			local location = game.GetLocation({Id = game.SessionMapState.CurrentExProjectile, IsProjectile = true })
			local startX = location.X
			local startY = location.Y
			local dropLocation = game.SpawnObstacle({ Name = "InvisibleTarget", LocationX = startX, LocationY = startY })

			local angle = game.GetAngle({ Id = game.CurrentRun.Hero.ObjectId })
			game.CreateProjectileFromUnit({
				WeaponName = weaponName,
				Name = projectileName,
				Angle = angle,
				Id = game.CurrentRun.Hero.ObjectId,
				DestinationId = dropLocation,
				FireFromTarget = true,
				AttachToTarget = true,
				DataProperties = derivedValues.PropertyChanges,
				ThingProperties = derivedValues.ThingPropertyChanges,
			})
		end
		if weaponData.Name == "WeaponAxeSpecialSwing" and isEx then
			local weaponName = weaponData.Name
			local projectileName = "ProjectileAxeBlock2"
			local derivedValues = game.GetDerivedPropertyChangeValues({
				ProjectileName = projectileName,
				WeaponName = weaponName,
				Type = "Projectile",
			})
			local angle = game.GetAngle({ Id = game.CurrentRun.Hero.ObjectId })
			if not game.HeroHasTrait("AxeRallyAspect_Secondary") then
				local location = game.GetLocation({Id = game.SessionMapState.CurrentExProjectile, IsProjectile = true })
				local startX = location.X
				local startY = location.Y
				local offset = 90
				local dropLocation1 = game.SpawnObstacle({ Name = "InvisibleTarget", LocationX = OffsetCoordinate(startX, angle, "X", offset), LocationY = OffsetCoordinate(startY, angle, "Y", offset) })
				offset = offset + 460
				local dropLocation2 = game.SpawnObstacle({ Name = "InvisibleTarget", LocationX = OffsetCoordinate(startX, angle, "X", offset), LocationY = OffsetCoordinate(startY, angle, "Y", offset) })
				offset = offset + 460
				local dropLocation3 = game.SpawnObstacle({ Name = "InvisibleTarget", LocationX = OffsetCoordinate(startX, angle, "X", offset), LocationY = OffsetCoordinate(startY, angle, "Y", offset) })
				game.CreateProjectileFromUnit({ WeaponName = weaponName, Name = projectileName, Id = game.CurrentRun.Hero.ObjectId, DestinationId = dropLocation1, DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges, FireFromTarget = true, Angle = angle })
				game.waitUnmodified(0.2)
				game.CreateProjectileFromUnit({ WeaponName = weaponName, Name = projectileName, Id = game.CurrentRun.Hero.ObjectId, DestinationId = dropLocation2, DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges, FireFromTarget = true, Angle = angle })
				game.waitUnmodified(0.2)
				game.CreateProjectileFromUnit({ WeaponName = weaponName, Name = projectileName, Id = game.CurrentRun.Hero.ObjectId, DestinationId = dropLocation3, DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges, FireFromTarget = true, Angle = angle })
				game.Destroy({Id = dropLocation1 })
				game.Destroy({Id = dropLocation2 })
				game.Destroy({Id = dropLocation3 })
			else
				local location = game.GetLocation({Id = game.SessionMapState.CurrentExProjectile, IsProjectile = true })
				local startX = location.X
				local startY = location.Y
				local dropLocation1 = game.SpawnObstacle({ Name = "InvisibleTarget", LocationX = startX, LocationY = startY })
				game.CreateProjectileFromUnit({ WeaponName = weaponName, Name = projectileName, Id = game.CurrentRun.Hero.ObjectId, DestinationId = dropLocation1, DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges, FireFromTarget = true, Angle = angle })
				game.waitUnmodified(0.4)
				derivedValues.PropertyChanges.DamageRadius = derivedValues.PropertyChanges.DamageRadius * 1.33
				location = game.GetLocation({Id = game.SessionMapState.CurrentExProjectile, IsProjectile = true })
				startX = location.X
				startY = location.Y
				local dropLocation2 = game.SpawnObstacle({ Name = "InvisibleTarget", LocationX = startX, LocationY = startY })
				game.CreateProjectileFromUnit({ WeaponName = weaponName, Name = projectileName, Id = game.CurrentRun.Hero.ObjectId, DestinationId = dropLocation2, DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges, FireFromTarget = true, Angle = angle })
				game.waitUnmodified(0.4)
				derivedValues.PropertyChanges.DamageRadius = derivedValues.PropertyChanges.DamageRadius * 1.66 / 1.33
				location = game.GetLocation({Id = game.SessionMapState.CurrentExProjectile, IsProjectile = true })
				startX = location.X
				startY = location.Y
				local dropLocation3 = game.SpawnObstacle({ Name = "InvisibleTarget", LocationX = startX, LocationY = startY })
				game.CreateProjectileFromUnit({ WeaponName = weaponName, Name = projectileName, Id = game.CurrentRun.Hero.ObjectId, DestinationId = dropLocation3, DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges, FireFromTarget = true, Angle = angle })
				game.Destroy({Id = dropLocation1 })
				game.Destroy({Id = dropLocation2 })
				game.Destroy({Id = dropLocation3 })
			end
		end
		if weaponData.Name == "WeaponSuitRanged" and isEx then
			local weaponName = weaponData.Name
			local projectileName = "ProjectileSuitBomb"
			if game.HeroHasTrait("SuitComboForwardRocketTrait") then
				projectileName = "ProjectileSuitBombStraight"
			end
			if not game.HeroHasTrait("SuitComboAspect_Secondary") then
				projectileName = "ProjectileSuitRangedUnguided"
			end
			local derivedValues = game.GetDerivedPropertyChangeValues({
				ProjectileName = projectileName,
				WeaponName = weaponName,
				Type = "Projectile",
			})
			local numProjectiles = 4
			local angle = game.GetAngle({ Id = game.CurrentRun.Hero.ObjectId })
			local location = game.GetLocation({Id = game.SessionMapState.CurrentExProjectile, IsProjectile = true })
			local dropLocation = game.SpawnObstacle({ Name = "InvisibleTarget", LocationX = location.X, LocationY = location.Y })
			if projectileName ~= "ProjectileSuitRangedUnguided" then
				game.CreateProjectileFromUnit({ WeaponName = weaponName,
					Name = projectileName,
					Id = game.CurrentRun.Hero.ObjectId,
					DestinationId = dropLocation,
					FireFromTarget = true,
					AttachToTarget = true,
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
					game.waitUnmodified(0.07)
				end
			end
			game.Destroy({Id = dropLocation})
		end
		if weaponData.Name == "WeaponSuitRanged" and not isEx then
			local weaponName = weaponData.Name
			local projectileName = "ProjectileSuitGrenade"
			if game.HeroHasTrait("SuitComboForwardRocketTrait") then
				projectileName = "ProjectileSuitGrenadeStraight"
			end
			if not game.HeroHasTrait("SuitComboAspect_Secondary") then
				projectileName = "ProjectileSuitRangedUnguided"
			end
			local derivedValues = game.GetDerivedPropertyChangeValues({
				ProjectileName = projectileName,
				WeaponName = weaponName,
				Type = "Projectile",
			})
			local numProjectiles = 2
			local angle = game.GetAngle({ Id = game.CurrentRun.Hero.ObjectId })
			local location = game.GetLocation({Id = game.SessionMapState.CurrentExProjectile, IsProjectile = true })
			local dropLocation = game.SpawnObstacle({ Name = "InvisibleTarget", LocationX = location.X, LocationY = location.Y })
			if projectileName ~= "ProjectileSuitRangedUnguided" then
				game.CreateProjectileFromUnit({ WeaponName = weaponName,
					Name = projectileName,
					Id = game.CurrentRun.Hero.ObjectId,
					DestinationId = dropLocation,
					AttachToTarget = true,
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
					game.waitUnmodified(0.02)
				end
			end
			game.Destroy({Id = dropLocation})
		end
		if weaponData.Name == "WeaponLobSpecial" and game.HeroHasTrait("LobGunAspect_Secondary") then
			local weaponName = weaponData.Name
			local projectileName = "ProjectileLobSpecialBounce"
			if isEx then
				projectileName = "ProjectileLobGunRift"
			end
			local derivedValues = game.GetDerivedPropertyChangeValues({
				ProjectileName = projectileName,
				WeaponName = weaponName,
				Type = "Projectile",
			})
			local location = game.GetLocation({Id = game.SessionMapState.CurrentExProjectile, IsProjectile = true })
			local dropLocation = game.SpawnObstacle({ Name = "InvisibleTarget", LocationX = location.X, LocationY = location.Y })
			local angle = game.GetAngle({ Id = game.CurrentRun.Hero.ObjectId })
			game.CreateProjectileFromUnit({ WeaponName = weaponName,
				Name = projectileName,
				Id = game.CurrentRun.Hero.ObjectId,
				DestinationId = dropLocation,
				FireFromTarget = true,
				DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges, Angle = angle
			})
		end
	end
end

modutil.mod.Path.Wrap("HandleAttachRecord", function (base, weaponData, functionArgs, triggerArgs)
	if weaponData.Name == "WeaponTorchSpecial" and game.IsExWeapon( weaponData.Name, { Combat = true }, triggerArgs ) then
		triggerArgs.NumProjectiles = triggerArgs.NumProjectiles or 2
		triggerArgs.ProjectileName = triggerArgs.ProjectileName or "ProjectileTorchOrbitEx"
	end
    base(weaponData, functionArgs, triggerArgs)
    mod.HandleAttachRecord(weaponData, functionArgs, triggerArgs)
end)