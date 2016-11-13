
local myname, ns = ...


local function OnUnitEnteredVehicle(self, event, unit, ...)
	if unit ~= "player" then return end
	ns.SendMessage("_PLAYER_ENTERED_VEHICLE", ...)
end


local function OnUnitExitedVehicle(self, event, unit, ...)
	if unit ~= "player" then return end
	ns.SendMessage("_PLAYER_EXITED_VEHICLE", ...)
end


ns.RegisterCallback("UNIT_ENTERED_VEHICLE", OnUnitEnteredVehicle)
ns.RegisterCallback("UNIT_EXITED_VEHICLE", OnUnitExitedVehicle)
