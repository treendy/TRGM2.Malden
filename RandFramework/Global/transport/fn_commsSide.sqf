params ["_speaker","_text"];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;

_target = [0, -2] select isMultiplayer;
[_speaker,_text] remoteExecCall ["sideChat",_target,false];

true;