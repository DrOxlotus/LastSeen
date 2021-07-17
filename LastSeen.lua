local addonName, addonTable = ...
local e = CreateFrame("Frame", "LastSeenEventFrame")
local L = addonTable.L

e:RegisterEvent("ADDON_LOADED")
e:RegisterEvent("PLAYER_LEVEL_CHANGED")
e:RegisterEvent("PLAYER_LOGIN")
e:RegisterEvent("ZONE_CHANGED_NEW_AREA")


e:SetScript("OnEvent", function(self, event, ...)
	if (event == "ADDON_LOADED") then
		local addon = ...
		if (addon == addonName) then
			-- Process saved variables. If they are nil, then they need to be initialized as empty tables.
			if (LastSeenItems == nil) then
				LastSeenItems = {}
			end
			if (LastSeenCreatures == nil) then
				LastSeenCreatures = {}
			end
		end
	end
	
	if (event == "PLAYER_LEVEL_CHANGED") then
		local _, newLevel = ...
		addonTable.playerLevel = newLevel
	end
	
	if (event == "PLAYER_LOGIN") then
		-- It may help collectors to know the map, race, class, and level of the player that looted an item in case of restrictions.
		local playerRace = UnitRace("player")
		local playerClass = UnitClass("player")
		local playerLevel = UnitLevel("player")
		local uiMapID = C_Map.GetBestMapForUnit("player")
		local uiMapName = C_Map.GetMapInfo(uiMapID).name
		addonTable.playerRace, addonTable.playerClass, addonTable.playerLevel, addonTable.map = playerRace, playerClass, playerLevel, uiMapName
	end
	
	if (event == "ZONE_CHANGED_NEW_AREA") then
		local uiMapID = C_Map.GetBestMapForUnit("player")
		local uiMapName = C_Map.GetMapInfo(uiMapID).name
		addonTable.map = uiMapName
	end
end)