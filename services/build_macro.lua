
local myname, ns = ...


local _, class = UnitClass("player")
local emergency_spells = {
	DRUID = "Travel Form(Shapeshift)",
	PALADIN = "Divine Shield",
	PRIEST = "Psychic Scream",
	HUNTER = "Feign Death",
	WARLOCK = "Feign Death",
	SHAMAN = "Feign Death",
	MAGE = "Ice Block",
	MONK = "Touch of Death",
}
local EMERGENCY_SPELL = emergency_spells[class]
local MACRO = [[#showtooltip [combat,nomounted] EMERGENCY_SPELL; MOUNT
/cast [combat,nomounted] EMERGENCY_SPELL
/stopmacro [combat,nomounted]
/run C_MountJournal.SummonByID(0)
]]
MACRO = MACRO:gsub("EMERGENCY_SPELL", EMERGENCY_SPELL)


local multipass = {
	[121820] = "flying", -- Obsidian Nightwing
}


function ns.BuildMacro()
	return MACRO:gsub("MOUNT", ns.GetGroundMount())
end
