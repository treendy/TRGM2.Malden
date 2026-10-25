//Run by the AO "spotted" trigger (see TRGM_fnc_populateSideMission): flares, reinforcements, air support, mortars and patrols react to the spotted player
params ["", "_thisThisList", "_FirstPos", "_iSideIndex", "_bIsMainObjective"]; //[thisTrigger, thisList, AO pos, AO index, is main objective]


if (isNil "FlareCounter") then {
		FlareCounter = 15;
};
if (isNil "FireFlares") then {
		FireFlares = selectRandom[true,false];
};

_MainObjectivePos = ObjectivePossitions select 0;


if (isServer && count _thisThisList > 0) then {
//9062.48,9828.87
	if (FireFlares) then {
		//gives 3 second delay before firing up flare, and also, will wait 10 seconds before firing up more
		FlareCounter = FlareCounter - 1; 
		if (FlareCounter == 10) then {
			_centPos = _FirstPos;
			_FirstFlarePos = _centPos getPos [(floor random 150),(floor random 360)];
			_SecondFlarePos = _centPos getPos [(floor random 150),(floor random 360)];
			[_FirstFlarePos] spawn TRGM_fnc_fireAOFlares;
			sleep 0.5;
			[_SecondFlarePos] spawn TRGM_fnc_fireAOFlares;			

		};
		if (FlareCounter == 0) then {
			FlareCounter = 30;
		};
	};


	_SpottedUnit = _thisThisList select 0;
	if (isPlayer _SpottedUnit) then {
	
		//so trigger will only be active for one second... inside this class we how many times its been called agasint the sideindex to decide if we continue (each side has its own trigger, so will be called multiple times if players sptted in multiple areas)
		//two counters, one to count if to use reinforcments/air support etc... and the other to make sure we dont call patrol to move to pos every second (need to give the patrol at least 30 seconds to move before relocate waypoints)
		SpottedActiveFinished = false;
		PublicVariable "SpottedActiveFinished";
		sleep 1;
		SpottedActiveFinished = true;
		PublicVariable "SpottedActiveFinished";
	

		_SpottedUnitPos = getpos (_thisThisList select 0);

		_maxPatrolSearch = 2000;

		//sends the group of _unit to the spotted position, then back to the AO in a cycle
		private _fnc_sendGroupToSpotted = {
			params ["_unit"];
			private _grp = group _unit;
			[_grp] call TRGM_fnc_deleteAllWaypoints;
			_grp setCombatMode "RED";
			_grp setFormation "WEDGE";
			_grp setSpeedMode "FULL";
			private _wp = _grp addWaypoint [getPos _unit,0,0];
			_wp setWaypointType "MOVE";
			_wp setWaypointSpeed "FULL";
			_wp setWaypointBehaviour "AWARE";
			_wp setWaypointFormation "WEDGE";
			_wp = _grp addWaypoint [_SpottedUnitPos,0,1];
			_wp setWaypointSpeed "FULL";
			_wp = _grp addWaypoint [_FirstPos,7,2];
			_wp setWaypointType "CYCLE";
			_grp setCombatMode "RED";
			_grp setFormation "WEDGE";
			_grp setSpeedMode "FULL";
		};

		//sends a random vehicle of _types within _radius to search and destroy the spotted position
		private _fnc_sendTankToSpotted = {
			params ["_types", "_radius"];
			private _nearestTanks = nearestObjects [_SpottedUnitPos, _types, _radius];
			if (count _nearestTanks > 0) then {
				private _grp = group (selectRandom _nearestTanks);
				[_grp] call TRGM_fnc_deleteAllWaypoints;
				private _wp = _grp addWaypoint [_SpottedUnitPos,10];
				_wp setWaypointType "SAD";
				_wp setWaypointSpeed "FULL";
				_wp setWaypointBehaviour "AWARE";
			};
		};

		_SpottedUnitCount = {_x distance _SpottedUnit < 200} count units group _SpottedUnit;
		if (_SpottedUnitCount > 0) then {
			_bAllowPatrolChange = true;
			_bAllowNextMortarRounds = true;
			_PatrolMoveCount = 0;
			_InfCount = 0;
			_TankCount = 0;
			_AirCount = 0;
			_MortarAllowedCount = 0;

			_PatrolMoveMaxCount = 300; // 5 mins
			_NextMortarMaxCount = 120; // 2 mins
			_InfMaxCount = 240; //4 mins before scount, then another four mins for reinforcements
			_TankMaxCount = 240;
			_AirMaxCount = 240;
			_bInfSpottedAction = false;
			_bTankSpottedAction = false;
			_bAirSpottedAction = false;
			if (_bIsMainObjective) then {
				_InfMaxCount = 60;
				_TankMaxCount = 120;
				_AirMaxCount = 120;		
			};
			if (bCommsBlocked) then {
				_InfMaxCount = 600; //10 mins
				_TankMaxCount = 600;
				_AirMaxCount = 600;	
			};
			_currentAODetail = nil;
			//AODetails = [[AOIndex,InfSpottedCount,VehSpottedCount,AirSpottedCount,bScoutCalled, patrolMoveCounter,MortarAllowedCount]]
			{
				if (_x select 0 == _iSideIndex) then {
					_currentAODetail = _x;
					_PatrolMoveCount = (_x select 5);
					if (_PatrolMoveCount > 0) then {
						_bAllowPatrolChange = false;
					}
					else {
						_bAllowPatrolChange = true;
					};
					_PatrolMoveCount = _PatrolMoveCount + 1;
					_x set [5,_PatrolMoveCount]; 
					if (_PatrolMoveCount == _PatrolMoveMaxCount) then {
						_x set [5,0]; 
					};
					
					_MortarAllowedCount = (_x select 6);
					if (_MortarAllowedCount > 0) then {
						_bAllowNextMortarRounds = false;
					}
					else {
						_bAllowNextMortarRounds = true;
					};
					if (_MortarAllowedCount > 0) then {
						_MortarAllowedCount = _MortarAllowedCount + 1;
						_x set [6,_MortarAllowedCount]; 
					};
					
					if (_MortarAllowedCount >= _NextMortarMaxCount) then {
						_x set [6,0]; 
					};


					if (!(vehicle _SpottedUnit isKindOf "Car") && !(vehicle _SpottedUnit isKindOf "Air") && !(vehicle _SpottedUnit isKindOf "Ship")) then {  //if not a tank or air unit, then just treat as though its a "Man" kindOf... was worried about playins being in car or another type not checekd which wouldnt fire this spotted script)
						if (_x select 1 > -1) then {
							_InfCount = (_x select 1) + 1;
							_x set [1,_InfCount]; 
							if (_InfCount == _InfMaxCount) then {
								if (!(_x select 4)) then { //if scount not called in this AO
									_x set [4,True]; 
									_x set [1,0]; 
									if ((_bIsMainObjective && selectRandom [true,false]) || (!_bIsMainObjective && selectRandom [true,false,false])) then {
										[_SpottedUnitPos, 3] spawn TRGM_fnc_enemyAirSupport;
									};
								}
								else {
									_bInfSpottedAction = true;
									_x set [1,-1]; 
								};
							
							};
						};
					};
					if (vehicle _SpottedUnit isKindOf "Car" || vehicle _SpottedUnit isKindOf "Ship") then {
						if (_x select 2 > -1) then {
							_TankCount = (_x select 2) + 1;
							_x set [2,_TankCount];  
							if (_TankCount == _TankMaxCount) then {
								_bTankSpottedAction = true;
								_x set [2,-1]; 
							};
						};
					};
					if (vehicle _SpottedUnit isKindOf "Air") then {
						if (_x select 3 > -1) then {
							_AirCount = (_x select 3) + 1;
							_x set [3,_AirCount];  
							if (_AirCount == _AirMaxCount) then {
								_bAirSpottedAction = true;
								_x set [3,-1]; 
							};
						};
					};
				};
			} forEach AODetails;
			publicVariable "AODetails";
		
			if (!(isNil "_currentAODetail")) then {
				sleep 5; //wait 5 seconds before enemy react


if (_bInfSpottedAction) then {
						if (_bIsMainObjective) then {
							[EAST, ReinforceStartPos1, _MainObjectivePos, 3, true, false, false, false, false] spawn TRGM_fnc_reinforcements;	
							if (bAllowLargerPatrols) then { 
								sleep 3;
								[EAST, ReinforceStartPos1, _MainObjectivePos, 3, true, false, false, false, false] spawn TRGM_fnc_reinforcements;	
							};
							ParaDropped = true;
							publicVariable "ParaDropped";
						}
						else {
							[EAST, ReinforceStartPos1, _SpottedUnitPos, 3, true, false, false, false, false] spawn TRGM_fnc_reinforcements;	
						};
					
				};	

				if (_bTankSpottedAction) then {
					[_SpottedUnitPos, 2] spawn TRGM_fnc_enemyAirSupport;
					[_FirstPos] spawn TRGM_fnc_airSiren;
				};
				
				if (_bAirSpottedAction) then {
					[_SpottedUnitPos, 1] spawn TRGM_fnc_enemyAirSupport;
					[_FirstPos] spawn TRGM_fnc_airSiren;
				};	
			
				//==============Now the generic spotted action to send a patrol to investigate of they have spotted inf ================================================
				if ((vehicle _SpottedUnit isKindOf "Car") && _bAllowPatrolChange) then {
					_nearestATs = nearestObjects [_SpottedUnitPos, [sATMan,sATManMilitia], _maxPatrolSearch];
					if (bDebugMode) then {hint format["AT pre count check: %1",count _nearestATs]; sleep 2;};
					if (count _nearestATs > 0) then {
						if (bDebugMode) then {hint "for than zero - count _nearestATs"; sleep 2;};
						[_nearestATs select 0] call _fnc_sendGroupToSpotted;
					};
					if (selectRandom[true,false]) then {
						[[sTank3Tank], 4000] call _fnc_sendTankToSpotted;
					};
				};

				
				//mortar script
				if (_bAllowNextMortarRounds && !bMortarFiring) then {
					_bFiredMortar = false;
					_currentAODetail set [6,1];  //commence counting now fired... when reach zero again, we will wait until round fired again
					_nearestMortars = nearestObjects [_SpottedUnitPos,sMortar + sMortarMilitia,_maxPatrolSearch];
					_ChancesOfFireMortar = [true,true,false];
					_iRoundsToFire = 1;
					
					_nearplayercount = {(_x distance _SpottedUnit) < 10} count allPlayers;
					if (_nearplayercount > selectRandom [3,4]) then {_ChancesOfFireMortar = [true]; _iRoundsToFire = 2};
					if (count _nearestMortars > 0 && speed _SpottedUnit < 1 && selectRandom _ChancesOfFireMortar && _SpottedUnit distance _MainObjectivePos > 200) then {
						_menNear = (nearestObjects [_SpottedUnit, ["Man"], 1250]) select {side _x == east};
						_bAllowMortar = true;
						_SpotterFound = false;
						_Spotter = nil;
						{
							if ((getPos _SpottedUnit distance getPos _x) < 55 && side _x == east) then {
								_bAllowMortar = false; //enemy units are too close to spotted unit to call mortar
							}
							else {
								if (!_SpotterFound && (getPos _SpottedUnit distance getPos _x) > 55 && side _x == East) then {
									
									_cansee = [objNull, "VIEW"] checkVisibility [eyePos _x, eyePos _SpottedUnit];
									if (bDebugMode) then {hint format["POW4 %1",_cansee];};
									sleep 0.6;
									if (_cansee > 0.2) then {
										sleep 3;
										//Set animation, or view binocs and face player
										_SpotterFound = true;
										_Spotter = _x;
										if (bDebugMode) then {
											_test = createMarker [format["SpotterMrk%1%2%3",getPos _x select 0,getPos _x select 1,selectRandom[1,2,3,4,5]], getPos _x];  
											_test setMarkerShape "ICON";  
											_test setMarkerType "hd_dot";  
											_test setMarkerText "SPOTTER"; 
										};
										
									};
								};
							};
							
						} forEach _menNear;
						if (_SpotterFound) then {
							if (bDebugMode) then {hint "SPOTTER FOUND"; sleep 2;};
							_Spotter call BIS_fnc_ambientAnim__terminate;
							_Spotter playMoveNow "Acts_listeningToRadio_loop";
							_Spotter disableAI "anim";
							_startPos = getPos _SpottedUnit;
							sleep 7;
							if (alive(_Spotter)) then {
								_Spotter enableAI "anim";
								_Spotter playMoveNow "Acts_listeningToRadio_out";
								_endPos = getPos _SpottedUnit;
								_dDistance = _startPos distance _endPos;
								if (_dDistance < 7 && _bAllowMortar) then {
									_nearestMortar = _nearestMortars select 0;
									_Ammo = getArtilleryAmmo [_nearestMortar] select 0;
									bMortarFiring = true;
									publicVariable "bMortarFiring";
									_iFiredCount = 0;
									while {_iFiredCount < _iRoundsToFire} do {
										_iFiredCount = _iFiredCount + 1;
										_TargetPos = [(_SpottedUnitPos select 0)+(75 * sin floor(random 360)),(_SpottedUnitPos select 1)+(75 * cos floor(random 360))];
										[_nearestMortar, [_TargetPos, _Ammo, 1]] remoteExec ["commandArtilleryFire", _nearestMortar];
										sleep 3;
									};
									bMortarFiring = false;
									publicVariable "bMortarFiring";
									_currentAODetail set [6,1];  //commence counting now fired... when reach zero again, we will wait until round fired again
									_bFiredMortar = true;
								};
							};
							
						};
							
					};
					if (!_bFiredMortar) then {
						_currentAODetail set [6,0];  //reset to zero as nothing was fired this attempt
					};
				};

				if (!(vehicle _SpottedUnit isKindOf "Car") && !(vehicle _SpottedUnit isKindOf "Air") && _bAllowPatrolChange) then {

					if (bBaseHasChopper && selectRandom [true]) then {
			
						[group EnemyBaseChopperPilot] call TRGM_fnc_deleteAllWaypoints;
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

				
					//one scan for both the patrol move (nearest team leader within _maxPatrolSearch) and the dead team leader clean up (3000m), nearestObjects is sorted by distance
					_nearbyTLs = nearestObjects [_SpottedUnitPos, [sTeamleader,sTeamleaderMilitia], 3000];
					if (count _nearbyTLs > 0 && {((_nearbyTLs select 0) distance _SpottedUnitPos) <= _maxPatrolSearch}) then {
						[_nearbyTLs select 0] call _fnc_sendGroupToSpotted;
					};

					if (selectRandom[true,false]) then {
						[[sTank1ArmedCar,sTank2APC,sTank3Tank,sTank1ArmedCarMilitia,sTank2APCMilitia,sTank3TankMilitia], 3000] call _fnc_sendTankToSpotted;
					};

					{
						if (!(alive _x)) then {
							deleteVehicle _x;
						};
					} forEach _nearbyTLs;

				
				};
			};
		
		};
	
	};

};

