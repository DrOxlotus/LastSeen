local addonName, addonTable = ...
local e = CreateFrame("Frame")
local L = addonTable.L

e:RegisterEvent("NAME_PLATE_UNIT_ADDED")
e:RegisterEvent("UPDATE_MOUSEOVER_UNIT")

e:SetScript("OnEvent", function(self, event, ...)
	if (event == "NAME_PLATE_UNIT_ADDED") then
	
	end
	
	if (event == "UPDATE_MOUSEOVER_UNIT") then
	
	end
end)