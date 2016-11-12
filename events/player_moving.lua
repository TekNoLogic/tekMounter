
local myname, ns = ...


local is_moving = false


function ns.IsMoving()
	return is_moving
end


local function Tick()
	C_Timer.After(.1, Tick)

	local moving = GetUnitSpeed("player") > 0
	if moving == is_moving then return end

	is_moving = moving
	local message = is_moving and "_PLAYER_MOVING" or "_PLAYER_STATIONARY"
	ns.SendMessage(message)
end


ns.RegisterCallback("PLAYER_LOGIN", Tick)
