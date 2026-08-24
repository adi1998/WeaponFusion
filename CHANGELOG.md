# Changelog

## [Unreleased]

- Fusion state is now stored in the save file.

## [1.0.0] - 2026-08-08

- Same weapon fusion no longer experimental :)
- Fix duplicated Anubis omega special from Momus/Eos not inheriting the damage and radius boost.
- Eos will now duplicate Supay base special.
- Minor Aspect of Supay will no longer auto-fire basic torch aspects' attacks.
- Adjust Counter Barrage rocket spawn workaround
- Minor Aspect of Hel now blocks all omega Attacks and Specials during Valkyrie form and properly resumes charging them after it ends.
- Remove ImGui menu (its been outdated and unnecessary since the in-game UI was introduced).
- Fix Pan plus Morrigan not having homing Specials
- Nyx sprint blast now gets boosted when fused with Supay
- Skull's Minor Aspect of Melinoe now boosts other skull aspects
- Nyx Nightspawns added for Shiva and Hel special
- Nyx's omega Boost can now trigger Medea's attack explosion

## [0.9.6] - 2026-08-04

- Fix manifest

## [0.9.5] - 2026-08-04

## [0.9.4] - 2026-08-04

#### Dev

- Replace Context.Wrap.Static with Context.Env

## [0.9.3] - 2026-07-27

- Random weapon fusion now applies to Chaos Above/Below and similar trials.
- Fix crash that occurs when HermesDuos is installed.

## [0.9.2] - 2026-07-19

- Fix unfuse option not properly unfusing weapons

## [0.9.1] - 2026-07-12

- Fix Artemis not consuming crit charges from Anubis ticks
- Fix Shiva only buffing the first axe omega attack projectile
- Fix Shiva tooltip always showing max Destructive stacks as 2

## [0.9.0] - 2026-07-11

- Shiva as primary aspect now gets Destructive stacks from the secondary omega specials
- Fix fusion menu fusing unexpected aspects if not all aspects for a weapon are unlocked

## [0.8.1] - 2026-07-08

- Fix Morrigan special Nightspawn
- Fix Torch omega attack firing in the opposite direction
- SKip checkpoint invalidation in some cases to avoid losing runs

## [0.8.0] - 2026-06-18

- Implement Nyx Nightspawns for staff attack and special, torch attack, skull attack and dagger special
- Allow Nyx omega Boost to activate Valkyire form
- Fix attack Nightspawns for coat attacks during same weapon fusion

## [0.7.3] - 2026-06-16

- Minor Momus and Circe fixes for same weapon fusion
- Fix Exceptional Talent for Minor Aspect of Hel
- Fix Artemis not boosting Supay Attacks
- Fix Axe not consuming Artemis crit charges
- Fix Psychic Whirlwind breaking daggers omega special

## [0.7.2] - 2026-06-10

- Block fusion menu unless all weapons are unlocked

## [0.7.1] - 2026-06-08

- Minor compatibility patch for dx2_weapons, proper compatibility still not guaranteed but the mods should atleast load without issue now.
- Fix primary weapon selection allowing locked weapon selection

## [0.7.0] - 2026-06-05

- Add experimental support for same weapon fusion
- Add Axe and Staff minor aspects for AspectYoungMel

## [0.6.3] - 2026-06-04

- Remove hitstop from Morrigan's Blood Triad and Dagger Omega Attack
- Fix Nergal and Thanatos not working properly after the Anubis fix

## [0.6.2] - 2026-05-26

- Premium Service (Hephaeustus Legendary) will now also upgrade the Minor Aspects
- Fix ranged charged casts and cleave-casts not having the momus cast animation with Minor Aspect of Momus

## [0.6.1] - 2026-05-21

- Add Minor Aspect of Hel

## [0.5.1] - 2026-05-18

- Fix for testaments sometimes getting enabled in Dream Dives if random fusion is enabled

## [0.5.0] - 2026-05-17

- Add Minor Aspect of Momus, able to duplicate every omega attack
- Add proper support for Charon as primary aspect, all other weapons' omega specials trigger cleave-cast
- Add Minor Aspects of Melinoe for all weapons except skulls
- Fix Eos' duplicate skull omega specials not being created properly
- Fix Supay attack not auto firing when Melinoe puts the flames away to use another weapon
- Fix Anubis base attack not increasing stacks for Thanatos and Nergal
- Fix Minor Aspect of Artemis boosting regular attack speed for torches and skull
- Primary Anubis no longer increases Mana cost for fused omega specials
- Fix axe always having Psychic Whirlwind active for fused specials

## [0.4.2] - 2026-05-14

- Block Pan and Charon from appearing as primary aspect in random fusions
- Minor UI adjustments

## [0.4.1] - 2026-05-13

- Add some audio and visual flourishes to the menu
- Fix a crash in cases were no aspect is equipped for a weapon

## [0.4.0] - 2026-05-12

- Add ingame menu for weapon fusion, accessible by saluting the silver pool

## [0.3.0] - 2026-05-12

- Aspect of Eos' Daybreaker will now correctly duplicate all Specials
- Trick Knives now gets properly boosted by special boons
- Replace projectiles spawned by Trick Knives for axe, torch, staff and coat

## [0.2.2] - 2026-05-11

- Counter Barrage(Xinth) now correctly fires special rockets when in a fused state
- Current fusion status is always shown in the imgui window
- Fixed biome transition maps being disabled (oops)
- Imgui shouldn't allow same weapon fusion anymore (it already did nothing expect cause con-_fusion_)

## [0.2.1] - 2026-05-10

- Moros now doesn't destroy the special projectiles immediately
- Fix skulls and Shiva not detonating Moros flames
- Slightly reduce Artemis omega attack speed
- Artemis now also boosts staff omega attack speed

## [0.2.0] - 2026-05-09

- Adds the Argent Skull with Aspect of Persephone available as a secondary aspect
- Add option for random fusion every run
- Fix Shiva not boosting some omega attacks
- Fusing weapons now instantly swaps to the fused weapon, primary aspect still needs to be changed using the in-game UI
- Fusion now triggers a save
- Fix for SkyFall not unequipping properly in the Crossroads, when switching weapons

## [0.1.3] - 2026-05-08

- Fix crash due to shit code
- Minor aspects will be the same level as the source aspect

## [0.1.2] - 2026-05-08

- Better hammer compatibility for the secondary weapon
- Fix crash due to missing file

## [0.1.1] - 2026-05-07

- Fix charon missing it's cast damage mulitplier

## [0.1.0] - 2026-05-07

- First version of the mod!

[unreleased]: https://github.com/adi1998/WeaponFusion/compare/1.0.0...HEAD
[1.0.0]: https://github.com/adi1998/WeaponFusion/compare/0.9.6...1.0.0
[0.9.6]: https://github.com/adi1998/WeaponFusion/compare/0.9.5...0.9.6
[0.9.5]: https://github.com/adi1998/WeaponFusion/compare/0.9.4...0.9.5
[0.9.4]: https://github.com/adi1998/WeaponFusion/compare/0.9.3...0.9.4
[0.9.3]: https://github.com/adi1998/WeaponFusion/compare/0.9.2...0.9.3
[0.9.2]: https://github.com/adi1998/WeaponFusion/compare/0.9.1...0.9.2
[0.9.1]: https://github.com/adi1998/WeaponFusion/compare/0.9.0...0.9.1
[0.9.0]: https://github.com/adi1998/WeaponFusion/compare/0.8.1...0.9.0
[0.8.1]: https://github.com/adi1998/WeaponFusion/compare/0.8.0...0.8.1
[0.8.0]: https://github.com/adi1998/WeaponFusion/compare/0.7.3...0.8.0
[0.7.3]: https://github.com/adi1998/WeaponFusion/compare/0.7.2...0.7.3
[0.7.2]: https://github.com/adi1998/WeaponFusion/compare/0.7.1...0.7.2
[0.7.1]: https://github.com/adi1998/WeaponFusion/compare/0.7.0...0.7.1
[0.7.0]: https://github.com/adi1998/WeaponFusion/compare/0.6.3...0.7.0
[0.6.3]: https://github.com/adi1998/WeaponFusion/compare/0.6.2...0.6.3
[0.6.2]: https://github.com/adi1998/WeaponFusion/compare/0.6.1...0.6.2
[0.6.1]: https://github.com/adi1998/WeaponFusion/compare/0.5.1...0.6.1
[0.5.1]: https://github.com/adi1998/WeaponFusion/compare/0.5.0...0.5.1
[0.5.0]: https://github.com/adi1998/WeaponFusion/compare/0.4.2...0.5.0
[0.4.2]: https://github.com/adi1998/WeaponFusion/compare/0.4.1...0.4.2
[0.4.1]: https://github.com/adi1998/WeaponFusion/compare/0.4.0...0.4.1
[0.4.0]: https://github.com/adi1998/WeaponFusion/compare/0.3.0...0.4.0
[0.3.0]: https://github.com/adi1998/WeaponFusion/compare/0.2.2...0.3.0
[0.2.2]: https://github.com/adi1998/WeaponFusion/compare/0.2.1...0.2.2
[0.2.1]: https://github.com/adi1998/WeaponFusion/compare/0.2.0...0.2.1
[0.2.0]: https://github.com/adi1998/WeaponFusion/compare/0.1.3...0.2.0
[0.1.3]: https://github.com/adi1998/WeaponFusion/compare/0.1.2...0.1.3
[0.1.2]: https://github.com/adi1998/WeaponFusion/compare/0.1.1...0.1.2
[0.1.1]: https://github.com/adi1998/WeaponFusion/compare/0.1.0...0.1.1
[0.1.0]: https://github.com/adi1998/WeaponFusion/compare/03f2884a625204f31ae0c34a05aae362fce0006e...0.1.0