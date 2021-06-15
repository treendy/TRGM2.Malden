sText = _this select 0;
pos = _this select 1;

format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;

_mrkDebug = Nil;
_mrkDebug = createMarker [sText, pos];
_mrkDebug setMarkerShape "ICON";
_mrkDebug setMarkerType "hd_dot";
_mrkDebug setMarkerText sText;


true;