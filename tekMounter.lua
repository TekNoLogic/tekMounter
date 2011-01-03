
local myname, ns = ...
if not ns.macro then return end


local frame = CreateFrame("Button", "tekMounter", UIParent, "SecureActionButtonTemplate")
frame:EnableMouse(true)
frame:RegisterForClicks("AnyUp")
frame:SetAttribute("type", "macro")
frame:SetAttribute("macrotext", ns.macro)


if ns.isdruid then
	frame:SetScript("PreClick", function(self)
		if InCombatLockdown() then return end

		if GetUnitSpeed("player") > 0 then
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