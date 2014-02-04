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
	local flying, ground, multi, multifly = {}, {}, {}, {}
	local _, class = UnitClass("player")
	if UnitRace("player") == "Worgen" then table.insert(ground, "Running Wild(Racial)") end
	for i=1,GetNumCompanions("MOUNT") do
		local _, name, spell_id, _, _, mount_type = GetCompanionInfo("MOUNT", i)
		-- mount_type bitmap:
		-- JUSFG - jump, underwater, swim on surface, fly, ground
		-- 01100 - seahorse
		-- 11101 - land
		-- 00011 - air
		-- 11111 - landair

		-- It sems if a flying mount can jump, that means it can be used as a
		-- ground mount in noflyable areas
		local canrun  = bit.band(mount_type, 1) ~= 0
		local canfly  = bit.band(mount_type, 2) ~= 0
		local canjump = bit.band(mount_type, 16) ~= 0
		local isaq    = aqmounts[spell_id]
		local canuse  = not trademounts[spell_id]
										or GetSpellInfo((GetSpellInfo(trademounts[spell_id])))
		if canuse and not isaq then
			if canfly then table.insert(flying, name) end
			if canrun and (not canfly or canjump) then table.insert(ground, name) end
			if multipass[spell_id] then table.insert(multi, name) end
			if multipass[spell_id] == 'flying' then table.insert(multifly, name) end
		end
	end

	if not next(ground) then return end

	if UnitExists('party1') and not UnitExists('party2') and UnitIsConnected('party1') then
		if next(multi) then ground = multi end
		if next(multifly) then flying = multifly end
	end

	ns.isdruid = class == "DRUID"
	if ns.isdruid then flying = {GetSpellInfo("Swift Flight Form") or GetSpellInfo("Flight Form")} end

	ns.canfly = not not next(flying)

  local t = ""
  local e = emergency_spells[class] or "Auto Attack"
  
  t = t.. "/cast [combat,nomounted] ".. e .. "\n"
  if ns.isdruid then
    t = t.. "/cancelaura [form:1] Bear Form; [form:3] Cat Form; [form:5] Moonkin Form\n"
    t = t.. "/cast [nomounted,swimming] Aquatic Form(Shapeshift)\n"
  end
 	if ns.canfly then
    t = t.. "/cast [nomounted,nocombat,flyable] ".. ns.trand(flying).. "\n"
  end
  t = t.. "/cast [noswimming,nomounted,nocombat".. (ns.canfly and ",noflyable" or "").. "] ".. ns.trand(ground).. "\n"
  t = t.. "/stopmacro [nomounted]\n"
  t = t.. "/dismount [noflying][flying,mod]\n"
  ns.macro = t

	local t = ""
  t = t.. "#showtooltip [combat,nomounted] ".. e
  if ns.isdruid then
    t = t.. "; [nomounted,swimming] Aquatic Form(Shapeshift)"
	  end
 	if ns.canfly then
    t = t.. "; [flyable] ".. flying[1]
  end
  t = t.. "; ".. ground[1]
	t = t.. "\n/click tekMounter"
	ns.placeholder = t
end
