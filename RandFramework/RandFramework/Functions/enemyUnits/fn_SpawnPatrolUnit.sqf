params ["_wayX","_wayY", "_group","_index","_IncludTeamLeader"];

_startPos = [_wayX + 5 + floor random 10,_wayY + 5 + floor random 10];
_sUnitType = selectRandom [sRiflemanToUse, sRiflemanToUse,sRiflemanToUse,sMachineGunManToUse, sEngineerToUse, sGrenadierToUse, sMedicToUse,sAAManToUse,sATManToUse];
if (_index == 0 && _IncludTeamLeader) then {
	_sUnitType = sTeamleaderToUse;
};
[_sUnitType, _startPos, _group] call TREND_fnc_CreateUnit;