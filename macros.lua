
local myname, ns = ...


local emergency_spells = {
	DRUID = "Travel Form(Shapeshift)",
	PALADIN = "Divine Shield",
	PRIEST = "Psychic Scream",
	HUNTER = "Feign Death",
	WARLOCK = "Feign Death",
	SHAMAN = "Feign Death",
	MAGE = "Ice Block",
	MONK = "Touch of Death",
}
local multipass = {
	[121820] = 'flying', -- Obsidian Nightwing
}


function ns.Scan()
	local _, class = UnitClass("player")
	ns.isdruid = class == "DRUID"

  local t = ""
  t = t.. "/cast [combat,nomounted] ".. emergency_spells[class].. "\n"
  t = t.. "/run C_MountJournal.SummonByID(0)\n"
  ns.macro = t

	local t = ""
  t = t.. "#showtooltip [combat,nomounted] ".. emergency_spells[class]
  t = t.. "; ".. ns.GetGroundMount()
	t = t.. "\n/click tekMounter"
	ns.placeholder = t
end
