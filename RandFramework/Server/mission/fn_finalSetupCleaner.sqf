//loop through TRGM_VAR_friendlySentryCheckpointPos
//check if any of TRGM_VAR_CheckPointAreas + TRGM_VAR_SentryAreas are near
//if so, delete any friendly units
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;
{
	_currentFriendCpPos = _x;
	_enemyNear = false;
	//check if enemy near
	{
		if (side _x isEqualTo east) then {
			_enemyNear = true;
		};
	} forEach nearestObjects [_currentFriendCpPos, ["Man","Car","Tank"], 400];
	//if enemy is near, then delete this friendly checkpoint
	if (_enemyNear) then {
		{
			if ((side _x isEqualTo west)) then {
				deleteVehicle _x;
			};
		} forEach nearestObjects [_currentFriendCpPos, ["Man","Car","Tank"], 100];
	};
} forEach TRGM_VAR_friendlySentryCheckpointPos;

//check AO camp pos, any enemy units within 150meters, delete
if (TRGM_VAR_iStartLocation isEqualTo 1) then {//move to ao camp
	{
		//if (_y distance getPos _x > TRGM_VAR_PunishmentRadius) then {
		if ((side _x isEqualTo east)) then {
			deleteVehicle _x;
		};
		//};
	} forEach nearestObjects [TRGM_VAR_AOCampPos, ["Man","Car","Tank"], 100];
};
true;