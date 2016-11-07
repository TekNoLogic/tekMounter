
local myname, ns = ...
-- if not ns.macro then return end

local function dumpmacro(...)
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
		ns.Debug(" ")
		ns.Debug("Macro updated")
		dumpmacro(string.split("\n", ns.macro))

		local macroid = GetMacroIndexByName("tekMounter")
		if macroid then EditMacro(macroid, "tekMounter", "INV_Misc_QuestionMark", ns.placeholder, 1) end

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
frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("COMPANION_UPDATE")
frame:SetScript("OnEvent", UpdateMacro)
frame:SetScript("PostClick", UpdateMacro)
