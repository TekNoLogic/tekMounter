
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
local aqmounts = {
	[25953] = 'blue',
	[26054] = 'red',
	[26055] = 'yellow',
	[26056] = 'green',
}
local trademounts = {
	[44153] = 12656, -- Engineering 300
	[44151] = 30350, -- Engineering 375
	[44554] = 12180, -- Tailoring 300
	[61309] = 51309, -- Tailoring 450
}
local multipass = {
	[121820] = 'flying', -- Obsidian Nightwing
}


function ns.Scan()
	local ground, multi, multifly = {}, {}, {}
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
