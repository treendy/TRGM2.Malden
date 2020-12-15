params ["_thisThis", "_thisThisList", "_FirstPos", "_iSideIndex", "_bIsMainObjective"];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;

//hint format["THIS: \nTHISLIST: %1",str(_thisThisList)];
//sleep 10;
_MainObjectivePos = TREND_ObjectivePossitions select 0;

//hint format["Spotted2: %1",_this select 1];

//if (TREND_bDebugMode) then {hint "spotted init";};

if (isServer && count _thisThisList > 0) then {
//9062.48,9828.87
	if (TREND_FireFlares) then {
		//gives 3 second delay before firing up flare, and also, will wait 10 seconds before firing up more
		TREND_FlareCounter = TREND_FlareCounter - 1;
		if (TREND_FlareCounter == 10) then {
			_centPos = _FirstPos;
			_FirstFlarePos = _centPos getPos [(floor random 150),(floor random 360)];
			_SecondFlarePos = _centPos getPos [(floor random 150),(floor random 360)];
			[_FirstFlarePos] spawn TREND_fnc_fireAOFlares;
			sleep 0.5;
			[_SecondFlarePos] spawn TREND_fnc_fireAOFlares;

		};
		if (TREND_FlareCounter == 0) then {
			TREND_FlareCounter = 30;
		};
	};

	//[_SpottedUnitPos, 1] spawn TREND_fnc_enemyAirSupport;

	_SpottedUnit = _thisThisList select 0;
	if (isNil "_SpottedUnit") exitWith {};
	_SpottedUnitPos = getpos _SpottedUnit;

	if (isPlayer _SpottedUnit) then {

		//so trigger will only be active for one second... inside this class we how many times its been called agasint the sideindex to decide if we continue (each side has its own trigger, so will be called multiple times if players sptted in multiple areas)
		//two counters, one to count if to use reinforcments/air support etc... and the other to make sure we dont call patrol to move to pos every second (need to give the patrol at least 30 seconds to move before relocate waypoints)
		TREND_TimeSinceLastSpottedAction = time; publicVariable "TREND_TimeSinceLastSpottedAction";


		_SpottedUnitPos = getpos _SpottedUnit;

		_maxPatrolSearch = 2000;



		//_SpottedUnitCount = count _thisThisList;
		//_SpottedUnitCount = FriendlySide countSide nearestObjects [_SpottedUnitPos, [(call sTeamleader)], 250];
		_SpottedUnitCount = { _x distance _SpottedUnit < 200 } count units group _SpottedUnit;
		//if (TREND_bDebugMode) then {hint format["pre first spotted count check: %1",_SpottedUnitCount];};
		_AlivePlayerCount = { alive _x } count allplayers;
		//hint "a";
		if (_SpottedUnitCount > 0) then {
		//hint "d";
			//========First take care of additional support (reinforcements, air to air/ground support etc... based on the type of threat the enemy have spotted)
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
			if (TREND_bCommsBlocked) then {
				_InfMaxCount = 600; //10 mins
				_TankMaxCount = 600;
				_AirMaxCount = 600;
			};
			_currentAODetail = nil;
			//TREND_AODetails = [[AOIndex,InfSpottedCount,VehSpottedCount,AirSpottedCount,bScoutCalled, patrolMoveCounter,MortarAllowedCount]]
			{
				//HINT format["HERE: %1, %2", _x select 0,_iSideIndex];
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
										[_SpottedUnitPos, 3] spawn TREND_fnc_enemyAirSupport;
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
			} forEach TREND_AODetails;
			publicVariable "TREND_AODetails";

			if (!(isNil "_currentAODetail")) then {
				sleep 5; //wait 5 seconds before enemy react

				//if (_SpottedUnit distance _MainObjectivePos < 300 && !(vehicle _SpottedUnit isKindOf "Air")) then {
				//	if (!TREND_ParaDropped) then {
				//
				//		[EAST, call TREND_GetReinforceStartPos, _MainObjectivePos, 3, true, false, false, false, false] spawn TREND_fnc_reinforcements;
				//		if (call TREND_bAllowLargerPatrols) then {
				//			sleep 3;
				//			[EAST, call TREND_GetReinforceStartPos, _MainObjectivePos, 3, true, false, false, false, false] spawn TREND_fnc_reinforcements;
				//		};
				//		TREND_ParaDropped = true;
				//		publicVariable "TREND_ParaDropped";
				//	};
				//};


				if (_bInfSpottedAction) then {
						if (_bIsMainObjective) then {
							[EAST, call TREND_GetReinforceStartPos, _MainObjectivePos, 3, true, false, false, false, false] spawn TREND_fnc_reinforcements;
							if (call TREND_bMoreEnemies) then {
								sleep 3;
								[EAST, call TREND_GetReinforceStartPos, _MainObjectivePos, 3, true, false, false, false, false] spawn TREND_fnc_reinforcements;
							};
							TREND_ParaDropped = true; publicVariable "TREND_ParaDropped";
						}
						else {
							[EAST, call TREND_GetReinforceStartPos, _SpottedUnitPos, 3, true, false, false, false, false] spawn TREND_fnc_reinforcements;
							if (call TREND_bMoreEnemies) then {
								sleep 3;
								[EAST, call TREND_GetReinforceStartPos, _MainObjectivePos, 3, true, false, false, false, false] spawn TREND_fnc_reinforcements;
							};
						};

				};

				if (_bTankSpottedAction) then {
					[_SpottedUnitPos, 2] spawn TREND_fnc_enemyAirSupport;
					TREND_fnc_AirSiren = {
						_FirstPos = _this select 0;
						_iLoopSirenCount = 0;
						while {_iLoopSirenCount < 5} do {
							_iLoopSirenCount = _iLoopSirenCount + 1;
							_missiondir = call { private "_arr"; _arr = toArray str missionConfigFile; _arr resize (count _arr - 15); toString _arr };
							playSound3D [_missiondir + "RandFramework\Sounds\Siren.ogg",nil,false,_FirstPos,1.5,1,0];

							sleep 40;
						};
					};
					[_FirstPos] spawn TREND_fnc_AirSiren;
				};

				if (_bAirSpottedAction) then {
					[_SpottedUnitPos, 1] spawn TREND_fnc_enemyAirSupport;
					TREND_fnc_AirSiren = {
						_FirstPos = _this select 0;
						_iLoopSirenCount = 0;
						while {_iLoopSirenCount < 5} do {
							_iLoopSirenCount = _iLoopSirenCount + 1;
							_missiondir = call { private "_arr"; _arr = toArray str missionConfigFile; _arr resize (count _arr - 15); toString _arr };
							playSound3D [_missiondir + "RandFramework\Sounds\Siren.ogg",nil,false,_FirstPos,1.5,1,0];

							sleep 40;
						};
					};
					[_FirstPos] spawn TREND_fnc_AirSiren;
				};

				//==============Now the generic spotted action to send a patrol to investigate of they have spotted inf ================================================
				if ((vehicle _SpottedUnit isKindOf "Car") && _bAllowPatrolChange) then {
					if  ((_SpottedUnitCount > 0)) then {
						_nearestATs = nearestObjects [_SpottedUnitPos, [(call sATMan),(call sATManMilitia)], _maxPatrolSearch];
						if (TREND_bDebugMode) then {hint format["AT pre count check: %1",count _nearestATs]; sleep 2;};
						if (count _nearestATs > 0) then {

							if (TREND_bDebugMode) then {hint "for than zero - count _nearestATs"; sleep 2;};
							_nearestTL = _nearestATs select 0;
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
							_SpottedWP1b setWaypointType "CYCLE";
							group _nearestTL setCombatMode "RED";
							group _nearestTL setFormation "WEDGE";
							group _nearestTL setSpeedMode "FULL";
						};
						if (selectRandom[true,false]) then {

							_nearestTanks = nearestObjects [_SpottedUnitPos, [(call sTank3Tank)], 4000];
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
				};


				//mortar script
				if  ((_SpottedUnitCount > 0) && _bAllowNextMortarRounds && !TREND_bMortarFiring) then {
					//hint format["eee:%1",str(_currentAODetail)];
					_bFiredMortar = false;
					_currentAODetail set [6,1];  //commence counting now fired... when reach zero again, we will wait until round fired again
					_nearestMortars = nearestObjects [_SpottedUnitPos,(call sMortar) + (call sMortarMilitia),_maxPatrolSearch];
					_ChancesOfFireMortar = [true,true,false];
					_iRoundsToFire = 1;

					_playerClose = [];
					{
						if ((_x distance _SpottedUnit) < 10) then {
							_playerClose pushback _x;
						};
					} foreach allPlayers;
					_nearplayercount = count _playerClose;
					if (_nearplayercount > selectRandom [3,4]) then {_ChancesOfFireMortar = [true]; _iRoundsToFire = 2};
					if (count _nearestMortars > 0 && speed _SpottedUnit < 1 && selectRandom _ChancesOfFireMortar && _SpottedUnit distance _MainObjectivePos > 200) then {
						_menNear = nearestObjects [player, ["Man"], 1250];
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
									if (TREND_bDebugMode) then {hint format["POW4 %1",_cansee];};
									sleep 0.6;
									if (_cansee > 0.2) then {
										//hint "POW2 POW POW POW";
										sleep 3;
										//Set animation, or view binocs and face player
										_SpotterFound = true;
										_Spotter = _x;
										if (TREND_bDebugMode) then {
											_test = nil;
											_test = createMarker [format["SpotterMrk%1%2%3",getPos _x select 0,getPos _x select 1,selectRandom[1,2,3,4,5]], getPos _x];
											_test setMarkerShape "ICON";
											_test setMarkerType "hd_dot";
											_test setMarkerText "SPOTTER";
											//hint "POW POW POW POW";
										};

									};
								};
							};

						} forEach _menNear;
						if (_SpotterFound) then {
							if (TREND_bDebugMode) then {hint "SPOTTER FOUND"; sleep 2;};
							_Spotter call BIS_fnc_ambientAnim__terminate;
							_Spotter playMoveNow "Acts_listeningToRadio_loop";
							_Spotter disableAI "anim";
							_startPos = getPos _SpottedUnit;
							//if (TREND_bDebugMode) then {hint format["spottedStartPos: %1",str(_startPos)];};
							sleep 7;
							if (alive(_Spotter)) then {
								_Spotter enableAI "anim";
								_Spotter playMoveNow "Acts_listeningToRadio_out";
								_endPos = getPos _SpottedUnit;
								_dDistance = _startPos distance _endPos;
								//if (TREND_bDebugMode) then {hint format["spottedEndPos: %1 - Distance:%2 - PlayersNear:%3 - Chance:%4",str(_endPos), str(_dDistance),str(_nearplayercount),str(_ChancesOfFireMortar)];};
								if (_dDistance < 7 && _bAllowMortar) then {
									_nearestMortar = _nearestMortars select 0;
									_Ammo = nil;
									_Ammo = getArtilleryAmmo [_nearestMortar] select 0;
									TREND_bMortarFiring = true;
									publicVariable "TREND_bMortarFiring";
									_iFiredCount = 0;
									while {_iFiredCount < _iRoundsToFire} do {
										_iFiredCount = _iRoundsToFire + 1;
										_TargetPos = [(_SpottedUnitPos select 0)+(75 * sin floor(random 360)),(_SpottedUnitPos select 1)+(75 * cos floor(random 360))];
										[_nearestMortar, [_TargetPos, _Ammo, 1]] remoteExec ["commandArtilleryFire", -2, false];
										sleep 3;
									};
									TREND_bMortarFiring = false;
									publicVariable "TREND_bMortarFiring";
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

					if (TREND_bBaseHasChopper) then {

						while {(count (waypoints group TREND_EnemyBaseChopperPilot)) > 0} do {
							deleteWaypoint ((waypoints group TREND_EnemyBaseChopperPilot) select 0);
						};
						//EnemyBaseChopper set waypoint to spotted location then AO then RTB
						//GETIN NEAREST
						//EnemyBaseChopperPilot
						_EnemyBaseChopperWP0 = group TREND_EnemyBaseChopperPilot addWaypoint [getPos TREND_EnemyBaseChopperPilot,0,1];
						_EnemyBaseChopperWP0 setWaypointType "GETIN NEAREST";
						_EnemyBaseChopperWP0 setWaypointSpeed "FULL";

						_EnemyBaseChopperWP1 = group TREND_EnemyBaseChopperPilot addWaypoint [getPos _SpottedUnit,0,1];
						_EnemyBaseChopperWP1 setWaypointType "SENTRY";
						_EnemyBaseChopperWP1 setWaypointSpeed "LIMITED";
						_EnemyBaseChopperWP1 setWaypointBehaviour "AWARE";

						_EnemyBaseChopperWP1 = group TREND_EnemyBaseChopperPilot addWaypoint [getPos _SpottedUnit,0,1];
						_EnemyBaseChopperWP1 setWaypointType "MOVE";
						_EnemyBaseChopperWP1 setWaypointSpeed "LIMITED";
						_EnemyBaseChopperWP1 setWaypointBehaviour "AWARE";

						_EnemyBaseChopperWP1 = group TREND_EnemyBaseChopperPilot addWaypoint [getPos TREND_baseHeliPad,0,2];
						_EnemyBaseChopperWP1 setWaypointType "MOVE";
						_EnemyBaseChopperWP1 setWaypointSpeed "FULL";
						_EnemyBaseChopperWP1 setWaypointStatements ["true", "(vehicle this) LAND 'LAND';"];
					};

					//if (TREND_bDebugMode) then {hint format["inFirstGenericIf: %1",_AlivePlayerCount > 7]; sleep 1;};

					if  ((_SpottedUnitCount > 0)) then {
						//if (TREND_bDebugMode) then {hint format["inSecondGenericIf: %1",_AlivePlayerCount > 7]; sleep 2;};


						//if (TREND_bDebugMode) then {sleep 2};
						_nearestTLs = nearestObjects [_SpottedUnitPos, [(call sTeamleader),(call sTeamleaderMilitia)], _maxPatrolSearch];
						//if (TREND_bDebugMode) then {hint format["pre count check: %1",count _nearestTLs]; sleep 2;};
						if (count _nearestTLs > 0) then {

							//if (TREND_bDebugMode) then {hint "for than zero - count _nearestTLs"; sleep 2;};
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
							_SpottedWP1b setWaypointType "CYCLE";
							group _nearestTL setCombatMode "RED";
							group _nearestTL setFormation "WEDGE";
							group _nearestTL setSpeedMode "FULL";
						};

						//_flare1 = "F_40mm_White" createVehicle getPos _nearestTL;

						if (selectRandom[true,false]) then {

							_nearestTanks = nearestObjects [_SpottedUnitPos, [(call sTank1ArmedCar),(call sTank2APC),(call sTank3Tank),(call sTank1ArmedCarMilitia),(call sTank2APCMilitia),(call sTank3TankMilitia)], 3000];
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



					_anyTLsCheckAlive = nearestObjects [_SpottedUnitPos, [(call sTeamleader),(call sTeamleaderMilitia)], 3000];
					{
						if (!(alive _x)) then {
							deleteVehicle _x;
						}
					} forEach _anyTLsCheckAlive;


				};
			};

		};

	};

};

