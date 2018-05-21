#include "../../setUnitGlobalVars.sqf";

_SpottedPos = _this select 0;
_IsAirType = _this select 1; // 1=AirToAir, 2=AirToGround, 3=Scout



if (isServer) then {

		if (isNil "CalledAirsupportIndex") then {
			CalledAirsupportIndex = 1;
			publicVariable "CalledAirsupportIndex";	
		}
		else {
			CalledAirsupportIndex = CalledAirsupportIndex + 1;
			publicVariable "CalledAirsupportIndex";	

		};
			
		//WaitTime = floor random 420; //any time up to 7 mins
		//publicVariable "WaitTime";

		//sleep WaitTime;
			
		_groupp1 = createGroup east;
			
		_AirVehicle = nil;
		if (_IsAirType == 1) then {
			_AirVehicle = selectRandom EnemyAirToAirSupports;
		};
		if (_IsAirType == 2) then {
			_AirVehicle = selectRandom EnemyAirToGroundSupports;
		};
		if (_IsAirType == 3) then {
			_AirVehicle = selectRandom EnemyAirScout;
		};

		hint format ["AirType: %1",_AirVehicle];
		sleep 1;

		_airSup1Array = [ReinforceStartPos1, 45, _AirVehicle, _groupp1] call Bis_fnc_spawnvehicle;
		_enemyAirSup1 = _airSup1Array select 0;
		_enemyAirSup1 flyInHeight 40;
		_enemyAirSup1 setVehicleAmmo 1;

		hint format ["Spawned pos: %1",ReinforceStartPos1];
		sleep 1;

		_sAirName = format["objAirSupport%1",CalledAirsupportIndex];
		_enemyAirSup1 setVariable [_sAirName, _enemyAirSup1, true];
		missionNamespace setVariable [_sAirName, _enemyAirSup1];

		//if (PlayAirSupportWarningRadio && _IsAirType == 1) then {
		//	[[HQMan,"FastMoverSpotted"],"sideRadio",true,true] call BIS_fnc_MP;
		//};
	
		hint format ["_SpottedPos: %1",_SpottedPos];
		sleep 1;

		_iFlyRange = 1000;
		if (_IsAirType == 3) then {_iFlyRange = 300;};
		_v1wp1 = _groupp1 addWaypoint [_SpottedPos, 0];
		_v1wp2 = _groupp1 addWaypoint [[(_SpottedPos select 0) + _iFlyRange,(_SpottedPos select 1) + _iFlyRange], 0];
		_v1wp3 = _groupp1 addWaypoint [[(_SpottedPos select 0) + _iFlyRange,(_SpottedPos select 1) - _iFlyRange], 0];
		_v1wp4 = _groupp1 addWaypoint [[(_SpottedPos select 0) - _iFlyRange,(_SpottedPos select 1) + _iFlyRange], 0];
		_v1wp5 = _groupp1 addWaypoint [[(_SpottedPos select 0) - _iFlyRange,(_SpottedPos select 1) - _iFlyRange], 0];
		_v1wp6 = _groupp1 addWaypoint [[(_SpottedPos select 0) + _iFlyRange,(_SpottedPos select 1)], 0];
		_v1wp7 = _groupp1 addWaypoint [ReinforceStartPos1, 0];
		_v1wp8 = _groupp1 addWaypoint [ReinforceStartPos1, 0];
		[_groupp1, 0] setWaypointStatements ["true", format["%1 flyInHeight 40;",_sAirName]];
		[_groupp1, 0] setWaypointSpeed "FULL";
		[_groupp1, 0] setWaypointBehaviour "SAFE";
		[_groupp1, 1] setWaypointStatements ["true", format["%1 flyInHeight 40;",_sAirName]];
		[_groupp1, 1] setWaypointSpeed "LIMITED";
		//[_groupp1, 1] setWaypointBehaviour "COMBAT";
		[_groupp1, 7] setWaypointStatements ["true", format["deleteVehicle %1;",_sAirName]];
		_groupp1 setBehaviour "COMBAT";
		

		
	};
