params [["_content", ""], ["_durationOrCondition", 30, [0,{}]], ["_notificationIndex", -1]];
if (_content isEqualTo "") exitWith {};

if (_content isEqualType "") then {
	_content = parseText format ["<t size='0.90'>%1</t>", _content];
};

if !(_content isEqualType (parseText "")) exitWith {};

if (_notificationIndex isEqualTo -1) then {
	_notificationIndex = [10, 99] call BIS_fnc_randomInt;
};

if (_durationOrCondition isEqualType {}) then {
	[[_content, 86400, 10, _notificationIndex, _durationOrCondition], {_this spawn TREND_fnc_handleNotification}] remoteExec ["call"];
} else {
	[[_content, _durationOrCondition, 10, _notificationIndex], {_this spawn TREND_fnc_handleNotification}] remoteExec ["call"];
};

_notificationIndex;