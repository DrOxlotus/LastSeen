local addonName, addonTable = ...
local discord = "Lightsky#0658"
local locale = GAME_LOCALE or GetLocale()

-- Identifies if the addon supports the player's language. If not, let's print a message to their chat box and give them a way to contact me.
local supportedLocales = {
	"enGB",
	"enUS",
}
local isLocaleSupported = false
for i = 1, #supportedLocales do
	if (supportedLocales[i] == locale) then
		isLocaleSupported = true
	end
end
if (isLocaleSupported == false) then
	print("|cffFF0000WARNING:|r " .. addonName .. " does NOT support " .. locale .. "! Please consider aiding in updating the addon to work for your language. If you speak English, please add me on Discord @ " .. discord .. ".")
end
--

-- The localized strings used by the addon.
local L = setmetatable({}, { __index = function(t, k)
	local v = tostring(k)
	rawset(t, k, v)
	return v
end })
if (locale == "enGB" or locale == "enUS") then
		-- Objects
		L["Ancient Treasure"]						= "Ancient Treasure"
		L["Gordok Tribute"]							= "Gordok Tribute"
		L["Treasure of the Shen'dralar"]			= "Treasure of the Shen'dralar"
		L["Chest of The Seven"]						= "Chest of The Seven"
		L["Cache of the Firelord"]					= "Cache of the Firelord"
		L["Large Battered Chest"]					= "Large Battered Chest"
		L["Reinforced Fel Iron Chest"]				= "Reinforced Fel Iron Chest"
		L["Dust Covered Chest"]						= "Dust Covered Chest"
		L["Cache of Pure Energy"]					= "Cache of Pure Energy"
		L["Spoils of Blackfathom"]					= "Spoils of Blackfathom"
		L["Invasive Mawshroom"]						= "Invasive Mawshroom"
		L["Domination Sealed Chest"]				= "Domination Sealed Chest"
		L["Helgarde Supply Cache"]					= "Helgarde Supply Cache"
		L["Mawsworn Cache"]							= "Mawsworn Cache"
		L["Nest of Unusual Materials"]				= "Nest of Unusual Materials"
		L["Relic Cache"]							= "Relic Cache"
		L["Riftbound Cache"]						= "Riftbound Cache"
		L["Rift Hidden Cache"]						= "Rift Hidden Cache"
		L["Seeping Cone"]							= "Seeping Cone"
		L["Drop Box"]								= "Drop Box"
		-- Strings
		L["Colored Addon Name"] 					= "|cff00CCFF" .. addonName .. "|r: "
		L["Info Source Unavailable"]				= "Please report the information below:"
		L["Unknown Source"]							= "Unknown Source"
		-- Symbols
		L["Green Plus"]								= "|cff52D66C+|r "
		L["Red Minus"]								= "|cffEF5858-|r "
		-- Other
		L["Discord"]								= discord
		
		
		--[[L["ADDED"]									= "Added";
		L["ADDON_NAME_SETTINGS"] 					= "|cff00ccff" .. addon .. "|r";
		L["APPROXIMATELY"] 							= "approximately";
		L["ARMOR_TEMPLATE_CLOTH"]					= "Cloth";
		L["ARMOR_TEMPLATE_LEATHER"]					= "Leather";
		L["ARMOR_TEMPLATE_MAIL"]					= "Mail";
		L["ARMOR_TEMPLATE_PLATE"]					= "Plate";
		L["BAD_DATA_SINGLE"]						= " |cffffdc14item purged from the items table due to corrupt information or it's been ignored.|r";
		L["BAD_DATA_MULTIPLE"]						= " |cffffdc14item(s) purged from the items table due to corrupt information or they're now ignored.|r";
		L["BAD_REQUEST"]							= "|cffffdc14Bad request. Please try again.|r";
		L["COMMAND_FORMAT"]							= "format";
		L["COMMAND_HISTORY"] 						= "history";
		L["COMMAND_IGNORE"] 						= "ignore";
		L["COMMAND_IGNORE_SHORT"] 					= "i";
		L["COMMAND_LOCALE"]							= "locale";
		L["COMMAND_LOOT"] 							= "loot";
		L["COMMAND_PROGRESS"]						= "progress";
		L["COMMAND_REMOVE"] 						= "remove";
		L["COMMAND_REMOVE_SHORT"] 					= "rm";
		L["COMMAND_SEARCH"] 						= "search";
		L["COMMAND_SLASH1"]							= "/ls";
		L["COMMAND_SLASH2"]							= "/lastseen";
		L["COMMAND_VIEW"] 							= "view";
		L["CREATURE"] 								= "Creature";
		L["DATE"]									= date("%m/%d/%Y");
		L["DEBUG"] 									= "Debug";
		L["DESCRIPTION_FILTER_GEM"]					= "Tells the addon to track or ignore gems. Check to track or uncheck to ignore.";
		L["DESCRIPTION_FILTER_NECK"]				= "Tells the addon to track or ignore necklaces. Check to track or uncheck to ignore.";
		L["DESCRIPTION_FILTER_QUEST"]				= "Tells the addon to track or ignore quest items. Check to track or uncheck to ignore.";
		L["DESCRIPTION_FILTER_RING"]				= "Tells the addon to track or ignore rings. Check to track or uncheck to ignore.";
		L["DESCRIPTION_FILTER_TRINKET"]				= "Tells the addon to track or ignore trinkets. Check to track or uncheck to ignore.";
		L["DESCRIPTION_MODE_DEBUG"]					= "|cffffffffDebug|r: Normal mode, but also shows variable content for debugging.";
		L["DESCRIPTION_MODE_NORMAL"]				= "|cffffffffNormal|r: Lets the player know when items are added or updated.";
		L["DESCRIPTION_MODE_NOUPDATES"]				= "|cffffffffNo Updates|r: This mode will only inform the player when NEW items are seen, but not when items are updated.";
		L["DESCRIPTION_MODE_SILENT"]				= "|cffffffffSilent|r: This mode won't share any information with the player. Does *NOT* affect tracking.";
		L["DESCRIPTION_SCAN_ON_LOOT1"]				= "Consider bonus IDs as items are looted.";
		L["DESCRIPTION_SCAN_ON_LOOT2"]				= "This option will not remove variants like \"of the Fireflash\" from item links or names.";
		L["DESCRIPTION_SCAN_TOOLTIPS_ON_HOVER"]		= "While the quest frame is open, allow LastSeen to scan tooltips on hover.\n|cffA71A19WARNING|r: Enabling this will affect ALL tooltips while the quest frame is open.\n\nThis is helpful for tracking quest choices without re-doing the quest.";
		L["DESCRIPTION_SHOW_SOURCES"]				= "If an item has been seen from more than one source, checking this button\nwill tell you how many and display up to 4 of the other sources.";
		L["ERR_JOIN_SINGLE_SCENARIO_S"]				= "You have joined the queue for Island Expeditions.";
		L["FILTERS"]								= "Filters";
		L["GEMS"]									= "Gems";
		L["IGNORING"]								= "Ignoring";
		L["INVALID_GUID_OR_UNITNAME"]				= "|cffffdc14Invalid GUID or unit name detected.|r";
		L["ISLAND_EXPEDITIONS"]						= "Island Expeditions";
		L["KEYBIND_OPEN_SETTINGS"]					= "Open Settings";
		L["LOOT_FAST_DISABLED"] 					= "Loot Fast mode disabled.";
		L["LOOT_FAST_ENABLED"] 						= "Loot Fast mode enabled.";
		L["LOOT_ITEM_PUSHED_SELF"] 					= "You receive item: ";
		L["LOOT_ITEM_SELF"] 						= "You receive loot: ";
		L["MALFORMED_ITEM_LINK"]					= "|cffffdc14A malformed item link was detected.|r";
		L["MANUALLY_IGNORED_ITEM"]					= "A manually ignored item.";
		L["NECK"]									= "Neck";
		L["NO_ITEMS_FOUND"]							= "|cffffdc14No item(s) found.|r";
		L["NO_QUEUE"]								= "You are no longer queued.";
		L["NORMAL"] 								= "Normal";
		L["NO_UPDATES"] 							= "No Updates";
		L["OF"] 									= "of";
		L["PLAYER"] 								= "Player";
		L["QUESTS"]									= "Quests";
		L["RELEASE"] 								= "[" .. GetAddOnMetadata(addon, "Version") .. "]";
		L["RESULTS"]								= " result(s)";
		L["RINGS"]									= "Rings";
		L["SCAN_ON_LOOT"] 							= "Scan on Loot";
		L["SCAN_TOOLTIPS_ON_HOVER"]					= "Scan Tooltips on Hover";
		L["SEEN_FROM"]								= "Seen from ";
		L["SHOW_EXTRA_SOURCES"]						= "Show Extra Sources";
		L["SILENT"] 								= "Silent";
		L["SOURCES"] 								= "sources";
		L["THIS_ITEM_IS_IGNORED"]					= "This item is ignored.";
		L["TRINKETS"]								= "Trinkets";
		L["UNKNOWN"]								= "Unknown";
		L["UNKNOWN_SOURCE"]							= " |cffffdc14was looted from an unknown source.|r";
		L["UPDATED"]								= "Updated";
		L["VEHICLE"] 								= "Vehicle";
		L["WEAPON_TYPE_ONE_HANDED_AXES"]			= "One-Handed Axes";
		L["WEAPON_TYPE_ONE_HANDED_SWORDS"]			= "One-Handed Swords";
		L["WEAPON_TYPE_ONE_HANDED_MACES"]			= "One-Handed Maces";
		L["WEAPON_TYPE_DAGGERS"]					= "Daggers";
		L["WEAPON_TYPE_FIST_WEAPONS"]				= "Fist Weapons";
		L["WEAPON_TYPE_TWO_HANDED_AXES"]			= "Two-Handed Axes";
		L["WEAPON_TYPE_TWO_HANDED_SWORDS"]			= "Two-Handed Swords";
		L["WEAPON_TYPE_TWO_HANDED_MACES"]			= "Two-Handed Maces";
		L["WEAPON_TYPE_STAVES"]						= "Staves";
		L["WEAPON_TYPE_POLEARMS"]					= "Polearms";
		L["WEAPON_TYPE_WARGLAIVES"]					= "Warglaives";
		L["WEAPON_TYPE_BOWS"]						= "Bows";
		L["WEAPON_TYPE_CROSSBOWS"]					= "Crossbows";
		L["WEAPON_TYPE_GUNS"]						= "Guns";
		L["WEAPON_TYPE_WANDS"]						= "Wands";
		L["WEAPON_TYPE_SHIELDS"]					= "Shields";
		L["Z_SPELL_NAMES"] = {
			{
				["spellName"] 						= "Collecting",
			},
			{
				["spellName"] 						= "Fishing",
			},
			{
				["spellName"] 						= "Frisking Toga",
			},
			{
				["spellName"] 						= "Herb Gathering",
			},
			{
				["spellName"] 						= "Looting",
			},
			{
				["spellName"] 						= "Mining",
			},
			{
				["spellName"] 						= "Opening",
			},
			{
				["spellName"]						= "Retrieving",
			},
			{
				["spellName"] 						= "Skinning",
			},
			{
				["spellName"] 						= "Survey",
			},
		};]]
end
--

addonTable.L = L