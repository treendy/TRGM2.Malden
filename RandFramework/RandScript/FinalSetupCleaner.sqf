//loop through friendlySentryCheckpointPos
//check if any of CheckPointAreas + SentryAreas are near
//if so, delete any friendly units
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
} forEach friendlySentryCheckpointPos;

//check AO camp pos, any enemy units within 150meters, delete
if (iStartLocation == 1) then {//move to ao camp
	{
		//if (_y distance getPos _x > PunishmentRadius) then {
		if ((side _x == east)) then {
			deleteVehicle _x;
		};
		//};
	} forEach nearestObjects [AOCampPos, ["Man","Car","Tank"], 100];
};
