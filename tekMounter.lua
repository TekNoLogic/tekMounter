
local myname, ns = ...
-- if not ns.macro then return end

local function dumpmacro(...)
	for i=1,select("#", ...) do
		local v = select(i, ...)
		ns.Debug(v)
	end
end

local frame = CreateFrame("Button", "tekMounter", UIParent, "SecureActionButtonTemplate")
frame:EnableMouse(true)
frame:RegisterForClicks("AnyUp")

frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("COMPANION_UPDATE")
frame:SetScript("OnEvent", function()
	ns.Scan()
	if ns.placeholder and not InCombatLockdown() then
		frame:SetAttribute("type", "macro")
		frame:SetAttribute("macrotext", ns.macro)
		ns.Debug(" ")
		ns.Debug("Macro updated")
		dumpmacro(string.split("\n", ns.macro))

		local macroid = GetMacroIndexByName("tekMounter")
		if macroid then EditMacro(macroid, "tekMounter", 1, ns.placeholder, 1) end

		if ns.isdruid and not ns.druidpreclick then
			frame:SetScript("PreClick", function(self)
				if InCombatLockdown() then return end

				if GetUnitSpeed("player") > 0 and not IsSwimming() then
					frame:SetAttribute("macrotext", [[
/cast [nomounted] ]].. (ns.canfly and "Flight Form(Shapeshift)" or "Travel Form(Shapeshift)").. [[

/stopmacro [nomounted]
/dismount
]])
				else
					frame:SetAttribute("macrotext", ns.macro)
				end
			end)
			ns.druidpreclick = true
		end
	end
end)

