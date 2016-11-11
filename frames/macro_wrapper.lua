
local myname, ns = ...


local _, class = UnitClass("player")
local IS_DRUID = class == "DRUID"
local MACRO = [[
/cast [nomounted] SPELL
/stopmacro [nomounted]
/dismount
]]


local function IsMoving()
	if IsSwimming() then return end
	return GetUnitSpeed("player") > 0 or IsFalling("player")
end


local function PreClick(self)
	if not IS_DRUID or InCombatLockdown() then return end

	if IsMoving() then
		local spell = "Travel Form(Shapeshift)"
		if ns.CanFly() then spell = "Flight Form(Shapeshift)" end

		self:SetAttribute("macrotext", MACRO:gsub("SPELL", spell))
	else
		self:SetAttribute("macrotext", nil)
	end
end


local function PostClick(self)
	if not IS_DRUID or InCombatLockdown() then return end

	self:SetAttribute("macrotext", nil)
end


local frame = CreateFrame("Button", "tekMounter", UIParent, "SecureActionButtonTemplate")
frame:EnableMouse(true)
frame:RegisterForClicks("AnyUp")
frame:SetScript("PreClick", PreClick)
frame:SetScript("PostClick", PostClick)
