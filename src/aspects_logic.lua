
function mod.CheckFrenzyCount(victim, functionArgs, triggerArgs)

	local passesHitCheck = functionArgs.FirstHitOnly == nil or (functionArgs.FirstHitOnly and not game.ProjectileHasUnitHit( triggerArgs.ProjectileId, "CheckFrenzyCount_Secondary" ))

	if triggerArgs.SourceProjectile ~= nil and functionArgs.MultihitProjectileWhitelistLookup and functionArgs.MultihitProjectileWhitelistLookup[triggerArgs.SourceProjectile] and functionArgs.MultihitProjectileConditions[triggerArgs.SourceProjectile] then
		local conditions = functionArgs.MultihitProjectileConditions[triggerArgs.SourceProjectile]
		passesHitCheck = true
		if conditions.Cooldown and not game.CheckCooldown( "CheckFrenzyCount_Secondary", conditions.Cooldown ) then
			passesHitCheck = false
		end
	end
	if passesHitCheck then
		game.ProjectileRecordUnitHit( triggerArgs.ProjectileId, "CheckFrenzyCount_Secondary")
		if game.IsEmpty( game.CurrentRun.Hero.ActiveEffects ) or not game.CurrentRun.Hero.ActiveEffects.Frenzy then
			local startingCount = game.MapState.FrenzyHits or 0
			game.IncrementTableValue( game.MapState, "FrenzyHits" )
			local requiredCount = 21
			local traitData = game.GetHeroTrait("AxeRallyAspect_Secondary")
			if traitData.OnEnemyDamagedAction and traitData.OnEnemyDamagedAction.Args then
				requiredCount = traitData.OnEnemyDamagedAction.Args.RequiredCount or requiredCount
			end
			if game.ScreenAnchors.AxeUIChargeAmount then
				game.SetAnimationFrameTarget({ Name = "StaffReloadTimer", DestinationId = game.ScreenAnchors.AxeUIChargeAmount, Fraction = game.MapState.FrenzyHits / requiredCount, Instant = true })
			end
		end

		if game.MapState.FrenzyHits >= functionArgs.RequiredCount then
			game.MapState.FrenzyHits = 0
			local dataProperties = game.MergeTables(game.EffectData[functionArgs.EffectName].DataProperties, functionArgs.DataProperties)
			dataProperties.Duration = dataProperties.Duration + game.GetTotalHeroTraitValue("FrenzyDurationBonus")
			game.ApplyEffect( game.MergeTables({ DestinationId = game.CurrentRun.Hero.ObjectId, Id = game.CurrentRun.Hero.ObjectId, EffectName = functionArgs.EffectName, DataProperties = dataProperties }))
		end
	end
end

function mod.CheckPerfectAxeCrit( victim, args, triggerArgs )
	if game.IsExWeapon( triggerArgs.SourceWeapon, { Combat = true }, triggerArgs ) then
		return
	end
	if triggerArgs.SourceProjectile and game.ProjectileData[triggerArgs.SourceProjectile] and game.ProjectileData[triggerArgs.SourceProjectile].IsAdditionalCastProjectile then
		return
	end

	local passesHitCheck = args.FirstHitOnly == nil or (args.FirstHitOnly and not game.ProjectileHasUnitHit( triggerArgs.ProjectileId, "CheckPerfectAxeCrit_Secondary" ))

	if triggerArgs.SourceProjectile ~= nil and args.MultihitProjectileWhitelistLookup and args.MultihitProjectileWhitelistLookup[triggerArgs.SourceProjectile] and args.MultihitProjectileConditions[triggerArgs.SourceProjectile] then
		local conditions = args.MultihitProjectileConditions[triggerArgs.SourceProjectile]
		passesHitCheck = true
		if conditions.Cooldown and not game.CheckCooldown( "CheckPerfectAxeCrit_Secondary", conditions.Cooldown ) then
			passesHitCheck = false
		end
	end

	if passesHitCheck then
		game.ProjectileRecordUnitHit( triggerArgs.ProjectileId, "CheckPerfectAxeCrit_Secondary")
		local trait = game.GetHeroTrait( "AxePerfectCriticalAspect_Secondary")

		local prevCritChance = game.round(trait.PerfectCritChance * 100, 1)
		local maxCritChance = game.round(args.MaxCrit * 100, 1)

		trait.PerfectCritChance = math.min( args.MaxCrit,  trait.PerfectCritChance + args.Increment )

		local currCritChance = game.round(trait.PerfectCritChance * 100, 1)

		if prevCritChance < maxCritChance and currCritChance == maxCritChance then
			game.PlaySound({ Name = "/SFX/ThanatosCreepyBellStart", Id = game.CurrentRun.Hero.ObjectId })
			game.CreateAnimation({ Name = "ThanatosMaxMortalityFx", DestinationId = game.CurrentRun.Hero.ObjectId, Group = "FX_Standing_Add" })
		end

		game.UpdateAxeUI( trait )
	end
end

modutil.mod.Path.Wrap("SetupPerfectCritUI", function (base)
	if game.SessionMapState.WeaponsDisabled then
		return
	end
	if game.HeroHasTrait("AxePerfectCriticalAspect_Secondary") then
		game.wait(0.05)
		local trait = game.GetHeroTrait("AxePerfectCriticalAspect_Secondary")
    	local currentCrit = game.round(trait.PerfectCritChance * 100, 1)
    	local maxCrit = trait.ReportedMaxCrit * 100
    	if currentCrit == maxCrit then
    		game.CreateAnimation({ Name = "ThanatosMaxMortalityFx", DestinationId = game.CurrentRun.Hero.ObjectId })
    	end
	end
	return base()
end)

modutil.mod.Path.Wrap("ShowAxeUI", function (base)
	base()

	if (not game.HeroHasTrait("AxePerfectCriticalAspect_Secondary") and not game.HeroHasTrait("AxeRallyAspect_Secondary")) or not game.ShowingCombatUI then
		return
	end

	if game.ScreenAnchors.AxeUI ~= nil then
		return
	end

	game.ScreenAnchors.AxeUI = game.CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray_Overlay_Additive", X = game.HUDScreen.AmmoX + 150, Y = game.ScreenHeight - game.HUDScreen.AmmoBottomOffset})
	game.ScreenAnchors.AxeUIChargeAmount = game.CreateScreenObstacle({ Name = "BlankObstacle", Group = game.HUDScreen.ComponentData.DefaultGroup, X = game.HUDScreen.AmmoX + 150, Y = game.ScreenHeight - game.HUDScreen.AmmoBottomOffset})

	if game.HeroHasTrait("AxeRallyAspect_Secondary") then
		game.SetAnimation({ Name = "StaffReloadTimer", DestinationId = game.ScreenAnchors.AxeUIChargeAmount })
		local currentHits = game.MapState.FrenzyHits or 0
		local requiredCount = 12
		local traitData = game.GetHeroTrait("AxeRallyAspect_Secondary")
		if traitData.OnWeaponFiredFunctions and traitData.OnWeaponFiredFunctions.FunctionArgs then
			requiredCount = traitData.OnWeaponFiredFunctions.FunctionArgs.RequiredCount or requiredCount
		end
		game.SetAnimationFrameTarget({ Name = "StaffReloadTimer", DestinationId = game.ScreenAnchors.AxeUIChargeAmount, Fraction = currentHits / requiredCount, Instant = true })
		if currentHits >= requiredCount then
			game.SetAnimation({Name = "StaffReloadTimerReady", SuppressSounds = true, DestinationId = game.ScreenAnchors.AxeUI })
		end
		game.SetAlpha({ Id = game.ScreenAnchors.AxeUI, Duration = 0, Fraction = 0 })
		game.SetAlpha({ Id = game.ScreenAnchors.AxeUI, Duration = game.HUDScreen.FadeInDuration, Fraction = game.ConfigOptionCache.HUDOpacity })
		game.SetAlpha({ Id = game.ScreenAnchors.AxeUIChargeAmount, Duration = 0, Fraction = 0 })
		game.SetAlpha({ Id = game.ScreenAnchors.AxeUIChargeAmount, Duration = game.HUDScreen.FadeInDuration, Fraction = game.ConfigOptionCache.HUDOpacity })
	elseif game.HeroHasTrait("AxePerfectCriticalAspect_Secondary") then
		local trait = game.GetHeroTrait("AxePerfectCriticalAspect_Secondary")
		local currentCrit = game.round(trait.PerfectCritChance * 100 * game.GetTotalHeroTraitValue( "LuckMultiplier", { IsMultiplier = true } ))
		local maxCrit = game.round(trait.ReportedMaxCrit * 100 * game.GetTotalHeroTraitValue( "LuckMultiplier", { IsMultiplier = true } ))
		game.SetAnimation({ Name = "StaffReloadTimer", DestinationId = game.ScreenAnchors.AxeUIChargeAmount })
		game.SetAnimationFrameTarget({ Name = "StaffReloadTimer", DestinationId = game.ScreenAnchors.AxeUIChargeAmount, Fraction = currentCrit/ maxCrit, Instant = true })

		game.SetAlpha({ Id = game.ScreenAnchors.AxeUI, Duration = 0, Fraction = 0 })
		game.SetAlpha({ Id = game.ScreenAnchors.AxeUI, Duration = game.HUDScreen.FadeInDuration, Fraction = game.ConfigOptionCache.HUDOpacity })
		game.SetAlpha({ Id = game.ScreenAnchors.AxeUIChargeAmount, Duration = 0, Fraction = 0 })
		game.SetAlpha({ Id = game.ScreenAnchors.AxeUIChargeAmount, Duration = game.HUDScreen.FadeInDuration, Fraction = game.ConfigOptionCache.HUDOpacity })
		game.CreateTextBox({
			Id = game.ScreenAnchors.AxeUI,
			OffsetX = 26, OffsetY = -2,
			Text = "UI_CritText",
			TextSymbolScale = 0.88,
			Font = "NumericP22UndergroundSCHeavy", FontSize = 24,
			ShadowRed = 0.1, ShadowBlue = 0.1, ShadowGreen = 0.1,
			OutlineColor = {0.113, 0.113, 0.113, 1}, OutlineThickness = 1,
			ShadowAlpha = 1.0, ShadowBlur = 0, ShadowOffsetY = 2, ShadowOffsetX = 0,
			Justification = "Left",LuaKey = "TempTextData", LuaValue = { Amount = currentCrit }
		})
	end
end)

modutil.mod.Path.Wrap("ShowSuitUI", function (base, args)
	base(args)
	args = args or {}
	if (not game.HeroHasTrait("SuitMarkCritAspect_Secondary") and not game.HeroHasTrait("SuitComboAspect_Secondary")) or not game.ShowingCombatUI then
		return
	end
	if game.ScreenAnchors.SuitUI ~= nil then
		game.SetAlpha({ Ids = { game.ScreenAnchors.SuitUI, game.ScreenAnchors.SuitUIChargeAmount }, Duration = args.FadeDuration or game.HUDScreen.FadeInDuration, Fraction = args.Fraction or game.ConfigOptionCache.HUDOpacity })
		return
	end

	game.ScreenAnchors.SuitUI = game.CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray_Overlay_Additive", X = game.HUDScreen.AmmoX + 150, Y = game.ScreenHeight - game.HUDScreen.AmmoBottomOffset})
	game.ScreenAnchors.SuitUIChargeAmount = game.CreateScreenObstacle({ Name = "BlankObstacle", Group = game.HUDScreen.ComponentData.DefaultGroup, X = game.HUDScreen.AmmoX + 150, Y = game.ScreenHeight - game.HUDScreen.AmmoBottomOffset})
	game.SetAnimation({ Name = "StaffReloadTimer", DestinationId = game.ScreenAnchors.SuitUIChargeAmount })
	game.SetAnimationFrameTarget({ Name = "StaffReloadTimer", DestinationId = game.ScreenAnchors.SuitUIChargeAmount, Fraction = 0, Instant = true })
	game.SetAlpha({ Id = game.ScreenAnchors.SuitUI, Duration = 0, Fraction = 0 })
	game.SetAlpha({ Id = game.ScreenAnchors.SuitUI, Duration = game.HUDScreen.FadeInDuration, Fraction = game.ConfigOptionCache.HUDOpacity })
	game.SetAlpha({ Id = game.ScreenAnchors.SuitUIChargeAmount, Duration = 0, Fraction = 0 })
	game.SetAlpha({ Id = game.ScreenAnchors.SuitUIChargeAmount, Duration = game.HUDScreen.FadeInDuration, Fraction = game.ConfigOptionCache.HUDOpacity })
	game.CreateTextBox({
		Id = game.ScreenAnchors.SuitUI,
		OffsetX = 26, OffsetY = -2,
		TextSymbolScale = 0.88,
		Font = "NumericP22UndergroundSCHeavy", FontSize = 24,
		ShadowRed = 0.1, ShadowBlue = 0.1, ShadowGreen = 0.1,
		OutlineColor = {0.113, 0.113, 0.113, 1}, OutlineThickness = 1,
		ShadowAlpha = 1.0, ShadowBlur = 0, ShadowOffsetY = 2, ShadowOffsetX = 0,
		Justification = "Left",
		})
	game.UpdateSuitUI()
end)

modutil.mod.Path.Wrap("UpdateSuitUI", function (base)
	base()
	if game.HeroHasTrait("SuitComboAspect_Secondary") then
		local trait = game.GetHeroTrait("SuitComboAspect_Secondary")
		local effectName = trait.OnWeaponFiredFunctions.FunctionArgs.EffectName
		local stacks = 0
		local maxStacks = trait.OnWeaponFiredFunctions.FunctionArgs.SelfEffectMaxStacks

		if not game.IsEmpty(game.CurrentRun.Hero.ActiveEffects) and game.CurrentRun.Hero.ActiveEffects[effectName] then
			stacks = game.CurrentRun.Hero.ActiveEffects[effectName]
		end

		local text = "UI_StackText"
		local font = "NumericP22UndergroundSCHeavy"
		if stacks >= trait.OnWeaponFiredFunctions.FunctionArgs.SelfEffectMaxStacks then
			text = "UI_StackText_Max"
			font = "P22UndergroundSCHeavy"
		end
		game.SetAnimationFrameTarget({ Name = "StaffReloadTimer", DestinationId = game.ScreenAnchors.SuitUIChargeAmount, Fraction = stacks/maxStacks, Instant = true })
		if stacks >= maxStacks then
			game.SetAnimation({ Name = "StaffReloadTimerReady", DestinationId = game.ScreenAnchors.SuitUI })
		else
			game.StopAnimation({ Name = "StaffReloadTimerReady", DestinationId = game.ScreenAnchors.SuitUI })
		end
		game.ModifyTextBox({ Id = game.ScreenAnchors.SuitUI, Text =  text, Font = font, LuaKey = "TempTextData", LuaValue = { Amount = stacks}})
	end
end)

modutil.mod.Path.Wrap("ShivaAttackBoostApply", function (base, triggerArgs)
	base(triggerArgs)
	if not game.HeroHasTrait("SuitComboAspect_Secondary") then
		return
	end
	local victim = triggerArgs.Victim
	game.IncrementTableValue( victim.ActiveEffects, triggerArgs.EffectName )

	game.UpdateSuitUI()

	local trait = game.GetHeroTrait("SuitComboAspect_Secondary")
	local maxStacks = trait.OnWeaponFiredFunctions.FunctionArgs.SelfEffectMaxStacks
	game.PlaySound({ Name = "/SFX/Player Sounds/ShivaPowerUp", Id = game.CurrentRun.Hero.ObjectId })
	game.SetAnimationFrameTarget({ Name = "StaffReloadTimer", DestinationId = game.ScreenAnchors.SuitUIChargeAmount, Fraction = victim.ActiveEffects[triggerArgs.EffectName]/maxStacks, Instant = true })
	if victim.ActiveEffects[triggerArgs.EffectName] >= maxStacks then
		game.SessionMapState.ShivaMaxStackPresentation = true
		game.SetAnimation({ Name = "StaffReloadTimerReady", DestinationId = game.ScreenAnchors.SuitUI })
	end
end)

modutil.mod.Path.Wrap("ShivaAttackBoostClear", function (base, triggerArgs)
	base(triggerArgs)
	if not game.HeroHasTrait("SuitComboAspect_Secondary") then
		return
	end

	local victim = triggerArgs.Victim
	local trait = game.GetHeroTrait("SuitComboAspect_Secondary")

	game.SetAnimationFrameTarget({ Name = "StaffReloadTimer", DestinationId = game.ScreenAnchors.SuitUIChargeAmount, Fraction = 0, Instant = true })
	if game.SessionMapState.ShivaMaxStackPresentation then
		game.SetAnimation({ Name = "StaffReloadTimerOut", DestinationId = game.ScreenAnchors.SuitUI })
		game.SessionMapState.ShivaMaxStackPresentation = nil
	end
	game.UpdateSuitUI()
end)

modutil.mod.Path.Wrap("CheckSuitComboAttackBuff", function (base, weaponData, functionArgs, triggerArgs)
	if game.Contains({"WeaponAxeSpin", "WeaponStaffSwing5", "WeaponLob", "WeaponTorch"}, weaponData.Name) and
			game.IsExWeapon( weaponData.Name, { Combat = true }, triggerArgs ) then
		if weaponData.Name == "WeaponStaffSwing5" then
			game.waitUntil(_PLUGIN.guid .. "ProjectileCreation")
			if not game.HeroHasTrait("StaffRaiseDeadAspect") then
				game.waitUntil(_PLUGIN.guid .. "ProjectileCreation")
			end
			if game.HeroHasTrait("StaffExAoETrait") then
				game.waitUntil(_PLUGIN.guid .. "ProjectileCreation")
				game.waitUntil(_PLUGIN.guid .. "ProjectileCreation")
			end
		elseif weaponData.Name == "WeaponAxeSpin" then
			game.waitUntil(_PLUGIN.guid .. "ProjectileCreation")
		elseif weaponData.Name == "WeaponTorch" then
			game.wait(0.01)
		elseif weaponData.Name == "WeaponLob" then

		end

		local projectileIds = game.SessionMapState[_PLUGIN.guid .. "ProjectileIds"] or {}
		local stacks = game.CurrentRun.Hero.ActiveEffects[functionArgs.EffectName]
		if not stacks then
			game.SessionMapState[_PLUGIN.guid .. "ProjectileIds"] = nil
			return
		end
		if functionArgs.SelfEffectMaxStacks and stacks > functionArgs.SelfEffectMaxStacks then
			stacks = functionArgs.SelfEffectMaxStacks
		end
		for _, id in ipairs(projectileIds) do
			game.SessionMapState.SuitBonusProjectileId[id] = 1 + functionArgs.SelfEffectStackMultiplier * stacks
		end
		game.ClearEffect({Id = game.CurrentRun.Hero.ObjectId, Name = "ShivaAttackBoost"})
		game.SessionMapState[_PLUGIN.guid .. "ProjectileIds"] = nil
		return
	elseif game.Contains({"WeaponAxeSpin", "WeaponStaffSwing5", "WeaponLob", "WeaponTorch"}, weaponData.Name) then
		game.SessionMapState[_PLUGIN.guid .. "ProjectileIds"] = nil
		return
	end
	game.SessionMapState[_PLUGIN.guid .. "ProjectileIds"] = nil
	base(weaponData, functionArgs, triggerArgs)
end)

function mod.CheckSuitComboAttackBuff(triggerArgs, functionArgs)
	game.SessionMapState[_PLUGIN.guid .. "ProjectileIds"] = game.SessionMapState[_PLUGIN.guid .. "ProjectileIds"] or {}
	table.insert(game.SessionMapState[_PLUGIN.guid .. "ProjectileIds"], triggerArgs.ProjectileId)
	game.notifyExistingWaiters(_PLUGIN.guid .. "ProjectileCreation")
end

function mod.StopThanatosMaxMortalityFx()
	game.StopAnimation({ Name = "ThanatosMaxMortalityFx", DestinationId = game.CurrentRun.Hero.ObjectId})
end

modutil.mod.Path.Wrap("ShowDaggerUI", function (base, args)
	base(args)

	if game.HeroHasTrait("DaggerBlockAspect") then
		return
	end

	args = args or {}
	if not game.ShowingCombatUI  and not args.Force then
		return
	end
	if not game.HeroHasTrait("DaggerBlockAspect_Secondary") then
		return
	end

	if game.ScreenAnchors.DaggerUI ~= nil then
		game.SetAlpha({ Ids = { game.ScreenAnchors.DaggerUI, game.ScreenAnchors.DaggerUIChargeAmount }, Duration = args.FadeDuration or game.HUDScreen.FadeInDuration, Fraction = args.Fraction or game.ConfigOptionCache.HUDOpacity })
		return
	end
	if game.ScreenAnchors.DaggerUIChargeAmount then
		game.Destroy({ Id = game.ScreenAnchors.DaggerUIChargeAmount })
	end

	game.ScreenAnchors.DaggerUI = game.CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray_Overlay_Additive", X = game.HUDScreen.AmmoX + 150 , Y = game.ScreenHeight - game.HUDScreen.AmmoBottomOffset })
	game.ScreenAnchors.DaggerUIChargeAmount = game.CreateScreenObstacle({ Name = "BlankObstacle", Group = game.HUDScreen.ComponentData.DefaultGroup, X = game.HUDScreen.AmmoX + 150, Y = game.ScreenHeight - game.HUDScreen.AmmoBottomOffset })

	local trait = game.GetHeroTrait("DaggerBlockAspect_Secondary")
	local totalTime = trait.OnWeaponChargeFunctions.FunctionArgs.Cooldown

	if not game.CheckCooldownNoTrigger("DaggerBlockShield", totalTime) and game.SessionState.GlobalCooldowns.DaggerBlockShield then
		local remainingTime = totalTime - ( game._worldTime - game.SessionState.GlobalCooldowns.DaggerBlockShield)			
		game.SetAnimation({ Name = "StaffReloadTimer", DestinationId = game.ScreenAnchors.DaggerUIChargeAmount, PlaySpeed = game.ScreenData.HUD.ReloadTimerFrames / totalTime })
		game.SetAnimation({ Name = "StaffReloadTimer", DestinationId = game.ScreenAnchors.DaggerUIChargeAmount, StartFrameFraction = 1 - remainingTime / totalTime })
		game.SetAnimationFrameTarget({ Name = "StaffReloadTimer", DestinationId = game.ScreenAnchors.DaggerUIChargeAmount, Fraction = 1 })
	else
		game.SetAnimation({ Name = "StaffReloadTimerReady",SuppressSounds = true, DestinationId = game.ScreenAnchors.DaggerUI })
		game.SetAnimation({ Name = "StaffReloadTimer", DestinationId = game.ScreenAnchors.DaggerUIChargeAmount})
		game.SetAnimationFrameTarget({ Name = "StaffReloadTimer", DestinationId = game.ScreenAnchors.DaggerUIChargeAmount, Fraction = 1, Instant = true })
	end
	game.SetAlpha({ Id = game.ScreenAnchors.DaggerUI, Duration = 0, Fraction = 0 })
	game.SetAlpha({ Id = game.ScreenAnchors.DaggerUI, Duration = game.HUDScreen.FadeInDuration, Fraction = game.ConfigOptionCache.HUDOpacity })
	game.SetAlpha({ Id = game.ScreenAnchors.DaggerUIChargeAmount, Duration = 0, Fraction = 0 })
	game.SetAlpha({ Id = game.ScreenAnchors.DaggerUIChargeAmount, Duration = game.HUDScreen.FadeInDuration, Fraction = game.ConfigOptionCache.HUDOpacity })
end)

modutil.mod.Path.Wrap("ShowLobUI", function (base)
	base()
	if (not game.HeroHasTrait("LobImpulseAspect_Secondary") and not game.HeroHasTrait("LobGunAspect_Secondary")) or not game.ShowingCombatUI then
		return
	end

	if game.ScreenAnchors.LobUI ~= nil then
		return
	end
	game.ScreenAnchors.LobUI = game.CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray_Overlay_Additive", X = game.HUDScreen.AmmoX + 150, Y = game.ScreenHeight - game.HUDScreen.AmmoBottomOffset })
	game.ScreenAnchors.LobUIChargeAmount = game.CreateScreenObstacle({ Name = "BlankObstacle", Group = game.HUDScreen.ComponentData.DefaultGroup, X = game.HUDScreen.AmmoX + 150, Y = game.ScreenHeight - game.HUDScreen.AmmoBottomOffset })
	game.SetAnimation({ Name = "StaffReloadTimer", DestinationId = game.ScreenAnchors.LobUIChargeAmount })
	if game.HeroHasTrait("LobImpulseAspect_Secondary") then
		local trait = game.GetHeroTrait("LobImpulseAspect_Secondary")
		local currentCharge = trait.Charge
		local maxCharge = trait.OnEnemyDamagedAction.Args.MaxCharge
		local currentChargeText = game.round( currentCharge, 1)
		game.SetAnimationFrameTarget({ Name = "StaffReloadTimer", DestinationId = game.ScreenAnchors.LobUIChargeAmount, Fraction = currentCharge/ maxCharge, Instant = true })

		if trait.Charge >= trait.OnEnemyDamagedAction.Args.MaxCharge then
			game.SetAnimation({ Name = "StaffReloadTimerReady", SuppressSounds = true, DestinationId = game.ScreenAnchors.LobUI })
		end
	elseif game.HeroHasTrait("LobGunAspect_Secondary") then
		game.SetAnimationFrameTarget({ Name = "StaffReloadTimer", DestinationId = game.ScreenAnchors.LobUIChargeAmount, Fraction = 0, Instant = true })
	end
	game.SetAlpha({ Id = game.ScreenAnchors.LobUI, Duration = 0, Fraction = 0 })
	game.SetAlpha({ Id = game.ScreenAnchors.LobUI, Duration = game.HUDScreen.FadeInDuration, Fraction = game.ConfigOptionCache.HUDOpacity })
	game.SetAlpha({ Id = game.ScreenAnchors.LobUIChargeAmount, Duration = 0, Fraction = 0 })
	game.SetAlpha({ Id = game.ScreenAnchors.LobUIChargeAmount, Duration = game.HUDScreen.FadeInDuration, Fraction = game.ConfigOptionCache.HUDOpacity })
end)

game.OnWeaponChargeCanceled{ "WeaponAxeSpin",
	function( triggerArgs )
		if game.MapState.DaggerBlockShieldActive then
			game.MapState.DaggerBlockShieldActive = false
			game.SetThingProperty({ Property = "AllowDodge", Value = true, DestinationId = game.CurrentRun.Hero.ObjectId, DataValue = false })
			game.SetPlayerInterruptible("DaggerBlock")
			local traitData = game.GetHeroTrait("DaggerBlockAspect_Secondary")
			local chargeFunctionArgs = traitData.OnWeaponChargeFunctions.FunctionArgs
			if chargeFunctionArgs.Vfx then
				game.StopAnimation({ Name = chargeFunctionArgs.Vfx, DestinationId = game.CurrentRun.Hero.ObjectId })
			end
			if chargeFunctionArgs.BackVfx then
				game.StopAnimation({ Name = chargeFunctionArgs.BackVfx, DestinationId = game.CurrentRun.Hero.ObjectId })
			end
		end
	end
}

game.OnWeaponChargeCanceled{ "WeaponTorch",
	function( triggerArgs )
		if game.MapState.DaggerBlockShieldActive then
			game.MapState.DaggerBlockShieldActive = false
			game.SetThingProperty({ Property = "AllowDodge", Value = true, DestinationId = game.CurrentRun.Hero.ObjectId, DataValue = false })
			game.SetPlayerInterruptible("DaggerBlock")
			local traitData = game.GetHeroTrait("DaggerBlockAspect_Secondary")
			local chargeFunctionArgs = traitData.OnWeaponChargeFunctions.FunctionArgs
			if chargeFunctionArgs.Vfx then
				game.StopAnimation({ Name = chargeFunctionArgs.Vfx, DestinationId = game.CurrentRun.Hero.ObjectId })
			end
			if chargeFunctionArgs.BackVfx then
				game.StopAnimation({ Name = chargeFunctionArgs.BackVfx, DestinationId = game.CurrentRun.Hero.ObjectId })
			end
		end
	end
}

game.OnWeaponChargeCanceled{ "WeaponStaffSwing5",
	function( triggerArgs )
		if game.MapState.DaggerBlockShieldActive then
			game.MapState.DaggerBlockShieldActive = false
			game.SetThingProperty({ Property = "AllowDodge", Value = true, DestinationId = game.CurrentRun.Hero.ObjectId, DataValue = false })
			game.SetPlayerInterruptible("DaggerBlock")
			local traitData = game.GetHeroTrait("DaggerBlockAspect_Secondary")
			local chargeFunctionArgs = traitData.OnWeaponChargeFunctions.FunctionArgs
			if chargeFunctionArgs.Vfx then
				game.StopAnimation({ Name = chargeFunctionArgs.Vfx, DestinationId = game.CurrentRun.Hero.ObjectId })
			end
			if chargeFunctionArgs.BackVfx then
				game.StopAnimation({ Name = chargeFunctionArgs.BackVfx, DestinationId = game.CurrentRun.Hero.ObjectId })
			end
		end
	end
}

game.OnWeaponChargeCanceled{ "WeaponSuitCharged",
	function( triggerArgs )
		if game.MapState.DaggerBlockShieldActive then
			game.MapState.DaggerBlockShieldActive = false
			game.SetThingProperty({ Property = "AllowDodge", Value = true, DestinationId = game.CurrentRun.Hero.ObjectId, DataValue = false })
			game.SetPlayerInterruptible("DaggerBlock")
			local traitData = game.GetHeroTrait("DaggerBlockAspect_Secondary")
			local chargeFunctionArgs = traitData.OnWeaponChargeFunctions.FunctionArgs
			if chargeFunctionArgs.Vfx then
				game.StopAnimation({ Name = chargeFunctionArgs.Vfx, DestinationId = game.CurrentRun.Hero.ObjectId })
			end
			if chargeFunctionArgs.BackVfx then
				game.StopAnimation({ Name = chargeFunctionArgs.BackVfx, DestinationId = game.CurrentRun.Hero.ObjectId })
			end
		end
	end
}

game.OnWeaponChargeCanceled{ "WeaponLob",
	function( triggerArgs )
		if game.MapState.DaggerBlockShieldActive then
			game.MapState.DaggerBlockShieldActive = false
			game.SetThingProperty({ Property = "AllowDodge", Value = true, DestinationId = game.CurrentRun.Hero.ObjectId, DataValue = false })
			game.SetPlayerInterruptible("DaggerBlock")
			local traitData = game.GetHeroTrait("DaggerBlockAspect_Secondary")
			local chargeFunctionArgs = traitData.OnWeaponChargeFunctions.FunctionArgs
			if chargeFunctionArgs.Vfx then
				game.StopAnimation({ Name = chargeFunctionArgs.Vfx, DestinationId = game.CurrentRun.Hero.ObjectId })
			end
			if chargeFunctionArgs.BackVfx then
				game.StopAnimation({ Name = chargeFunctionArgs.BackVfx, DestinationId = game.CurrentRun.Hero.ObjectId })
			end
		end
	end
}

if game.TraitData.LobCloseAttackAspect.OnEnemyDamagedAction then
	game.TraitData.LobCloseAttackAspect.OnEnemyDamagedAction.ValidWeapons =
	{
		"WeaponLobSpecial", "WeaponStaffBall", "WeaponDaggerThrow", "WeaponTorchSpecial", "WeaponAxeSpecial", "WeaponSuitRanged"
	}
end

game.WeaponData.WeaponBlink.OnFiredFunctionNames = game.WeaponData.WeaponBlink.OnFiredFunctionNames or {}

table.insert(game.WeaponData.WeaponBlink.OnFiredFunctionNames, _PLUGIN.guid .. "." .. "RecordBlinkCharge")

function mod.RecordBlinkCharge(unit, weaponData, args, triggerArgs)
	if game.CurrentRun.Hero.Weapons["WeaponLob"] and not game.CurrentRun.Hero.Weapons["WeaponLobSpecial"] then
		local ammoPacks  = game.GetIdsByType({ Name = "LobAmmoPack"})
		game.SetObstacleProperty({ Property = "Magnetism", Value = game.WeaponData.WeaponLobSpecial.MagnetismMultiplier, DestinationIds = ammoPacks, ValueChangeType = "Multiply" })
		game.SessionMapState.MagnetismMultiplier = game.WeaponData.WeaponLobSpecial.MagnetismMultiplier
	end
end

game.OnBlinkFinished{ "WeaponBlink", function (triggerArgs)
	if game.CurrentRun.Hero.Weapons["WeaponLob"] and not game.CurrentRun.Hero.Weapons["WeaponLobSpecial"] and game.SessionMapState.MagnetismMultiplier then
		for id, data in pairs( game.SessionMapState.AutoMagnetizeIds ) do
			data.MagnetismMultiplier = game.WeaponData.WeaponLobSpecial.MagnetismMultiplier
		end

		local playerMagnetism = game.SessionMapState.MagnetismMultiplier * game.GetBaseDataValue({ Type = "Obstacle", Name = "LobAmmoPack", Property = "Magnetism"})
		local ammoPacks  = game.GetIdsByType({ Name = "LobAmmoPack"})
		for _, ammoId in pairs( ammoPacks ) do
			if game.GetDistance ({ Id = ammoId, DestinationId = game.CurrentRun.Hero.ObjectId }) >= playerMagnetism then
				game.SetObstacleProperty({ Property = "Magnetism", Value = 1/game.SessionMapState.MagnetismMultiplier, DestinationId = ammoId, ValueChangeType = "Multiply" })
			end
		end
		game.SessionMapState.MagnetismMultiplier = nil
	end
end}

modutil.mod.Path.Wrap("HandleGunBehavior", function (base, weaponData, functionArgs, triggerArgs)
	base(weaponData, functionArgs, triggerArgs)
	if game.IsExWeapon( weaponData.Name, { Combat = true }, triggerArgs )  then
		local chargeStages = game.GetWeaponChargeStages( weaponData )
		local weaponCharge = (game.MapState.WeaponCharge or {})[weaponData.Name] or 1
		if #chargeStages <= weaponCharge and game.Contains( {"WeaponStaffBall", "WeaponDaggerThrow", "WeaponTorchSpecial", "WeaponAxeSpecial", "WeaponAxeSpecialSwing", "WeaponSuitRanged"}, weaponData.Name ) then
			local dataProperties = game.MergeTables(game.EffectData[functionArgs.EffectName].DataProperties, functionArgs.EffectData)
			dataProperties.Duration = dataProperties.Duration + game.GetTotalHeroTraitValue("OverheatDurationIncrease")
			game.ApplyEffect({ DestinationId = game.CurrentRun.Hero.ObjectId, Id = game.CurrentRun.Hero.ObjectId, EffectName = functionArgs.EffectName, DataProperties = dataProperties })
		end
	end
end)

modutil.mod.Path.Wrap("BlockLaunchMissile", function (base, blocker, args, triggerArgs)
	if not game.CurrentRun.Hero.Weapons["WeaponSuitRanged"] then
		if not blocker or not blocker.ObjectId then
			return
		end
		if triggerArgs.WeaponName == "WeaponSuitCharged" and not game.CheckCountInWindow( "SuitRetaliate", args.Window, args.Count + 1) and game.CheckCooldown("SuitRetaliate"..blocker.ObjectId, args.PerEnemyCooldown ) then
			local projectileName = "ProjectileSuitRangedGuided"
			local weaponName = "WeaponSuitRanged"
			local projectileCount = args.ProjectileCount or 5
			local derivedValues = game.GetDerivedPropertyChangeValues({
				ProjectileName = projectileName,
				WeaponName = weaponName ,
				Type = "Projectile",
				MatchProjectileName = true,
			})

			local enemyId = nil
			local weaponData = game.GetWeaponData( game.CurrentRun.Hero, "WeaponSuitRanged" )

			for i=1, projectileCount do
				enemyId = game.GetClosest({
					Id = game.CurrentRun.Hero.ObjectId,
					DestinationName = "EnemyTeam",
					IgnoreInvulnerable = true,
					IgnoreHomingIneligible = true,
					IgnoreSelf = true,
					ExcludeId = game.SessionMapState.ExistingMissileTargetId,
					Distance = weaponData.Range,
					YScale = weaponData.SeekScaleY,
					Arc = weaponData.UnguidedSeekAngle,
					Angle = game.GetAngle({ Id = game.CurrentRun.Hero.ObjectId }),
				})
				if enemyId == 0 then
					enemyId = game.SessionMapState.ExistingMissileTargetId
				end
				game.SessionMapState.ExistingMissileTargetId = enemyId

				local projectile = game.CreateProjectileFromUnit({ WeaponName = game.WeaponData["WeaponSuit"].SecondaryWeapon, Name = projectileName,
					DestinationId = game.CurrentRun.Hero.ObjectId, TargetIdOverride = enemyId, Id = game.CurrentRun.Hero.ObjectId, FireFromTarget = true,
					Duration = 0.5, EaseOut = 1, DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges,
					Angle = game.GetAngle({ Id = game.CurrentRun.Hero.ObjectId }) + game.RandomFloat(-100, 100), PerfectCharge = triggerArgs.PerfectCharge
				})
				game.SessionMapState.InvalidSplitIds[projectile] = true
				game.wait(0.03)
			end
		end
	end
	return base(blocker, args, triggerArgs)
end)

modutil.mod.Path.Wrap("FireDaggerSpecial", function (base, weaponData, traitArgs, triggerArgs)
	if game.CurrentRun.Hero.Weapons.WeaponDagger and not game.CurrentRun.Hero.Weapons.WeaponDaggerThrow then
		local weaponProjectileMap = {
			WeaponStaffBall = "ProjectileStaffBall",
			WeaponTorchSpecial = "ProjectileTorchOrbit",
			WeaponAxeSpecial = "ProjectileAxeSpecial",
			WeaponSuitRanged = "ProjectileSuitRangedUnguided",
			WeaponLobSpecial = "ProjectileDaggerThrow",
			WeaponDaggerThrow = "ProjectileDaggerThrow",
		}
		if game.HeroHasTrait("LobGunAspect_Secondary") then
			weaponProjectileMap.WeaponLobSpecial = "ProjectileLobSpecialBounce"
		end
		local secondWeapon = game.WeaponData["WeaponDagger"].SecondaryWeapon
		local chosenProjectile = weaponProjectileMap[secondWeapon]
		if secondWeapon == "WeaponSuitRanged" and game.HeroHasTrait("SuitComboAspect_Secondary") then
			chosenProjectile = "ProjectileSuitGrenade"
			if game.HeroHasTrait("SuitComboForwardRocketTrait") then
				chosenProjectile = "ProjectileSuitGrenadeStraight"
			end
		end
		local startAngle = game.GetAngle({ Id = game.CurrentRun.Hero.ObjectId })

		local propertyWeapon = secondWeapon
		if chosenProjectile == "ProjectileDaggerThrow" then
			propertyWeapon = "WeaponDaggerThrow"
		end
		local derivedValues = game.GetDerivedPropertyChangeValues({
			ProjectileName = chosenProjectile,
			WeaponName = propertyWeapon,
			Type = "Projectile",
		})

		if chosenProjectile == "ProjectileAxeSpecial" and secondWeapon == "WeaponAxeSpecial" and not derivedValues.PropertyChanges.StartFx then
			derivedValues.PropertyChanges.StartFx = "AxeSwipeUpper"
		end

		local spread = traitArgs.Spread
		if chosenProjectile == "ProjectileTorchOrbit" then
			spread = 240
		elseif chosenProjectile == "ProjectileAxeSpecial" then
			spread = 90
		end

		for i=1, traitArgs.Projectiles do
			local projectileId = game.CreateProjectileFromUnit({ WeaponName = secondWeapon, Name = chosenProjectile, Id = game.CurrentRun.Hero.ObjectId,
				Angle = startAngle - spread/2 + (i - 1) * spread/(traitArgs.Projectiles - 1 ), DataProperties = derivedValues.PropertyChanges, ThingProperties = derivedValues.ThingPropertyChanges })
		end
	else
		base(weaponData, traitArgs, triggerArgs)
	end
end)

modutil.mod.Path.Wrap("CheckDaggerCritCharges", function (base, weaponData, functionArgs, triggerArgs)
	if game.HeroHasTrait("TorchAutofireAspect") or weaponData.Name == "WeaponAxeSpin" then
		return
	end
	return base(weaponData, functionArgs, triggerArgs)
end)

modutil.mod.Path.Wrap("CalculateCritChance", function (base, attacker, victim, weaponData, triggerArgs)
	local critChance = { CritChance = base(attacker, victim, weaponData, triggerArgs) }
	if attacker ~= nil and attacker.OutgoingCritModifiers ~= nil and ( not weaponData or not weaponData.IgnoreOutgoingCritModifiers ) then
		for i, modifierData in ipairs( attacker.OutgoingCritModifiers ) do
			local validProjectile = modifierData.ValidProjectilesLookup == nil or ( triggerArgs.SourceProjectile and modifierData.ValidProjectilesLookup[ triggerArgs.SourceProjectile ] ~= nil and triggerArgs.EffectName == nil )
			local validWeapon = modifierData.ValidWeaponsLookup == nil or ( modifierData.ValidWeaponsLookup[ triggerArgs.SourceWeapon ] ~= nil and triggerArgs.EffectName == nil )
			if validWeapon and validProjectile then
				if attacker == game.CurrentRun.Hero then
					if modifierData.ValidVolleyChance and game.MapState[_PLUGIN.guid .. "CritVolleys"] and game.MapState[_PLUGIN.guid .. "CritVolleys"][triggerArgs.SourceWeapon] and triggerArgs.ProjectileId and game.MapState[_PLUGIN.guid .. "CritVolleys"][triggerArgs.SourceWeapon][triggerArgs.ProjectileId] then
						game.addCritMultiplier( modifierData, modifierData.ValidVolleyChance, critChance )
					end
				end
			end
		end
	end
	return critChance.CritChance
end)

function mod.CheckDaggerCritChargesProjectile(triggerArgs, functionArgs)
	local weaponData = game.WeaponData.WeaponTorch
	if triggerArgs.name == "ProjectileAxeSpin" then
		weaponData = game.WeaponData.WeaponAxeSpin
	end
	if weaponData.Name == "WeaponAxeSpin" or game.HeroHasTrait("TorchAutofireAspect") then
		if game.MapState.DaggerCharges and game.MapState.DaggerCharges >= 1 then
			game.MapState[_PLUGIN.guid .. "CritVolleys"] = game.MapState[_PLUGIN.guid .. "CritVolleys"] or {}
			game.MapState[_PLUGIN.guid .. "CritVolleys"][weaponData.Name] = game.MapState[_PLUGIN.guid .. "CritVolleys"][weaponData.Name] or {}

			game.IncrementTableValue(game.MapState[_PLUGIN.guid .. "CritVolleys"][weaponData.Name], triggerArgs.ProjectileId, 1)
			local numProjectiles = 1

			game.MapState.DaggerCharges = game.MapState.DaggerCharges - numProjectiles

			for k,v in ipairs( game.SessionMapState.DaggerCritTicks ) do
				if k > game.MapState.DaggerCharges then
					game.RemoveArtemisDaggerTick( k )
				end
			end

			if game.MapState.DaggerCharges <= 0 then
				local traitData = game.GetHeroTrait("DaggerBlockAspect_Secondary")
				local chargeFunctionArgs = traitData.OnWeaponChargeFunctions.FunctionArgs
				game.thread( game.DaggerBlockClearedPresentation, chargeFunctionArgs )
				game.MapState.DaggerCharges = 0
			end
		end
	end
end

function mod.CheckAxeFreeSpinCrit(victim, functionArgs, triggerArgs)
	if game.HeroHasTrait("AxeFreeSpinTrait") and game.CheckCooldown(_PLUGIN.guid .. "FreeSpinCrit", 0.15) then
		if game.MapState.DaggerCharges and game.MapState.DaggerCharges >= 1 then
			game.MapState.DaggerCharges = game.MapState.DaggerCharges - 1
			for k,v in ipairs( game.SessionMapState.DaggerCritTicks ) do
				if k > game.MapState.DaggerCharges then
					game.RemoveArtemisDaggerTick( k )
				end
			end
			if game.MapState.DaggerCharges <= 0 then
				local traitData = game.GetHeroTrait("DaggerBlockAspect_Secondary")
				local chargeFunctionArgs = traitData.OnWeaponChargeFunctions.FunctionArgs
				game.thread( game.DaggerBlockClearedPresentation, chargeFunctionArgs )
				game.MapState.DaggerCharges = 0
			end
			if game.MapState.DaggerCharges <= 0 then
				game.wait(0.1)
				game.MapState[_PLUGIN.guid .. "CritVolleys"]["WeaponAxeSpin"] = {}
			end
		end
	end
end