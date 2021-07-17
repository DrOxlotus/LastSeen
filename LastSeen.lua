local addonName, addonTable = ...
local e = CreateFrame("Frame", "LastSeenEventFrame")
local L = addonTable.L

e:RegisterEvent("ADDON_LOADED")
e:RegisterEvent("PLAYER_LEVEL_CHANGED")
e:RegisterEvent("PLAYER_LOGIN")

e:SetScript("OnEvent", function(self, event, ...)
	if (event == "ADDON_LOADED") then
		local addon = ...
		if (addon == addonName) then
			-- Process saved variables. If they are nil, then they need to be initialized as empty tables.
			if (LastSeenItems == nil) then
				LastSeenItems = {}
			end
		end
	end
	
	if (event == "PLAYER_LEVEL_CHANGED") then
		local _, newLevel = ...
		addonTable.playerLevel = newLevel
	end
	
	if (event == "PLAYER_LOGIN") then
		-- It may help collectors to know the race, class, and level of the player that looted an item in case of restrictions.
		local playerRace = UnitRace("player")
		local playerClass = UnitClass("player")
		local playerLevel = UnitLevel("player")
		addonTable.playerRace, addonTable.playerClass, addonTable.playerLevel = playerRace, playerClass, playerLevel
	end
end)