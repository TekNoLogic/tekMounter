
local myname, ns = ...


local _, CLASS = UnitClass("player")
local GHOST_WOLF = GetSpellInfo(2645)
local TRAVEL_FORM = GetSpellInfo(783)
local MACRO = ns.GenerateMacro(
[[#showtooltip
/cast [combat,nomounted] EMERGENCY_SPELL; MOUNT
]])


function ns.GetClassMacro()
	if CLASS == "DRUID" then return MACRO:gsub("MOUNT", TRAVEL_FORM) end
	if CLASS == "SHAMAN" and ns.IsMoving() then
		return MACRO:gsub("MOUNT", GHOST_WOLF)
	end
end
