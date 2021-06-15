params [
	["_FirstPos", []],
	["_iTaskIndex", 0],
	["_bIsMainObjective", false],
	["_thisThis", objNull],
	["_thisThisList", []]
];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;

if !(isServer) exitWith {};

if (_FirstPos isEqualTo []) exitWith {};
if (isNull _thisThis) exitWith {};
if (_thisThisList isEqualTo []) exitWith {};

_MainObjectivePos = TRGM_VAR_ObjectivePossitions select _iTaskIndex;
if (isNil "_MainObjectivePos") then {_MainObjectivePos = TRGM_VAR_ObjectivePossitions select 0;};

format["Spotted: %1", _thisThisList] call TRGM_GLOBAL_fnc_log;

if (TRGM_VAR_FireFlares) then {
	//gives 3 second delay before firing up flare, and also, will wait 10 seconds before firing up more
	TRGM_VAR_FlareCounter = TRGM_VAR_FlareCounter - 1;
	if (TRGM_VAR_FlareCounter isEqualTo 10) then {
		_centPos = _FirstPos;
		_FirstFlarePos = _centPos getPos [(floor random 150),(floor random 360)];
		_SecondFlarePos = _centPos getPos [(floor random 150),(floor random 360)];
		[_FirstFlarePos] spawn TRGM_GLOBAL_fnc_fireAOFlares;
		sleep 0.5;
		[_SecondFlarePos] spawn TRGM_GLOBAL_fnc_fireAOFlares;

	};
	if (TRGM_VAR_FlareCounter isEqualTo 0) then {
		TRGM_VAR_FlareCounter = 30;
	};
};

//[_SpottedUnitPos, 1] spawn TRGM_GLOBAL_fnc_enemyAirSupport;

_SpottedUnits = _thisThisList select { alive _x && isPlayer _x };

if (_SpottedUnits isEqualTo []) exitWith {};

_SpottedUnit = selectRandom _SpottedUnits;
_SpottedUnitPos = getPos _SpottedUnit;

//so trigger will only be active for one second... inside this class we how many times its been called agasint the sideindex to decide if we continue (each side has its own trigger, so will be called multiple times if players sptted in multiple areas)
//two counters, one to count if to use reinforcments/air support etc... and the other to make sure we dont call patrol to move to pos every second (need to give the patrol at least 30 seconds to move before relocate waypoints)
TRGM_VAR_TimeSinceLastSpottedAction = time; publicVariable "TRGM_VAR_TimeSinceLastSpottedAction";

_maxPatrolSearch = 2000;

_SpottedUnitCount = { _x distance _SpottedUnit < 200 } count units group _SpottedUnit;
//if (TRGM_VAR_bDebugMode) then {[format["pre first spotted count check: %1",_SpottedUnitCount]] call TRGM_GLOBAL_fnc_notify;};
_AlivePlayerCount = { alive _x } count allplayers;
//["a"] call TRGM_GLOBAL_fnc_notify;
if (_SpottedUnitCount > 0) then {
//["d"] call TRGM_GLOBAL_fnc_notify;
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
	if (TRGM_VAR_bCommsBlocked) then {
		_InfMaxCount = 600; //10 mins
		_TankMaxCount = 600;
		_AirMaxCount = 600;
	};
	_currentAODetail = nil;
	//TRGM_VAR_AODetails = [[AOIndex,InfSpottedCount,VehSpottedCount,AirSpottedCount,bScoutCalled, patrolMoveCounter,MortarAllowedCount]]
	{
		//[format["HERE: %1, %2", _x select 0,_iTaskIndex]] call TRGM_GLOBAL_fnc_notify;
		if (_x select 0 isEqualTo _iTaskIndex) then {
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
			if (_PatrolMoveCount isEqualTo _PatrolMoveMaxCount) then {
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
					if (_InfCount isEqualTo _InfMaxCount) then {
						if (!(_x select 4)) then { //if scount not called in this AO
							_x set [4,True];
							_x set [1,0];
							if ((_bIsMainObjective && random 1 < .50) || (!_bIsMainObjective && random 1 < .33)) then {
								[_SpottedUnitPos, 3] spawn TRGM_GLOBAL_fnc_enemyAirSupport;
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
					if (_TankCount isEqualTo _TankMaxCount) then {
						_bTankSpottedAction = true;
						_x set [2,-1];
					};
				};
			};
			if (vehicle _SpottedUnit isKindOf "Air") then {
				if (_x select 3 > -1) then {
					_AirCount = (_x select 3) + 1;
					_x set [3,_AirCount];
					if (_AirCount isEqualTo _AirMaxCount) then {
						_bAirSpottedAction = true;
						_x set [3,-1];
					};
				};
			};
		};
	} forEach TRGM_VAR_AODetails;
	publicVariable "TRGM_VAR_AODetails";

	if (!(isNil "_currentAODetail")) then {
		sleep 5; //wait 5 seconds before enemy react

		if (_bInfSpottedAction) then {
				if (_bIsMainObjective) then {
					[EAST, call TRGM_GETTER_fnc_aGetReinforceStartPos, _MainObjectivePos, 3, true, false, false, false, false, false] spawn TRGM_GLOBAL_fnc_reinforcements;
					if (call TRGM_GETTER_fnc_bMoreEnemies) then {
						sleep 5;
						[EAST, call TRGM_GETTER_fnc_aGetReinforceStartPos, _MainObjectivePos, 3, true, false, false, false, false, false] spawn TRGM_GLOBAL_fnc_reinforcements;
					};
					TRGM_VAR_ParaDropped = true; publicVariable "TRGM_VAR_ParaDropped";
				}
				else {
					[EAST, call TRGM_GETTER_fnc_aGetReinforceStartPos, _SpottedUnitPos, 3, true, false, false, false, false, false] spawn TRGM_GLOBAL_fnc_reinforcements;
					if (call TRGM_GETTER_fnc_bMoreEnemies) then {
						sleep 5;
						[EAST, call TRGM_GETTER_fnc_aGetReinforceStartPos, _MainObjectivePos, 3, true, false, false, false, false, false] spawn TRGM_GLOBAL_fnc_reinforcements;
					};
				};

		};

		if (_bTankSpottedAction) then {
			[_SpottedUnitPos, 2] spawn TRGM_GLOBAL_fnc_enemyAirSupport;
			TRGM_LOCAL_fnc_airSiren = {
				_FirstPos = _this select 0;
				_iLoopSirenCount = 0;
				while {_iLoopSirenCount < 5} do {
					_iLoopSirenCount = _iLoopSirenCount + 1;
					_missiondir = call { private "_arr"; _arr = toArray str missionConfigFile; _arr resize (count _arr - 15); toString _arr };
					playSound3D [_missiondir + "RandFramework\Sounds\Siren.ogg",nil,false,_FirstPos,1.5,1,0];

					sleep 40;
				};
			};
			[_FirstPos] spawn TRGM_LOCAL_fnc_airSiren;
		};

		if (_bAirSpottedAction) then {
			[_SpottedUnitPos, 1] spawn TRGM_GLOBAL_fnc_enemyAirSupport;
			TRGM_LOCAL_fnc_airSiren = {
				_FirstPos = _this select 0;
				_iLoopSirenCount = 0;
				while {_iLoopSirenCount < 5} do {
					_iLoopSirenCount = _iLoopSirenCount + 1;
					_missiondir = call { private "_arr"; _arr = toArray str missionConfigFile; _arr resize (count _arr - 15); toString _arr };
					playSound3D [_missiondir + "RandFramework\Sounds\Siren.ogg",nil,false,_FirstPos,1.5,1,0];

					sleep 40;
				};
			};
			[_FirstPos] spawn TRGM_LOCAL_fnc_airSiren;
		};

		//==============Now the generic spotted action to send a patrol to investigate of they have spotted inf ================================================
		if ((vehicle _SpottedUnit isKindOf "Car") && _bAllowPatrolChange) then {
			if  ((_SpottedUnitCount > 0)) then {
				_nearestATs = nearestObjects [_SpottedUnitPos, [(call sATMan),(call sATManMilitia)], _maxPatrolSearch];
				if (TRGM_VAR_bDebugMode) then {[format["AT pre count check: %1",count _nearestATs]] call TRGM_GLOBAL_fnc_notify; sleep 2;};
				if (count _nearestATs > 0) then {

					if (TRGM_VAR_bDebugMode) then {["for than zero - count _nearestATs"] call TRGM_GLOBAL_fnc_notify; sleep 2;};
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
				if (random 1 < .50) then {

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
		if  ((_SpottedUnitCount > 0) && _bAllowNextMortarRounds && !TRGM_VAR_bMortarFiring) then {
			//[format["eee:%1",str(_currentAODetail)]] call TRGM_GLOBAL_fnc_notify;
			_bFiredMortar = false;
			_currentAODetail set [6,1];  //commence counting now fired... when reach zero again, we will wait until round fired again
			_nearestMortars = nearestObjects [_SpottedUnitPos,(call sMortar) + (call sMortarMilitia),_maxPatrolSearch];
			_ChancesOfFireMortar = .66;
			_iRoundsToFire = 1;

			_playerClose = [];
			{
				if ((_x distance _SpottedUnit) < 10) then {
					_playerClose pushback _x;
				};
			} foreach allPlayers;
			_nearplayercount = count _playerClose;
			if (_nearplayercount > selectRandom [3,4]) then {_ChancesOfFireMortar = 1; _iRoundsToFire = 2};
			if (count _nearestMortars > 0 && speed _SpottedUnit < 1 && random 1 <= _ChancesOfFireMortar && _SpottedUnit distance _MainObjectivePos > 200) then {
				_menNear = nearestObjects [player, ["Man"], 1250];
				_bAllowMortar = true;
				_SpotterFound = false;
				_Spotter = nil;
				{
					if ((getPos _SpottedUnit distance getPos _x) < 55 && side _x isEqualTo east) then {
						_bAllowMortar = false; //enemy units are too close to spotted unit to call mortar
					}
					else {
						if (!_SpotterFound && (getPos _SpottedUnit distance getPos _x) > 55 && side _x isEqualTo East) then {

							_cansee = [objNull, "VIEW"] checkVisibility [eyePos _x, eyePos _SpottedUnit];
							// if (TRGM_VAR_bDebugMode) then {[format["POW4 %1",_cansee]] call TRGM_GLOBAL_fnc_notify;};
							sleep 0.6;
							if (_cansee > 0.2) then {
								//["POW2 POW POW POW"] call TRGM_GLOBAL_fnc_notify;
								sleep 3;
								//Set animation, or view binocs and face player
								_SpotterFound = true;
								_Spotter = _x;
								if (TRGM_VAR_bDebugMode) then {
									_test = nil;
									_test = createMarker [format["SpotterMrk%1%2%3",getPos _x select 0,getPos _x select 1,selectRandom[1,2,3,4,5]], getPos _x];
									_test setMarkerShape "ICON";
									_test setMarkerType "hd_dot";
									_test setMarkerText "SPOTTER";
									//["POW POW POW POW"] call TRGM_GLOBAL_fnc_notify;
								};

							};
						};
					};

				} forEach _menNear;
				if (_SpotterFound) then {
					if (TRGM_VAR_bDebugMode) then {["SPOTTER FOUND"] call TRGM_GLOBAL_fnc_notify; sleep 2;};
					_Spotter call BIS_fnc_ambientAnim__terminate;
					_Spotter playMoveNow "Acts_listeningToRadio_loop";
					_Spotter disableAI "anim";
					_startPos = getPos _SpottedUnit;
					//if (TRGM_VAR_bDebugMode) then {[format["spottedStartPos: %1",str(_startPos)]] call TRGM_GLOBAL_fnc_notify;};
					sleep 7;
					if (alive(_Spotter)) then {
						_Spotter enableAI "anim";
						_Spotter playMoveNow "Acts_listeningToRadio_out";
						_endPos = getPos _SpottedUnit;
						_dDistance = _startPos distance _endPos;
						//if (TRGM_VAR_bDebugMode) then {[format["spottedEndPos: %1 - Distance:%2 - PlayersNear:%3 - Chance:%4",str(_endPos), str(_dDistance),str(_nearplayercount),str(_ChancesOfFireMortar)]] call TRGM_GLOBAL_fnc_notify;};
						if (_dDistance < 7 && _bAllowMortar) then {
							_nearestMortar = _nearestMortars select 0;
							_Ammo = nil;
							_Ammo = getArtilleryAmmo [_nearestMortar] select 0;
							TRGM_VAR_bMortarFiring = true;
							publicVariable "TRGM_VAR_bMortarFiring";
							_iFiredCount = 0;
							while {_iFiredCount < _iRoundsToFire} do {
								_iFiredCount = _iRoundsToFire + 1;
								_TargetPos = [(_SpottedUnitPos select 0)+(75 * sin floor(random 360)),(_SpottedUnitPos select 1)+(75 * cos floor(random 360))];
								[_nearestMortar, [_TargetPos, _Ammo, 1]] remoteExec ["commandArtilleryFire", -2, false];
								sleep 3;
							};
							TRGM_VAR_bMortarFiring = false;
							publicVariable "TRGM_VAR_bMortarFiring";
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

			if (TRGM_VAR_bBaseHasChopper) then {

				while {(count (waypoints group TRGM_VAR_EnemyBaseChopperPilot)) > 0} do {
					deleteWaypoint ((waypoints group TRGM_VAR_EnemyBaseChopperPilot) select 0);
				};
				//EnemyBaseChopper set waypoint to spotted location then AO then RTB
				//GETIN NEAREST
				//EnemyBaseChopperPilot
				_EnemyBaseChopperWP0 = group TRGM_VAR_EnemyBaseChopperPilot addWaypoint [getPos TRGM_VAR_EnemyBaseChopperPilot,0,1];
				_EnemyBaseChopperWP0 setWaypointType "GETIN NEAREST";
				_EnemyBaseChopperWP0 setWaypointSpeed "FULL";

				_EnemyBaseChopperWP1 = group TRGM_VAR_EnemyBaseChopperPilot addWaypoint [getPos _SpottedUnit,0,1];
				_EnemyBaseChopperWP1 setWaypointType "SENTRY";
				_EnemyBaseChopperWP1 setWaypointSpeed "LIMITED";
				_EnemyBaseChopperWP1 setWaypointBehaviour "AWARE";

				_EnemyBaseChopperWP1 = group TRGM_VAR_EnemyBaseChopperPilot addWaypoint [getPos _SpottedUnit,0,1];
				_EnemyBaseChopperWP1 setWaypointType "MOVE";
				_EnemyBaseChopperWP1 setWaypointSpeed "LIMITED";
				_EnemyBaseChopperWP1 setWaypointBehaviour "AWARE";

				_EnemyBaseChopperWP1 = group TRGM_VAR_EnemyBaseChopperPilot addWaypoint [getPos TRGM_VAR_baseHeliPad,0,2];
				_EnemyBaseChopperWP1 setWaypointType "MOVE";
				_EnemyBaseChopperWP1 setWaypointSpeed "FULL";
				_EnemyBaseChopperWP1 setWaypointStatements ["true", "(vehicle this) LAND 'LAND';"];
			};

			//if (TRGM_VAR_bDebugMode) then {[format["inFirstGenericIf: %1",_AlivePlayerCount > 7]] call TRGM_GLOBAL_fnc_notify; sleep 1;};

			if  ((_SpottedUnitCount > 0)) then {
				//if (TRGM_VAR_bDebugMode) then {[format["inSecondGenericIf: %1",_AlivePlayerCount > 7]] call TRGM_GLOBAL_fnc_notify; sleep 2;};


				//if (TRGM_VAR_bDebugMode) then {sleep 2};
				_nearestTLs = nearestObjects [_SpottedUnitPos, [(call sTeamleader),(call sTeamleaderMilitia)], _maxPatrolSearch];
				//if (TRGM_VAR_bDebugMode) then {[format["pre count check: %1",count _nearestTLs]] call TRGM_GLOBAL_fnc_notify; sleep 2;};
				if (count _nearestTLs > 0) then {

					//if (TRGM_VAR_bDebugMode) then {["for than zero - count _nearestTLs"] call TRGM_GLOBAL_fnc_notify; sleep 2;};
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

				if (random 1 < .50) then {

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

