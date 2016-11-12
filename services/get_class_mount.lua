
local myname, ns = ...


local _, CLASS = UnitClass("player")
local GHOST_WOLF = GetSpellInfo(2645)
local TRAVEL_FORM = GetSpellInfo(783)


function ns.GetClassMount()
	if CLASS == "DRUID" then return TRAVEL_FORM end
	if CLASS == "SHAMAN" and not IsMounted() and ns.IsMoving() then
		return GHOST_WOLF
	end
end
