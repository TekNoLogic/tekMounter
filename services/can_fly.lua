
local myname, ns = ...


function ns.CanFly()
	local _, class = UnitClass("player")
	if class ~= "DRUID" then return end
	return not not (GetSpellInfo("Swift Flight Form") or GetSpellInfo("Flight Form"))
end
