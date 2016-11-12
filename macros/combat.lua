
local myname, ns = ...


local MACRO = ns.GenerateMacro(
[[#showtooltip [combat,nomounted] EMERGENCY_SPELL; MOUNT
/leavevehicle [canexitvehicle]
/stopmacro [canexitvehicle]
/cast [combat,nomounted] EMERGENCY_SPELL; MOUNT
]])


function ns.GetCombatMacro()
	if not ns.InCombat() then return end

	local mount = ns.GetClassMount() or ns.GetGroundMount()
	return MACRO[mount]
end
