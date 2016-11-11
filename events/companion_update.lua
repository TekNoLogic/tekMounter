
local myname, ns = ...


local function OnCompanionUpdate(self, message, ...)
	ns.SendMessage("_COMPANION_UPDATE", ...)
end


local function OnPlayerEnteringWorld(self)
	ns.RegisterCallback(self, "COMPANION_UPDATE", OnCompanionUpdate)
end


local function OnPlayerLeavingWorld(self)
	ns.UnregisterCallback(self, "COMPANION_UPDATE")
end


local context = {}
ns.RegisterCallback(context, "PLAYER_LOGIN", OnPlayerEnteringWorld)
ns.RegisterCallback(context, "PLAYER_ENTERING_WORLD", OnPlayerEnteringWorld)
ns.RegisterCallback(context, "PLAYER_LEAVING_WORLD", OnPlayerLeavingWorld)
