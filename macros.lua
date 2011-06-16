
local myname, ns = ...


local function macro(combat, ground, flying)
end


local emergency_spells = {
	DRUID = "Travel Form(Shapeshift)",
	PALADIN = "Divine Shield",
	PRIEST = "Psychic Scream",
	HUNTER = "Feign Death",
}
function ns.Scan()
	local flying, ground, _, class = {}, {}, UnitClass("player")
	if UnitRace("player") == "Worgen" then table.insert(ground, "Running Wild(Racial)") end
	for i=1,GetNumCompanions("MOUNT") do
		local _, name, spell_id, _, _, mount_type = GetCompanionInfo("MOUNT", i)
		if bit.band(mount_type, 2) ~= 0 then
			-- flying mount
			table.insert(flying, name)
		elseif bit.band(mount_type, 1) ~= 0 then
			-- ground mount
			table.insert(ground, name)
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
	local crusader = GetSpellInfo(GetSpellInfo(32223))
	if crusader then
   	t = t.. "/cast [nomounted] !".. crusader.. "; !Devotion Aura\n"
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