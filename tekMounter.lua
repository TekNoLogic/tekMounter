
local myname, ns = ...
if not ns.macro then return end


local frame = CreateFrame("Button", "tekMounter", UIParent, "SecureActionButtonTemplate")
frame:EnableMouse(true)
frame:RegisterForClicks("AnyUp")
frame:SetAttribute("type", "macro")
frame:SetAttribute("macrotext", ns.macro)

frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function()
	if ns.placeholder then
		local macroid = GetMacroIndexByName("tekMounter")
		if macroid then EditMacro(macroid, "tekMounter", 1, ns.placeholder, 1) end
	end
end)

if ns.isdruid then
	frame:SetScript("PreClick", function(self)
		if InCombatLockdown() then return end

		if GetUnitSpeed("player") > 0 and not IsSwimming() then
			frame:SetAttribute("macrotext", [[
/cast [nomounted] Travel Form(Shapeshift)
/stopmacro [nomounted]
/dismount
]])
		else
			frame:SetAttribute("macrotext", ns.macro)
		end
	end)
end
