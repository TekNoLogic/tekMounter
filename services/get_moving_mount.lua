
local myname, ns = ...


local _, CLASS = UnitClass("player")
local SPELLS = {
	HUNTER = GetSpellInfo(186257), -- Aspect of the Cheetah
	SHAMAN = GetSpellInfo(2645), -- Ghost Wolf
}
local SPELL = SPELLS[CLASS]


function ns.GetMovingMount()
	if not SPELL then return end
	if IsMounted() then return end
	if not ns.IsMoving() then return end

	return SPELL
end
