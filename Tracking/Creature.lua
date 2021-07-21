local addonName, addonTable = ...
local e = CreateFrame("Frame")
local L = addonTable.L

local unitType, unitID, unitGUID, unitName
local uiMapID, uiMapName

e:RegisterEvent("NAME_PLATE_UNIT_ADDED")
e:RegisterEvent("UPDATE_MOUSEOVER_UNIT")

e:SetScript("OnEvent", function(self, event, ...)
	-- The reason we specify Vehicle as a supported unit's type is due to some creatures being considered Vehicles by Blizzard. No idea why.
	if (event == "NAME_PLATE_UNIT_ADDED") then
		local unitToken = ...
		if (unitToken) then
			if (UnitGUID(unitToken) ~= nil) then
				uiMapID = C_Map.GetBestMapForUnit("player")
				uiMapName = C_Map.GetMapInfo(uiMapID).name
				addonTable.map = uiMapName
				unitGUID = UnitGUID(unitToken)
				unitType, _, _, _, _, unitID = strsplit("-", unitGUID); unitID = tonumber(unitID)
				if (unitType == "Creature" or unitType == "Vehicle") then
					unitName = UnitName(unitToken)
					LastSeenCreatures[unitID] = {
						creatureName = unitName,
						map = addonTable.map,
					}
				end
			end
		end
	end
	
	if (event == "UPDATE_MOUSEOVER_UNIT") then
		local unit = "mouseover"
		if (UnitGUID(unit) ~= nil) then
			uiMapID = C_Map.GetBestMapForUnit("player")
			uiMapName = C_Map.GetMapInfo(uiMapID).name
			addonTable.map = uiMapName
			unitGUID = UnitGUID(unit)
			unitType, _, _, _, _, unitID = strsplit("-", unitGUID); unitID = tonumber(unitID)
			if (unitType == "Creature" or unitType == "Vehicle") then
				unitName = UnitName(unit)
				LastSeenCreatures[unitID] = {
					creatureName = unitName,
					map = addonTable.map,
				}
			end
		end
	end
end)