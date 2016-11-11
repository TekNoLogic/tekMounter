
local myname, ns = ...


local GROUND_TYPE = 230
local IDS = C_MountJournal.GetMountIDs()


local function GetActiveMount()
	for _,id in pairs(IDS) do
		local name, _, _, active = C_MountJournal.GetMountInfoByID(id)
		if active then return name end
	end
end


local function IsGroundMount(id)
	-- http://wow.gamepedia.com/API_C_MountJournal.GetMountInfoExtraByID
	local _, _, _, _, mount_type = C_MountJournal.GetMountInfoExtraByID(id)
	return mount_type == GROUND_TYPE
end


local function GetFirstGroundMount()
	for _,id in pairs(IDS) do
		local name, _, _, _, usable, _, favorite = C_MountJournal.GetMountInfoByID(id)
		if favorite and usable and IsGroundMount(id) then return name end
	end
end


local last_mount
function ns.GetGroundMount()
	-- local _, class = UnitClass("player")
	-- if UnitRace("player") == "Worgen" then return "Running Wild(Racial)" end

	if IsMounted() then
		last_mount = GetActiveMount()
	else
		last_mount = last_mount or GetFirstGroundMount()
	end

	return last_mount
end
