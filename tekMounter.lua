
local myname, ns = ...


local function dumpmacro(...)
	ns.Debug(" ")
	ns.Debug("Macro updated")

	for i=1,select("#", ...) do
		local v = select(i, ...)
		ns.Debug(v)
	end
end


local function UpdateMacro(self)
	ns.Scan()
	if ns.placeholder and not InCombatLockdown() then
		self:SetAttribute("type", "macro")
		self:SetAttribute("macrotext", ns.macro)

		dumpmacro(string.split("\n", ns.macro))

		ns.EditMacro(ns.placeholder)
	end
end


ns.RegisterCallback("_COMPANION_UPDATE", UpdateMacro)
ns.RegisterCallback("PLAYER_LOGIN", UpdateMacro)
ns.RegisterCallback("PLAYER_ENTERING_WORLD", UpdateMacro)
