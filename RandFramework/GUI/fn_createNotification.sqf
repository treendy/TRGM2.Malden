// Internal function for creating Notifications

params [["_insertIndex", 0], ["_text", ""], ["_duration", 5], ["_priority", 5], ["_notificationIndex", -1], ["_condition", {true}]];
if (_text isEqualTo "") exitWith {};
private ["_control", "_progress"];

if (isNull (uiNamespace getVariable ["TREND_notifications_disp", displayNull])) then { call TREND_fnc_initNotifications; };

disableSerialization;
private _display = uiNamespace getVariable ["TREND_notifications_disp", displayNull];
if (isNull _display) exitWith {};

private _mainCtrlGroup = _display displayCtrl 9010;
private _mainCtrlGroupSize = ctrlPosition _mainCtrlGroup;
_mainCtrlGroupSize params ["_mainCtrlGroupX", "_mainCtrlGroupY", "_mainCtrlGroupW", "_mainCtrlGroupH"];

_ctrlGroup = [uiNamespace getVariable [format["TREND_notification_%1", _notificationIndex], controlNull], controlNull] select (_notificationIndex isEqualTo -1);
if !(isNull _ctrlGroup) then {
    private _textControl = _ctrlGroup controlsGroupCtrl 1000;
    _textControl ctrlSetStructuredText _text;
    _textControl ctrlCommit 0;
} else {
    _ctrlGroup = _display ctrlCreate ["RscControlsGroupNoScrollbars", -1, _mainCtrlGroup];
    uiNamespace setVariable [format["TREND_notification_%1", _notificationIndex], _ctrlGroup];
    _ctrlGroup ctrlSetPosition [0, 0, _mainCtrlGroupW, _mainCtrlGroupH];
    _ctrlGroup ctrlSetFade 1;
    _ctrlGroup ctrlCommit 0;

    private _ctrlGroupSize = ctrlPosition _ctrlGroup;
    _ctrlGroupSize params ["_ctrlGroupX", "_ctrlGroupY", "_ctrlGroupW", "_ctrlGroupH"];

    _control = _display ctrlCreate ["RscStructuredText", 1000, _ctrlGroup];
    _control ctrlSetStructuredText _text;
    _control ctrlSetPosition [0, 0.01, _ctrlGroupW, 0.05];
    _control ctrlSetBackgroundColor [0, 0, 0, 0.75];
    _control ctrlCommit 0;

    private _messageHeight = 0.00;
    _control ctrlSetPosition [0, 0.01, _ctrlGroupW, (ctrlTextHeight _control) + 0.01];
    _control ctrlCommit 0;

    {
        if !(_forEachIndex isEqualTo 1) then {
            _messageHeight = _messageHeight + ((ctrlPosition _x) select 3);
        };
    } forEach ((allControls _display) select {(ctrlParentControlsGroup _x) isEqualTo _ctrlGroup});
    _ctrlGroup ctrlSetPosition [0, 0, _mainCtrlGroupW, _messageHeight];
    _ctrlGroup ctrlSetFade 1;
    _ctrlGroup ctrlCommit 0;

    private _notificationList = uiNamespace getVariable ["TREND_notifications_list", []];
    _notificationList = _notificationList select {!isNull (_x select 1)};
    private _startPositionY = 0;
    {
        _x params ["_priority", "_control"];
        private _messagePadding = 0.01;
        if (_forEachIndex >= _insertIndex) then {
            private _controlPosition = ctrlPosition _control;
            _controlPosition set [1, parseNumber(((_controlPosition select 1) + ((ctrlPosition _ctrlGroup) select 3) + _messagePadding) toFixed 4)];
            _control ctrlSetPosition _controlPosition;
            _control ctrlCommit 0.20;
        } else {
            _startPositionY = _startPositionY + ((ctrlPosition _control) select 3) + _messagePadding;
        };
    } forEach _notificationList;

    if ((count _notificationList) >= 1) then {
        waitUntil {ctrlCommitted ((_notificationList select ((count _notificationList) - 1)) select 1)}
    };

    private _insertElement = {
        if !(params[["_array", [], [[]]], ["_element", nil], ["_index", -1, [0]]]) exitWith {};
        private _return = [];
        {_return append _x} forEach [_array select [0, _index], [_element], _array select [_index, count _array]];
        _return;
    };

    _notificationList = [_notificationList, [_priority, _ctrlGroup], _insertIndex] call _insertElement;
    uiNamespace setVariable ["TREND_notifications_list", _notificationList];

    private _currentPosition = ctrlPosition _ctrlGroup;
    _currentPosition set [1, _startPositionY];
    _ctrlGroup ctrlSetPosition _currentPosition;
    _ctrlGroup ctrlCommit 0;

    _ctrlGroup ctrlSetFade 0;
    _ctrlGroup ctrlCommit 0.20;
    waitUntil {ctrlCommitted _ctrlGroup};

    [_ctrlGroup controlsGroupCtrl 1000, _duration, _condition] spawn {
        params [["_textControl", controlNull], ["_duration", 5], ["_condition", {true}]];
        if (isNull _textControl) exitWith {};

        private _endTime = time + _duration;
        waitUntil { if ((isNull _textControl) || (time >= _endTime) || !(call _condition)) exitWith {true}; false; };

        [ctrlParentControlsGroup _textControl] call TREND_fnc_deleteNotification;
    };
};

_ctrlGroup;