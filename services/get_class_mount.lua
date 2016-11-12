
local myname, ns = ...


local _, CLASS = UnitClass("player")
local GHOST_WOLF = GetSpellInfo(2645)
local TRAVEL_FORM = GetSpellInfo(783)


local function UseGhostWolf()
	if ns.InCombat() then return true end
	if IsMounted() then return false end
	if ns.IsMoving() then return true end
end


function ns.GetClassMount()
	if CLASS == "DRUID" then return TRAVEL_FORM end
	if CLASS == "SHAMAN" and UseGhostWolf() then return GHOST_WOLF end
end
