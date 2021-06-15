params [["_content", ""], ["_durationOrCondition", 30, [0,{}]], ["_notificationIndex", -1]];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;
if (_content isEqualTo "") exitWith {};

if (_content isEqualType "") then {
    private _result = "";
    private _offset = count ("\n" splitString "");

    while {_content find "\n" != -1} do {
        private _index = _content find "\n";

        _result = _result + (_content select [0, _index]) + "<br />";
        _content = _content select [_index + _offset];
    };

    _content = _result + _content;
    _content = parseText format ["<t size='0.90'>%1</t>", _content];
};

if !(_content isEqualType (parseText "")) exitWith {};

if (_notificationIndex isEqualTo -1) then {
    _notificationIndex = [10, 99] call BIS_fnc_randomInt;
};

if (_durationOrCondition isEqualType {}) then {
    [[_content, 86400, 10, _notificationIndex, _durationOrCondition], {_this spawn TRGM_GUI_fnc_handleNotification}] remoteExec ["call"];
} else {
    [[_content, _durationOrCondition, 10, _notificationIndex], {_this spawn TRGM_GUI_fnc_handleNotification}] remoteExec ["call"];
};

_notificationIndex;