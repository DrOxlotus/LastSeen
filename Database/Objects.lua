local addonName, addonTable = ...
local L = addonTable.L

local objects = {
	[75293]			= L["Large Battered Chest"],
	[214383]		= L["Cache of Pure Energy"],
	[225817]		= L["Spoils of Blackfathom"],
	[369132]		= L["Domination Sealed Chest"],
	[369145]		= L["Helgarde Supply Cache"],
	[369327]		= L["Invasive Mawshroom"],
	[369329]		= L["Invasive Mawshroom"],
	[369330]		= L["Invasive Mawshroom"],
	[369331]		= L["Invasive Mawshroom"],
	[369332]		= L["Invasive Mawshroom"],
	[369339]		= L["Mawsworn Cache"],
	[368205]		= L["Mawsworn Cache"],
	[368206]		= L["Mawsworn Cache"],
	[368207]		= L["Mawsworn Cache"],
	[368208]		= L["Mawsworn Cache"],
	[368213]		= L["Mawsworn Cache"],
	[368214]		= L["Mawsworn Cache"],
	[368876]		= L["Mawsworn Cache"],
	[369141]		= L["Mawsworn Cache"],
	[369341]		= L["Mawsworn Cache"],
	[369333]		= L["Nest of Unusual Materials"],
	[369334]		= L["Nest of Unusual Materials"],
	[369335]		= L["Nest of Unusual Materials"],
	[369336]		= L["Nest of Unusual Materials"],
	[369337]		= L["Nest of Unusual Materials"],
	[369437]		= L["Riftbound Cache"],
	[369438]		= L["Riftbound Cache"],
	[369439]		= L["Riftbound Cache"],
	[369440]		= L["Riftbound Cache"],
	[368645]		= L["Rift Hidden Cache"],
	[368646]		= L["Rift Hidden Cache"],
	[368647]		= L["Rift Hidden Cache"],
	[368648]		= L["Rift Hidden Cache"],
	[368649]		= L["Rift Hidden Cache"],
	[368650]		= L["Rift Hidden Cache"],
}

addonTable.Objects = objects