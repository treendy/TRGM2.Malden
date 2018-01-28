
_FirstPos = _this select 0;
_SecondPos = _this select 1;

if (isServer) then {

	if (isNil "ParaDropped") then {
		ParaDropped = false;
		publicVariable "ParaDropped";
	};

	
	if (!ParaDropped && AllowParaDrop) then {
		
		[EAST, ReinforceStartPos1, _FirstPos, 3, true, false, false, false, false] execVM "RandFramework\reinforcements.sqf";	
		sleep 5;
		[EAST, ReinforceStartPos2, _SecondPos, 3, true, false, false, false, false] execVM "RandFramework\reinforcements.sqf";	

		ParaDropped = true;
		publicVariable "ParaDropped";
	};

	sleep 10; //wait 10 seconds before enemy react

	_iMaxNearest = 1;
	if (isMultiplayer) then {
		_iMaxNearest = 4;
	};
	_iMaxNearestCount = 0;
	_nearestUnits = nearestObjects [_FirstPos, [sRifleman, sTeamleader], 1100];
	{
		
		_iMaxNearestCount = _iMaxNearestCount + 1;
		_nearestTL1 = _x;
		_cnt = count units group _nearestTL1;
		if (_cnt > 2) then {

			_nearestTL1wPosArray = waypoints group _nearestTL1;
			i = 0;
			{
				deleteWaypoint [group _nearestTL1, i];
				i = i + 1;
			} forEach _nearestTL1wPosArray;

			_TaskReGroupWP = group _nearestTL1 addWaypoint [_FirstPos,7,0];
			_TaskReGroupWP setWaypointType "MOVE";
			_TaskReGroupWP setWaypointSpeed "FULL";
			_TaskReGroupWP setWaypointBehaviour "AWARE";	
			_TaskReGroupWP setWaypointFormation "WEDGE";	
			_TaskReGroupWP2 = group _nearestTL1 addWaypoint [_SecondPos,7,1];
			_TaskReGroupWP2 setWaypointType "MOVE";
			_TaskReGroupWP2 = group _nearestTL1 addWaypoint [_FirstPos,7,2];
			_TaskReGroupWP2 setWaypointType "CYCLE";
			//group _nearestTL1 setCombatMode "RED";
			//group _nearestTL1 setFormation selectRandom ["LINE", "WEDGE"];
			if (_iMaxNearestCount > _iMaxNearest) exitWith {true;};
		};
	} forEach _nearestUnits;
	
};