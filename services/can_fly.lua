
local myname, ns = ...


local _, class = UnitClass("player")
local IS_DRUID = class == "DRUID"
local FLIGHT = GetSpellInfo(165962)
local SWIFT_FLIGHT = GetSpellInfo(40123)


function ns.CanFly()
	if not IS_DRUID then return end
	return not not (GetSpellInfo(SWIFT_FLIGHT) or GetSpellInfo(FLIGHT))
end
