
local myname, ns = ...


local is_moving = false


local function Tick()
	C_Timer.After(.1, Tick)

	local moving = GetUnitSpeed("player") > 0
	if moving == is_moving then return end

	local message = moving and ns.MOVING or ns.STATIONARY
	ns.SendMessage(message)
	is_moving = moving
end


ns.RegisterCallback("PLAYER_LOGIN", Tick)
