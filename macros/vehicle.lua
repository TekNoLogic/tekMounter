
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
-- /run if CanExitVehicle() then VehicleExit() end


function ns.GetVehicleMacro()
	if not CanExitVehicle() then return end

	if ns.InCombat() then
		if CLASS == "DRUID" then
			return MACRO[TRAVEL_FORM]
		end

		if CLASS == "SHAMAN" then
			return MACRO[GHOST_WOLF]
		end

		return MACRO[ns.GetGroundMount()]
	end

	local multimount = ns.GetMultiMount()
	if multimount then return MACRO[multimount] end

	if CLASS == "DRUID" then return MACRO[TRAVEL_FORM] end

	if CLASS == "SHAMAN" and ns.IsMoving() then return MACRO[GHOST_WOLF] end

	local mount = ns.GetGroundMount()
	if mount then return MACRO[mount] end
end