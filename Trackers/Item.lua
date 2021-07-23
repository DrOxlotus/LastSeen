-- This controller oversees raw item management. These are items that are natively acquired from open-world drops.
local addonName, addonTable = ...
local e = CreateFrame("Frame", "LastSeenItemController")
local L = addonTable.L

local ignoredItemTypes = {
	"Quest",
	"Tradeskill",
	"Food & Drink",
	"Elixir",
}

-- Item Information Variables
local itemID, itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice, itemClassID, itemSubclassID, itemBindType, itemExpacID, itemSetID, itemIsCraftingReagent
local source, map

local lootSourceGUID, entityID
local patch, lootDate

e:RegisterEvent("LOOT_OPENED")
e:RegisterEvent("LOOT_READY")
e:RegisterEvent("LOOT_CLOSED")

e:SetScript("OnEvent", function(self, event, ...)
	if (event == "LOOT_OPENED" or event == "LOOT_READY") then
		local numLootItems = GetNumLootItems()
		if (numLootItems < 1) then return end
		for i = 1, numLootItems do
			itemLink = GetLootSlotLink(i)
			if (itemLink) then
				lootSourceGUID = (GetLootSourceInfo(i))
				if (lootSourceGUID) then
					_, _, _, _, _, entityID = strsplit("-", lootSourceGUID); entityID = tonumber(entityID)
					if (entityID) then -- This protects against nil errors when players loot items like lockboxes.
						_, itemID = strsplit(":", itemLink); itemID = tonumber(itemID)
						itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice, itemClassID, itemSubclassID, itemBindType, itemExpacID, itemSetID, itemIsCraftingReagent = GetItemInfo(itemLink)
						if (itemQuality == nil) then return end
						-- We need to filter out items that we don't care about.
						if (itemQuality < 1) then return end
						for type = 1, #ignoredItemTypes do
							if (ignoredItemTypes[type] == itemType) then return end
							if (ignoredItemTypes[type] == itemSubType) then return end
						end
						for _, ignoredItemID in ipairs(addonTable.ignoredItems) do
							if (ignoredItemID == itemID) then return end
						end
						for _, ignoredItemID in ipairs(LastSeenIgnoredItems) do
							if (ignoredItemID == itemID) then return end
						end
						-- Let's get the current patch and date to store in the table.
						patch = GetBuildInfo()
						lootDate = date("%d/%m/%y")
						-- A creature ID isn't always available, so let's test for that.
						if (LastSeenCreatures[entityID]) then
							source = LastSeenCreatures[entityID].creatureName
							map = LastSeenCreatures[entityID].map
						elseif (addonTable.objects[entityID]) then
							-- A valid creature wasn't found in the Creatures table to match with the item. Let's check the Objects table now.
							source = addonTable.objects[entityID]
							map = C_Map.GetMapInfo(C_Map.GetBestMapForUnit("player")).name
						else
							source = L["Unknown Source"]
							map = C_Map.GetMapInfo(C_Map.GetBestMapForUnit("player")).name
							print(L["Colored Addon Name"] .. L["Info Source Unavailable"] .. " @" .. L["Discord"] .. "\n" .. C_Map.GetMapInfo(C_Map.GetBestMapForUnit("player")).name .. ", [" .. itemLink .. ", " .. entityID .. "]")
						end
						-- The item shouldn't be filtered out, so let's add it to the Items table.
						if (LastSeenItems[itemID]) then
							-- This isn't a NEW item. Confirm if any information requires an update.
							if (LastSeenItems[itemID]["sourceInfo"].lootDate ~= lootDate) then
								LastSeenItems[itemID]["sourceInfo"].lootDate = lootDate
							end
							if (LastSeenItems[itemID]["sourceInfo"].patch ~= patch) then
								LastSeenItems[itemID]["sourceInfo"].patch = patch
							end
							if (LastSeenItems[itemID]["sourceInfo"].map ~= addonTable.uiMapName) then
								LastSeenItems[itemID]["sourceInfo"].map = addonTable.uiMapName
							end
							if (LastSeenItems[itemID]["sourceInfo"].name ~= source) then
								LastSeenItems[itemID]["sourceInfo"].name = source
							end
							if (LastSeenItems[itemID]["playerInfo"].race ~= addonTable.playerRace) then
								LastSeenItems[itemID]["playerInfo"].race = addonTable.playerRace
							end
							if (LastSeenItems[itemID]["playerInfo"].class ~= addonTable.playerClass) then
								LastSeenItems[itemID]["playerInfo"].class = addonTable.playerClass
							end
							if (LastSeenItems[itemID]["playerInfo"].level ~= addonTable.playerLevel) then
								LastSeenItems[itemID]["playerInfo"].level = addonTable.playerLevel
							end
						else
							-- This is a new item.
							LastSeenItems[itemID] = {
								itemName = itemName,
								itemLink = itemLink,
								itemQuality = itemQuality,
								itemLevel = itemLevel,
								itemMinLevel = itemMinLevel,
								itemType = itemType,
								itemSubType = itemSubType,
								itemStackCount = itemStackCount,
								itemEquipLoc = itemEquipLoc,
								itemTexture = itemTexture,
								itemSellPrice = itemSellPrice,
								itemClassID = itemClassID,
								itemSubclassID = itemSubclassID,
								itemBindType = itemBindType,
								itemExpacID = itemExpacID,
								itemSetID = itemSetID,
								itemIsCraftingReagent = itemIsCraftingReagent,
								playerInfo = {
									race = addonTable.playerRace,
									class = addonTable.playerClass,
									level = addonTable.playerLevel,
								},
								sourceInfo = {
									name = source,
									map = map,
									lootDate = lootDate,
									patch = patch,
								},
							}
							print(L["Colored Addon Name"] .. L["Green Plus"] .. "|T" .. itemTexture .. ":0|t" .. itemLink)
						end
					end
				end
			end
		end
	end
end)