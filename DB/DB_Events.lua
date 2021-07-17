local addon, tbl = ...;

local events = {
	"ENCOUNTER_START",
	"INSTANCE_GROUP_SIZE_CHANGED",
	"ISLAND_COMPLETED",
	"ITEM_DATA_LOAD_RESULT",
	"MAIL_INBOX_UPDATE",
	"MERCHANT_CLOSED",
	"MERCHANT_SHOW",
	"MODIFIER_STATE_CHANGED",
	"PLAYER_LOGIN",
	"PLAYER_LOGOUT",
	"UI_INFO_MESSAGE",
	"UNIT_SPELLCAST_SENT"
};
-- Synopsis: These are events that must occur before the addon will take action. Each event is documented in main.lua.

tbl.events = events