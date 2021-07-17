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

local lootSourceInfo, creatureID

local patch

e:RegisterEvent("LOOT_OPENED")
e:RegisterEvent("LOOT_READY")
e:RegisterEvent("LOOT_CLOSED")

e:SetScript("OnEvent", function(self, event, ...)
	if (event == "LOOT_OPENED" or event == "LOOT_READY") then
		local lootItems = GetNumLootItems()
		for i = 1, lootItems do
			itemLink = GetLootSlotLink(i)
			lootSourceInfo = { GetLootSourceInfo(i) }
			for j = 1, #lootSourceInfo, 2 do
				if (itemLink) then
					-- A GUID is passed back to us that contains the ID of where the item sourced from (e.g. an NPC), let's cast that to a number and use it later.
					_, _, _, _, _, creatureID = strsplit("-", lootSourceInfo[j]); creatureID = tonumber(creatureID)
					_, itemID = strsplit(":", itemLink); itemID = tonumber(itemID)
					itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice, itemClassID, itemSubclassID, itemBindType, itemExpacID, itemSetID, itemIsCraftingReagent = GetItemInfo(itemLink)
					-- We need to filter out items that we don't care about.
					if (itemQuality < 1) then return end
					for j = 1, #ignoredItemTypes do
						if (ignoredItemTypes[j] == itemType) then return end
					end
					-- Let's get the current patch to store in the table.
					patch = GetBuildInfo()
					-- The item shouldn't be filtered out, so let's add it to the Items table.
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
							lootDate = date("%d/%m/%y"),
							patch = patch,
						},
					}
					print(L["COLORED_ADDON_NAME"] .. L["GREEN_PLUS"] .. "|T" .. itemTexture .. ":0|t" .. itemLink)
				end
			end
		end
	end
end)