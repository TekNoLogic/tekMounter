
local myname, ns = ...


local MACRO = ns.GenerateMacro(
[[#showtooltip [combat,nomounted] EMERGENCY_SPELL; MOUNT
/cast [combat,nomounted] EMERGENCY_SPELL
/stopmacro [combat,nomounted]
/run C_MountJournal.SummonByID(0)
]])


function ns.GetRandomMacro()
	local mount = ns.GetGroundMount()
	if mount then return MACRO[mount] end
end
