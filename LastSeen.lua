-------------------------------------------------------
-- LastSeen | Oxlotus - Area 52 (US) | Copyright © 2019
-------------------------------------------------------

local addonName, addonTable = ...;

local frame = CreateFrame("Frame");
local date = date("%m/%d/%y");
local lastTable = addonTable.LastSeenItems;

frame:RegisterEvent("LOOT_OPENED");
frame:RegisterEvent("CHAT_MSG_LOOT");
frame:RegisterEvent("PLAYER_LOGIN");
frame:RegisterEvent("PLAYER_LOGOUT");

local function AddLoot()
	for i = GetNumLootItems(), 1, -1 do
		local itemName = select(2, GetLootSlotInfo(i)); addonTable.itemName = itemName;
		local itemRarity = select(5, GetLootSlotInfo(i)); addonTable.itemRarity = itemRarity;
		if itemRarity < 2 then
			local itemLink = GetLootSlotLink(i);
			if itemLink ~= nil then
				local itemID, _, _, _, _, _, _ = GetItemInfoInstant(itemLink); addonTable.itemID = itemID;
				if lastTable[itemID] then
					if lastTable[itemID].itemName == "" then
						-- This is a custom item added by the player. Now is the time to update it.
						lastTable[itemID].itemName = itemName;
						lastTable[itemID].lootDate = date;
					elseif lastTable[itemID].lootDate ~= date then
						lastTable[itemID].lootDate = date; -- Update an existing record.
						print(addonName .. ": Updated the record for " .. itemLink .. ".");
					end
				else
					lastTable[itemID] = {itemName = itemName, lootDate = date}; -- Add a new record.
					print(addonName .. ": Added a new record for " .. itemLink .. ".");
				end
			end
		end
	end
end

local function AddPushedLoot(chatMsg, unitName)
	if not chatMsg then return end
	local itemLink = string.match(chatMsg, ":(.*])");
	
	if not itemLink then return end
	
	local itemID = select(1, GetItemInfoInstant(itemLink)); addonTable.itemID = itemID;
	local itemName = select(1, GetItemInfo(itemID));
	local itemRarity = select(3, GetItemInfo(itemID));
	if itemRarity < 2 then
		if lastTable[itemID] then
			if lastTable[itemID].itemName == "" then
				-- This is a custom item added by the player. Now is the time to update it.
				lastTable[itemID].itemName = itemName;
				lastTable[itemID].lootDate = date;
			elseif lastTable[itemID].lootDate ~= date then
				lastTable[itemID].lootDate = date; -- Update an existing record.
				print(addonName .. ": Updated the record for " .. itemLink .. ".");
			end
		else
			lastTable[itemID] = {itemName = itemName, lootDate = date}; -- Add a new record.
			print(addonName .. ": Added a new record for " .. itemLink .. ".");
		end
	end
end

local function AddItem(customItemID)
	if lastTable[tonumber(customItemID)] then
		print(addonName .. ": That item is already in the database!");
	else
		lastTable[tonumber(customItemID)] = {itemName = "", lootDate = ""};
		print(addonName .. ": Added a new record for " .. customItemID .. ".");
	end
end

local function ClearDB()
	lastTable = {};
	print(addonName .. ": Database cleared.")
end

local function DumpDB()
	for k,v in pairs(lastTable) do
		print(v.itemName .. " (" .. k .. ")" .. " - " .. v.lootDate);
	end
end

local function Search(customItemID)
	if not lastTable[tonumber(customItemID)] then
		print(addonName .. ": Item not found.");
	else
		print(lastTable[tonumber(customItemID)].itemName .. " - " .. lastTable[tonumber(customItemID)].lootDate);
	end
end

SLASH_LastSeen1 = "/lastseen";
SLASH_LastSeen2 = "/last";
SlashCmdList["LastSeen"] = function(cmd, editbox)
	local _, _, cmd, args = string.find(cmd, "%s?(%w+)%s?(.*)");
	
	if not cmd or cmd == "" then
		print(addonName .. ": \nVersion: " .. addonTable.addonVersion .. " (" .. addonTable.addonReleaseDate .. ")" .. "\n" ..
		"Author: " .. addonTable.addonAuthor .. "\n" .. "Contact: " .. addonTable.addonAuthorContact .. "\n" ..
		"Commands: " .. addonTable.commands);
	elseif cmd == "add" and args ~= "" then
		AddItem(args);
	elseif cmd == "clear" then
		ClearDB();
	elseif cmd == "dump" then
		DumpDB();
	elseif cmd == "search" and args ~= "" then
		Search(args);
	end
end

frame:SetScript("OnEvent", function(self, event, ...)
	if event == "PLAYER_LOGIN" then
		lastTable = LastSeenItemsDB;
		if next(lastTable) == nil then
			lastTable = {};
		end
		frame:UnregisterEvent("PLAYER_LOGIN");
	elseif event == "LOOT_OPENED" then -- Looted items
		AddLoot();
	elseif event == "CHAT_MSG_LOOT" then -- Pushed items (e.g. world quests, tradeskills, etc.)
		local chatMsg, _, _, _, unitName, _, _, _, _, _, _, _, _ = ...;
		if string.match(unitName, "(.*)-") == UnitName("player") then
			AddPushedLoot(chatMsg, unitName);
		end
	elseif event == "PLAYER_LOGOUT" then
		LastSeenItemsDB = lastTable;
	end
end)