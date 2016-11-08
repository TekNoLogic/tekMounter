
local myname, ns = ...


local NAME = "tekMounter"
local ICON = "INV_Misc_QuestionMark"


function ns.EditMacro(macro)
	local macro_id = GetMacroIndexByName(NAME)
	if not macro_id then return end

	EditMacro(macro_id, NAME, ICON, macro, 1)
end
