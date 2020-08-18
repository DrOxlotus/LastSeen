local addon, tbl = ...;

local L = tbl.L

SLASH_LastSeen1 = L["SLASH_CMD_1"];
SLASH_LastSeen2 = L["SLASH_CMD_2"];
SlashCmdList["LastSeen"] = function(cmd, editbox)
	local _, _, cmd, args = string.find(cmd, "%s?(%w+)%s?(.*)");

	if not cmd or cmd == "" then
		tbl.LoadSettings();
	elseif cmd == L["CMD_DISCORD"] then -- Gives the player the link to the Discord server.
		print(L["ADDON_NAME"] .. "https://discord.gg/7Ve8JQv");
	elseif cmd == L["CMD_FORMAT"] then -- Allows the player to change their date format for existing items.
		tbl.DateFormat(args);
	elseif cmd == L["CMD_HELP"] then -- Provides the available commands to the player in the chat frame.
		tbl.Help();
	elseif cmd == L["CMD_HISTORY"] then -- Allows the player to view the last 20 items they've acquired. This is persistent between sessions and characters.
		tbl.GetTable(tbl.History);
	elseif cmd == L["CMD_LOCALE"] and args ~= "" then -- Allows the player to change the current locale for the addon, despite the game client's current language.
		tbl.SetLocale(args);
		tbl.Settings["locale"] = tbl["locale"];
	elseif cmd == L["CMD_LOOT"] then -- Enables or disables a faster loot speed.
		if tbl.Settings["lootFast"] then
			tbl.Settings["lootFast"] = not tbl.Settings["lootFast"]; tbl.Settings.lootFast = tbl.Settings["lootFast"];
			print(L["ADDON_NAME"] .. L["INFO_MSG_LOOT_DISABLED"]);
		else
			tbl.Settings["lootFast"] = true tbl.Settings.lootFast = tbl.Settings["lootFast"];
			print(L["ADDON_NAME"] .. L["INFO_MSG_LOOT_ENABLED"]);
		end
	elseif cmd == L["CMD_MAN"] and args ~= "" then -- Allows the player to ask the addon for command usage.
		tbl.Manual(args);
	elseif cmd == L["CMD_REMOVE"] or cmd == L["CMD_REMOVE_SHORT"] then -- Removes an item from the items table. Accepts an ID or link.
		tbl.Remove(args);
	elseif cmd == L["CMD_SEARCH"] and args ~= "" then -- Searches the items table for matches to the query. Accepts creatures, items, quests, and zones.
		tbl.Search(args);
	elseif cmd == L["CMD_VIEW"] then -- When items with bad data are removed, this command allows the player to view them before they are removed, or report them.
		if next(tbl.removedItems) ~= nil then
			for k, v in pairs(tbl.removedItems) do
				print(k .. ": " .. v);
			end
		end
	end
end
