
local myname, ns = ...


local _, CLASS = UnitClass("player")
local emergency_spells = {
	DRUID = "Travel Form(Shapeshift)",
	PALADIN = "Divine Shield",
	PRIEST = "Psychic Scream",
	HUNTER = "Feign Death",
	WARLOCK = "Feign Death",
	SHAMAN = "Astral Shift",
	MAGE = "Ice Block",
	MONK = "Touch of Death",
}
local EMERGENCY_SPELL = emergency_spells[CLASS]
local GHOST_WOLF = GetSpellInfo(2645)
local TRAVEL_FORM = GetSpellInfo(783)


local SIMPLE_MACRO = [[#showtooltip
/cast [combat,nomounted] EMERGENCY_SPELL; MOUNT
]]
local RANDOM_MACRO = [[#showtooltip [combat,nomounted] EMERGENCY_SPELL; MOUNT
/cast [combat,nomounted] EMERGENCY_SPELL
/stopmacro [combat,nomounted]
/run C_MountJournal.SummonByID(0)
]]
SIMPLE_MACRO = SIMPLE_MACRO:gsub("EMERGENCY_SPELL", EMERGENCY_SPELL)
RANDOM_MACRO = RANDOM_MACRO:gsub("EMERGENCY_SPELL", EMERGENCY_SPELL)


local multipass = {
	[121820] = "flying", -- Obsidian Nightwing
}


function ns.BuildMacro()
	if CLASS == "DRUID" then
		return SIMPLE_MACRO:gsub("MOUNT", TRAVEL_FORM)
	end

	if CLASS == "SHAMAN" and ns.IsMoving() then
		return SIMPLE_MACRO:gsub("MOUNT", GHOST_WOLF)
	end

	return RANDOM_MACRO:gsub("MOUNT", ns.GetGroundMount())
end
