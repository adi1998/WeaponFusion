modutil.mod.Path.Context.Wrap.Static("DoThrowEx", function (weaponName)
    modutil.mod.Path.Wrap("GetDerivedPropertyChangeValues", function (base, args)
        if args.ProjectileName == "ProjectileThrowCharged" and game.HeroHasTrait("StaffSelfHitAspect") and game.SessionMapState[_PLUGIN.guid.."DoThrowExRecord"] then
            table.insert(game.SessionMapState[_PLUGIN.guid.."DoThrowExRecord"], {
                Angle = game.GetAngle({ Id = game.CurrentRun.Hero.ObjectId }),
                Location = game.GetLocation({ Id = game.CurrentRun.Hero.ObjectId }),
                Time = game._worldTime
            })
        end
        return base(args)
    end)
end)