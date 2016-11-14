
local myname, ns = ...


local _, CLASS = UnitClass("player")
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


function ns.GetPassengerMount()
	if not UnitExists("party1") then return end
	if UnitExists("party2") then return end
	if not UnitIsConnected("party1") then return end

	if CLASS == "DRUID" and not IsFlyableArea() then return TRAVEL_FORM end
	for _,mount in pairs(MULTI_MOUNTS) do
		if GetSpellInfo(mount) then return mount end
	end
end
