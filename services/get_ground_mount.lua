
local myname, ns = ...


-- http://wow.gamepedia.com/API_C_MountJournal.GetMountInfoExtraByID


local GROUND_TYPE = 230


local IDS = C_MountJournal.GetMountIDs()


local last_mount
function ns.GetGroundMount()

	for _,id in pairs(IDS) do
		local name, _, _, active, usable, _, favorite = C_MountJournal.GetMountInfoByID(id)
		local _, _, _, is_self_mount, mount_type = C_MountJournal.GetMountInfoExtraByID(id)

		if active then
			last_mount = name
			return name
		end

		if not last_mount and favorite and usable and mount_type == GROUND_TYPE then
			last_mount = name
		end
	end

	return last_mount
end
