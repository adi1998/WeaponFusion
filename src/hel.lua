function mod.HandleGunBehavior(weaponData, functionArgs, triggerArgs)
    if game.IsExWeapon( weaponData.Name, { Combat = true }, triggerArgs )  then
		if triggerArgs.ProjectileId and ( weaponData.Name == "WeaponLobSpecial" ) then
			local chargeStages = game.GetWeaponChargeStages( weaponData )
			local manaSpend = game.GetManaCost( weaponData, false, { ManaCostOverride = chargeStages[game.MapState.WeaponCharge[weaponData.Name]].ManaCost})
			game.ManaDelta( -manaSpend )
			if weaponData.Name == "WeaponLobSpecial" then
				local dataProperties = game.MergeTables( game.EffectData[functionArgs.EffectName].DataProperties, functionArgs.EffectData )
				dataProperties.Duration = dataProperties.Duration + game.GetTotalHeroTraitValue("OverheatDurationIncrease")
				game.ApplyEffect({ DestinationId = game.CurrentRun.Hero.ObjectId, Id = game.CurrentRun.Hero.ObjectId, EffectName = functionArgs.EffectName, DataProperties = dataProperties })
				game.RunWeaponMethod({ Id = game.CurrentRun.Hero.ObjectId, Weapon = "WeaponLobSpecial", Method = "forceReload"})
            end
		end
    end
end

function mod.OverheatApply( triggerArgs )
	if triggerArgs.Reapplied then
		return
	end
	game.SetAnimationFrameTarget({ Name = "StaffReloadTimer", DestinationId = game.ScreenAnchors.LobUIChargeAmount, Fraction = 1, Instant = true })
	game.SetAnimation({ Name = "StaffReloadTimer", DestinationId = game.ScreenAnchors.LobUIChargeAmount, PlaySpeed = 100 / triggerArgs.Duration })
    game.SetAnimationFrameTarget({ Name = "StaffReloadTimer", DestinationId = game.ScreenAnchors.LobUIChargeAmount, Fraction = 0 })
	game.SessionMapState.OverheatConsecutiveHit = 0
	game.SessionMapState.Overheat = true
	game.ModifyTextBox({ Id = game.ScreenAnchors.LobUI, FadeTarget = 1, FadeDuration = 0.2 })
    game.SessionMapState.BlockStagedCharge.WeaponTorch = true
    game.SessionMapState.BlockStagedCharge.WeaponAxe = true
    game.SessionMapState.BlockStagedCharge.WeaponAxeSpin = true
    game.SessionMapState.BlockStagedCharge.WeaponSuit = true
    game.SessionMapState.BlockStagedCharge.WeaponSuitCharged = true
	game.SessionMapState.BlockStagedCharge.WeaponLobSpecial = true
	local totalSpeedChange = triggerArgs.Modifier
	if totalSpeedChange ~= 1 then
		local allPropertyChanges =
		{
		}
		local speedPropertyChange =
		{
			WeaponNames =
            {
                "WeaponStaffSwing", "WeaponStaffSwing2", "WeaponStaffSwing3",
                "WeaponDagger", "WeaponDaggerDash", "WeaponDagger2", "WeaponDaggerMultiStab", "WeaponDaggerDouble",
                "WeaponTorch",
                "WeaponAxe", "WeaponAxe2", "WeaponAxe3", "WeaponAxeDash", "WeaponAxe4", "WeaponAxe5",
                "WeaponSuit", "WeaponSuit2", "WeaponSuitDouble", "WeaponSuitDash"
            },
			ChangeValue = totalSpeedChange,
			SpeedPropertyChanges = true,
		}
		for q, weaponName in pairs(speedPropertyChange.WeaponNames) do
			local newPropertyChanges = game.DeepCopyTable(game.WeaponData.DefaultWeaponValues.DefaultSpeedPropertyChanges)
			if game.WeaponData[weaponName] and game.WeaponData[weaponName].SpeedPropertyChanges then
				newPropertyChanges = game.DeepCopyTable( game.WeaponData[weaponName].SpeedPropertyChanges)
			end
			for s, newPropertyChange in pairs(newPropertyChanges) do
				newPropertyChange = game.MergeTables( newPropertyChange, speedPropertyChange )
				newPropertyChange.WeaponNames = nil
				newPropertyChange.WeaponName = weaponName
				newPropertyChange.ChangeType = "Multiply"
				if newPropertyChange.InvertSource then
					if newPropertyChange.ChangeValue then
						newPropertyChange.ChangeValue = 1 / newPropertyChange.ChangeValue
					end
				end
				newPropertyChange.SpeedPropertyChanges = nil
				table.insert(allPropertyChanges, newPropertyChange )
			end
		end

		game.MapState.OverheatSpeedPropertyChanges = allPropertyChanges
		game.ApplyUnitPropertyChanges( game.CurrentRun.Hero, game.MapState.OverheatSpeedPropertyChanges )
	end
	game.thread( game.UpdateLobUI )
	game.thread( game.OverheatStartPresentation, triggerArgs )
    game.SetAnimation({Name = "StaffReloadTimerReady", DestinationId = game.ScreenAnchors.LobUI })
	game.SetCastArmDisabled( "Overheat" )
end

modutil.mod.Path.Wrap("OverheatApply", function (base, triggerArgs)
    if not game.CurrentRun.Hero.Weapons["WeaponLob"] then
        return mod.OverheatApply(triggerArgs)
    end
    return base(triggerArgs)
end)

modutil.mod.Path.Wrap("OverheatClear", function (base, triggerArgs)
    if not game.CurrentRun.Hero.Weapons["WeaponLob"] then
        game.SessionMapState.BlockStagedCharge.WeaponTorch = nil
        game.SessionMapState.BlockStagedCharge.WeaponAxe = nil
        game.SessionMapState.BlockStagedCharge.WeaponAxeSpin = nil
        game.SessionMapState.BlockStagedCharge.WeaponSuit = nil
        game.SessionMapState.BlockStagedCharge.WeaponSuitCharged = nil
    end
    return base(triggerArgs)
end)