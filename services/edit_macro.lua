
local myname, ns = ...


local NAME = "tekMounter"
local ICON = "INV_Misc_QuestionMark"
local BUILD_FUNCS = {
	"GetCombatMacro",
	"GetVehicleMacro",
	"GetPassengerMacro",
	"GetClassMacro",
	"GetRandomMacro",
}


local function BuildMacro()
	for _,func in ipairs(BUILD_FUNCS) do
		local macro = ns[func]()
		if macro then return macro end
	end
end


local function UpdateMacro(self)
	if InCombatLockdown() then return end

	local macro_id = GetMacroIndexByName(NAME)
	if not macro_id then return end

	local macro = BuildMacro()
	if macro then EditMacro(macro_id, NAME, ICON, macro, 1) end
end


local function OnVehicle(self, event, unit)
	if unit == "player" then return UpdateMacro(self) end
end


ns.RegisterCallback("_COMPANION_UPDATE", UpdateMacro)
ns.RegisterCallback("_ENTERING_COMBAT", UpdateMacro)
ns.RegisterCallback("_LEAVING_COMBAT", UpdateMacro)
ns.RegisterCallback("_PLAYER_MOVING", UpdateMacro)
ns.RegisterCallback("_PLAYER_STATIONARY", UpdateMacro)
ns.RegisterCallback("PLAYER_ENTERING_WORLD", UpdateMacro)
ns.RegisterCallback("PLAYER_LOGIN", UpdateMacro)
ns.RegisterCallback("UNIT_ENTERED_VEHICLE", OnVehicle)
ns.RegisterCallback("UNIT_EXITED_VEHICLE", OnVehicle)
ns.RegisterCallback("VEHICLE_UPDATE", UpdateMacro)
