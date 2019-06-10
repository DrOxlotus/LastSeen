--[[
	Project			: LastSeen © 2019
	Author			: Oxlotus - Area 52-US
	Date Created	: 2019-04-23
	Purpose			: Handler for all item-related functions.
]]--

local lastSeen, lastSeenNS = ...;
local L = lastSeenNS.L;
local select = select;

lastSeenNS.New = function(itemID, itemName, itemLink, itemRarity, itemType, today, source, currentMap)
	LastSeenItemsDB[itemID] = {itemName = itemName, itemLink = itemLink, itemRarity = itemRarity, itemType = itemType, lootDate = today, source = source, location = currentMap};
	if lastSeenNS.mode ~= L["QUIET_MODE"] then
		print(L["ADDON_NAME"] .. L["ADDED_ITEM"] .. "|T"..select(5, GetItemInfoInstant(itemID))..":0|t" .. itemLink .. ".");
	end
	return;
end

lastSeenNS.Update = function(manualEntry, itemID, itemName, itemLink, itemType, itemRarity, lootDate, source, location)
	if LastSeenItemsDB[itemID].manualEntry == true then -- A manually entered item has been seen!
		LastSeenItemsDB[itemID].itemName = itemName;
		LastSeenItemsDB[itemID].itemLink = itemLink;
		LastSeenItemsDB[itemID].itemType = itemType;
		LastSeenItemsDB[itemID].itemRarity = itemRarity;
		LastSeenItemsDB[itemID].lootDate = lootDate;
		LastSeenItemsDB[itemID].source = source;
		LastSeenItemsDB[itemID].location = location;
		LastSeenItemsDB[itemID].manualEntry = nil; -- Remove the manual entry flag.
		lastSeenNS.wasUpdated = true;
	else
		for v in pairs(LastSeenItemsDB[itemID]) do
			if v == "lootDate" then if LastSeenItemsDB[itemID][v] ~= lootDate then LastSeenItemsDB[itemID][v] = lootDate; lastSeenNS.wasUpdated = true; end; end
			if v == "location" then if LastSeenItemsDB[itemID][v] ~= location then LastSeenItemsDB[itemID][v] = location; lastSeenNS.wasUpdated = true; end; end
			if v == "source" then if LastSeenItemsDB[itemID][v] ~= source then LastSeenItemsDB[itemID][v] = source; lastSeenNS.wasUpdated = true; end; end
		end
	end
	if lastSeenNS.wasUpdated and lastSeenNS.mode ~= L["QUIET_MODE"] then
		print(L["ADDON_NAME"] .. L["UPDATED_ITEM"] .. "|T"..select(5, GetItemInfoInstant(itemID))..":0|t" .. itemLink .. ".");
		lastSeenNS.wasUpdated = false;
	end
	return;
end

local function GetItemIDFromItemLink(itemLink)
	local itemID = select(1, GetItemInfoInstant(itemLink));
	
	return itemID;
end

local function GetItemNameFromItemID(itemID)
	local itemName = select(1, GetItemInfo(itemID));
	
	return itemName;
end

local function GetItemRarityFromItemID(itemID)
	local itemRarity = select(3, GetItemInfo(itemID));
	
	return itemRarity;
end

local function GetItemTypeFromItemID(itemID)
	local itemType = select(6, GetItemInfo(itemID));
	
	return itemType;
end

local function PlayerLootedContainer(itemLink, currentDate, currentMap)
	local itemID = GetItemIDFromItemLink(itemLink);
	if not itemID then return end;
	
	local itemName = GetItemNameFromItemID(itemID); -- This is the name of the item container, not the loot.
	local itemRarity = GetItemRarityFromItemID(itemID);
	local itemType = GetItemTypeFromItemID(itemID);
	
	if itemRarity >= LastSeenSettingsCacheDB.rarity or LastSeenItemsDB[itemID]["manualEntry"] then
		if lastSeenNS.ignoredItemTypes[itemType] ~= nil then
			return;
		elseif lastSeenNS.ignoredItems[itemID] then
			return;
		elseif LastSeenIgnoredItemsDB[itemID] then
			return;
		end
		
		if LastSeenItemsDB[itemID] then
			lastSeenNS.Update(manualEntry, itemID, itemName, itemLink, itemType, itemRarity, currentDate, lastSeenNS.lootedItem, currentMap);
		else
			lastSeenNS.New(itemID, itemName, itemLink, itemRarity, itemType, currentDate, lastSeenNS.lootedItem, currentMap);
		end
	end
end

local function PlayerLootedObject(itemLink, currentDate, currentMap)
	local itemID = GetItemIDFromItemLink(itemLink);
	if not itemID then return end;
	
	local itemName = GetItemNameFromItemID(itemID); -- This is the name of the item container, not the loot.
	local itemRarity = GetItemRarityFromItemID(itemID);
	local itemType = GetItemTypeFromItemID(itemID);
	
	if itemRarity >= LastSeenSettingsCacheDB.rarity or LastSeenItemsDB[itemID]["manualEntry"] then
		if lastSeenNS.ignoredItemTypes[itemType] ~= nil then
			return;
		elseif lastSeenNS.ignoredItems[itemID] then
			return;
		elseif LastSeenIgnoredItemsDB[itemID] then
			return;
		end
		
		if LastSeenItemsDB[itemID] then
			lastSeenNS.Update(manualEntry, itemID, itemName, itemLink, itemType, itemRarity, currentDate, lastSeenNS.target, currentMap);
		else
			lastSeenNS.New(itemID, itemName, itemLink, itemRarity, itemType, currentDate, lastSeenNS.target, currentMap);
		end
	end
end

local function PlayerReceivedFromTrade(itemLink, currentDate, currentMap)
	local itemID = GetItemIDFromItemLink(itemLink);
	if not itemID then return end;
	
	local itemName = GetItemNameFromItemID(itemID); -- This is the name of the item container, not the loot.
	local itemRarity = GetItemRarityFromItemID(itemID);
	local itemType = GetItemTypeFromItemID(itemID);
	
	if itemRarity >= LastSeenSettingsCacheDB.rarity or LastSeenItemsDB[itemID]["manualEntry"] then
		if lastSeenNS.ignoredItemTypes[itemType] ~= nil then
			return;
		elseif lastSeenNS.ignoredItems[itemID] then
			return;
		elseif LastSeenIgnoredItemsDB[itemID] then
			return;
		end
		
		if LastSeenItemsDB[itemID] then
			lastSeenNS.Update(manualEntry, itemID, itemName, itemLink, itemType, itemRarity, currentDate, L["TRADE"], currentMap);
		else
			lastSeenNS.New(itemID, itemName, itemLink, itemRarity, itemType, currentDate, L["TRADE"], currentMap);
		end
	end
end

local function PlayerReceivedFromAuctionHouse(itemLink, currentDate, currentMap)
	local itemID = GetItemIDFromItemLink(itemLink);
	if not itemID then return end;
	
	local itemName = GetItemNameFromItemID(itemID); -- This is the name of the item container, not the loot.
	local itemRarity = GetItemRarityFromItemID(itemID);
	local itemType = GetItemTypeFromItemID(itemID);
	
	if itemRarity >= LastSeenSettingsCacheDB.rarity or LastSeenItemsDB[itemID]["manualEntry"] then
		if lastSeenNS.ignoredItemTypes[itemType] ~= nil then
			return;
		elseif lastSeenNS.ignoredItems[itemID] then
			return;
		elseif LastSeenIgnoredItemsDB[itemID] then
			return;
		end
		
		if LastSeenItemsDB[itemID] then
			lastSeenNS.Update(manualEntry, itemID, itemName, itemLink, itemType, itemRarity, currentDate, L["AUCTION"], currentMap);
		else
			lastSeenNS.New(itemID, itemName, itemLink, itemRarity, itemType, currentDate, L["AUCTION"], currentMap);
		end
	end
end

local function PlayerCreatedItem(itemLink, currentDate, currentMap)
	local itemID = GetItemIDFromItemLink(itemLink);
	if not itemID then return end;
	
	local itemName = GetItemNameFromItemID(itemID); -- This is the name of the item container, not the loot.
	local itemRarity = GetItemRarityFromItemID(itemID);
	local itemType = GetItemTypeFromItemID(itemID);
	
	if itemRarity >= LastSeenSettingsCacheDB.rarity or LastSeenItemsDB[itemID]["manualEntry"] then
		if lastSeenNS.ignoredItemTypes[itemType] ~= nil then
			return;
		elseif lastSeenNS.ignoredItems[itemID] then
			return;
		elseif LastSeenIgnoredItemsDB[itemID] then
			return;
		end
		
		if LastSeenItemsDB[itemID] then
			lastSeenNS.Update(manualEntry, itemID, itemName, itemLink, itemType, itemRarity, currentDate, L["IS_CRAFTED_ITEM"], currentMap);
		else
			lastSeenNS.New(itemID, itemName, itemLink, itemRarity, itemType, currentDate, L["IS_CRAFTED_ITEM"], currentMap);
		end
	end
end

local function PlayerBoughtItem(itemLink, currentDate, currentMap)
	local itemID = GetItemIDFromItemLink(itemLink);
	if not itemID then return end;
	
	local itemName = GetItemNameFromItemID(itemID); -- This is the name of the item container, not the loot.
	local itemRarity = GetItemRarityFromItemID(itemID);
	local itemType = GetItemTypeFromItemID(itemID);
	
	if itemRarity >= LastSeenSettingsCacheDB.rarity or LastSeenItemsDB[itemID]["manualEntry"] then
		if lastSeenNS.ignoredItemTypes[itemType] ~= nil then
			return;
		elseif lastSeenNS.ignoredItems[itemID] then
			return;
		elseif LastSeenIgnoredItemsDB[itemID] then
			return;
		end
		
		if LastSeenItemsDB[itemID] then
			lastSeenNS.Update(manualEntry, itemID, itemName, itemLink, itemType, itemRarity, currentDate, lastSeenNS.merchantName, currentMap);
		else
			lastSeenNS.New(itemID, itemName, itemLink, itemRarity, itemType, currentDate, lastSeenNS.merchantName, currentMap);
		end
	end
end 

lastSeenNS.LootDetected = function(constant, currentDate, currentMap, itemSource, questID)
	if not constant then return end; -- If the passed constant is nil, then simply return to avoid error.
	
	if lastSeenNS.doNotUpdate then return end;
	
	questID = questID or 0; -- The questID argument is an optional argument.
	
	local link = lastSeenNS.ExtractItemLink(constant); if not link then return end;
	-- The item passed isn't a looted item, but a received item from something else.
	-- Let's figure out what that source is.
	if itemSource == L["IS_QUEST_ITEM"] and questID ~= 0 then -- Quest Item
		-- The item received was a quest reward and shouldn't be handled by the ItemHandler.
		lastSeenNS.QuestChoices(questID, link, currentDate);
		return;
	elseif itemSource == L["MAIL"] then -- Mailbox Item
		local isAuctionItem = true;
	elseif itemSource == L["IS_MISCELLANEOUS"] then -- An item looted from a container like the [Oozing Bag].
		PlayerLootedContainer(link, currentDate, currentMap);
	elseif itemSource == L["IS_OBJECT"] then
		PlayerLootedObject(link, currentDate, currentMap);
	elseif itemSource == L["TRADE"] then
		PlayerReceivedFromTrade(link, currentDate, currentMap);
	elseif itemSource == L["AUCTION"] then
		PlayerReceivedFromAuctionHouse(link, currentDate, currentMap);
	elseif itemSource == L["IS_CRAFTED_ITEM"] then
		PlayerCreatedItem(link, currentDate, currentMap);
	elseif itemSource == L["MERCHANT"] then
		PlayerBoughtItem(link, currentDate, currentMap);
	else
		link = lastSeenNS.ExtractItemLink(constant); -- Just an item looted from a creature. Simple; classic.
	end
	
	if select(1, GetItemInfoInstant(link)) == 0 then return end; -- This is here for items like pet cages.
	
	local itemID = select(1, GetItemInfoInstant(link)); if not itemID then return end;
	
	local itemLink = select(2, GetItemInfo(itemID));
	local itemName = select(1, GetItemInfo(itemID));
	local itemRarity = select(3, GetItemInfo(itemID));
	local itemType = select(6, GetItemInfo(itemID));
	local itemSourceCreatureID = lastSeenNS.itemsToSource[itemID];
	
	if itemRarity >= LastSeenSettingsCacheDB.rarity or LastSeenItemsDB[itemID]["manualEntry"] then
		if lastSeenNS.ignoredItemTypes[itemType] ~= nil then return;
		elseif lastSeenNS.ignoredItems[itemID] then return;
		elseif LastSeenIgnoredItemsDB[itemID] then return;
		end

		if LastSeenItemsDB[itemID] then -- This is an update situation because the item has been looted before.
			if itemSourceCreatureID ~= nil then
				lastSeenNS.Update(manualEntry, itemID, itemName, itemLink, itemType, itemRarity, currentDate, LastSeenCreaturesDB[itemSourceCreatureID].unitName, currentMap);
			end
		else -- An item seen for the first time.
			if itemSourceCreatureID ~= nil then
				if LastSeenCreaturesDB[itemSourceCreatureID] and not lastSeenNS.isMailboxOpen then
					if not lastSeenNS.isAutoLootPlusLoaded then
						lastSeenNS.New(itemID, itemName, itemLink, itemRarity, itemType, currentDate, LastSeenCreaturesDB[itemSourceCreatureID].unitName, currentMap);
					end
				else
					print(L["ADDON_NAME"] .. L["UNABLE_TO_DETERMINE_SOURCE"] .. itemLink .. ". " .. L["DISCORD_REPORT"]);
				end
			end
		end
	end
end