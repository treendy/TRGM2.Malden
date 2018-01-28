#include "../../setUnitGlobalVars.sqf";


_thisThis = _this select 0;
_thisThisList = _this select 1;
_FirstPos = _this select 2;
_SecondPos = _this select 3;


if (isServer) then {

	TREND_fnc_FireFlares = {
		[1] execVM "RandFramework\RandScript\fireAOFlares.sqf";
		sleep 0.2;
		[2] execVM "RandFramework\RandScript\fireAOFlares.sqf";
		sleep 10;
		[2] execVM "RandFramework\RandScript\fireAOFlares.sqf";
		sleep 0.2;
		[1] execVM "RandFramework\RandScript\fireAOFlares.sqf";
	};
	[] spawn TREND_fnc_FireFlares;



	_SpottedUnit = _thisThisList select 0;
	SpottedActiveFinished = false;
	PublicVariable "SpottedActiveFinished";

	_maxPatrolSearch = 1500;
	if (IsSingleMission) then {_maxPatrolSearch = 3000};

	if (bBaseHasChopper) then {
		
		while {(count (waypoints group EnemyBaseChopperPilot)) > 0} do {
			deleteWaypoint ((waypoints group EnemyBaseChopperPilot) select 0);
		};
		//EnemyBaseChopper set waypoint to spotted location then AO then RTB
		//GETIN NEAREST
		//EnemyBaseChopperPilot
		_EnemyBaseChopperWP0 = group EnemyBaseChopperPilot addWaypoint [getPos EnemyBaseChopperPilot,0,1];
		_EnemyBaseChopperWP0 setWaypointType "GETIN NEAREST";
		_EnemyBaseChopperWP0 setWaypointSpeed "FULL";

		_EnemyBaseChopperWP1 = group EnemyBaseChopperPilot addWaypoint [getPos _SpottedUnit,0,1];
		_EnemyBaseChopperWP1 setWaypointType "SENTRY";
		_EnemyBaseChopperWP1 setWaypointSpeed "LIMITED";
		_EnemyBaseChopperWP1 setWaypointBehaviour "AWARE";	

		_EnemyBaseChopperWP1 = group EnemyBaseChopperPilot addWaypoint [getPos _SpottedUnit,0,1];
		_EnemyBaseChopperWP1 setWaypointType "MOVE";
		_EnemyBaseChopperWP1 setWaypointSpeed "LIMITED";
		_EnemyBaseChopperWP1 setWaypointBehaviour "AWARE";	

		_EnemyBaseChopperWP1 = group EnemyBaseChopperPilot addWaypoint [getPos baseHeliPad,0,2];
		_EnemyBaseChopperWP1 setWaypointType "MOVE";
		_EnemyBaseChopperWP1 setWaypointSpeed "FULL";
		_EnemyBaseChopperWP1 setWaypointStatements ["true", "(vehicle this) LAND 'LAND';"];
	};
	
	_SpottedUnitCount = {_x distance _SpottedUnit < 200} count units group _SpottedUnit;
	_AlivePlayerCount = {alive _x} count allplayers;
	if (_SpottedUnitCount > 2 || _AlivePlayerCount < 8) then {
		sleep 5; //wait 10 seconds before enemy react
		//hint "Started";
		
		if (_SpottedUnit distance getMarkerPos "mrkFirstLocation" < 200 || _SpottedUnit distance getMarkerPos "mrkSecondLocation" < 200) then {
			if (!ParaDropped) then {
		
				[EAST, ReinforceStartPos1, _FirstPos, 3, true, false, false, false, false] execVM "RandFramework\reinforcements.sqf";	
				sleep 5;
				[EAST, ReinforceStartPos2, _SecondPos, 3, true, false, false, false, false] execVM "RandFramework\reinforcements.sqf";	

				ParaDropped = true;
				publicVariable "ParaDropped";
			};
		};	
				
		_SpottedUnitPos = getpos (_thisThisList select 0);

		if  ((_SpottedUnitCount > 3 && _SpottedUnitCount < 5 && _AlivePlayerCount > 7) || bSinglePatrolInvestigate) then {
		//hint "SpottedUnits more than 2";
			_nearestTLs = nearestObjects [_SpottedUnitPos, [sTeamleader], _maxPatrolSearch];
			if (count _nearestTLs > 0) then {
				_nearestTL = _nearestTLs select 0;
				while {(count (waypoints group _nearestTL)) > 0} do {
					deleteWaypoint ((waypoints group _nearestTL) select 0);
				};

				group _nearestTL setCombatMode "RED";
				group _nearestTL setFormation "WEDGE";
				group _nearestTL setSpeedMode "FULL";
				_SpottedWP1a = group _nearestTL addWaypoint [getPos _nearestTL,0,0];
				 _SpottedWP1a setWaypointType "MOVE";
				_SpottedWP1a setWaypointSpeed "FULL";
				_SpottedWP1a setWaypointBehaviour "AWARE";	
				_SpottedWP1a setWaypointFormation "WEDGE";	
				_SpottedWP1a2 = group _nearestTL addWaypoint [_SpottedUnitPos,0,1];
				_SpottedWP1a2 setWaypointSpeed "FULL";
				_SpottedWP1b = group _nearestTL addWaypoint [_FirstPos,7,2];
				_SpottedWP1c = group _nearestTL addWaypoint [_SecondPos,7,3];
				_SpottedWP1c setWaypointType "CYCLE";
				group _nearestTL setCombatMode "RED";
				group _nearestTL setFormation "WEDGE";
				group _nearestTL setSpeedMode "FULL";
			};

			//_flare1 = "F_40mm_White" createVehicle getPos _nearestTL;

			if (selectRandom[true]) then {
			
				_nearestTanks = nearestObjects [_SpottedUnitPos, [sTank1,sTank2,sTank3], 3000];
				if (count _nearestTanks > 0) then {
					_nearestTank = selectRandom _nearestTanks;
					_nearestTLTankwPosArray = waypoints group _nearestTank;

					while {(count (waypoints group _nearestTank)) > 0} do {
						deleteWaypoint ((waypoints group _nearestTank) select 0);
					};
					_SpottedWP5a = group _nearestTank addWaypoint [_SpottedUnitPos,10];
					_SpottedWP5a setWaypointType "SAD";
					_SpottedWP5a setWaypointSpeed "FULL";
					_SpottedWP5a setWaypointBehaviour "AWARE";	
				};
			};

		};

		if ((_SpottedUnitCount > 3 || _AlivePlayerCount < 8) && !bSinglePatrolInvestigate) then {
		//hint "SpottedUnits more than 4";
			_nearestTLs = nearestObjects [_SpottedUnitPos, [sTeamleader], _maxPatrolSearch];

			if (count _nearestTLs > 0) then {
				_nearestTL1 = _nearestTLs select 0;
				_nearestTL1wPosArray = waypoints group _nearestTL1;

				while {(count (waypoints group _nearestTL1)) > 0} do {
					deleteWaypoint ((waypoints group _nearestTL1) select 0);
				};

				group _nearestTL1 setCombatMode "RED";
				group _nearestTL1 setFormation "WEDGE";
				group _nearestTL1 setSpeedMode "FULL";
				_SpottedWP2a = group _nearestTL1 addWaypoint [getPos _nearestTL1,0,0];
				_SpottedWP2a setWaypointType "MOVE";
				_SpottedWP2a setWaypointSpeed "FULL";
				_SpottedWP2a setWaypointBehaviour "AWARE";	
				_SpottedWP2a setWaypointFormation "WEDGE";	
				_SpottedWP2a2 = group _nearestTL1 addWaypoint [_SpottedUnitPos,0,1];
				_SpottedWP2a2 setWaypointSpeed "FULL";
				_SpottedWP2b = group _nearestTL1 addWaypoint [_FirstPos,7,2];
				_SpottedWP2c = group _nearestTL1 addWaypoint [_SecondPos,7,3];
				_SpottedWP2c setWaypointType "CYCLE";
				group _nearestTL1 setCombatMode "RED";
				group _nearestTL1 setFormation "WEDGE";
				group _nearestTL1 setSpeedMode "FULL";

				//_flare2 = "F_40mm_White" createVehicle getPos _nearestTL1;
			};
			if (count _nearestTLs > 1) then {
				_nearestTL2 = _nearestTLs select 1;
				_nearestTL2wPosArray = waypoints group _nearestTL2;

				while {(count (waypoints group _nearestTL2)) > 0} do {
					deleteWaypoint ((waypoints group _nearestTL2) select 0);
				};

				group _nearestTL2 setCombatMode "RED";
				group _nearestTL2 setFormation  "WEDGE";
				group _nearestTL2 setSpeedMode "FULL";
				_SpottedWP3a = group _nearestTL2 addWaypoint [getPos _nearestTL2,7,0];
				_SpottedWP3a setWaypointType "MOVE";
				_SpottedWP3a setWaypointSpeed "FULL";
				_SpottedWP3a setWaypointBehaviour "AWARE";	
				_SpottedWP3a setWaypointFormation "WEDGE";	
				_SpottedWP3a2 = group _nearestTL2 addWaypoint [_SpottedUnitPos,7,1];
				_SpottedWP3a2 setWaypointSpeed "FULL";
				_SpottedWP3b = group _nearestTL2 addWaypoint [_FirstPos,7,2];
				_SpottedWP3c = group _nearestTL2 addWaypoint [_SecondPos,7,3];
				_SpottedWP3c setWaypointType "CYCLE";
				group _nearestTL2 setCombatMode "RED";
				group _nearestTL2 setFormation "WEDGE";
				group _nearestTL2 setSpeedMode "FULL";

				//_flare3 = "F_40mm_White" createVehicle getPos _nearestTL2;
			};

			if (count _nearestTLs > 2) then {
				_nearestTL3 = _nearestTLs select 2;
				_nearestTL3wPosArray = waypoints group _nearestTL3;

				while {(count (waypoints group _nearestTL3)) > 0} do {
					deleteWaypoint ((waypoints group _nearestTL3) select 0);
				};
				group _nearestTL3 setCombatMode "RED";
				group _nearestTL3 setFormation "WEDGE";
				group _nearestTL3 setSpeedMode "FULL";
				_SpottedWP4a = group _nearestTL3 addWaypoint [getPos _nearestTL3,7,0];
				_SpottedWP4a setWaypointType "MOVE";
				_SpottedWP4a setWaypointSpeed "FULL";
				_SpottedWP4a setWaypointBehaviour "AWARE";	
				_SpottedWP4a setWaypointFormation "WEDGE";	
				_SpottedWP4a2 = group _nearestTL3 addWaypoint [_SpottedUnitPos,7,1];
				_SpottedWP4a2 setWaypointSpeed "FULL";
				_SpottedWP4b = group _nearestTL3 addWaypoint [_FirstPos,7,2];
				_SpottedWP4c = group _nearestTL3 addWaypoint [_SecondPos,7,3];
				_SpottedWP4c setWaypointType "CYCLE";
				group _nearestTL3 setCombatMode "RED";
				group _nearestTL3 setFormation "WEDGE";
				group _nearestTL3 setSpeedMode "FULL";

				//_flare2 = "F_40mm_White" createVehicle getPos _nearestTL3;
			};

			if (selectRandom[true]) then {
				_nearestTanks = nearestObjects [_SpottedUnitPos, [sTank1,sTank2,sTank3], 3000];
				
				if (count _nearestTanks > 0) then {
					_nearestTank = _nearestTanks select 0;
					
					//gunner ((nearestObjects [player, [sTank1,sTank2,sTank3], 1000]) select 0);

					_gunner = gunner (_nearestTank); 
					if (!alive _gunner) then {
						if (count _nearestTanks > 1) then {
							_nearestTank = _nearestTanks select 1;
						};
					};
					if (count _nearestTanks > 1) then {if !(alive _nearestTank) then {_nearestTank = _nearestTanks select 1;};};
					if (count _nearestTanks > 2) then {if !(alive _nearestTank) then {_nearestTank = _nearestTanks select 2;};};
					if (count _nearestTanks > 3) then {if !(alive _nearestTank) then {_nearestTank = _nearestTanks select 3;};};
					if (count _nearestTanks > 4) then {if !(alive _nearestTank) then {_nearestTank = _nearestTanks select 4;};};
					_nearestTLTankwPosArray = waypoints group _nearestTank;

					while {(count (waypoints group _nearestTank)) > 0} do {
						deleteWaypoint ((waypoints group _nearestTank) select 0);
					};
					_SpottedWP5a = group _nearestTank addWaypoint [_SpottedUnitPos,10];
					_SpottedWP5a setWaypointType "SAD";
					if (isMultiplayer) then {
						_SpottedWP5a setWaypointSpeed "FULL";
					}
					else {
						_SpottedWP5a setWaypointSpeed "NORMAL";
					};
					_SpottedWP5a setWaypointBehaviour "AWARE";	
				};
			};

			if (selectRandom[true,false,false]) then {
				_nearestArts = nearestObjects [_SpottedUnitPos, [sArtilleryVeh], 2000];
				if (count _nearestArts > 0) then {
					_nearestArt =  selectRandom _nearestArts;
					_nearestArt reveal selectRandom _thisThisList;
				};
			};

			

		};

		_anyTLsCheckAlive = nearestObjects [_SpottedUnitPos, [sTeamleader], 3000];
		{
			if (!(alive _x)) then {
				deleteVehicle _x;
			}
		} forEach _anyTLsCheckAlive;

		sleep 420; //7 mins

		
		//hint "Ended";
	};
	SpottedActiveFinished = true;
	PublicVariable "SpottedActiveFinished";


};