local addonName, addonTable = ...
local e = CreateFrame("Frame", "LastSeenEventFrame")
local L = addonTable.L

e:RegisterEvent("ADDON_LOADED")

e:SetScript("OnEvent", function(self, event, ...)
	if (event == "ADDON_LOADED") then
		local addon = ...
		if (addon == addonName) then
			if (LastSeenItems == nil) then
				LastSeenItems = {}
			end
		end
	end
end)