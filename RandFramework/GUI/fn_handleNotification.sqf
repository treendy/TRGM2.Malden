// Adds a new notification to notification list

params [["_text", ""], ["_duration", 5], ["_priority", 5], ["_notificationIndex", -1], ["_condition", {true}]];
if (_text isEqualTo "") exitWith {};
if (isDedicated || !hasInterface) exitWith {};

disableSerialization;

for "_i" from 0 to 1 step 0 do {
	if ((uiNamespace getVariable ["TREND_notifications_active", scriptNull]) isEqualTo _thisScript) exitWith {};
	waitUntil {uiSleep 0.025; (scriptDone (uiNamespace getVariable ["TREND_notifications_active", scriptNull]))};
	uiNamespace setVariable ["TREND_notifications_active", _thisScript];
};

private _notificationList = uiNamespace getVariable ["TREND_notifications_list", []];
_notificationList = _notificationList select {!isNull (_x select 1)};
uiNamespace setVariable ["TREND_notifications_list", _notificationList];

private _insertIndex = 0;
private _currentNotifications = +_notificationList;
reverse _currentNotifications;

_priority = 100 - _priority;
private _foundPriorities = { (_x select 0) isEqualTo _priority } count _currentNotifications;
{if ((_x select 0) >= _priority) exitWith {_insertIndex = ((count _currentNotifications) - (_forEachIndex + _foundPriorities))}} forEach _currentNotifications;

[_insertIndex, _text, _duration, _priority, _notificationIndex, _condition] call TREND_fnc_createNotification;