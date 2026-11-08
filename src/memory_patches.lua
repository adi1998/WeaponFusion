-- sgg::Projectile::CheckProjectileImpact
local check_projectile_impact_ptr = rom.memory.scan_pattern(
    "48 8B C4 48 89 58 10 48 89 70 18 48 89 78 20 55 " ..
    "41 54 41 55 41 56 41 57 48 8D 68 A1 48 81 EC B0"
)

local returning_to_owner_check_offset = 0x82

if check_projectile_impact_ptr:is_valid() and not check_projectile_impact_ptr:is_null() then
    local check_projectile_impact_hook_site = check_projectile_impact_ptr:add(returning_to_owner_check_offset)

    rom.memory.dynamic_hook_mid("skip_returning_to_owner_check", {}, {}, 0, check_projectile_impact_hook_site,
        function(args)
            -- skippping sgg::Projectile::IsReturningToOwner result check:
            -- test    al, al
            -- jnz     loc_140088321
            return check_projectile_impact_hook_site:add(8)
        end
    )
else
	rom.log.warning("Unable to patch sgg::Projectile::CheckProjectileImpact")
end

-- sgg::Projectile *__fastcall sgg::ProjectileManager::Get(int id)
local sgg_get_projectile_ptr = rom.memory.scan_pattern(
	"48 83 EC 48 48 8B 05 ?? ?? ?? ?? 48 33 C4 48 89 " ..
	"44 24 38 89 4C 24 20 83 F9 FF 74 64 0F 57 C0 4C"
)

local id_projectile_map = {}

Record_projectile_id = nil

if sgg_get_projectile_ptr:is_valid() and not sgg_get_projectile_ptr:is_null() then
	rom.memory.dynamic_hook("get_projectile_hook", "uint64_t", {"int"}, sgg_get_projectile_ptr, {
		nil,
		function (projectile, id)
			if Record_projectile_id == id:get() then
				id_projectile_map[Record_projectile_id] = projectile:get()
			end
		end
	})
else
	rom.log.warning("Unable to hook sgg::ProjectileManager::Get")
end

function mod.extend_projectile_active_duration(id, duration)
	local property_offsets = {
		ReturnToOwnerAfterInactiveSeconds = 0x890,
		ReverseAfterDuration = 0x894,
		ReturnTimeRemaining = 0x6ac,
	}
	if id_projectile_map[id] then
		local projectile_ptr = rom.memory.pointer.new(id_projectile_map[id])
		if projectile_ptr:is_valid() and not projectile_ptr:is_null() then
			for _, value in pairs(property_offsets) do
				projectile_ptr:add(value):set_float(duration)
			end
			id_projectile_map[id] = nil
			Record_projectile_id = nil
		end
	end
end