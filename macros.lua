
local myname, ns = ...


local function macro(combat, ground, flying)
	ns.isdruid = UnitClass("player") == "Druid"

  local t = ""
  t = t.. "/cast [combat,nomounted] ".. combat.. "\n"
  if ns.isdruid then
    t = t.. "/cancelaura [form:1] Bear Form; [form:3] Cat Form; [form:5] Moonkin Form\n"
    t = t.. "/cast [nomounted,swimming] Aquatic Form(Shapeshift)\n"
  else
		local crusader = GetSpellInfo(GetSpellInfo(32223))
		if crusader then
    	t = t.. "/cast [nomounted] !".. crusader.. "; !Devotion Aura\n"
		end
  	if flying then
      t = t.. "/castrandom [nomounted,nocombat,flyable] ".. table.concat(flying, ", ").. "\n"
    end
    t = t.. "/castrandom [noswimming,nomounted,nocombat,noflyable] ".. table.concat(ground, ", ").. "\n"
  end
  t = t.. "/stopmacro [nomounted]\n"
  t = t.. "/dismount [noflying][flying,mod]\n"
  ns.macro = t

	local t = ""
  t = t.. "#showtooltip [combat,nomounted] ".. combat
  if ns.isdruid then
    t = t.. "; [nomounted,swimming] Aquatic Form(Shapeshift)"
  else
  	if flying then
      t = t.. "; [flyable] ".. flying[1]
    end
    t = t.. "; ".. ground[1]
  end
	t = t.. "\n/click tekMounter"
	ns.placeholder = t
end


local realm, name = GetRealmName(), UnitName("player")
if realm == "Area 52" then

	if name == "Bear" then
		macro({
			"Running Wild(Racial)",
			"Spotted Frostsaber",
			"Striped Dawnsaber",
			"Striped Frostsaber",
			"Striped Nightsaber",
		})
	end

	if name == "Beardyhead" then
		macro("Psychic Scream", {
			"Amani War Bear",
			"Armored Brown Bear",
			"Big Blizzard Bear",
		}, {
			"Red Drake",
			"Green Proto-Drake",
		})
	end

	if name == "Cub" then
		macro("Divine Shield", {
			"Big Blizzard Bear",
			"Swift Stormsaber",
			"Swift Mistsaber",
			"Swift Frostsaber",
			"Armored Brown Bear",
		}, {
			"Snowy Gryphon",
			"Swift Red Gryphon",
			"Golden Gryphon",
			"Ebon Gryphon",
		})
	end

end
