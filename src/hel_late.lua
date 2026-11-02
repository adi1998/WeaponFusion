modutil.mod.Path.Context.Env("OverheatApply", function ()
	modutil.mod.Path.Wrap("SetAnimation", function (base, args)
		if args.Name == "StaffReloadTimer" and game.HeroHasTrait("LobGunAspect_Secondary") then
			args.DestinationId = game.ScreenAnchors.LobUIChargeAmount_Secondary
		end
        if args.Name == "StaffReloadTimerReady" and game.HeroHasTrait("LobGunAspect_Secondary") then
			args.DestinationId = game.ScreenAnchors.LobUI_Secondary
		end
		return base(args)
	end)
	modutil.mod.Path.Wrap("SetAnimationFrameTarget", function (base, args)
		if args.Name == "StaffReloadTimer" and game.HeroHasTrait("LobGunAspect_Secondary") then
			args.DestinationId = game.ScreenAnchors.LobUIChargeAmount_Secondary
		end
		return base(args)
	end)
    modutil.mod.Path.Wrap("ModifyTextBox", function (base, args)
		if args.Id == game.ScreenAnchors.LobUI and game.HeroHasTrait("LobGunAspect_Secondary") then
			args.Id = game.ScreenAnchors.LobUI_Secondary
		end
		return base(args)
	end)
end)

modutil.mod.Path.Context.Env("OverheatClear", function ()
    modutil.mod.Path.Wrap("ModifyTextBox", function (base, args)
		if args.Id == game.ScreenAnchors.LobUI and game.HeroHasTrait("LobGunAspect_Secondary") then
			args.Id = game.ScreenAnchors.LobUI_Secondary
		end
		return base(args)
	end)
end)