
local myname, ns = ...


local MACRO = ns.GenerateMacro(
[[#showtooltip [combat,nomounted] EMERGENCY_SPELL; MOUNT
/leavevehicle [canexitvehicle]
/stopmacro [canexitvehicle]
/cast [combat,nomounted] EMERGENCY_SPELL; MOUNT
]])
local MOUNT_FUNCS = {
	"GetPassengerMount",
	"GetClassMount",
	"GetGroundMount",
}


function ns.GetVehicleMacro()
	if not CanExitVehicle() then return end

	for _,func in ipairs(MOUNT_FUNCS) do
		local mount = ns[func]()
		if mount then return MACRO[mount] end
	end
end
