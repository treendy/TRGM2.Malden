params [
	"_sidePos",
	"_sideType",
	"_sideMainBuilding",
	"_bIsMainObjective",
	"_iTaskIndex",
	"_allowFriendlyIns",
	["_ForceCivsOnly", false]
];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;

_dAngleAdustPerLoop = 0;
_bHasVehicle = false;

TREND_AODetails pushBack [_iTaskIndex,0,0,0,false,0,0];
publicVariable "TREND_AODetails";


//_bFriendlyInsurgents = true;
_bFriendlyInsurgents = selectRandom TREND_bFriendlyInsurgents;

_InsurgentSide = east;
if (_bFriendlyInsurgents) then {_InsurgentSide = west;};
if (_bIsMainObjective) then {_InsurgentSide = east; _bFriendlyInsurgents = false;}; //if main need to make sure not friendly insurgents

///*orangestest

_bThisMissionCivsOnly = selectRandom TREND_bCivsOnly;
_bTownBigenoughForFriendlyInsurgants = true;
_allBuildingsNearAO = nearestObjects [_sidePos, TREND_BasicBuildings, 100];
_allBuildingsNearAOCount = count _allBuildingsNearAO;
if (_allBuildingsNearAOCount <= TREND_iBuildingCountToAllowCivsAndFriendlyInformants) then {
	_bThisMissionCivsOnly = false;
	_bTownBigenoughForFriendlyInsurgants = false;
};
if (!_bTownBigenoughForFriendlyInsurgants && _bFriendlyInsurgents) then {
	_InsurgentSide = east;
	_bFriendlyInsurgents = false;
};
if (!_allowFriendlyIns) then {
	_InsurgentSide = east;
	_bFriendlyInsurgents = false;
};

if (_bIsMainObjective) then {_bThisMissionCivsOnly = false};

if (_ForceCivsOnly) then {
	_bThisMissionCivsOnly = true;
}
else {
	_bThisMissionCivsOnly = false;
};

_selectRandomW = call {random 1 > .80};;
if (call TREND_bMoreEnemies) then {
	_selectRandomW = call {random 1 > .65};
	_bThisMissionCivsOnly = false;
	_InsurgentSide = east;
	_bFriendlyInsurgents = false;
};

if (!_bFriendlyInsurgents) then {
	// if (!_bThisMissionCivsOnly) then {
	// 	//insert warlord
	// 	_flatPos = nil;
	// 	_flatPos = [_sidePos , 10, 40, 4, 0, 0.5, 0,[],[_sidePos,[0,0,0]]] call TREND_fnc_findSafePos;
	// 	//sWarloadSideMission createUnit [_flatPos, createGroup east, " this switchMove ""Acts_listeningToRadio_loop"" "];
	// };
}
else {
	TREND_ClearedPositions pushBack [_sidePos];
	publicVariable "TREND_ClearedPositions";
};

if ((_sideType == 7 || _sideType == 5) && _bFriendlyInsurgents) then { //if mission is kill officer or kill officer and in fridnldy area then make him prisoner
	sOfficerName = format["objInformant%1",_iTaskIndex];
	_officerObject = missionNamespace getVariable [sOfficerName , objNull];
	_officerObject disableAI "anim";
	_officerObject switchMove "Acts_ExecutionVictim_Loop";
	_officerObject disableAI "anim";
	_officerObject setCaptive true;
	_officerObject setVariable ["StopWalkScript", true];
	//_sideMainBuilding
	_allpositionsMainBuiding = _sideMainBuilding buildingPos -1;
	_officerObject setPosATL (selectRandom _allpositionsMainBuiding);
	removeAllWeapons _officerObject;
};
if (_sideType == 4) then { //if mission is informat, then dont be walkig around
	sInformantName = format["objInformant%1",_iTaskIndex];
	_InformantObject = missionNamespace getVariable [sInformantName , objNull];
	_InformantObject setVariable ["StopWalkScript", true];
	//_sideMainBuilding
	_allpositionsMainBuiding = _sideMainBuilding buildingPos -1;
	_InformantObject setPosATL (selectRandom _allpositionsMainBuiding);
};

//if (true) then {
if (TREND_AllowAOFires && _selectRandomW && !_bThisMissionCivsOnly) then {
	//"test_EmptyObjectForFireBig" createVehicle position board2;
	_fireRootx = getPos _sideMainBuilding select 0;
	_fireRooty = getPos _sideMainBuilding select 1;

	_firePos1 = [_fireRootx+5+(floor random 15),_fireRooty+5+(floor random 15)];
	_objFlame1 = "test_EmptyObjectForFireBig" createVehicle _firePos1;
	if (isOnRoad _firePos1) then {selectRandom TREND_WreckCarClasses createVehicle getPos _objFlame1;};

	if (_selectRandomW) then {
		_firePos2 = [_fireRootx-5-(floor random 15),_fireRooty-5-(floor random 15)];
		_objFlame2 = "test_EmptyObjectForFireBig" createVehicle _firePos2;
		if (isOnRoad _firePos2) then {selectRandom TREND_WreckCarClasses createVehicle getPos _objFlame2;};
	};

	if (_selectRandomW) then {
		_firePos3 = [_fireRootx+5+(floor random 15),_fireRooty-5-(floor random 15)];
		_objFlame3 = "test_EmptyObjectForFireBig" createVehicle _firePos3;
		if (isOnRoad _firePos3) then {selectRandom TREND_WreckCarClasses createVehicle getPos _objFlame3;};

	};
	if (_selectRandomW) then {
		_firePos4 = [_fireRootx-5-(floor random 15),_fireRooty+5+(floor random 15)];
		_objFlame4 = "test_EmptyObjectForFireBig" createVehicle _firePos4;
		if (isOnRoad _firePos4) then {selectRandom TREND_WreckCarClasses createVehicle getPos _objFlame4;};
	};
};

//if main var to set friendly insurg and also, if our random selction above plus 25/75 chance is true, then the units will be dressed as insurgents (player will not know if friendly of enemy)
if ((_bThisMissionCivsOnly || (!_bIsMainObjective && random 1 < .25))) then {
	TREND_ToUseMilitia_Side = true; publicVariable "TREND_ToUseMilitia_Side";
};

TREND_sideAllBuildingPos = _sideMainBuilding buildingPos -1;
_inf1X = _sidePos select 0;
_inf1Y = _sidePos select 1;

_trgCustomAIScript = nil;
_trgCustomAIScript = createTrigger ["EmptyDetector", _sidePos];
_trgCustomAIScript setVariable ["DelMeOnNewCampaignDay",true];
_trgCustomAIScript setTriggerArea [1250, 1250, 0, false];
_trgCustomAIScript setTriggerActivation [TREND_FriendlySideString, format["%1 D", TREND_EnemySideString], true];
_trgCustomAIScript setTriggerStatements ["this && {(time - TREND_TimeSinceLastSpottedAction) > (call TREND_GetSpottedDelay)}", format["nul = [%1, %2, %3, thisTrigger, thisList] spawn TREND_fnc_CallNearbyPatrol;",str(_sidePos),_iTaskIndex, _bIsMainObjective], ""];
//TREND_AODetails [_iTaskIndex,0,0,0,false,0]
//TREND_AODetails select

//Create extra detected trigger for more reinforcements
if (call TREND_bMoreEnemies) then {
	_trgCustomAIScript2 = nil;
	_trgCustomAIScript2 = createTrigger ["EmptyDetector", _sidePos];
	_trgCustomAIScript2 setVariable ["DelMeOnNewCampaignDay",true];
	_trgCustomAIScript2 setTriggerArea [1250, 1250, 0, false];
	_trgCustomAIScript2 setTriggerActivation [TREND_FriendlySideString, format["%1 D", TREND_EnemySideString], true];
	_trgCustomAIScript2 setTriggerStatements ["this && {(time - TREND_TimeSinceLastSpottedAction) > (call TREND_GetSpottedDelay * 1.5)}", format["nul = [%1, %2, %3, thisTrigger, thisList] spawn TREND_fnc_CallNearbyPatrol; nul = [true, %1] spawn TREND_fnc_alertNearbyUnits;",str(_sidePos),_iTaskIndex, _bIsMainObjective], ""];
};

TREND_debugMessages = TREND_debugMessages + format["\n\ntrendFunctions.sqf : _bFriendlyInsurgents: %1 - _bThisMissionCivsOnly: %2 ",str(_bFriendlyInsurgents),str(_bThisMissionCivsOnly)];

if (!_bFriendlyInsurgents) then {
	if (!_bThisMissionCivsOnly) then {

		_minimission = false;
		if (TREND_AdvancedSettings select TREND_ADVSET_MINIMISSIONS_IDX == 1) then {
			_minimission = true;
		};
		if (TREND_AdvancedSettings select TREND_ADVSET_MINIMISSIONS_IDX == 0) then {
			_minimission = random 1 < .50;
		};


		TREND_debugMessages = TREND_debugMessages + format["\n\ntrendFunctions.sqf : inside populate enemy -  _bFriendlyInsurgents: %1 - _bThisMissionCivsOnly: %2 ",str(_bFriendlyInsurgents),str(_bThisMissionCivsOnly)];
		//Spawn patrol
		//if main need a couple of these and always have 2 or 3

		["InitSniperCreator", true] call TREND_fnc_log;
		if (_selectRandomW) then {
			[_sidePos] spawn TREND_fnc_createEnemySniper;
		};
		["EndSniperCreator", true] call TREND_fnc_log;
		_bHasPatrols = false;
		if (_bIsMainObjective) then {_bHasPatrols = true};

		_bSmallerAllOverPatrols = random 1 < .50 || TREND_PatrolType == 1 || TREND_PatrolType == 2; //if single mission and random 50/50, or if forced by custom mission

		if (_minimission) then {
			if (random 1 < .50) then {
				if (random 1 < .50) then {
					[_sidePos,250 + (floor random 100),[2,3],true,_InsurgentSide, 10] spawn TREND_fnc_BuildingPatrol;
				}
				else {
					[_sidePos getPos [300,0],180 + (floor random 20),[2,3],true,_InsurgentSide] spawn TREND_fnc_RadiusPatrol;
				};
			};
		}
		else {
			if (_bSmallerAllOverPatrols) then {
				_bHasPatrols = true;
				_patrolUnitCounts = [2,3];
				if (TREND_PatrolType == 2) then {
					_patrolUnitCounts = [4,4,4,4,4,4,5,5,5,5,5,5];
				};

				if (_bIsMainObjective) then {
					[_sidePos,250 + (floor random 400),_patrolUnitCounts,true,_InsurgentSide, 10] spawn TREND_fnc_BuildingPatrol;
					[_sidePos,250 + (floor random 100),_patrolUnitCounts,true,_InsurgentSide, 10] spawn TREND_fnc_BuildingPatrol;
					[_sidePos getPos [300,0],180 + (floor random 20),_patrolUnitCounts,true,_InsurgentSide] spawn TREND_fnc_RadiusPatrol;
					[_sidePos getPos [300,90],180 + (floor random 20),_patrolUnitCounts,true,_InsurgentSide] spawn TREND_fnc_RadiusPatrol;
					[_sidePos getPos [300,180],180 + (floor random 20),_patrolUnitCounts,true,_InsurgentSide] spawn TREND_fnc_RadiusPatrol;
					[_sidePos getPos [300,270],180 + (floor random 20),_patrolUnitCounts,true,_InsurgentSide] spawn TREND_fnc_RadiusPatrol;
					[_sidePos getPos [600,45],200 + (floor random 50),_patrolUnitCounts,true,_InsurgentSide] spawn TREND_fnc_RadiusPatrol;
					[_sidePos getPos [600,135],200 + (floor random 50),_patrolUnitCounts,true,_InsurgentSide] spawn TREND_fnc_RadiusPatrol;
					[_sidePos getPos [600,225],200 + (floor random 50),_patrolUnitCounts,true,_InsurgentSide] spawn TREND_fnc_RadiusPatrol;
					[_sidePos getPos [600,315],200 + (floor random 50),_patrolUnitCounts,true,_InsurgentSide] spawn TREND_fnc_RadiusPatrol;
				}
				else {
					[_sidePos,250 + (floor random 100),[2,3],true,_InsurgentSide, 10] spawn TREND_fnc_BuildingPatrol;
					[_sidePos,800 + (floor random 100),[2,3],true,_InsurgentSide, 200] spawn TREND_fnc_BuildingPatrol;
					[_sidePos getPos [400,0],250 + (floor random 20),[2,3],true,_InsurgentSide] spawn TREND_fnc_RadiusPatrol;
					[_sidePos getPos [400,90],250 + (floor random 20),[2,3],true,_InsurgentSide] spawn TREND_fnc_RadiusPatrol;
					[_sidePos getPos [400,180],250 + (floor random 20),[2,3],true,_InsurgentSide] spawn TREND_fnc_RadiusPatrol;
					[_sidePos getPos [400,270],250 + (floor random 20),[2,3],true,_InsurgentSide] spawn TREND_fnc_RadiusPatrol;
				};


			}
			else {
				if (_bIsMainObjective) then {

					[_sidePos,15 + (floor random 150),[2,3],false,_InsurgentSide] spawn TREND_fnc_RadiusPatrol;
					if ((call TREND_bAllowLargerPatrols && _bIsMainObjective)) then {
						[_sidePos,15 + (floor random 150),[2,3],false,_InsurgentSide] spawn TREND_fnc_RadiusPatrol;
					};
				};
				if (_selectRandomW) then {
					//not adding a teamleader to small patrol as we need long dist to have teamleader for CallNearbyPatrols (3rd param for RadiusPatrol is false)
					[_sidePos,15 + (floor random 50),[2,3],false,_InsurgentSide] spawn TREND_fnc_RadiusPatrol;
					_bHasPatrols = true
				};


				//Spawn wide patrol
				//if main, need a couple of these and always have 2 or 3
				if (_bIsMainObjective) then {
					[_sidePos,500 + (floor random 250),[7,8,9],true,_InsurgentSide] spawn TREND_fnc_RadiusPatrol;
				}
				else {
					if (_selectRandomW) then {
						[_sidePos,500 + (floor random 250),[4,5,6],true,_InsurgentSide] spawn TREND_fnc_RadiusPatrol;
						_bHasPatrols = true
					};
				};

				if ((_bIsMainObjective && _selectRandomW)) then {
					//[_sidePos,500 + (floor random 250),[7,8,9,10],true,_InsurgentSide] spawn TREND_fnc_RadiusPatrol;
					if (call TREND_bAllowLargerPatrols && _bIsMainObjective) then {
						//[_sidePos,700 + (floor random 250),[7,8,9,10],true,_InsurgentSide] spawn TREND_fnc_RadiusPatrol;
						[_sidePos,900 + (floor random 250),[7,8,9,10],true,_InsurgentSide] spawn TREND_fnc_RadiusPatrol;
					};
				};



				//Spawn patrol to move from building to building
				if (_bIsMainObjective || _selectRandomW) then {
					[_sidePos,1000 + (floor random 500),[3,4,5],true,_InsurgentSide, 10] spawn TREND_fnc_BuildingPatrol;
					_bHasPatrols = true
				};
				if (_bIsMainObjective && call TREND_bAllowLargerPatrols) then {
					[_sidePos,1000 + (floor random 500),[3,4,5],true,_InsurgentSide, 10] spawn TREND_fnc_BuildingPatrol;
				};

				//Spawn distant patrol ready to move in (will need to spawn trigger)
				if (_bIsMainObjective || _selectRandomW ) then {
					[_sidePos,1000 + (floor random 500),[5,6],true,_InsurgentSide] spawn TREND_fnc_BackForthPatrol;
					_bHasPatrols = true
				};
				if (_bIsMainObjective && call TREND_bAllowLargerPatrols) then {
					[_sidePos,1000 + (floor random 500),[5,6,7],true,_InsurgentSide] spawn TREND_fnc_BackForthPatrol;
				};
			};
		};

		_chanceOfMortorTeam = .50;
		if (_bIsMainObjective) then {_chanceOfMortorTeam = 1};
		if (_minimission) then {_chanceOfMortorTeam = .15;};
		//Spawn Mortar team
		if (random 1 < _chanceOfMortorTeam || _selectRandomW) then {

			_flatPos = _sidePos;
			_flatPos = [_sidePos , 10, 200, 8, 0, 0.5, 0,[[getMarkerPos "mrkHQ", TREND_BaseAreaRange]],[_sidePos,_sidePos]] call TREND_fnc_findSafePos;
			[_flatPos,  (floor random 300), selectRandom (call sMortarToUse), createGroup _InsurgentSide] call BIS_fnc_spawnVehicle;

			if (TREND_bDebugMode) then {
				_test = nil;
				_test = createMarker [format["MORTARMrk%1%2%3",_flatPos select 0,_flatPos select 1,selectRandom[1,2,3,4,5]], _flatPos];
				_test setMarkerShape "ICON";
				_test setMarkerType "hd_dot";
				_test setMarkerText "MORTAR";
			};
		};

		//Spawn vehicle
		_chanceOfVeh = .50;
		if (_bIsMainObjective) then {_chanceOfVeh = 1};
		if (_minimission) then {_chanceOfVeh = .15;};
		//if main, spawn 1 or two, and also, spawn 2 or three in larger radius
		if (random 1 < _chanceOfVeh || _selectRandomW) then {
			//[format["AAALoc:%1",sTank1ToUse]] call TREND_fnc_notify;
			//sleep 3;

				_flatPos = nil;
				_flatPos = [_sidePos , 10, 200, 8, 0, 0.5, 0,[[getMarkerPos "mrkHQ", TREND_BaseAreaRange]],[[0,0,0],[0,0,0]],(call sTank1ArmedCarToUse)] call TREND_fnc_findSafePos;
				if (_minimission) then {
					[_flatPos,  (floor random 300), (call sTank1ArmedCarToUse), createGroup _InsurgentSide] call BIS_fnc_spawnVehicle;
				}
				else {

					if (_bIsMainObjective && _selectRandomW) then {
						_flatPos = nil;
						_flatPos = [_sidePos , 10, 200, 8, 0, 0.5, 0,[[getMarkerPos "mrkHQ", TREND_BaseAreaRange]],[[0,0,0],[0,0,0]],selectRandom[(call sTank1ArmedCarToUse),(call sTank2APCToUse),(call sTank3TankToUse)]] call TREND_fnc_findSafePos;
						[_flatPos,  (floor random 300), selectRandom[(call sTank1ArmedCarToUse),(call sTank2APCToUse),(call sTank3TankToUse)], createGroup _InsurgentSide] call BIS_fnc_spawnVehicle;
					};
					if (call TREND_bAllowLargerPatrols && _bIsMainObjective && _selectRandomW) then {
						_flatPos = nil;
						_flatPos = [_sidePos , 300, 1000, 8, 0, 0.5, 0,[[getMarkerPos "mrkHQ", TREND_BaseAreaRange]],[[0,0,0],[0,0,0]],selectRandom[(call sTank1ArmedCarToUse),(call sTank2APCToUse),(call sTank3TankToUse)]] call TREND_fnc_findSafePos;
						[_flatPos,  (floor random 300), selectRandom[(call sTank1ArmedCarToUse),(call sTank2APCToUse),(call sTank3TankToUse)], createGroup _InsurgentSide] call BIS_fnc_spawnVehicle;
					};
					if (call TREND_bAllowLargerPatrols && _bIsMainObjective) then {
						_flatPos = nil;
						_flatPos = [_sidePos , 300, 1000, 8, 0, 0.5, 0,[[getMarkerPos "mrkHQ", TREND_BaseAreaRange]],[[0,0,0],[0,0,0]],selectRandom[(call sTank1ArmedCarToUse),(call sTank2APCToUse),(call sTank3TankToUse)]] call TREND_fnc_findSafePos;
						[_flatPos,  (floor random 300), selectRandom[(call sTank1ArmedCarToUse),(call sTank2APCToUse),(call sTank3TankToUse)], createGroup _InsurgentSide] call BIS_fnc_spawnVehicle;

						_flatPos = nil;
						_flatPos = [_sidePos , 300, 1000, 8, 0, 0.5, 0,[[getMarkerPos "mrkHQ", TREND_BaseAreaRange]],[[0,0,0],[0,0,0]],selectRandom[(call sTank1ArmedCarToUse),(call sTank2APCToUse),(call sTank3TankToUse)]] call TREND_fnc_findSafePos;
						[_flatPos,  (floor random 300), selectRandom[(call sTank1ArmedCarToUse),(call sTank2APCToUse),(call sTank3TankToUse)], createGroup _InsurgentSide] call BIS_fnc_spawnVehicle;

					};
				};
				_bHasVehicle = true;

		};
		if (!_minimission) then {
			if (_bIsMainObjective || _selectRandomW) then {
				//[format["AAALoc:%1",sTank1ToUse]] call TREND_fnc_notify;
				//sleep 3;

					_flatPos = nil;
					_flatPos = [_sidePos , 10, 200, 4, 0, 0.5, 0,[[getMarkerPos "mrkHQ", TREND_BaseAreaRange]],[[0,0,0],[0,0,0]],selectRandom[(call sTank1ArmedCarToUse),(call sTank2APCToUse),(call sTank3TankToUse)]] call TREND_fnc_findSafePos;
					_vehOneGroup = nil;
					_vehOneGroup = createGroup _InsurgentSide;
					[_flatPos,  (floor random 300), selectRandom[(call sTank1ArmedCarToUse),(call sTank2APCToUse),(call sTank3TankToUse)], _vehOneGroup] call BIS_fnc_spawnVehicle;
					[_vehOneGroup, _sidePos, 2000 ] call bis_fnc_taskPatrol;
					_vehOneGroup setSpeedMode "LIMITED";

					if (_bIsMainObjective && _selectRandomW) then {
						_flatPos = nil;
						_flatPos = [_sidePos , 10, 200, 4, 0, 0.5, 0,[[getMarkerPos "mrkHQ", TREND_BaseAreaRange]],[[0,0,0],[0,0,0]],selectRandom[(call sTank1ArmedCarToUse),(call sTank2APCToUse),(call sTank3TankToUse)]] call TREND_fnc_findSafePos;
						_vehTwoGroup = nil;
						_vehTwoGroup = createGroup _InsurgentSide;
						[_flatPos,  (floor random 300), selectRandom[(call sTank1ArmedCarToUse),(call sTank2APCToUse),(call sTank3TankToUse)], _vehTwoGroup] call BIS_fnc_spawnVehicle;
						[_vehTwoGroup, _sidePos, 2000 ] call bis_fnc_taskPatrol;
						_vehTwoGroup setSpeedMode "LIMITED";
					};


					_bHasVehicle = true;

			};
		};

		//HERE!!!!!! adding the minimission checks!!!!!



		if (_bIsMainObjective || _selectRandomW) then {
			//[format["AAALoc:%1",sTank1ToUse]] call TREND_fnc_notify;
			//sleep 3;
			if (!_minimission || (_minimission && _selectRandomW)) then {
				_flatPos = nil;
				_flatPos = [_sidePos , 10, 500, 4, 0, 0.5, 0,[[getMarkerPos "mrkHQ", TREND_BaseAreaRange]],[[0,0,0],[0,0,0]],selectRandom (call UnarmedScoutVehicles)] call TREND_fnc_findSafePos;
				_vehScountOneGroup = nil;
				_vehScountOneGroup = createGroup _InsurgentSide;
				[_flatPos,  (floor random 300), selectRandom (call UnarmedScoutVehicles), _vehScountOneGroup] call BIS_fnc_spawnVehicle;
				[_vehScountOneGroup, _sidePos, 3000 ] call bis_fnc_taskPatrol;
				_vehScountOneGroup setSpeedMode "LIMITED";
			};
			if (_bIsMainObjective && _selectRandomW) then {
				_flatPos = nil;
				_flatPos = [_sidePos , 10, 500, 4, 0, 0.5, 0,[[getMarkerPos "mrkHQ", TREND_BaseAreaRange]],[[0,0,0],[0,0,0]],selectRandom (call UnarmedScoutVehicles)] call TREND_fnc_findSafePos;
				_vehScoutTwoGroup = nil;
				_vehScoutTwoGroup = createGroup _InsurgentSide;
				[_flatPos,  (floor random 300), selectRandom (call UnarmedScoutVehicles), _vehScoutTwoGroup] call BIS_fnc_spawnVehicle;
				[_vehScoutTwoGroup, _sidePos, 2000 ] call bis_fnc_taskPatrol;
				_vehScoutTwoGroup setSpeedMode "LIMITED";
			};
			_bHasVehicle = true;

		};

		if (_minimission) then {
			if (_selectRandomW) then {[_sidePos,100,[1,2,3],_InsurgentSide,_bThisMissionCivsOnly] spawn TREND_fnc_OccupyHouses;};
		}
		else {
			//if main then 100% occupie houses, and increase number and range
			[_sidePos,10,[1],_InsurgentSide,_bThisMissionCivsOnly] spawn TREND_fnc_OccupyHouses;
			if (_bIsMainObjective || _selectRandomW) then {
				[_sidePos,200,[1,2,3],_InsurgentSide,_bThisMissionCivsOnly] spawn TREND_fnc_OccupyHouses;
				[_sidePos,500,[4,5,6],_InsurgentSide,_bThisMissionCivsOnly] spawn TREND_fnc_OccupyHouses;
				if (call TREND_bAllowLargerPatrols && _bIsMainObjective) then {
					[_sidePos,1000,[4,5,6],_InsurgentSide,_bThisMissionCivsOnly] spawn TREND_fnc_OccupyHouses;
				};
			}
			else {
				[_sidePos,100,[1,2],_InsurgentSide,_bThisMissionCivsOnly] spawn TREND_fnc_OccupyHouses;
				[_sidePos,1000,[1,2,3,4],_InsurgentSide,_bThisMissionCivsOnly] spawn TREND_fnc_OccupyHouses;
			};
		};


		if (!_minimission || _selectRandomW) then {
		//Spawn nasty surprise (AAA, IEDs, wider patrol)
			if ((_bIsMainObjective && _selectRandomW) || (!_bIsMainObjective && _selectRandomW)) then {
				if ((call sAAAVehMilitia) != "") then {
					_flatPos = nil;
					_flatPos = [_sidePos , 10, 200, 4, 0, 0.5, 0,[[getMarkerPos "mrkHQ", TREND_BaseAreaRange]],[[0,0,0],[0,0,0]],(call sAAAVehToUse)] call TREND_fnc_findSafePos;
					_AAAGroup = createGroup _InsurgentSide;
					[_flatPos,  (floor random 300), (call sAAAVehToUse), _AAAGroup] call BIS_fnc_spawnVehicle;
					{
						_x setskill ["aimingAccuracy",1];
						_x setskill ["aimingShake",1];
						_x setskill ["aimingSpeed",1];
						_x setskill ["spotDistance",1];
						_x setskill ["spotTime",0.7];
						_x setskill ["courage",1];
						_x setskill ["commanding",0.9];
						_x setskill ["general",1];
						_x setskill ["endurance",1.0];
						_x setskill ["reloadSpeed",0.5];
					} forEach units _AAAGroup;
				};
			};
		};


		if (TREND_MainIsHidden || _minimission) then {
			//spawn wide map checkpoints
			_iCount = 5;
			//if (!_bIsMainObjective) then {_iCount = selectRandom [0,1];};
			if (_iCount > 0) then {_dAngleAdustPerLoop = 360 / _iCount;};
			while {_iCount > 0} do {
				_thisAreaRange = 20000;
				_checkPointGuidePos = _sidePos;
				_iCount = _iCount - 1;
				_flatPos = nil;

				_flatPos = [_checkPointGuidePos , 400, _thisAreaRange, 10, 0, 0.2, 0,[[getMarkerPos "mrkHQ", TREND_BaseAreaRange]] + TREND_CheckPointAreas + TREND_SentryAreas,[_checkPointGuidePos,_checkPointGuidePos]] call TREND_fnc_findSafePos;

				if (_flatPos select 0 > 0) then {
					_thisPosAreaOfCheckpoint = _flatPos;
					_thisRoadOnly = false;
					_thisSide = east;
					_thisUnitTypes = [(call sRiflemanToUse), (call sRiflemanToUse),(call sRiflemanToUse),(call sMachineGunManToUse), (call sEngineerToUse), (call sGrenadierToUse), (call sMedicToUse),(call sAAManToUse),(call sATManToUse)];
					_thisAllowBarakade = _selectRandomW;
					_thisIsDirectionAwayFromAO = true;
					[_sidePos,_thisPosAreaOfCheckpoint,_thisAreaRange,_thisRoadOnly,_thisSide,_thisUnitTypes,_thisAllowBarakade,_thisIsDirectionAwayFromAO,false,(call UnarmedScoutVehicles),50] spawn TREND_fnc_setCheckpoint;
				}
			};
		};

		if (_minimission) then {
			//spawn inner random sentrys
			_iCount = 1;
			//if (!_bIsMainObjective) then {_iCount = selectRandom [0,1];};
			if (_iCount > 0) then {_dAngleAdustPerLoop = 360 / _iCount;};
			while {_iCount > 0} do {
				_thisAreaRange = 50;
				_checkPointGuidePos = _sidePos;
				_iCount = _iCount - 1;
				_flatPos = nil;

				_flatPos = [_checkPointGuidePos , 0, 50, 10, 0, 0.2, 0,[[getMarkerPos "mrkHQ", TREND_BaseAreaRange]] + TREND_CheckPointAreas + TREND_SentryAreas,[_checkPointGuidePos,_checkPointGuidePos]] call TREND_fnc_findSafePos;

				if (_flatPos select 0 > 0) then {
					_thisPosAreaOfCheckpoint = _flatPos;
					_thisRoadOnly = false;
					_thisSide = east;
					_thisUnitTypes = [(call sRiflemanToUse), (call sRiflemanToUse),(call sRiflemanToUse),(call sMachineGunManToUse), (call sEngineerToUse), (call sGrenadierToUse), (call sMedicToUse),(call sAAManToUse),(call sATManToUse)];
					_thisAllowBarakade = false;
					_thisIsDirectionAwayFromAO = true;
					[_sidePos,_thisPosAreaOfCheckpoint,_thisAreaRange,_thisRoadOnly,_thisSide,_thisUnitTypes,_thisAllowBarakade,_thisIsDirectionAwayFromAO,false,(call UnarmedScoutVehicles),50] spawn TREND_fnc_setCheckpoint;
				};

				_iCount = selectRandom [0,1];
				if (!_bIsMainObjective) then {_iCount = 1;};
				if (_iCount > 0) then {_dAngleAdustPerLoop = 360 / _iCount;};
				while {_iCount > 0} do {
					_thisAreaRange = 500;
					//_checkPointGuidePos = _sidePos getPos [700, _dAngleAdustPerLoop * (_iCount + 1)];
					_checkPointGuidePos = _sidePos getPos [1250, floor(random 360)];
					_iCount = _iCount - 1;
					_flatPos = nil;
					_flatPos = [_checkPointGuidePos , 0, 500, 10, 0, 0.2, 0,[[getMarkerPos "mrkHQ", TREND_BaseAreaRange]] + TREND_CheckPointAreas + TREND_SentryAreas,[_checkPointGuidePos,_checkPointGuidePos]] call TREND_fnc_findSafePos;
					if (_flatPos select 0 > 0) then {
						_thisPosAreaOfCheckpoint = _flatPos;
						_thisRoadOnly = true;
						_thisSide = west;
						_thisUnitTypes = (call FriendlyCheckpointUnits);
						_thisAllowBarakade = true;
						_thisIsDirectionAwayFromAO = false;
						[_sidePos,_thisPosAreaOfCheckpoint,_thisAreaRange,_thisRoadOnly,_thisSide,_thisUnitTypes,_thisAllowBarakade,_thisIsDirectionAwayFromAO,true,(call FriendlyScoutVehicles),500] spawn TREND_fnc_setCheckpoint;
					};
				};
			};
		}
		else {
			//spawn inner random sentrys
			_iCount = [1,2] select (call TREND_bMoreEnemies);
			//if (!_bIsMainObjective) then {_iCount = selectRandom [0,1];};
			if (_iCount > 0) then {_dAngleAdustPerLoop = 360 / _iCount;};
			while {_iCount > 0} do {
				_thisAreaRange = 50;
				_checkPointGuidePos = _sidePos;
				_iCount = _iCount - 1;
				_flatPos = nil;

				_flatPos = [_checkPointGuidePos , 0, 50, 10, 0, 0.2, 0,[[getMarkerPos "mrkHQ", TREND_BaseAreaRange]] + TREND_CheckPointAreas + TREND_SentryAreas,[_checkPointGuidePos,_checkPointGuidePos]] call TREND_fnc_findSafePos;

				if (_flatPos select 0 > 0) then {
					_thisPosAreaOfCheckpoint = _flatPos;
					_thisRoadOnly = false;
					_thisSide = east;
					_thisUnitTypes = [(call sRiflemanToUse), (call sRiflemanToUse),(call sRiflemanToUse),(call sMachineGunManToUse), (call sEngineerToUse), (call sGrenadierToUse), (call sMedicToUse),(call sAAManToUse),(call sATManToUse)];
					_thisAllowBarakade = false;
					_thisIsDirectionAwayFromAO = true;
					[_sidePos,_thisPosAreaOfCheckpoint,_thisAreaRange,_thisRoadOnly,_thisSide,_thisUnitTypes,_thisAllowBarakade,_thisIsDirectionAwayFromAO,false,(call UnarmedScoutVehicles),50] spawn TREND_fnc_setCheckpoint;
				}
			};

			//spawn inner checkpoints
			_iCount = [1,2] select (call TREND_bMoreEnemies);
			if (!_bIsMainObjective) then {_iCount = selectRandom [0,1,1];};
			if ((!_bIsMainObjective && !_bHasPatrols) || _selectRandomW) then {_iCount = selectRandom [1,1,2];};
			if (_iCount > 0) then {_dAngleAdustPerLoop = 360 / _iCount;};
			while {_iCount > 0} do {
				_thisAreaRange = 50;
				_checkPointGuidePos = _sidePos;
				_iCount = _iCount - 1;
				_flatPos = nil;
				_flatPos = [_checkPointGuidePos , 0, 50, 10, 0, 0.2, 0,[[getMarkerPos "mrkHQ", TREND_BaseAreaRange]] + TREND_CheckPointAreas + TREND_SentryAreas,[_checkPointGuidePos,_checkPointGuidePos]] call TREND_fnc_findSafePos;
				if (_flatPos select 0 > 0) then {
					_thisPosAreaOfCheckpoint = _flatPos;
					_thisRoadOnly = true;
					_thisSide = east;
					_thisUnitTypes = [(call sRiflemanToUse), (call sRiflemanToUse),(call sRiflemanToUse),(call sMachineGunManToUse), (call sEngineerToUse), (call sGrenadierToUse), (call sMedicToUse),(call sAAManToUse),(call sATManToUse)];
					_thisAllowBarakade = true;
					_thisIsDirectionAwayFromAO = true;
					[_sidePos,_thisPosAreaOfCheckpoint,_thisAreaRange,_thisRoadOnly,_thisSide,_thisUnitTypes,_thisAllowBarakade,_thisIsDirectionAwayFromAO,true,(call UnarmedScoutVehicles),100] spawn TREND_fnc_setCheckpoint;
				}
			};

			//spawn outer but close surrunding checkpoints
			_iCount = [2,3] select (call TREND_bMoreEnemies);
			if (!_bIsMainObjective) then {_iCount = selectRandom ([[0,1], [1,2]] select (call TREND_bMoreEnemies));};
			if ((!_bIsMainObjective && !_bHasPatrols) || _selectRandomW) then {_iCount = selectRandom [0,1,2];};
			if (_iCount > 0) then {_dAngleAdustPerLoop = 360 / _iCount;};
			while {_iCount > 0} do {
				_thisAreaRange = 75;
				//_checkPointGuidePos = _sidePos getPos [250, _dAngleAdustPerLoop * (_iCount + 1)];
				_checkPointGuidePos = _sidePos getPos [250, floor(random 360)];
				_iCount = _iCount - 1;
				_flatPos = nil;
				_flatPos = [_checkPointGuidePos , 0, 75, 10, 0, 0.2, 0,[[getMarkerPos "mrkHQ", TREND_BaseAreaRange]] + TREND_CheckPointAreas + TREND_SentryAreas,[_checkPointGuidePos,_checkPointGuidePos]] call TREND_fnc_findSafePos;
				if (_flatPos select 0 > 0) then {
					_thisPosAreaOfCheckpoint = _flatPos;
					_thisRoadOnly = true;
					_thisSide = east;
					_thisUnitTypes = [(call sRiflemanToUse), (call sRiflemanToUse),(call sRiflemanToUse),(call sMachineGunManToUse), (call sEngineerToUse), (call sGrenadierToUse), (call sMedicToUse),(call sAAManToUse),(call sATManToUse)];
					_thisAllowBarakade = true;
					_thisIsDirectionAwayFromAO = true;
					[_sidePos,_thisPosAreaOfCheckpoint,_thisAreaRange,_thisRoadOnly,_thisSide,_thisUnitTypes,_thisAllowBarakade,_thisIsDirectionAwayFromAO,true,(call UnarmedScoutVehicles),300] spawn TREND_fnc_setCheckpoint;
				}
			};

			//spawn outer far checkpoints
			_iCount = [2,3] select (call TREND_bMoreEnemies);
			if (!_bIsMainObjective) then {_iCount = selectRandom ([[0,1], [1,2]] select (call TREND_bMoreEnemies));};
			if ((!_bIsMainObjective && !_bHasPatrols) || _selectRandomW) then {_iCount = selectRandom [[1,2], [2,3]] select (call TREND_bMoreEnemies);};
			if (_iCount > 0) then {_dAngleAdustPerLoop = 360 / _iCount;};
			while {_iCount > 0} do {
				_thisAreaRange = 250;
				//_checkPointGuidePos = _sidePos getPos [1000, _dAngleAdustPerLoop * (_iCount + 1)];
				_checkPointGuidePos = _sidePos getPos [1000, floor(random 360)];
				_iCount = _iCount - 1;
				_flatPos = nil;
				_flatPos = [_checkPointGuidePos , 0, 250, 10, 0, 0.2, 0,[[getMarkerPos "mrkHQ", TREND_BaseAreaRange]] + TREND_CheckPointAreas + TREND_SentryAreas,[_checkPointGuidePos,_checkPointGuidePos]] call TREND_fnc_findSafePos;
				if (_flatPos select 0 > 0) then {
					_thisPosAreaOfCheckpoint = _flatPos;
					_thisRoadOnly = true;
					_thisSide = east;
					_thisUnitTypes = [(call sRiflemanToUse), (call sRiflemanToUse),(call sRiflemanToUse),(call sMachineGunManToUse), (call sEngineerToUse), (call sGrenadierToUse), (call sMedicToUse),(call sAAManToUse),(call sATManToUse)];
					_thisAllowBarakade = true;
					_thisIsDirectionAwayFromAO = true;
					[_sidePos,_thisPosAreaOfCheckpoint,_thisAreaRange,_thisRoadOnly,_thisSide,_thisUnitTypes,_thisAllowBarakade,_thisIsDirectionAwayFromAO,true,(call UnarmedScoutVehicles),500] spawn TREND_fnc_setCheckpoint;
				}
			};

			//spawn outer far sentrys
			_iCount = [1,2] select (call TREND_bMoreEnemies);
			if (!_bIsMainObjective) then {_iCount = selectRandom ([[0,1], [1,2]] select (call TREND_bMoreEnemies));};
			if ((!_bIsMainObjective && !_bHasPatrols) || _selectRandomW) then {_iCount = selectRandom [[1,2], [2,3]] select (call TREND_bMoreEnemies);};
			if (_iCount > 0) then {_dAngleAdustPerLoop = 360 / _iCount;};
			while {_iCount > 0} do {
				_thisAreaRange = 250;
				//_checkPointGuidePos = _sidePos getPos [1000, _dAngleAdustPerLoop * (_iCount + 1)];
				_checkPointGuidePos = _sidePos getPos [1200, floor(random 360)];
				_iCount = _iCount - 1;
				_flatPos = nil;
				_flatPos = [_checkPointGuidePos , 0, 250, 10, 0, 0.2, 0,[[getMarkerPos "mrkHQ", TREND_BaseAreaRange]] + TREND_CheckPointAreas + TREND_SentryAreas,[_checkPointGuidePos,_checkPointGuidePos]] call TREND_fnc_findSafePos;
				if (_flatPos select 0 > 0) then {
					_thisPosAreaOfCheckpoint = _flatPos;
					_thisRoadOnly = false;
					_thisSide = east;
					_thisUnitTypes = [(call sRiflemanToUse), (call sRiflemanToUse),(call sRiflemanToUse),(call sMachineGunManToUse), (call sEngineerToUse), (call sGrenadierToUse), (call sMedicToUse),(call sAAManToUse),(call sATManToUse)];
					_thisAllowBarakade = false;
					_thisIsDirectionAwayFromAO = true;
					[_sidePos,_thisPosAreaOfCheckpoint,_thisAreaRange,_thisRoadOnly,_thisSide,_thisUnitTypes,_thisAllowBarakade,_thisIsDirectionAwayFromAO,false,(call UnarmedScoutVehicles),500] spawn TREND_fnc_setCheckpoint;
				}
			};


			//future update... player faction here, or frienly rebels
			//spawn outer nearish friendly checkpoint
			_iCount = selectRandom ([[1,2], [2,3]] select (call TREND_bMoreEnemies));
			if (!_bIsMainObjective || _selectRandomW) then {_iCount = [1,2] select (call TREND_bMoreEnemies);};
			if (_iCount > 0) then {_dAngleAdustPerLoop = 360 / _iCount;};
			while {_iCount > 0} do {
				_thisAreaRange = 500;
				//_checkPointGuidePos = _sidePos getPos [700, _dAngleAdustPerLoop * (_iCount + 1)];
				_checkPointGuidePos = _sidePos getPos [1250, floor(random 360)];
				_iCount = _iCount - 1;
				_flatPos = nil;
				_flatPos = [_checkPointGuidePos , 0, 500, 10, 0, 0.2, 0,[[getMarkerPos "mrkHQ", TREND_BaseAreaRange]] + TREND_CheckPointAreas + TREND_SentryAreas,[_checkPointGuidePos,_checkPointGuidePos]] call TREND_fnc_findSafePos;
				if (_flatPos select 0 > 0) then {
					_thisPosAreaOfCheckpoint = _flatPos;
					_thisRoadOnly = true;
					_thisSide = west;
					_thisUnitTypes = (call FriendlyCheckpointUnits);
					_thisAllowBarakade = true;
					_thisIsDirectionAwayFromAO = false;
					[_sidePos,_thisPosAreaOfCheckpoint,_thisAreaRange,_thisRoadOnly,_thisSide,_thisUnitTypes,_thisAllowBarakade,_thisIsDirectionAwayFromAO,true,(call FriendlyScoutVehicles),500] spawn TREND_fnc_setCheckpoint;
				};
			};
		};

		//Spawn Mil occupy units
		_MilSearchDistFromCent = 3000;
		//occupy miletary building
		_allMilBuildings = nearestObjects [_sidePos, TREND_MilBuildings, _MilSearchDistFromCent];
		_iCount = 0;
		_milOccupyOdds = [true,false,false];
		if (_bIsMainObjective) then {
			_milOccupyOdds = [true,false];
		};
		if (_selectRandomW) then {
			_milOccupyOdds = [true];
		};
		if (count _allMilBuildings > 0) then {

			{
				_thisMilBuilPos = getPos _x;
				_distanceFromBase = getMarkerPos "mrkHQ" distance getPos _x;
				if (SelectRandom _milOccupyOdds && _distanceFromBase > TREND_BaseAreaRange && !(_thisMilBuilPos in TREND_OccupiedHousesPos)) then {
				//if (SelectRandom _milOccupyOdds && _distanceFromBase > TREND_BaseAreaRange) then {
					_iCount = _iCount + 1;
					_MilGroup1 = nil;
					_objMilUnit1 = nil;
					_objMilUnit2 = nil;
					_objMilUnit3 = nil;
					_MilGroup1 = createGroup east;
					_objMilUnit1 = _MilGroup1 createUnit [selectRandom[(call sRiflemanToUse),(call sMachineGunManToUse)],[-1000,0,0],[],0,"NONE"];
					_objMilUnit2 = _MilGroup1 createUnit [selectRandom[(call sRiflemanToUse),(call sMachineGunManToUse)],[-1002,0,0],[],0,"NONE"];
					_objMilUnit3 = _MilGroup1 createUnit [selectRandom[(call sRiflemanToUse),(call sMachineGunManToUse)],[-1003,0,0],[],0,"NONE"];
					TREND_OccupiedHousesPos = TREND_OccupiedHousesPos + [_thisMilBuilPos];
					[getPos _x, [_objMilUnit1,_objMilUnit2,_objMilUnit3], -1, true, false,true] spawn TREND_fnc_Zen_OccupyHouse;
					sleep 0.2;
					_objMilUnit1 setUnitPos "up";
					_objMilUnit2 setUnitPos "up";
					_objMilUnit3 setUnitPos "up";
					{deleteVehicle _x} forEach nearestObjects [[-1000,0,0], ["all"], 100];

					_ParkedCar = nil;
					if (_selectRandomW) then {
						_flatPos = nil;
						_flatPos = [getpos _x , 0, 20, 10, 0, 0.5, 0,[[getMarkerPos "mrkHQ", TREND_BaseAreaRange]],[getpos _x,getpos _x],selectRandom (call UnarmedScoutVehicles)] call TREND_fnc_findSafePos;
						_ParkedCar = selectRandom (call UnarmedScoutVehicles) createVehicle _flatPos;
						_ParkedCar setDir (floor(random 360));
					};

					if (_selectRandomW) then {
						_MilGroup4 = createGroup east;
						_sCheckpointGuyName = format["objMilGuyName%1",(floor(random 999999))];
						_pos5 = [getpos _x , 0, 30, 5, 0, 0.5, 0,[[getMarkerPos "mrkHQ", TREND_BaseAreaRange]],[getpos _x,getpos _x]] call TREND_fnc_findSafePos;
						_guardUnit5 = _MilGroup4 createUnit [(call sRiflemanToUse),_pos5,[],0,"NONE"];
						_guardUnit5 setVariable [_sCheckpointGuyName, _guardUnit5, true];
						missionNamespace setVariable [_sCheckpointGuyName, _guardUnit5];
						TREND_fnc_WalkingGuyLoop = {
							_objManName = _this select 0;
							_thisInitPos = _this select 1;
							_objMan = missionNamespace getVariable _objManName;

							group _objMan setSpeedMode "LIMITED";
							group _objMan setBehaviour "SAFE";

							while {alive(_objMan) && {behaviour _objMan == "SAFE"}} do {
								[_objManName,_thisInitPos,_objMan,35] spawn TREND_fnc_HVTWalkAround;
								sleep 2;
								waitUntil {sleep 1; speed _objMan < 0.5};
								sleep 10;
							};
						};
						[_sCheckpointGuyName,_pos5] spawn TREND_fnc_WalkingGuyLoop;
					};
					//because we have a base, we see if a helipad is aviable for an attack chopper
					_HeliPads = nearestObjects [getPos _x, ["Land_HelipadCircle_F","Land_HelipadSquare_F"], 200];
					if (count _HeliPads > 0 && !TREND_bBaseHasChopper && _selectRandomW) then {
						TREND_baseHeliPad =  selectRandom _HeliPads; publicVariable "TREND_baseHeliPad";
						TREND_bBaseHasChopper =  true; publicVariable "TREND_bBaseHasChopper";
						_BaseChopperGroup = createGroup TREND_EnemySide;
						_EnemyBaseChopper = selectRandom (call EnemyBaseChoppers) createVehicle getPosATL TREND_baseHeliPad;
						_EnemyBaseChopper setDir direction TREND_baseHeliPad;
						(call sEnemyHeliPilotToUse) createUnit [[(getPos TREND_baseHeliPad select 0)+10,(getPos TREND_baseHeliPad select 1)+10], _BaseChopperGroup];
						(call sEnemyHeliPilotToUse) createUnit [[(getPos TREND_baseHeliPad select 0)+11,(getPos TREND_baseHeliPad select 1)+10], _BaseChopperGroup];
						{
							[_x,"STAND","ASIS"] call BIS_fnc_ambientAnimCombat;
						} forEach units _BaseChopperGroup;

						//EnemyBaseChopperPilot = getNEAREST (call sEnemyHeliPilot) to chopper
						_EnemyBaseChopperPilots = nearestObjects [getPos TREND_baseHeliPad, [(call sEnemyHeliPilotToUse)], 250];
						TREND_EnemyBaseChopperPilot =  _EnemyBaseChopperPilots select 0; publicVariable "TREND_EnemyBaseChopperPilot";
						// _BaseChopperGroup

					};
				};
				if (_iCount > 10) exitWith {};
			} forEach _allMilBuildings;

		};

	}
	else { //else if _bThisMissionCivsOnly
		//spawn inner checkpoints
		_iCount = selectRandom ([[0,0,0,0,1], [1,1,1,1,2]] select (call TREND_bMoreEnemies));
		//if (!_bIsMainObjective) then {_iCount = selectRandom [0,1];};
		if (_iCount > 0) then {_dAngleAdustPerLoop = 360 / _iCount;};
		while {_iCount > 0} do {
			_thisAreaRange = 50;
			_checkPointGuidePos = _sidePos;
			_iCount = _iCount - 1;
			_flatPos = nil;
			_flatPos = [_checkPointGuidePos , 0, 50, 10, 0, 0.2, 0,[[getMarkerPos "mrkHQ", TREND_BaseAreaRange]] + TREND_CheckPointAreas + TREND_SentryAreas,[_checkPointGuidePos,_checkPointGuidePos]] call TREND_fnc_findSafePos;
			if (_flatPos select 0 > 0) then {
				_thisPosAreaOfCheckpoint = _flatPos;
				_thisRoadOnly = true;
				_thisSide = east;
				_thisUnitTypes = [(call sRiflemanToUse), (call sRiflemanToUse),(call sRiflemanToUse),(call sMachineGunManToUse), (call sEngineerToUse), (call sGrenadierToUse), (call sMedicToUse),(call sAAManToUse),(call sATManToUse)];
				_thisAllowBarakade = true;
				_thisIsDirectionAwayFromAO = true;
				[_sidePos,_thisPosAreaOfCheckpoint,_thisAreaRange,_thisRoadOnly,_thisSide,_thisUnitTypes,_thisAllowBarakade,_thisIsDirectionAwayFromAO,true,(call UnarmedScoutVehicles),100] spawn TREND_fnc_setCheckpoint;
			};
		};
		//spawn inner sentry
		_iCount = selectRandom ([[0,0,0,0,1], [1,1,1,1,2]] select (call TREND_bMoreEnemies));
		//if (!_bIsMainObjective) then {_iCount = selectRandom [0,1];};
		if (_iCount > 0) then {_dAngleAdustPerLoop = 360 / _iCount;};
		while {_iCount > 0} do {
			_thisAreaRange = 50;
			_checkPointGuidePos = _sidePos;
			_iCount = _iCount - 1;
			_flatPos = nil;
			_flatPos = [_checkPointGuidePos , 0, 50, 10, 0, 0.2, 0,[[getMarkerPos "mrkHQ", TREND_BaseAreaRange]] + TREND_CheckPointAreas + TREND_SentryAreas,[_checkPointGuidePos,_checkPointGuidePos]] call TREND_fnc_findSafePos;
			if (_flatPos select 0 > 0) then {
				_thisPosAreaOfCheckpoint = _flatPos;
				_thisRoadOnly = false;
				_thisSide = east;
				_thisUnitTypes = [(call sRiflemanToUse), (call sRiflemanToUse),(call sRiflemanToUse),(call sMachineGunManToUse), (call sEngineerToUse), (call sGrenadierToUse), (call sMedicToUse),(call sAAManToUse),(call sATManToUse)];
				_thisAllowBarakade = false;
				_thisIsDirectionAwayFromAO = true;
				[_sidePos,_thisPosAreaOfCheckpoint,_thisAreaRange,_thisRoadOnly,_thisSide,_thisUnitTypes,_thisAllowBarakade,_thisIsDirectionAwayFromAO,true,(call UnarmedScoutVehicles),100] spawn TREND_fnc_setCheckpoint;
			};
		};

	};

}
else {

	[_sidePos,200,true] spawn TREND_fnc_SpawnCivs; //3rd param of true says these are rebels and function will set rebels instead of civs

	_lapPos = _sidePos getPos [50, 180];
	_markerFriendlyRebs = createMarker [format["mrkFriendlyRebs%1",_iTaskIndex], _lapPos];
	_markerFriendlyRebs setMarkerShape "ICON";
	_markerFriendlyRebs setMarkerType "hd_dot";
	_markerFriendlyRebs setMarkerText (localize "STR_TRGM2_trendFunctions_OccupiedByFriendRebel");
};
//orangestest*/
if (_selectRandomW) then {
	_iAnimalCount = 0;
	_flatPosInside = nil;
	_flatPosInside = [_sidePos , 0, 100, 4, 0, 0.5, 0,[[getMarkerPos "mrkHQ", TREND_BaseAreaRange]],[_sidePos,[0,0,0]]] call BIS_fnc_findSafePos;
	while {_iAnimalCount < 4} do {
		_iAnimalCount = _iAnimalCount + 1;
		_myDog1 = nil;
		_myDog1 = createAgent ["Fin_random_F", _flatPosInside, [], 50, "NONE"];
		sleep 0.1;
		_myDog1 playMove "Dog_Sit";
	};
};

if (_selectRandomW) then {
	_iAnimalCount = 0;
	_flatPosInside2 = nil;
	_flatPosInside2 = [_sidePos , 0, 100, 4, 0, 0.5, 0,[[getMarkerPos "mrkHQ", TREND_BaseAreaRange]],[_sidePos,[0,0,0]]] call BIS_fnc_findSafePos;
	while {_iAnimalCount < 8} do {
		_iAnimalCount = _iAnimalCount + 1;
		_myGoat1 = nil;
		_myGoat1 = createAgent ["Goat_random_F", _flatPosInside2, [], 5, "NONE"];
		sleep 0.1;
		_myGoat1 playMove "Goat_Walk";
	};
};

if (_selectRandomW) then {
	_iAnimalCount = 0;
	_flatPosOutSide2 = nil;
	_flatPosInside2 = [_sidePos , 500, 1500, 4, 0, 0.5, 0,[[getMarkerPos "mrkHQ", TREND_BaseAreaRange]],[_sidePos,[0,0,0]]] call BIS_fnc_findSafePos;
	while {_iAnimalCount < 8} do {
		_iAnimalCount = _iAnimalCount + 1;
		_myGoat2 = nil;
		_myGoat2 = createAgent ["Goat_random_F", _flatPosInside2, [], 5, "NONE"];
		sleep 0.1;
		_myGoat2 playMove "Goat_Stop";
	};
};



//Spawn IED
if (_selectRandomW) then {

	_iCount = 0;
	_low = 2;
	_high = 9;
	_LoopMax = selectRandom [_low,_low,_low,_high]; //zero based
	_IEDCount = 0;
	_bHightlightIEDTests = false;
	//will only ever be three IEDs but if 10 is loop then we will have random rubble to confuse player
	while {_iCount <= _LoopMax} do
	{

		_flatPos = nil;
		_flatPos = [_sidePos , 10, 80, 4, 0, 0.5, 0,[[getMarkerPos "mrkHQ", TREND_BaseAreaRange]],[[0,0,0],[0,0,0]],selectRandom TREND_IEDClassNames] call TREND_fnc_findSafePos;
		if (_IEDCount <= 2) then {
			_objIED1 = selectRandom TREND_IEDClassNames createVehicle _flatPos;
			_IEDCount = _IEDCount + 1;
		};
		//if (random 1 < .25 || _LoopMax == _high) then {
		//	_objIED1b = selectRandom TREND_IEDFakeClassNames createVehicle _flatPos;
		//	_objIED1b setPos _flatPos;
		//};

		if (_bHightlightIEDTests) then {
			_test = nil;
			_test = createMarker [format["IEDMrk%1%2%3",_inf1X,_inf1Y,_iCount], _flatPos];
			_test setMarkerShape "ICON";
			_test setMarkerType "hd_dot";
			_test setMarkerText "IED";
		};

		_iCount = _iCount + 1;
	};

};


if (_selectRandomW || _bThisMissionCivsOnly) then {
	TREND_debugMessages = TREND_debugMessages + format["\n\ntrendFunctions.sqf - Populate Civs : _bFriendlyInsurgents: %1 - _bThisMissionCivsOnly: %2 ",str(_bFriendlyInsurgents),str(_bThisMissionCivsOnly)];
	[_sidePos,200,false] spawn TREND_fnc_SpawnCivs;
};


//Spawn AT Mine on road if not vehicles and hack data mission
if (_sideType == 1 && random 1 < .50) then {

	_nearestRoad = [[_inf1X,_inf1Y], 100, []] call BIS_fnc_nearestRoad;
	if (isNil "_nearestRoad") then {
		//_bInfor1Found = false;
	}
	else {
		_roadConnectedTo = roadsConnectedTo _nearestRoad;
		if (count _roadConnectedTo > 0) then {
			_objAT = nil;
			_objAT = selectRandom TREND_ATMinesClassNames createVehicle getPosATL _nearestRoad;

			//_test = nil;
			//_test = createMarker [format["ATMrk%1%2%3",_inf1X,_inf1Y,_iCount], getPosATL _nearestRoad];
			//_test setMarkerShape "ICON";
			//_test setMarkerType "hd_dot";
			//_test setMarkerText "AT MINE";

		}
		else {
			_bInfor1Found = false;
		};
	};

};

true;