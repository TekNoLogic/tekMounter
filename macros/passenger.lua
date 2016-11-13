
local myname, ns = ...


local MACRO = ns.GenerateMacro(
[[#showtooltip
/cast [combat,nomounted] EMERGENCY_SPELL; MOUNT
]])


function ns.GetPassengerMacro()
	local mount = ns.GetPassengerMount()
	if mount then return MACRO[mount] end
end
