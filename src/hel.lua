game.TraitData.LobGunAspect.OnWeaponFiredFunctions.ValidWeapons = game.DeepCopyTable(game.WeaponSets.HeroAllWeapons)
table.insert(game.TraitData.LobGunAspect.OnWeaponFiredFunctions.ValidWeapons, "WeaponSprintEx")

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
	game.SessionMapState.BlockStagedCharge.WeaponStaffBall = true
	game.SessionMapState.BlockStagedCharge.WeaponStaffSwing5 = true
	game.SessionMapState.BlockStagedCharge.WeaponDagger5 = true
	game.SessionMapState.BlockStagedCharge.WeaponDaggerThrow = true
    game.SessionMapState.BlockStagedCharge.WeaponTorch = true
	game.SessionMapState.BlockStagedCharge.WeaponTorchSpecial = true
    game.SessionMapState.BlockStagedCharge.WeaponAxe = true
    game.SessionMapState.BlockStagedCharge.WeaponAxeSpin = true
	game.SessionMapState.BlockStagedCharge.WeaponAxeSpecialSwing = true
    game.SessionMapState.BlockStagedCharge.WeaponSuit = true
    game.SessionMapState.BlockStagedCharge.WeaponSuitCharged = true
	game.SessionMapState.BlockStagedCharge.WeaponSuitRanged = true
	game.SessionMapState.BlockStagedCharge.WeaponLob = true
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
                "WeaponSuit", "WeaponSuit2", "WeaponSuitDouble", "WeaponSuitDash",
				"WeaponLob",
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
    if not game.CurrentRun.Hero.Weapons["WeaponLob"] or not game.CurrentRun.Hero.Weapons["WeaponLobSpecial"] then
        return mod.OverheatApply(triggerArgs)
    end
    return base(triggerArgs)
end)

local function resumeCharging(weaponName, triggerArgs, chargeFunction)
	if game.GetWeaponProperty({ WeaponName = weaponName, Id = game.CurrentRun.Hero.ObjectId, Property = "Charging", DataValue = false}) then
		local weaponData = game.GetWeaponData( game.CurrentRun.Hero, weaponName )
		triggerArgs.name = weaponData.Name
		game.thread( chargeFunction or game.DoWeaponCharge, triggerArgs, weaponData, weaponData.OnChargeFunctionArgs )
		game.thread( game.HandleManaChargeIndicator, { name = weaponData.Name } )
	end
end

modutil.mod.Path.Wrap("OverheatClear", function (base, triggerArgs)
    if not game.CurrentRun.Hero.Weapons["WeaponLob"] or not game.CurrentRun.Hero.Weapons["WeaponLobSpecial"] then
		game.SessionMapState.BlockStagedCharge.WeaponStaffBall = nil
		game.SessionMapState.BlockStagedCharge.WeaponStaffSwing5 = nil
		game.SessionMapState.BlockStagedCharge.WeaponDagger5 = nil
		game.SessionMapState.BlockStagedCharge.WeaponDaggerThrow = nil
		game.SessionMapState.BlockStagedCharge.WeaponTorch = nil
		game.SessionMapState.BlockStagedCharge.WeaponTorchSpecial = nil
		game.SessionMapState.BlockStagedCharge.WeaponAxe = nil
		game.SessionMapState.BlockStagedCharge.WeaponAxeSpin = nil
		game.SessionMapState.BlockStagedCharge.WeaponAxeSpecialSwing = nil
		game.SessionMapState.BlockStagedCharge.WeaponSuit = nil
		game.SessionMapState.BlockStagedCharge.WeaponSuitCharged = nil
		game.SessionMapState.BlockStagedCharge.WeaponSuitRanged = nil

		resumeCharging("WeaponStaffBall", triggerArgs)
		resumeCharging("WeaponDaggerThrow", triggerArgs)
		resumeCharging("WeaponTorchSpecial", triggerArgs)
		resumeCharging("WeaponSuitRanged", triggerArgs)
		resumeCharging("WeaponTorch", triggerArgs)
		resumeCharging("WeaponDagger5", triggerArgs, game.MarkDaggerTarget)
		resumeCharging("WeaponAxeSpin", triggerArgs)
		resumeCharging("WeaponSuitCharged", triggerArgs)
    end
    return base(triggerArgs)
end)

function mod.CheckWeaponOverheat(triggerArgs, weaponData, args)
	if game.SessionMapState.BlockStagedCharge[weaponData.Name] then
		game.RunWeaponMethod({ Id = game.CurrentRun.Hero.ObjectId, Weapon = weaponData.Name, Method = "ForceControlRelease" })
	end
end