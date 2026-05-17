game.TraitData.AxeArmCastAspect.OnProjectileDeathFunction = {
    ValidProjectiles = { "ProjectileStaffBallCharged", "ProjectileSuitBomb", "ProjectileSuitBombStraight", "ProjectileSuitRangedCharged", "ProjectileDaggerThrowCharged", "ProjectileTorchOrbitEx" },
    Name = _PLUGIN.guid .. "." .. "CheckAxeCastArm",
    Args = {
        BlastMultiplier = { BaseValue = 1.15, SourceIsMultiplier = true },
        Animation = "CharonAspectDetonateFx",
    }
}

table.insert(game.TraitData.AxeArmCastAspect.OnProjectileCreationFunction.ValidProjectiles, "ProjectileThrowCharged")

function mod.CheckAxeCastArm(triggerArgs, functionArgs)
    local intersectionProjectiles = game.GetInProjectilesBlast({ ProjectileId = triggerArgs.ProjectileId, DestinationName = "ProjectileCast", UseDamageRadius = true, })
    if not game.IsEmpty(intersectionProjectiles) and game.CheckCooldown(_PLUGIN.guid .. "CheckAxeCastArm", 0.8) then
        local projectileId = game.GetFirstValue(intersectionProjectiles)
		local location = game.GetLocation({ Id = projectileId, IsProjectile = true })
		local dropLocationId = game.SpawnObstacle({ Name = "InvisibleTarget", LocationX = location.X, LocationY = location.Y})
		game.CreateAnimation({ Name = "CharonAspectDetonateFx", DestinationId = dropLocationId  }) --nopkg
		for _, projectileId in pairs( intersectionProjectiles) do
			for _, data in pairs( game.GetHeroTraitValues("OnEarlyCastDetonation")) do
				game.thread( game.CallFunctionName, data.FunctionName, projectileId, data.FunctionArgs )
			end
		end
		game.ArmAndDetonateProjectiles({ Ids = intersectionProjectiles, BlastMultiplier = functionArgs.BlastMultiplier, Duration = 0.2, ForceDetonate = true })
		for _, projectileId in pairs( intersectionProjectiles) do
			game.SessionState.EarlyDetonationProjectileIds[ projectileId ] = true
			--ExpireProjectiles({ ProjectileIds = { projectileId })
			if not game.IsEmpty(game.SessionMapState.CastAttachedProjectiles[projectileId]) then
				game.ExpireProjectiles({ ProjectileIds = game.SessionMapState.CastAttachedProjectiles[projectileId] })
			end
		end
		game.Destroy({ Id = dropLocationId })
    end
end

modutil.mod.Path.Wrap("CheckAxeCastArm", function (base, triggerArgs, args)
	game.SessionMapState[_PLUGIN.guid .. "CheckAxeCastArmProjectileName"] = triggerArgs.name
	return base(triggerArgs, args)
end)