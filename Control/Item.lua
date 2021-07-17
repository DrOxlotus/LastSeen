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

e:RegisterEvent("LOOT_OPENED")
e:RegisterEvent("LOOT_READY")
e:RegisterEvent("LOOT_CLOSED")

e:SetScript("OnEvent", function(self, event, ...)
	if (event == "LOOT_OPENED" or event == "LOOT_READY") then
		local lootItems = GetNumLootItems()
		for i = 1, lootItems do
			itemLink = GetLootSlotLink(i)
			if (itemLink) then
				_, itemID = strsplit(":", itemLink); itemID = tonumber(itemID)
				itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice, itemClassID, itemSubclassID, itemBindType, itemExpacID, itemSetID, itemIsCraftingReagent = GetItemInfo(itemLink)
				-- We need to filter out items that we don't care about.
				if (itemQuality < 1) then return end
				for j = 1, #ignoredItemTypes do
					if (ignoredItemTypes[j] == itemType) then return end
				end
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
				}
			end
			print(L["COLORED_ADDON_NAME"] .. L["GREEN_PLUS"] .. "|T" .. itemTexture .. ":0|t" .. itemLink)
		end
	end
end)