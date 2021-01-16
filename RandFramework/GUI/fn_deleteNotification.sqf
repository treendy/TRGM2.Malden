// Removes a notification from the list of notifications

if (isNull (uiNamespace getVariable ["TREND_notifications_disp", displayNull])) exitWith {};
params[["_ctrlGroup", controlNull, [controlNull]]];

disableSerialization;

for "_i" from 0 to 1 step 0 do {
    if ((uiNamespace getVariable ["TREND_notifications_active", scriptNull]) isEqualTo _thisScript) exitWith {};
    waitUntil {uiSleep 0.025; (scriptDone (uiNamespace getVariable ["TREND_notifications_active", scriptNull]))};
    uiNamespace setVariable ["TREND_notifications_active", _thisScript];
};

if (isNull _ctrlGroup) exitWith {};

_ctrlGroup ctrlSetFade 1;
_ctrlGroup ctrlCommit 0.20;
waitUntil {ctrlCommitted _ctrlGroup};

private _notificationList = uiNamespace getVariable ["TREND_notifications_list", []];
private _index = _notificationList findIf {(_x select 1) isEqualTo _ctrlGroup};
if (_index isEqualTo -1) exitWith {false};
{
    _x params ["_priority", "_control"];
    if (_forEachIndex > _index) then {
        private _messagePadding = 0.01;
        private _controlPosition = ctrlPosition _control;

        _controlPosition set [1, parseNumber(((_controlPosition select 1) - ((ctrlPosition _ctrlGroup) select 3) - _messagePadding) toFixed 4)];
        _control ctrlSetPosition _controlPosition;
        _control ctrlCommit 0.20;
    };
} forEach _notificationList;

if ((count _notificationList) >= 1) then {
    waitUntil {ctrlCommitted ((_notificationList select ((count _notificationList) - 1)) select 1)}
};

private _index = _notificationList findIf {(_x select 1) isEqualTo _ctrlGroup};
if !(_index isEqualTo -1) then {
	_notificationList deleteAt _index;
	uiNamespace setVariable ["TREND_notifications_list", _notificationList];
};
if (!isNull _ctrlGroup) then {ctrlDelete _ctrlGroup};