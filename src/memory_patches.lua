-- sgg::Projectile::CheckProjectileImpact
local check_projectile_impact_ptr = rom.memory.scan_pattern(
    "48 8B C4 48 89 58 10 48 89 70 18 48 89 78 20 55 " ..
    "41 54 41 55 41 56 41 57 48 8D 68 A1 48 81 EC B0"
)

local returning_to_owner_check_offset = 0x82

if check_projectile_impact_ptr:is_valid() then
    local check_projectile_impact_hook_site = check_projectile_impact_ptr:add(returning_to_owner_check_offset)

    rom.memory.dynamic_hook_mid("skip_returning_to_owner_check", {}, {}, 0, check_projectile_impact_hook_site,
        function(args)
            -- skippping sgg::Projectile::IsReturningToOwner result check:
            -- test    al, al
            -- jnz     loc_140088321
            return check_projectile_impact_hook_site:add(8)
        end
    )
end