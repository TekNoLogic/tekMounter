
local myname, ns = ...


local emergency_spells = {
	DRUID = "Travel Form(Shapeshift)",
	PALADIN = "Divine Shield",
	PRIEST = "Psychic Scream",
	HUNTER = "Feign Death",
	WARLOCK = "Feign Death",
	SHAMAN = "Feign Death",
	MAGE = "Feign Death",
	MONK = "Feign Death",
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
function ns.Scan()
	local flying, ground, _, class = {}, {}, UnitClass("player")
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
		end
	end

	if not next(ground) then return end

	ns.isdruid = class == "DRUID"
	if ns.isdruid then flying = {GetSpellInfo("Swift Flight Form") or GetSpellInfo("Flight Form")} end

	ns.canfly = not not next(flying)

  local t = ""
  t = t.. "/cast [combat,nomounted] ".. emergency_spells[class].. "\n"
  if ns.isdruid then
    t = t.. "/cancelaura [form:1] Bear Form; [form:3] Cat Form; [form:5] Moonkin Form\n"
    t = t.. "/cast [nomounted,swimming] Aquatic Form(Shapeshift)\n"
  end
 	if ns.canfly then
    t = t.. "/castrandom [nomounted,nocombat,flyable] ".. table.concat(flying, ", ").. "\n"
  end
  t = t.. "/castrandom [noswimming,nomounted,nocombat".. (ns.canfly and ",noflyable" or "").. "] ".. table.concat(ground, ", ").. "\n"
  t = t.. "/stopmacro [nomounted]\n"
  t = t.. "/dismount [noflying][flying,mod]\n"
  ns.macro = t

	local t = ""
  t = t.. "#showtooltip [combat,nomounted] ".. emergency_spells[class]
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
