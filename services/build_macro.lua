
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
SIMPLE_MACRO = SIMPLE_MACRO:gsub("EMERGENCY_SPELL", EMERGENCY_SPELL)

local VEHICLE_MACRO = [[#showtooltip [combat,nomounted] EMERGENCY_SPELL; MOUNT
/leavevehicle [canexitvehicle]
/stopmacro [canexitvehicle]
/cast [combat,nomounted] EMERGENCY_SPELL; MOUNT
]]
VEHICLE_MACRO = VEHICLE_MACRO:gsub("EMERGENCY_SPELL", EMERGENCY_SPELL)

local RANDOM_MACRO = [[#showtooltip [combat,nomounted] EMERGENCY_SPELL; MOUNT
/cast [combat,nomounted] EMERGENCY_SPELL
/stopmacro [combat,nomounted]
/run C_MountJournal.SummonByID(0)
]]
RANDOM_MACRO = RANDOM_MACRO:gsub("EMERGENCY_SPELL", EMERGENCY_SPELL)


function ns.BuildMacro()
	local macro
	if CanExitVehicle() then macro = VEHICLE_MACRO end

	if ns.InCombat() then
		if CLASS == "DRUID" then
			return VEHICLE_MACRO:gsub("MOUNT", TRAVEL_FORM)
		end

		if CLASS == "SHAMAN" then
			return VEHICLE_MACRO:gsub("MOUNT", GHOST_WOLF)
		end

		return VEHICLE_MACRO:gsub("MOUNT", ns.GetGroundMount())
	end

	local multimount = ns.GetMultiMount()
	if multimount then
		return (macro or SIMPLE_MACRO):gsub("MOUNT", multimount)
	end

	if CLASS == "DRUID" then
		return (macro or SIMPLE_MACRO):gsub("MOUNT", TRAVEL_FORM)
	end

	if CLASS == "SHAMAN" and ns.IsMoving() then
		return (macro or SIMPLE_MACRO):gsub("MOUNT", GHOST_WOLF)
	end

	local mount = ns.GetGroundMount()
	if not mount then return "" end
	return (macro or RANDOM_MACRO):gsub("MOUNT", mount)
end
