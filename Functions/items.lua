--[[
	Project			: LastSeen © 2019
	Author			: Oxlotus - Area 52-US
	Date Created	: 2019-04-23
	Purpose			: Handler for all item-related functions.
]]--

local lastSeen, lastSeenNS = ...;
local L = lastSeenNS.L;

lastSeenNS.GetItemID = function(query)
	if select(1, GetItemInfoInstant(query)) == nil then
		return 0;
	else
		return select(1, GetItemInfoInstant(query));
	end
end

lastSeenNS.GetItemLink = function(query)
	if select(2, GetItemInfo(query)) == nil then
		return "";
	else
		return select(2, GetItemInfo(query));
	end
end

lastSeenNS.GetItemType = function(query)
	if select(2, GetItemInfoInstant(query)) == nil then
		return 0;
	else
		return select(2, GetItemInfoInstant(query));
	end
end

lastSeenNS.GetLootSourceInfo = function()
	local lootSlots = GetNumLootItems();
	if lootSlots < 1 then return end;
	
	for i = 1, lootSlots do
		local itemLink = GetLootSlotLink(i);
		local lootSources = { GetLootSourceInfo(i) };
		
		if itemLink then
			for j = 1, #lootSources, 2 do
				local itemID = lastSeenNS.GetItemID(itemLink);
				local _, _, _, _, _, creatureID, _ = strsplit("-", lootSources[j]);
				lastSeenNS.itemsToSource[itemID] = tonumber(creatureID);
			end
		end
	end
end

lastSeenNS.Loot = function(msg, today, currentMap)
	if lastSeenNS.isQuestItemReward then return end;
	
	if not msg then return end;
	
	if string.match(msg, L["LOOT_ITEM_PUSHED_SELF"]) then
		lastSeenNS.itemLooted = select(3, string.find(msg, string.gsub(string.gsub(LOOT_ITEM_PUSHED_SELF, "%%s", "(.+)"), "%%d", "(.+)")));
	elseif string.match(msg, L["LOOT_ITEM_SELF"]) then
		lastSeenNS.itemLooted = select(3, string.find(msg, string.gsub(string.gsub(LOOT_ITEM_SELF, "%%s", "(.+)"), "%%d", "(.+)")));
	elseif string.match(msg, L["LOOT_ITEM_CREATED_SELF"]) then
		lastSeenNS.itemLooted = select(3, string.find(msg, string.gsub(string.gsub(LOOT_ITEM_CREATED_SELF, "%%s", "(.+)"), "%%d", "(.+)")));
		lastSeenNS.isCraftedItem = true;
	else
		lastSeenNS.itemLooted = string.match(msg, "[%+%p%s](.*)[%s%p%+]");
	end
	
	if not lastSeenNS.itemLooted then return end;
	
	if lastSeenNS.GetItemID(lastSeenNS.itemLooted) == 0 then return end;
	
	local mode = lastSeenNS.mode;
	local rarity = lastSeenNS.rarity;
	local itemID = lastSeenNS.GetItemID(lastSeenNS.itemLooted);
	local itemLink = lastSeenNS.GetItemLink(itemID);
	local itemName = select(1, GetItemInfo(itemID));
	local itemRarity = select(3, GetItemInfo(itemID));
	local itemType = lastSeenNS.GetItemType(itemID);
	local itemSourceID = lastSeenNS.itemsToSource[itemID];

	if rarity <= itemRarity then
		lastSeenNS.IfExists(lastSeenNS.ignoredItemTypes, itemType);
		lastSeenNS.IfExists(lastSeenNS.LastSeenIgnoredItems, itemID);
		lastSeenNS.IfExists(lastSeenNS.ignoredItems, itemID);
		if lastSeenNS.exists == false then
			if lastSeenNS.LastSeenItems[itemID] then -- Item exists in the looted database.
				if lastSeenNS.LastSeenItems[itemID].manualEntry == true then -- A manually entered item has been seen!
					lastSeenNS.LastSeenItems[itemID].itemName = itemName;
					lastSeenNS.LastSeenItems[itemID].itemLink = itemLink;
					lastSeenNS.LastSeenItems[itemID].itemType = itemType;
					lastSeenNS.LastSeenItems[itemID].itemRarity = rarity;
					lastSeenNS.LastSeenItems[itemID].lootDate = today;
					lastSeenNS.LastSeenItems[itemID].source = lastSeenNS.lootedCreatureID;
					lastSeenNS.LastSeenItems[itemID].location = currentMap;
					lastSeenNS.LastSeenItems[itemID].manualEntry = nil; -- Remove the manual entry flag.
					lastSeenNS.wasUpdated = true;
				else
					if lastSeenNS.LastSeenItems[itemID].lootDate ~= today then -- The item has been seen for the first time today.
						lastSeenNS.LastSeenItems[itemID].lootDate = today;
						lastSeenNS.wasUpdated = true;
						lastSeenNS.updateReason = L["NEW_LOOT_DATE"];
					end
					if lastSeenNS.LastSeenItems[itemID].location ~= currentMap then -- The item has now been "last seen" on a new map.
						lastSeenNS.LastSeenItems[itemID].location = currentMap;
						lastSeenNS.wasUpdated = true;
						lastSeenNS.updateReason = L["NEW_LOCATION"];
					end
					if itemSourceID ~= nil then
						if lastSeenNS.LastSeenItems[itemID].source ~= lastSeenNS.LastSeenCreatures[itemSourceID].unitName then
							lastSeenNS.LastSeenItems[itemID].source = lastSeenNS.LastSeenCreatures[itemSourceID].unitName;
							lastSeenNS.wasUpdated = true;
							lastSeenNS.updateReason = L["NEW_SOURCE"];
						end
					end
					if lastSeenNS.LastSeenItems[itemID].source == "" then -- An item added to the database prior to the existence of source tracking.
						-- do something here
					end
				end
				if lastSeenNS.wasUpdated and lastSeenNS.mode ~= L["QUIET_MODE"] then
					print(L["ADDON_NAME"] .. L["UPDATED_ITEM"] .. itemLink .. ". " .. L["REASON"] .. lastSeenNS.updateReason);
					lastSeenNS.wasUpdated = false;
					lastSeenNS.updateReason = "";
				end
			else
				if lastSeenNS.isMailboxOpen then
					lastSeenNS.LastSeenItems[itemID] = {itemName = itemName, itemLink = itemLink, itemRarity = itemRarity, itemType = itemType, lootDate = today, source = L["MAIL"], location = currentMap};
				elseif lastSeenNS.isTradeOpen then
					lastSeenNS.LastSeenItems[itemID] = {itemName = itemName, itemLink = itemLink, itemRarity = itemRarity, itemType = itemType, lootDate = today, source = L["TRADE"], location = currentMap};
				elseif lastSeenNS.isCraftedItem then
					lastSeenNS.LastSeenItems[itemID] = {itemName = itemName, itemLink = itemLink, itemRarity = itemRarity, itemType = itemType, lootDate = today, source = L["IS_CRAFTED_ITEM"], location = currentMap};
				else
					if lastSeenNS.LastSeenCreatures[itemSourceID] and not lastSeenNS.isAutoLootPlusLoaded then
						lastSeenNS.LastSeenItems[itemID] = {itemName = itemName, itemLink = itemLink, itemRarity = itemRarity, itemType = itemType, lootDate = today, source = lastSeenNS.LastSeenCreatures[itemSourceID].unitName, location = currentMap};
					else
						lastSeenNS.LastSeenItems[itemID] = {itemName = itemName, itemLink = itemLink, itemRarity = itemRarity, itemType = itemType, lootDate = today, source = "N/A", location = currentMap};
					end
				end
				if lastSeenNS.mode ~= L["QUIET_MODE"] then
					print(L["ADDON_NAME"] .. L["ADDED_ITEM"] .. itemLink .. ".");
				end
			end
		else
			lastSeenNS.exists = false;
		end
	end
end