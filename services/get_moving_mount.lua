
local myname, ns = ...


local _, CLASS = UnitClass("player")
local GHOST_WOLF = GetSpellInfo(2645)


function ns.GetMovingMount()
	if CLASS == "SHAMAN" and ns.IsMoving() then return GHOST_WOLF end
end
