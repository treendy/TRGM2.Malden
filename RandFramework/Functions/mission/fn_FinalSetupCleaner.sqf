//loop through TREND_friendlySentryCheckpointPos
//check if any of TREND_CheckPointAreas + TREND_SentryAreas are near
//if so, delete any friendly units
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;
{
	_currentFriendCpPos = _x;
	_enemyNear = false;
	//check if enemy near
	{
		if (side _x == east) then {
			_enemyNear = true;
		};
	} forEach nearestObjects [_currentFriendCpPos, ["Man","Car","Tank"], 400];
	//if enemy is near, then delete this friendly checkpoint
	if (_enemyNear) then {
		{
			if ((side _x == west)) then {
				deleteVehicle _x;
			};
		} forEach nearestObjects [_currentFriendCpPos, ["Man","Car","Tank"], 100];
	};
} forEach TREND_friendlySentryCheckpointPos;

//check AO camp pos, any enemy units within 150meters, delete
if (TREND_iStartLocation == 1) then {//move to ao camp
	{
		//if (_y distance getPos _x > TREND_PunishmentRadius) then {
		if ((side _x == east)) then {
			deleteVehicle _x;
		};
		//};
	} forEach nearestObjects [TREND_AOCampPos, ["Man","Car","Tank"], 100];
};
true;