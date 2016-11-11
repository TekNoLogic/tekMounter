
local myname, ns = ...


local NAME = "tekMounter"
local ICON = "INV_Misc_QuestionMark"


local function DebugMacro(...)
	ns.Debug(" ")
	ns.Debug("Macro updated")

	for i=1,select("#", ...) do
		local v = select(i, ...)
		ns.Debug(v)
	end
end


local function WriteMacro(macro)
	local macro_id = GetMacroIndexByName(NAME)
	if not macro_id then return end

	EditMacro(macro_id, NAME, ICON, macro, 1)
	DebugMacro(string.split("\n", macro))
end


local function UpdateMacro(self)
	if InCombatLockdown() then return end

	WriteMacro(ns.BuildMacro())
end


ns.RegisterCallback("_COMPANION_UPDATE", UpdateMacro)
ns.RegisterCallback("PLAYER_LOGIN", UpdateMacro)
ns.RegisterCallback("PLAYER_ENTERING_WORLD", UpdateMacro)
