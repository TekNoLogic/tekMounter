
local myname, ns = ...


local in_combat = false


function ns.InCombat()
	return in_combat
end


local function OnRegenDisable()
	in_combat = true
	ns.SendMessage("_ENTERING_COMBAT")
end


local function OnRegenEnable()
	in_combat = false
	ns.SendMessage("_LEAVING_COMBAT")
end


ns.RegisterCallback("PLAYER_REGEN_DISABLED", OnRegenDisable)
ns.RegisterCallback("PLAYER_REGEN_ENABLED", OnRegenEnable)
