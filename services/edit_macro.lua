
local myname, ns = ...


local NAME = "tekMounter"
local ICON = "INV_Misc_QuestionMark"


local function UpdateMacro(self)
	if InCombatLockdown() then return end

	local macro_id = GetMacroIndexByName(NAME)
	if not macro_id then return end

	local macro = ns.BuildMacro()
	EditMacro(macro_id, NAME, ICON, macro, 1)
end


ns.RegisterCallback("_COMPANION_UPDATE", UpdateMacro)
ns.RegisterCallback("PLAYER_LOGIN", UpdateMacro)
ns.RegisterCallback("PLAYER_ENTERING_WORLD", UpdateMacro)
ns.RegisterCallback(ns.MOVING, UpdateMacro)
ns.RegisterCallback(ns.STATIONARY, UpdateMacro)
