params ["_wayX","_wayY", "_group","_index","_IncludTeamLeader"];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;

_startPos = [_wayX + 5 + floor random 10,_wayY + 5 + floor random 10];
_sUnitType = selectRandom [(call sRiflemanToUse), (call sRiflemanToUse),(call sRiflemanToUse),(call sMachineGunManToUse), (call sEngineerToUse), (call sGrenadierToUse), (call sMedicToUse),(call sAAManToUse),(call sATManToUse)];
if (_index isEqualTo 0 && _IncludTeamLeader) then {
	_sUnitType = (call sTeamleaderToUse);
};
[_sUnitType, _startPos, _group] call TREND_fnc_CreateUnit;