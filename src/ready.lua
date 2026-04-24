mod.WeaponData = {
    WeaponStaffSwing = {
        Primary = {
            "WeaponStaffSwing2", "WeaponStaffSwing3", "WeaponStaffSwing5", "WeaponStaffDash"
        },
        Secondary = {
            "WeaponStaffBall"
        },
        PrimaryHammers = {
            "StaffExHealTrait",
            "StaffDoubleAttackTrait",
            "StaffLongAttackTrait",
            "StaffDashAttackTrait",
            "StaffAttackRecoveryTrait",
            "StaffExAoETrait",
            "StaffOneWayAttackTrait",
        },
        SecondaryHammers = {
            "StaffSecondStageTrait",
            "StaffPowershotTrait",
            "StaffFastSpecialTrait",
            "StaffJumpSpecialTrait",
            "StaffTripleShotTrait",
        }
    },

    WeaponDagger = {
        Primary = {
            "WeaponDagger2", "WeaponDagger5", "WeaponDaggerDash", "WeaponDaggerDouble", "WeaponDaggerMultiStab", "WeaponDaggerBlink"
        },
        Secondary = {
            "WeaponDaggerThrow"
        },
        PrimaryHammers = {
            "DaggerBlinkAoETrait",
            "DaggerDashAttackTripleTrait",
            "DaggerRapidAttackTrait",
            "DaggerAttackFinisherTrait",
            "DaggerFinalHitTrait",
            "DaggerBackstabTrait",

        },
        SecondaryHammers = {
            "DaggerSpecialLineTrait",
            "DaggerSpecialFanTrait",
            "DaggerSpecialConsecutiveTrait",
            "DaggerSpecialJumpTrait",
            "DaggerChargeStageSkipTrait",
            "DaggerSpecialReturnTrait",

        }
    }
}


function PatchHammerRequirements(hammerName, weaponName)
    local hammerData = game.TraitData[hammerName]
    hammerData.GameStateRequirements[1] =
    {
        Path = { "CurrentRun", "Hero", "Weapons", },
        HasAll = { weaponName, },
    }
end

for weapon, modWeaponData in pairs(mod.WeaponData) do
    for _, hammerName in ipairs(modWeaponData.SecondaryHammers) do
        PatchHammerRequirements(hammerName, modWeaponData.Secondary[1])
    end
end

function mod.PatchHeroWeaponSets(primarySource, secondarySource)
    local primaryData = mod.WeaponData[primarySource]
    local secondaryData = mod.WeaponData[secondarySource]

    game.WeaponSets.HeroWeaponSets[primarySource] = game.CombineTablesIPairs(primaryData.Primary, secondaryData.Secondary)
    game.WeaponSets.HeroWeaponSets[secondarySource] = game.CombineTablesIPairs(secondaryData.Primary, primaryData.Secondary)
end

function FuseWeapon(primarySource, secondarySource)
    mod.PatchHeroWeaponSets(primarySource, secondarySource)

    game.WeaponData[primarySource].SecondaryWeapon, game.WeaponData[secondarySource].SecondaryWeapon = game.WeaponData[secondarySource].SecondaryWeapon, game.WeaponData[primarySource].SecondaryWeapon
end

FuseWeapon("WeaponDagger", "WeaponStaffSwing")

game.SetupRunData()


modutil.mod.Path.Wrap("DropOriginMarker", function (base, weaponData, functionArgs, triggerArgs )
    if game.Contains({"WeaponDaggerThrow"}, weaponData.Name) then
        if IsExWeapon( weaponData.Name, { Combat = true }, triggerArgs ) or triggerArgs.DisjointExCast then
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
                thread(StartSpecialRepeatThread, startX, startY, GetAngle({Id = CurrentRun.Hero.ObjectId}), functionArgs, triggerArgs )
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