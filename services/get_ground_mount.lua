
local myname, ns = ...


-- http://wow.gamepedia.com/API_C_MountJournal.GetMountInfoExtraByID


local _, CLASS = UnitClass("player")
local GROUND_TYPE = 230
local IDS = C_MountJournal.GetMountIDs()
local TRAVEL_FORM = GetSpellInfo(783)
local MULTI_MOUNTS = {
	SANDSTONE_DRAKE = GetSpellInfo(93326),
	X53_ROCKET = GetSpellInfo(75973),
	OBSIDIAN_NIGHTWING = GetSpellInfo(121820),
	MEKGINEERS_CHOPPER = GetSpellInfo(60424),
	MECHANOHOG = GetSpellInfo(55531),
	EXPEDITION_YAK = GetSpellInfo(122708),
	TUNDRA_MAMMOTH = GetSpellInfo(61425),
}


local last_mount
function ns.GetGroundMount()

	for _,id in pairs(IDS) do
		local name, _, _, active, usable, _, favorite = C_MountJournal.GetMountInfoByID(id)
		local _, _, _, is_self_mount, mount_type = C_MountJournal.GetMountInfoExtraByID(id)

		if active then
			last_mount = name
			return name
		end

		if not last_mount and favorite and usable and mount_type == GROUND_TYPE then
			last_mount = name
		end
	end

	return last_mount
end


function ns.GetMultiMount()
	if not UnitExists("party1") then return end
	if UnitExists("party2") then return end
	if not UnitIsConnected("party1") then return end

	if CLASS == "DRUID" and not IsFlyableArea() then return TRAVEL_FORM end
	for _,mount in pairs(MULTI_MOUNTS) do
		if GetSpellInfo(mount) then return mount end
	end
end
