
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

		if ns.isdruid and not ns.druidpreclick then
			self:SetScript("PreClick", function(self)
				if InCombatLockdown() then return end

				if GetUnitSpeed("player") > 0 and not IsSwimming() then
					local travel = "Travel Form(Shapeshift)"
					if ns.CanFly() then travel = "Flight Form(Shapeshift)" end

					self:SetAttribute("macrotext", [[
/cast [nomounted] ]].. (travel).. [[

/stopmacro [nomounted]
/dismount
]])
				else
					self:SetAttribute("macrotext", ns.macro)
				end
			end)
			ns.druidpreclick = true
		end
	end
end


local frame = CreateFrame("Button", "tekMounter", UIParent, "SecureActionButtonTemplate")
frame:EnableMouse(true)
frame:RegisterForClicks("AnyUp")
frame:SetScript("PostClick", UpdateMacro)


ns.RegisterCallback(frame, "_COMPANION_UPDATE", UpdateMacro)
ns.RegisterCallback(frame, "PLAYER_LOGIN", UpdateMacro)
ns.RegisterCallback(frame, "PLAYER_ENTERING_WORLD", UpdateMacro)
