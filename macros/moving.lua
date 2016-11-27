
local myname, ns = ...


local MACRO = ns.GenerateMacro(
[[#showtooltip
/cast [combat,nomounted] EMERGENCY_SPELL; MOUNT
]])


function ns.GetMovingMacro()
	local mount = ns.GetMovingMount()
	if mount then return MACRO[mount] end
end
