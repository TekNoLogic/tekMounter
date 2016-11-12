
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


function ns.GenerateMacro(macro)
	macro = macro:gsub("EMERGENCY_SPELL", EMERGENCY_SPELL)
	local function MakeMacro(mount)
		return macro:gsub("MOUNT", mount)
	end
	return ns.NewMemoizingTable(MakeMacro)
end
