
_SpottedPos = _this select 0;
_IsAirType = _this select 1; // 1=AirToAir, 2=AirToGround, 3=Scout

format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;

if (isServer) then {

	TREND_CalledAirsupportIndex = TREND_CalledAirsupportIndex + 1;
	publicVariable "TREND_CalledAirsupportIndex";

	//WaitTime = floor random 420; //any time up to 7 mins
	//publicVariable "WaitTime";

	//sleep WaitTime;

	_groupp1 = createGroup east;

	_AirVehicle = nil;
	if (_IsAirType isEqualTo 1) then {
		_AirVehicle = selectRandom (call EnemyAirToAirSupports);
	};
	if (_IsAirType isEqualTo 2) then {
		_AirVehicle = selectRandom (call EnemyAirToGroundSupports);
	};
	if (_IsAirType isEqualTo 3) then {
		_AirVehicle = selectRandom (call EnemyAirScout);
	};

	//[format ["AirType: %1",_AirVehicle]] call TREND_fnc_notify;
	sleep 1;

	_enemyAirSup1 = createVehicle [_AirVehicle, call TREND_GetReinforceStartPos, [], 0, "NONE"];
	createVehicleCrew _enemyAirSup1;
	crew vehicle _enemyAirSup1 joinSilent _groupp1;
	_enemyAirSup1 flyInHeight 40;
	_enemyAirSup1 setVehicleAmmo 1;

	sleep 1;

	_sAirName = format["objAirSupport%1",TREND_CalledAirsupportIndex];
	_enemyAirSup1 setVariable [_sAirName, _enemyAirSup1, true];
	missionNamespace setVariable [_sAirName, _enemyAirSup1];

	//[format ["_SpottedPos: %1",_SpottedPos]] call TREND_fnc_notify;
	sleep 1;

	_iFlyRange = 1000;
	if (_IsAirType isEqualTo 3) then {_iFlyRange = 300;};
	_v1wp1 = _groupp1 addWaypoint [_SpottedPos, 0];
	_v1wp2 = _groupp1 addWaypoint [[(_SpottedPos select 0) + _iFlyRange,(_SpottedPos select 1) + _iFlyRange], 0];
	_v1wp3 = _groupp1 addWaypoint [[(_SpottedPos select 0) + _iFlyRange,(_SpottedPos select 1) - _iFlyRange], 0];
	_v1wp4 = _groupp1 addWaypoint [[(_SpottedPos select 0) - _iFlyRange,(_SpottedPos select 1) + _iFlyRange], 0];
	_v1wp5 = _groupp1 addWaypoint [[(_SpottedPos select 0) - _iFlyRange,(_SpottedPos select 1) - _iFlyRange], 0];
	_v1wp6 = _groupp1 addWaypoint [[(_SpottedPos select 0) + _iFlyRange,(_SpottedPos select 1)], 0];
	_v1wp7 = _groupp1 addWaypoint [call TREND_GetReinforceStartPos, 0];
	_v1wp8 = _groupp1 addWaypoint [call TREND_GetReinforceStartPos, 0];
	[_groupp1, 0] setWaypointStatements ["true", format["%1 flyInHeight 40;",_sAirName]];
	[_groupp1, 0] setWaypointSpeed "FULL";
	[_groupp1, 0] setWaypointBehaviour "SAFE";
	[_groupp1, 1] setWaypointStatements ["true", format["%1 flyInHeight 40;",_sAirName]];
	[_groupp1, 1] setWaypointSpeed "LIMITED";
	[_groupp1, 7] setWaypointStatements ["true", format["deleteVehicle %1;",_sAirName]];
	_groupp1 setBehaviour "COMBAT";
};
