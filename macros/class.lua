
local myname, ns = ...


local MACRO = ns.GenerateMacro(
[[#showtooltip
/cast [combat,nomounted] EMERGENCY_SPELL; MOUNT
]])


function ns.GetClassMacro()
	local mount = ns.GetClassMount()
	if mount then return MACRO[mount] end
end
