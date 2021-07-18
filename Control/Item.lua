-- This controller oversees raw item management. These are items that are natively acquired from open-world drops.
local addonName, addonTable = ...
local e = CreateFrame("Frame", "LastSeenItemController")
local L = addonTable.L

local ignoredItemTypes = {
	"Quest",
	"Tradeskill",
}

-- Item Information Variables
local itemID, itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice, itemClassID, itemSubclassID, itemBindType, itemExpacID, itemSetID, itemIsCraftingReagent

local lootSourceGUID, creatureID
local patch, lootDate
local isItemChanged

e:RegisterEvent("LOOT_OPENED")
e:RegisterEvent("LOOT_READY")
e:RegisterEvent("LOOT_CLOSED")

e:SetScript("OnEvent", function(self, event, ...)
	if (event == "LOOT_OPENED" or event == "LOOT_READY") then
		local numLootItems = GetNumLootItems()
		if (numLootItems < 1) then return end
		for i = numLootItems, 1, -1 do
			itemLink = GetLootSlotLink(i)
			if (itemLink) then
				lootSourceGUID = (GetLootSourceInfo(i))
				_, _, _, _, _, creatureID = strsplit("-", lootSourceGUID); creatureID = tonumber(creatureID)
				_, itemID = strsplit(":", itemLink); itemID = tonumber(itemID)
				itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice, itemClassID, itemSubclassID, itemBindType, itemExpacID, itemSetID, itemIsCraftingReagent = GetItemInfo(itemLink)
				-- We need to filter out items that we don't care about.
				if (itemQuality < 1) then return end
				for j = 1, #ignoredItemTypes do
					if (ignoredItemTypes[j] == itemType) then return end
				end
				-- Let's get the current patch and date to store in the table.
				patch = GetBuildInfo()
				lootDate = date("%d/%m/%y")
				-- The item shouldn't be filtered out, so let's add it to the Items table.
				if (LastSeenItems[itemID]) then
					-- This isn't a NEW item. Confirm if any information requires an update.
					if (LastSeenItems[itemID].lootDate ~= lootDate) then
						LastSeenItems[itemID].lootDate = lootDate
						isItemChanged = true
					end
					if (LastSeenItems[itemID].patch ~= patch) then
						LastSeenItems[itemID].patch = patch
						isItemChanged = true
					end
					if (LastSeenItems[itemID].map ~= LastSeenCreatures[creatureID].map) then
						LastSeenItems[itemID].map = LastSeenCreatures[creatureID].map
						isItemChanged = true
					end
					if (LastSeenItems[itemID].name ~= LastSeenCreatures[creatureID].creatureName) then
						LastSeenItems[itemID].name = LastSeenCreatures[creatureID].creatureName
						isItemChanged = true
					end
					if (LastSeenItems[itemID].race ~= addonTable.playerRace) then
						LastSeenItems[itemID].race = addonTable.playerRace
						isItemChanged = true
					end
					if (LastSeenItems[itemID].class ~= addonTable.playerClass) then
						LastSeenItems[itemID].class = addonTable.playerClass
						isItemChanged = true
					end
					if (LastSeenItems[itemID].level ~= addonTable.playerLevel) then
						LastSeenItems[itemID].level = addonTable.playerLevel
						isItemChanged = true
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
							name = LastSeenCreatures[creatureID].creatureName,
							map = LastSeenCreatures[creatureID].map,
							lootDate = lootDate,
							patch = patch,
						},
					}
					print(L["COLORED_ADDON_NAME"] .. L["GREEN_PLUS"] .. "|T" .. itemTexture .. ":0|t" .. itemLink)
				end
				if (isItemChanged) then
					print(L["COLORED_ADDON_NAME"] .. L["GREEN_PLUS"] .. "|T" .. itemTexture .. ":0|t" .. itemLink)
					isItemChanged = false
				end
			end
		end
	end
end)