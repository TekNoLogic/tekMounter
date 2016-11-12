
local myname, ns = ...


local MACRO = ns.GenerateMacro(
[[#showtooltip
/cast [combat,nomounted] EMERGENCY_SPELL; MOUNT
]])


function ns.GetPassengerMacro()
	local multimount = ns.GetPassengerMount()
	if multimount then return MACRO:gsub("MOUNT", multimount) end
end
