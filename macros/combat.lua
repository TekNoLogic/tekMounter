
local myname, ns = ...


local _, CLASS = UnitClass("player")
local GHOST_WOLF = GetSpellInfo(2645)
local TRAVEL_FORM = GetSpellInfo(783)
local MACRO = ns.GenerateMacro(
[[#showtooltip [combat,nomounted] EMERGENCY_SPELL; MOUNT
/leavevehicle [canexitvehicle]
/stopmacro [canexitvehicle]
/cast [combat,nomounted] EMERGENCY_SPELL; MOUNT
]])


function ns.GetCombatMacro()
	if not ns.InCombat() then return end

	if CLASS == "DRUID" then return MACRO[TRAVEL_FORM] end
	if CLASS == "SHAMAN" then return MACRO[GHOST_WOLF] end
	return MACRO[ns.GetGroundMount()]
end
