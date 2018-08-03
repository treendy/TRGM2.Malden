#include "../../setUnitGlobalVars.sqf";
bDebugging = false;

sTeamleaderToUse = sTeamleader;
sRiflemanToUse = sRifleman;
sTank1ArmedCarToUse = sTank1ArmedCar;
sTank2APCToUse = sTank2APC;
sTank3TankToUse = sTank3Tank;
sAAAVehToUse = sAAAVeh;
sAmmobearerToUse = sAmmobearer;
sGrenadierToUse = sGrenadier;
sMedicToUse = sMedic;
sAAManToUse = sAAMan;
sATManToUse = sATMan;
sMortarToUse = sMortar;
sMachineGunManToUse = sMachineGunMan;



bThisMissionCivsOnly = false;



TREND_fnc_PopulateSideMission = {
	_sidePos = _this select 0;
	_sideType = _this select 1;
	_sideMainBuilding = _this select 2;
	_bIsMainObjective = _this select 3;
	_iSideIndex = _this select 4;
	_allowFriendlyIns = _this select 5;
	_ForceCivsOnly = _this select 6; //default is false

	if (isNil "OccupiedHousesPos") then {OccupiedHousesPos = []};
	if (isNil ("_ForceCivsOnly")) then {_ForceCivsOnly = false};

	_dAngleAdustPerLoop = 0;
	_bHasVehicle = false;

	AODetails pushBack [_iSideIndex,0,0,0,false,0,0];
	publicVariable "AODetails";


	//_bFriendlyInsurgents = true;
	_bFriendlyInsurgents = selectRandom bFriendlyInsurgents;

	_InsurgentSide = east;
	if (_bFriendlyInsurgents) then {_InsurgentSide = west;};
	if (_bIsMainObjective) then {_InsurgentSide = east; _bFriendlyInsurgents = false;}; //if main need to make sure not friendly insurgents



	bThisMissionCivsOnly = selectRandom bCivsOnly;
	_bTownBigenoughForFriendlyInsurgants = true;
	_allBuildingsNearAO = nearestObjects [_sidePos, BasicBuildings, 100];
	_allBuildingsNearAOCount = count _allBuildingsNearAO;
	if (_allBuildingsNearAOCount <= iBuildingCountToAllowCivsAndFriendlyInformants) then {
		bThisMissionCivsOnly = false;
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

	if (_bIsMainObjective) then {bThisMissionCivsOnly = false};

	if (_ForceCivsOnly) then {bThisMissionCivsOnly = true};

	if (!_bFriendlyInsurgents) then {
		if (!bThisMissionCivsOnly) then {
			//insert warlord
			_flatPos = nil;
			_flatPos = [_sidePos , 10, 40, 4, 0, 0.5, 0,[],[_sidePos,[0,0,0]]] call BIS_fnc_findSafePos;
			//sWarloadSideMission createUnit [_flatPos, createGroup east, " this switchMove ""Acts_listeningToRadio_loop"" "];
		};
	}
	else {
		ClearedPositions pushBack [_sidePos];
  		publicVariable "ClearedPositions";
	};

	if ((_sideType == 7 || _sideType == 5) && _bFriendlyInsurgents) then { //if mission is kill officer or kill officer and in fridnldy area then make him prisoner
		sOfficerName = format["objInformant%1",_iSideIndex];
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
		sInformantName = format["objInformant%1",_iSideIndex];
		_InformantObject = missionNamespace getVariable [sInformantName , objNull];
		_InformantObject setVariable ["StopWalkScript", true];
		//_sideMainBuilding
		_allpositionsMainBuiding = _sideMainBuilding buildingPos -1;
		_InformantObject setPosATL (selectRandom _allpositionsMainBuiding);
	};

	//if (selectRandom [true]) then {
	if (selectRandom [true,false,false,false,false] && !bThisMissionCivsOnly) then {
		//"test_EmptyObjectForFireBig" createVehicle position board2;
		_fireRootx = getPos _sideMainBuilding select 0;
		_fireRooty = getPos _sideMainBuilding select 1;

		_firePos1 = [_fireRootx+5+(floor random 15),_fireRooty+5+(floor random 15)];
		_objFlame1 = "test_EmptyObjectForFireBig" createVehicle _firePos1;
		if (isOnRoad _firePos1) then {selectRandom WreckCarClasses createVehicle getPos _objFlame1;};

		if (selectRandom [true,false,false]) then {
			_firePos2 = [_fireRootx-5-(floor random 15),_fireRooty-5-(floor random 15)];
			_objFlame2 = "test_EmptyObjectForFireBig" createVehicle _firePos2;
			if (isOnRoad _firePos2) then {selectRandom WreckCarClasses createVehicle getPos _objFlame2;};
		};

		if (selectRandom [true,false,false]) then {
			_firePos3 = [_fireRootx+5+(floor random 15),_fireRooty-5-(floor random 15)];
			_objFlame3 = "test_EmptyObjectForFireBig" createVehicle _firePos3;
			if (isOnRoad _firePos3) then {selectRandom WreckCarClasses createVehicle getPos _objFlame3;};

		};
		if (selectRandom [true,false,false]) then {
			_firePos4 = [_fireRootx-5-(floor random 15),_fireRooty+5+(floor random 15)];
			_objFlame4 = "test_EmptyObjectForFireBig" createVehicle _firePos4;
			if (isOnRoad _firePos4) then {selectRandom WreckCarClasses createVehicle getPos _objFlame4;};
		};
	};

	//if main var to set friendly insurg and also, if our random selction above plus 50/50 chance is true, then the units will be dressed as insurgents (player will not know if friendly of enemy)
	if ((bThisMissionCivsOnly || (!_bIsMainObjective && selectRandom[true,false]))) then {
		sTeamleaderToUse = sTeamleaderMilitia;
		sRiflemanToUse = sRiflemanMilitia;
		sTank1ArmedCarToUse = sTank1ArmedCarMilitia;
		sTank2APCToUse = sTank2APCMilitia;
		sTank3TankToUse = sTank3TankMilitia;
		sAAAVehToUse = sAAAVehMilitia;
		sAmmobearerToUse = sAmmobearerMilitia;
		sGrenadierToUse = sGrenadierMilitia;
		sMedicToUse = sMedicMilitia;
		sAAManToUse = sAAManMilitia;
		sATManToUse = sATManMilitia;
		sMortarToUse = sMortarMilitia;
		sMachineGunManToUse = sMachineGunManMilitia;
	};

	sideAllBuildingPos = _sideMainBuilding buildingPos -1;
	_inf1X = _sidePos select 0;
	_inf1Y = _sidePos select 1;

	_trgCustomAIScript = nil;
	_trgCustomAIScript = createTrigger ["EmptyDetector", _sidePos];
	_trgCustomAIScript setVariable ["DelMeOnNewCampaignDay",true];
	_trgCustomAIScript setTriggerArea [1250, 1250, 0, false];
	_trgCustomAIScript setTriggerActivation [FriendlySideString, format["%1 D", EnemySideString], true];
	_trgCustomAIScript setTriggerStatements ["this && SpottedActiveFinished", format["nul = [this, thisList, %1, %2, %3] execVM ""RandFramework\RandScript\TREND_fnc_CallNearbyPatrol.sqf"";",str(_sidePos),_iSideIndex, _bIsMainObjective], ""];
	//AODetails [_iSideIndex,0,0,0,false,0]
	//AODetails select

	debugMessages = debugMessages + format["\n\ntrendFunctions.sqf : _bFriendlyInsurgents: %1 - bThisMissionCivsOnly: %2 ",str(_bFriendlyInsurgents),str(bThisMissionCivsOnly)];

	if (!_bFriendlyInsurgents) then {
		if (!bThisMissionCivsOnly) then {
			

			debugMessages = debugMessages + format["\n\ntrendFunctions.sqf : inside populate enemy -  _bFriendlyInsurgents: %1 - bThisMissionCivsOnly: %2 ",str(_bFriendlyInsurgents),str(bThisMissionCivsOnly)];
			//Spawn patrol
			//if main need a couple of these and always have 2 or 3

			_bHasPatrols = false;
			if (_bIsMainObjective) then {_bHasPatrols = true};

			if (_bIsMainObjective) then {

				[_sidePos,15 + (floor random 150),[2,3],false,_InsurgentSide] spawn TREND_fnc_RadiusPatrol;
				if (bAllowLargerPatrols && _bIsMainObjective) then {
					[_sidePos,15 + (floor random 150),[2,3],false,_InsurgentSide] spawn TREND_fnc_RadiusPatrol;
				};
			};
			if (selectRandom [true,false]) then {
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
				if (selectRandom [true,false]) then {
					[_sidePos,500 + (floor random 250),[4,5,6],true,_InsurgentSide] spawn TREND_fnc_RadiusPatrol;
					_bHasPatrols = true
				};
			};

			if (_bIsMainObjective && selectRandom [true,true,false]) then {
				//[_sidePos,500 + (floor random 250),[7,8,9,10],true,_InsurgentSide] spawn TREND_fnc_RadiusPatrol;
				if (bAllowLargerPatrols && _bIsMainObjective) then {
					//[_sidePos,700 + (floor random 250),[7,8,9,10],true,_InsurgentSide] spawn TREND_fnc_RadiusPatrol;
					[_sidePos,900 + (floor random 250),[7,8,9,10],true,_InsurgentSide] spawn TREND_fnc_RadiusPatrol;
				};
			};



			//Spawn patrol to move from building to building
			if (_bIsMainObjective || (selectRandom [true,false])) then {
				[_sidePos,1000 + (floor random 500),[3,4,5],true,_InsurgentSide, 10] spawn TREND_fnc_BuildingPatrol;
				_bHasPatrols = true
			};
			if (_bIsMainObjective && bAllowLargerPatrols) then {
				[_sidePos,1000 + (floor random 500),[3,4,5],true,_InsurgentSide, 10] spawn TREND_fnc_BuildingPatrol;
			};

			//Spawn distant patrol ready to move in (will need to spawn trigger)
			if (_bIsMainObjective || (selectRandom [true,false])) then {
				[_sidePos,1000 + (floor random 500),[5,6],true,_InsurgentSide] spawn TREND_fnc_BackForthPatrol;
				_bHasPatrols = true
			};
			if (_bIsMainObjective && bAllowLargerPatrols) then {
				[_sidePos,1000 + (floor random 500),[5,6,7],true,_InsurgentSide] spawn TREND_fnc_BackForthPatrol;
			};

			//Spawn Mortar team
			if (_bIsMainObjective || (selectRandom [true,false])) then {
				_flatPos = nil;
				_flatPos = [_sidePos , 10, 200, 8, 0, 0.5, 0,[[getMarkerPos "mrkHQ", BaseAreaRange]],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
				//[_flatPos,  (floor random 300), selectRandom[sMortarToUse], createGroup _InsurgentSide] call bis_fnc_spawnvehicle;
				[_flatPos,  (floor random 300), selectRandom sMortarToUse, createGroup _InsurgentSide] call bis_fnc_spawnvehicle;

				if (bDebugMode) then {
					_test = nil;
					_test = createMarker [format["MORTARMrk%1%2%3",_flatPos select 0,_flatPos select 1,selectRandom[1,2,3,4,5]], _flatPos];
					_test setMarkerShape "ICON";
					_test setMarkerType "hd_dot";
					_test setMarkerText "MORTAR";
				};
			};

			//Spawn vehicle
			//if main, spawn 1 or two, and also, spawn 2 or three in larger radius
			if (_bIsMainObjective || (selectRandom [true,false])) then {
				//hint format["AAALoc:%1",sTank1ToUse];
				//sleep 3;

					_flatPos = nil;
					_flatPos = [_sidePos , 10, 200, 8, 0, 0.5, 0,[[getMarkerPos "mrkHQ", BaseAreaRange]],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
					[_flatPos,  (floor random 300), selectRandom[sTank1ArmedCarToUse,sTank2APCToUse,sTank3TankToUse], createGroup _InsurgentSide] call bis_fnc_spawnvehicle;
					if (_bIsMainObjective && selectRandom [true,false]) then {
						_flatPos = nil;
						_flatPos = [_sidePos , 10, 200, 8, 0, 0.5, 0,[[getMarkerPos "mrkHQ", BaseAreaRange]],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
						[_flatPos,  (floor random 300), selectRandom[sTank1ArmedCarToUse,sTank2APCToUse,sTank3TankToUse], createGroup _InsurgentSide] call bis_fnc_spawnvehicle;
					};
					if (bAllowLargerPatrols && _bIsMainObjective && selectRandom [true,false]) then {
						_flatPos = nil;
						_flatPos = [_sidePos , 300, 1000, 8, 0, 0.5, 0,[[getMarkerPos "mrkHQ", BaseAreaRange]],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
						[_flatPos,  (floor random 300), selectRandom[sTank1ArmedCarToUse,sTank2APCToUse,sTank3TankToUse], createGroup _InsurgentSide] call bis_fnc_spawnvehicle;
					};
					if (bAllowLargerPatrols && _bIsMainObjective) then {
						_flatPos = nil;
						_flatPos = [_sidePos , 300, 1000, 8, 0, 0.5, 0,[[getMarkerPos "mrkHQ", BaseAreaRange]],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
						[_flatPos,  (floor random 300), selectRandom[sTank1ArmedCarToUse,sTank2APCToUse,sTank3TankToUse], createGroup _InsurgentSide] call bis_fnc_spawnvehicle;

						_flatPos = nil;
						_flatPos = [_sidePos , 300, 1000, 8, 0, 0.5, 0,[[getMarkerPos "mrkHQ", BaseAreaRange]],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
						[_flatPos,  (floor random 300), selectRandom[sTank1ArmedCarToUse,sTank2APCToUse,sTank3TankToUse], createGroup _InsurgentSide] call bis_fnc_spawnvehicle;

					};

					_bHasVehicle = true;

			};

			if (_bIsMainObjective || (selectRandom [true,false])) then {
				//hint format["AAALoc:%1",sTank1ToUse];
				//sleep 3;

					_flatPos = nil;
					_flatPos = [_sidePos , 10, 200, 4, 0, 0.5, 0,[[getMarkerPos "mrkHQ", BaseAreaRange]],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
					_vehOneGroup = nil;
					_vehOneGroup = createGroup _InsurgentSide;
					[_flatPos,  (floor random 300), selectRandom[sTank1ArmedCarToUse,sTank2APCToUse,sTank3TankToUse], _vehOneGroup] call bis_fnc_spawnvehicle;
					[_vehOneGroup, _sidePos, 2000 ] call bis_fnc_taskPatrol;
					_vehOneGroup setSpeedMode "LIMITED";

					if (_bIsMainObjective && selectRandom [true,false]) then {
						_flatPos = nil;
						_flatPos = [_sidePos , 10, 200, 4, 0, 0.5, 0,[[getMarkerPos "mrkHQ", BaseAreaRange]],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
						_vehTwoGroup = nil;
						_vehTwoGroup = createGroup _InsurgentSide;
						[_flatPos,  (floor random 300), selectRandom[sTank1ArmedCarToUse,sTank2APCToUse,sTank3TankToUse], _vehTwoGroup] call bis_fnc_spawnvehicle;
						[_vehTwoGroup, _sidePos, 2000 ] call bis_fnc_taskPatrol;
						_vehTwoGroup setSpeedMode "LIMITED";
					};


					_bHasVehicle = true;

			};
			if (_bIsMainObjective || (selectRandom [true,false])) then {
				//hint format["AAALoc:%1",sTank1ToUse];
				//sleep 3;

					_flatPos = nil;
					_flatPos = [_sidePos , 10, 500, 4, 0, 0.5, 0,[[getMarkerPos "mrkHQ", BaseAreaRange]],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
					_vehScountOneGroup = nil;
					_vehScountOneGroup = createGroup _InsurgentSide;
					[_flatPos,  (floor random 300), selectRandom UnarmedScoutVehicles, _vehScountOneGroup] call bis_fnc_spawnvehicle;
					[_vehScountOneGroup, _sidePos, 3000 ] call bis_fnc_taskPatrol;
					_vehScountOneGroup setSpeedMode "LIMITED";

					if (_bIsMainObjective && selectRandom [true,false]) then {
						_flatPos = nil;
						_flatPos = [_sidePos , 10, 500, 4, 0, 0.5, 0,[[getMarkerPos "mrkHQ", BaseAreaRange]],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
						_vehScoutTwoGroup = nil;
						_vehScoutTwoGroup = createGroup _InsurgentSide;
						[_flatPos,  (floor random 300), selectRandom UnarmedScoutVehicles, _vehScoutTwoGroup] call bis_fnc_spawnvehicle;
						[_vehScoutTwoGroup, _sidePos, 2000 ] call bis_fnc_taskPatrol;
						_vehScoutTwoGroup setSpeedMode "LIMITED";
					};
					_bHasVehicle = true;

			};

			//if main then 100% occupie houses, and increase number and range
			if selectRandom [true] then {[_sidePos,10,[1],_InsurgentSide] spawn TREND_fnc_OccupyHouses;};
				//sleep 120;
			if (_bIsMainObjective) then {
				[_sidePos,200,[1,2,3],_InsurgentSide] spawn TREND_fnc_OccupyHouses;
				[_sidePos,500,[4,5,6],_InsurgentSide] spawn TREND_fnc_OccupyHouses;
				if (bAllowLargerPatrols && _bIsMainObjective) then {
					[_sidePos,1000,[4,5,6],_InsurgentSide] spawn TREND_fnc_OccupyHouses;
				};
			}
			else {

				if selectRandom [true] then {[_sidePos,100,[1,2],_InsurgentSide] spawn TREND_fnc_OccupyHouses;};
				if selectRandom [true] then {[_sidePos,1000,[1,2,3,4],_InsurgentSide] spawn TREND_fnc_OccupyHouses;};
			};

			//Spawn nasty surprise (AAA, IEDs, wider patrol)
			if ((_bIsMainObjective && selectRandom [true,false]) || (!_bIsMainObjective && selectRandom [true,false,false,false])) then {
				if (sAAAVehMilitia != "") then {
					_flatPos = nil;
					_flatPos = [_sidePos , 10, 200, 4, 0, 0.5, 0,[[getMarkerPos "mrkHQ", BaseAreaRange]],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
					_AAAGroup = createGroup _InsurgentSide;
					[_flatPos,  (floor random 300), sAAAVehToUse, _AAAGroup] call bis_fnc_spawnvehicle;
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


			//spawn inner random sentrys
			_iCount = 1;
			//if (!_bIsMainObjective) then {_iCount = selectRandom [0,1];};
			if (_iCount > 0) then {_dAngleAdustPerLoop = 360 / _iCount;};
			while {_iCount > 0} do {
				_thisAreaRange = 50;
				_checkPointGuidePos = _sidePos;
				_iCount = _iCount - 1;
				_flatPos = nil;

				_flatPos = [_checkPointGuidePos , 0, 50, 10, 0, 0.2, 0,[[getMarkerPos "mrkHQ", BaseAreaRange]] + CheckPointAreas + SentryAreas,[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
		
				if (_flatPos select 0 > 0) then {
					_thisPosAreaOfCheckpoint = _flatPos;
					_thisRoadOnly = false;
					_thisSide = east;
					_thisUnitTypes = [sRiflemanToUse, sRiflemanToUse,sRiflemanToUse,sMachineGunManToUse, sAmmobearerToUse, sGrenadierToUse, sMedicToUse,sAAManToUse,sATManToUse];
					_thisAllowBarakade = selectRandom [false];
					_thisIsDirectionAwayFromAO = true;
					[_sidePos,_thisPosAreaOfCheckpoint,_thisAreaRange,_thisRoadOnly,_thisSide,_thisUnitTypes,_thisAllowBarakade,_thisIsDirectionAwayFromAO,false,UnarmedScoutVehicles,50] execVM "RandFramework\setCheckpoint.sqf";
				}
			};

			//spawn inner checkpoints
			_iCount = 1;
			if (!_bIsMainObjective) then {_iCount = selectRandom [0,1,1];};
			if (!_bIsMainObjective && !_bHasPatrols) then {_iCount = selectRandom [1,1,2];};
			if (_iCount > 0) then {_dAngleAdustPerLoop = 360 / _iCount;};
			while {_iCount > 0} do {
				_thisAreaRange = 50;
				_checkPointGuidePos = _sidePos;
				_iCount = _iCount - 1;
				_flatPos = nil;
				_flatPos = [_checkPointGuidePos , 0, 50, 10, 0, 0.2, 0,[[getMarkerPos "mrkHQ", BaseAreaRange]] + CheckPointAreas + SentryAreas,[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
				if (_flatPos select 0 > 0) then {
					_thisPosAreaOfCheckpoint = _flatPos;
					_thisRoadOnly = true;
					_thisSide = east;
					_thisUnitTypes = [sRiflemanToUse, sRiflemanToUse,sRiflemanToUse,sMachineGunManToUse, sAmmobearerToUse, sGrenadierToUse, sMedicToUse,sAAManToUse,sATManToUse];
					_thisAllowBarakade = true;
					_thisIsDirectionAwayFromAO = true;
					[_sidePos,_thisPosAreaOfCheckpoint,_thisAreaRange,_thisRoadOnly,_thisSide,_thisUnitTypes,_thisAllowBarakade,_thisIsDirectionAwayFromAO,true,UnarmedScoutVehicles,100] execVM "RandFramework\setCheckpoint.sqf";
				}
			};

			//spawn outer but close surrunding checkpoints
			_iCount = 2;
			if (!_bIsMainObjective) then {_iCount = selectRandom [0,1];};
			if (!_bIsMainObjective && !_bHasPatrols) then {_iCount = selectRandom [0,1,2];};
			if (_iCount > 0) then {_dAngleAdustPerLoop = 360 / _iCount;};
			while {_iCount > 0} do {
				_thisAreaRange = 75;
				//_checkPointGuidePos = _sidePos getPos [250, _dAngleAdustPerLoop * (_iCount + 1)];
				_checkPointGuidePos = _sidePos getPos [250, floor(random 360)];
				_iCount = _iCount - 1;
				_flatPos = nil;
				_flatPos = [_checkPointGuidePos , 0, 75, 10, 0, 0.2, 0,[[getMarkerPos "mrkHQ", BaseAreaRange]] + CheckPointAreas + SentryAreas,[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
				if (_flatPos select 0 > 0) then {
					_thisPosAreaOfCheckpoint = _flatPos;
					_thisRoadOnly = true;
					_thisSide = east;
					_thisUnitTypes = [sRiflemanToUse, sRiflemanToUse,sRiflemanToUse,sMachineGunManToUse, sAmmobearerToUse, sGrenadierToUse, sMedicToUse,sAAManToUse,sATManToUse];
					_thisAllowBarakade = true;
					_thisIsDirectionAwayFromAO = true;
					[_sidePos,_thisPosAreaOfCheckpoint,_thisAreaRange,_thisRoadOnly,_thisSide,_thisUnitTypes,_thisAllowBarakade,_thisIsDirectionAwayFromAO,true,UnarmedScoutVehicles,300] execVM "RandFramework\setCheckpoint.sqf";
				}
			};

			//spawn outer far checkpoints
			_iCount = 2;
			if (!_bIsMainObjective) then {_iCount = selectRandom [0,1];};
			if (!_bIsMainObjective && !_bHasPatrols) then {_iCount = selectRandom [1,2];};
			if (_iCount > 0) then {_dAngleAdustPerLoop = 360 / _iCount;};
			while {_iCount > 0} do {
				_thisAreaRange = 250;
				//_checkPointGuidePos = _sidePos getPos [1000, _dAngleAdustPerLoop * (_iCount + 1)];
				_checkPointGuidePos = _sidePos getPos [1000, floor(random 360)];
				_iCount = _iCount - 1;
				_flatPos = nil;
				_flatPos = [_checkPointGuidePos , 0, 250, 10, 0, 0.2, 0,[[getMarkerPos "mrkHQ", BaseAreaRange]] + CheckPointAreas + SentryAreas,[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
				if (_flatPos select 0 > 0) then {
					_thisPosAreaOfCheckpoint = _flatPos;
					_thisRoadOnly = true;
					_thisSide = east;
					_thisUnitTypes = [sRiflemanToUse, sRiflemanToUse,sRiflemanToUse,sMachineGunManToUse, sAmmobearerToUse, sGrenadierToUse, sMedicToUse,sAAManToUse,sATManToUse];
					_thisAllowBarakade = true;
					_thisIsDirectionAwayFromAO = true;
					[_sidePos,_thisPosAreaOfCheckpoint,_thisAreaRange,_thisRoadOnly,_thisSide,_thisUnitTypes,_thisAllowBarakade,_thisIsDirectionAwayFromAO,true,UnarmedScoutVehicles,500] execVM "RandFramework\setCheckpoint.sqf";
				}
			};

			//spawn outer far sentrys
			_iCount = 1;
			if (!_bIsMainObjective) then {_iCount = selectRandom [0,1];};
			if (!_bIsMainObjective && !_bHasPatrols) then {_iCount = selectRandom [1,2];};
			if (_iCount > 0) then {_dAngleAdustPerLoop = 360 / _iCount;};
			while {_iCount > 0} do {
				_thisAreaRange = 250;
				//_checkPointGuidePos = _sidePos getPos [1000, _dAngleAdustPerLoop * (_iCount + 1)];
				_checkPointGuidePos = _sidePos getPos [1200, floor(random 360)];
				_iCount = _iCount - 1;
				_flatPos = nil;
				_flatPos = [_checkPointGuidePos , 0, 250, 10, 0, 0.2, 0,[[getMarkerPos "mrkHQ", BaseAreaRange]] + CheckPointAreas + SentryAreas,[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
				if (_flatPos select 0 > 0) then {
					_thisPosAreaOfCheckpoint = _flatPos;
					_thisRoadOnly = false;
					_thisSide = east;
					_thisUnitTypes = [sRiflemanToUse, sRiflemanToUse,sRiflemanToUse,sMachineGunManToUse, sAmmobearerToUse, sGrenadierToUse, sMedicToUse,sAAManToUse,sATManToUse];
					_thisAllowBarakade = selectRandom [false];
					_thisIsDirectionAwayFromAO = true;
					[_sidePos,_thisPosAreaOfCheckpoint,_thisAreaRange,_thisRoadOnly,_thisSide,_thisUnitTypes,_thisAllowBarakade,_thisIsDirectionAwayFromAO,false,UnarmedScoutVehicles,500] execVM "RandFramework\setCheckpoint.sqf";
				}
			};


			//future update... player faction here, or frienly rebels
			//spawn outer nearish friendly checkpoint
			_iCount = selectRandom [1,2];
			if (!_bIsMainObjective) then {_iCount = selectRandom [1];};
			if (_iCount > 0) then {_dAngleAdustPerLoop = 360 / _iCount;};
			while {_iCount > 0} do {
				_thisAreaRange = 500;
				//_checkPointGuidePos = _sidePos getPos [700, _dAngleAdustPerLoop * (_iCount + 1)];
				_checkPointGuidePos = _sidePos getPos [1250, floor(random 360)];
				_iCount = _iCount - 1;
				_flatPos = nil;
				_flatPos = [_checkPointGuidePos , 0, 500, 10, 0, 0.2, 0,[[getMarkerPos "mrkHQ", BaseAreaRange]] + CheckPointAreas + SentryAreas,[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
				if (_flatPos select 0 > 0) then {
					_thisPosAreaOfCheckpoint = _flatPos;
					_thisRoadOnly = true;
					_thisSide = west;
					_thisUnitTypes = FriendlyCheckpointUnits;
					_thisAllowBarakade = true;
					_thisIsDirectionAwayFromAO = false;
					[_sidePos,_thisPosAreaOfCheckpoint,_thisAreaRange,_thisRoadOnly,_thisSide,_thisUnitTypes,_thisAllowBarakade,_thisIsDirectionAwayFromAO,true,FriendlyScoutVehicles,500] execVM "RandFramework\setCheckpoint.sqf";
				};
			};

			//Spawn Mil occupy units
			_MilSearchDistFromCent = 3000;
			//occupy miletary building
			_allMilBuildings = nearestObjects [_sidePos, MilBuildings, _MilSearchDistFromCent];
			_iCount = 0;
			_milOccupyOdds = [true,false,false];
			if (_bIsMainObjective) then {
				_milOccupyOdds = [true,false];
			};
			if (count _allMilBuildings > 0) then {

				{
					_thisMilBuilPos = getPos _x;
					_distanceFromBase = getMarkerPos "mrkHQ" distance getPos _x;
					if (SelectRandom _milOccupyOdds && _distanceFromBase > BaseAreaRange && !(_thisMilBuilPos in OccupiedHousesPos)) then {
					//if (SelectRandom _milOccupyOdds && _distanceFromBase > BaseAreaRange) then {
						_iCount = _iCount + 1;
						_MilGroup1 = nil;
						_objMilUnit1 = nil;
						_objMilUnit2 = nil;
						_objMilUnit3 = nil;
						_MilGroup1 = createGroup east;
						_objMilUnit1 = createGroup east createUnit [selectRandom[sRiflemanToUse,sMachineGunManToUse],[0,0,0],[],0,"NONE"];
						_objMilUnit2 = createGroup east createUnit [selectRandom[sRiflemanToUse,sMachineGunManToUse],[2,0,0],[],0,"NONE"];
						_objMilUnit3 = createGroup east createUnit [selectRandom[sRiflemanToUse,sMachineGunManToUse],[3,0,0],[],0,"NONE"];
						OccupiedHousesPos = OccupiedHousesPos + [_thisMilBuilPos];
						[getPos _x, [_objMilUnit1,_objMilUnit2,_objMilUnit3], -1, true, false,true] execVM "RandFramework\Zen_OccupyHouse.sqf";
						sleep 0.2;
						_objMilUnit1 setUnitPos "up";
						_objMilUnit2 setUnitPos "up";
						_objMilUnit3 setUnitPos "up";
						{deleteVehicle _x} forEach nearestObjects [[0,0,0], ["all"], 100];

						_ParkedCar = nil;
						if (selectRandom [true,false,false]) then {
							_flatPos = nil;
							_flatPos = [getpos _x , 0, 20, 10, 0, 0.5, 0,[[getMarkerPos "mrkHQ", BaseAreaRange]],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
							_ParkedCar = selectRandom UnarmedScoutVehicles createVehicle _flatPos;
							_ParkedCar setDir (floor(random 360));
						};

						if (selectRandom [true,false,false]) then {
							_MilGroup4 = createGroup east;
							_sCheckpointGuyName = format["objMilGuyName%1",(floor(random 999999))];
							_pos5 = [getpos _x , 0, 30, 5, 0, 0.5, 0,[[getMarkerPos "mrkHQ", BaseAreaRange]],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
							_guardUnit5 = _MilGroup4 createUnit [sRiflemanToUse,_pos5,[],0,"NONE"];
							_guardUnit5 setVariable [_sCheckpointGuyName, _guardUnit5, true];
							missionNamespace setVariable [_sCheckpointGuyName, _guardUnit5];
							TREND_fnc_WalkingGuyLoop = {
								_objManName = _this select 0;
								_thisInitPos = _this select 1;
								_objMan = missionNamespace getVariable _objManName;

								group _objMan setSpeedMode "LIMITED";
								group _objMan setBehaviour "SAFE";

								while {true && alive(_objMan) && behaviour _objMan == "SAFE"} do {
									[_objManName,_thisInitPos,_objMan,35] execVM "RandFramework\HVTWalkAround.sqf";
									sleep 2;
									waitUntil {sleep 1; speed _objMan < 0.5};
									sleep 10;
								};
							};
							[_sCheckpointGuyName,_pos5] spawn TREND_fnc_WalkingGuyLoop;
						};
						//because we have a base, we see if a helipad is aviable for an attack chopper
						_HeliPads = nearestObjects [getPos _x, ["Land_HelipadCircle_F","Land_HelipadSquare_F"], 200];
						if (count _HeliPads > 0 && !bBaseHasChopper && SelectRandom [true,false]) then {
							baseHeliPad = selectRandom _HeliPads;
							publicVariable "baseHeliPad";
							bBaseHasChopper = true;
							publicVariable "bBaseHasChopper";
							_BaseChopperGroup = createGroup EnemySide;
							_EnemyBaseChopper = selectRandom EnemyBaseChoppers createVehicle getPosATL baseHeliPad;
							_EnemyBaseChopper setDir direction baseHeliPad;
							sEnemyHeliPilot createUnit [[(getPos baseHeliPad select 0)+10,(getPos baseHeliPad select 1)+10], _BaseChopperGroup];
							sEnemyHeliPilot createUnit [[(getPos baseHeliPad select 0)+11,(getPos baseHeliPad select 1)+10], _BaseChopperGroup];
							{
								[_x,"STAND","ASIS"] call BIS_fnc_ambientAnimCombat;
							} forEach units _BaseChopperGroup;

							//EnemyBaseChopperPilot = getNEAREST sEnemyHeliPilot to chopper
							_EnemyBaseChopperPilots = nearestObjects [getPos baseHeliPad, [sEnemyHeliPilot], 250];
							EnemyBaseChopperPilot = _EnemyBaseChopperPilots select 0;
							publicVariable "EnemyBaseChopperPilot";
							// _BaseChopperGroup

						};
					};
					if (_iCount > 10) exitWith {};
				} forEach _allMilBuildings;

			};

		}
		else { //else if bThisMissionCivsOnly
			//spawn inner checkpoints
			_iCount = selectRandom[0,0,0,0,1];
			//if (!_bIsMainObjective) then {_iCount = selectRandom [0,1];};
			if (_iCount > 0) then {_dAngleAdustPerLoop = 360 / _iCount;};
			while {_iCount > 0} do {
				_thisAreaRange = 50;
				_checkPointGuidePos = _sidePos;
				_iCount = _iCount - 1;
				_flatPos = nil;
				_flatPos = [_checkPointGuidePos , 0, 50, 10, 0, 0.2, 0,[[getMarkerPos "mrkHQ", BaseAreaRange]] + CheckPointAreas + SentryAreas,[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
				if (_flatPos select 0 > 0) then {
					_thisPosAreaOfCheckpoint = _flatPos;
					_thisRoadOnly = true;
					_thisSide = east;
					_thisUnitTypes = [sRiflemanToUse, sRiflemanToUse,sRiflemanToUse,sMachineGunManToUse, sAmmobearerToUse, sGrenadierToUse, sMedicToUse,sAAManToUse,sATManToUse];
					_thisAllowBarakade = true;
					_thisIsDirectionAwayFromAO = true;
					[_sidePos,_thisPosAreaOfCheckpoint,_thisAreaRange,_thisRoadOnly,_thisSide,_thisUnitTypes,_thisAllowBarakade,_thisIsDirectionAwayFromAO,true,UnarmedScoutVehicles,100] execVM "RandFramework\setCheckpoint.sqf";
				};
			};
			//spawn inner sentry
			_iCount = selectRandom[0,0,0,0,1];
			//if (!_bIsMainObjective) then {_iCount = selectRandom [0,1];};
			if (_iCount > 0) then {_dAngleAdustPerLoop = 360 / _iCount;};
			while {_iCount > 0} do {
				_thisAreaRange = 50;
				_checkPointGuidePos = _sidePos;
				_iCount = _iCount - 1;
				_flatPos = nil;
				_flatPos = [_checkPointGuidePos , 0, 50, 10, 0, 0.2, 0,[[getMarkerPos "mrkHQ", BaseAreaRange]] + CheckPointAreas + SentryAreas,[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
				if (_flatPos select 0 > 0) then {
					_thisPosAreaOfCheckpoint = _flatPos;
					_thisRoadOnly = false;
					_thisSide = east;
					_thisUnitTypes = [sRiflemanToUse, sRiflemanToUse,sRiflemanToUse,sMachineGunManToUse, sAmmobearerToUse, sGrenadierToUse, sMedicToUse,sAAManToUse,sATManToUse];
					_thisAllowBarakade = false;
					_thisIsDirectionAwayFromAO = true;
					[_sidePos,_thisPosAreaOfCheckpoint,_thisAreaRange,_thisRoadOnly,_thisSide,_thisUnitTypes,_thisAllowBarakade,_thisIsDirectionAwayFromAO,true,UnarmedScoutVehicles,100] execVM "RandFramework\setCheckpoint.sqf";
				};
			};

		};

	}
	else {

		[_sidePos,200,true] spawn TREND_fnc_SpawnCivs; //3rd param of true says these are rebels and function will set rebels instead of civs

		_lapPos = _sidePos getPos [50, 180];
		_markerFriendlyRebs = createMarker [format["mrkFriendlyRebs%1",_iSideIndex], _lapPos];
		_markerFriendlyRebs setMarkerShape "ICON";
		_markerFriendlyRebs setMarkerType "hd_dot";
		_markerFriendlyRebs setMarkerText (localize "STR_TRGM2_trendFunctions_OccupiedByFriendRebel");
	};

	if (selectRandom [true,false]) then {
		_iAnimalCount = 0;
		_flatPosInside = nil;
		_flatPosInside = [_sidePos , 0, 100, 4, 0, 0.5, 0,[[getMarkerPos "mrkHQ", BaseAreaRange]],[_sidePos,[0,0,0]]] call BIS_fnc_findSafePos;
		while {_iAnimalCount < 4} do {
			_iAnimalCount = _iAnimalCount + 1;
			_myDog1 = nil;
			_myDog1 = createAgent ["Fin_random_F", _flatPosInside, [], 50, "NONE"];
			sleep 0.1;
			_myDog1 playMove "Dog_Sit";
		};
	};

	if (selectRandom [true,false]) then {
		_iAnimalCount = 0;
		_flatPosInside2 = nil;
		_flatPosInside2 = [_sidePos , 0, 100, 4, 0, 0.5, 0,[[getMarkerPos "mrkHQ", BaseAreaRange]],[_sidePos,[0,0,0]]] call BIS_fnc_findSafePos;
		while {_iAnimalCount < 8} do {
			_iAnimalCount = _iAnimalCount + 1;
			_myGoat1 = nil;
			_myGoat1 = createAgent ["Goat_random_F", _flatPosInside2, [], 5, "NONE"];
			sleep 0.1;
			_myGoat1 playMove "Goat_Walk";
		};
	};

	if (selectRandom [true,false]) then {
		_iAnimalCount = 0;
		_flatPosOutSide2 = nil;
		_flatPosInside2 = [_sidePos , 500, 1500, 4, 0, 0.5, 0,[[getMarkerPos "mrkHQ", BaseAreaRange]],[_sidePos,[0,0,0]]] call BIS_fnc_findSafePos;
		while {_iAnimalCount < 8} do {
			_iAnimalCount = _iAnimalCount + 1;
			_myGoat2 = nil;
			_myGoat2 = createAgent ["Goat_random_F", _flatPosInside2, [], 5, "NONE"];
			sleep 0.1;
			_myGoat2 playMove "Goat_Stop";
		};
	};



	//Spawn IED
	if (selectRandom [true,false]) then {

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
			_flatPos = [_sidePos , 10, 80, 4, 0, 0.5, 0,[[getMarkerPos "mrkHQ", BaseAreaRange]],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
			if (_IEDCount <= 2) then {
				_objIED1 = selectRandom IEDClassNames createVehicle _flatPos;
				_IEDCount = _IEDCount + 1;
			};
			//if (selectRandom[true,false,false,false] || _LoopMax == _high) then {
			//	_objIED1b = selectRandom IEDFakeClassNames createVehicle _flatPos;
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


	if (selectRandom [true,true,true,false] || bThisMissionCivsOnly) then {
		debugMessages = debugMessages + format["\n\ntrendFunctions.sqf - Populate Civs : _bFriendlyInsurgents: %1 - bThisMissionCivsOnly: %2 ",str(_bFriendlyInsurgents),str(bThisMissionCivsOnly)];
		[_sidePos,200,false] spawn TREND_fnc_SpawnCivs;
	};


	//Spawn AT Mine on road if not vehicles and hack data mission
	if (_sideType == 1 && selectRandom[true,false]) then {

		_nearestRoad = [[_inf1X,_inf1Y], 100, []] call BIS_fnc_nearestRoad;
		if (isNil "_nearestRoad") then {
			//_bInfor1Found = false;
		}
		else {
			_roadConnectedTo = roadsConnectedTo _nearestRoad;
			if (count _roadConnectedTo > 0) then {
				_objAT = nil;
				_objAT = selectRandom ATMinesClassNames createVehicle getPosATL _nearestRoad;

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
};
//--------------------------------------------------------------------------------------
TREND_fnc_SpawnCivs = {
	_sidePos = _this select 0;
	_distFromCent = _this select 1;
	_bIsRebels = _this select 2;

	_allBuildings = nil;
	_allBuildings = nearestObjects [_sidePos, BasicBuildings, _distFromCent];

	_unitCount = count _allBuildings;
	if (_unitCount > 10) then {
		_unitCount = 10;
	};

	_iCount = 0; //_unitCount
	_randBuilding = nil;

	_bAllCivsBad = selectRandom [true,false,false,false];

	_bRebelLeaderPicked = false;
	while {_iCount <= _unitCount} do
	{
		//spanwn civ in random building pos
		_randBuilding = selectRandom _allBuildings;
		_sInitString = "";
		//_sCivUniform = selectRandom civUniformClasses;

		if (selectRandom[true,false,false,false,false]) then {

			if (_bIsRebels) then {				
					//_sInitString = format["this execVM ""RandFramework\BadReb.sqf""; this forceAddUniform ""%1""; removeHeadgear this; Removevest this;",_sCivUniform];		
					_sInitString = "this execVM ""RandFramework\BadReb.sqf"";";		

			}
			else {
				//_sInitString = format["[this] spawn TRGM_fnc_badCivInitialize; this forceAddUniform ""%1""; removeHeadgear this;Removevest this;",_sCivUniform];
				//_sInitString = format["this execVM ""RandFramework\BadCiv.sqf""; this addaction [""Search Civ"",""RandFramework\SearchCiv.sqf"", nil,1.5,true,true,"""",""true"",5]; this forceAddUniform ""%1""; removeHeadgear this;Removevest this;",_sCivUniform];
				_sInitString = "this execVM ""RandFramework\BadCiv.sqf""; this addaction [localize ""STR_TRGM2_civillians_fnbadCivAddSearchAction_Button"",""RandFramework\SearchCiv.sqf"", nil,1.5,true,true,"""",""true"",5]; removeHeadgear this;Removevest this;";
			};
		}
		else {
			if (_bIsRebels) then {
				if (!_bRebelLeaderPicked) then {
					//_sInitString = format["this addaction [""Talk to leader"",""RandFramework\TalkRebLead.sqf"", nil,1.5,true,true,"""",""true"",5]; this addEventHandler [""killed"", {_this execVM ""RandFramework\InsKilled.sqf"";}]; this forceAddUniform ""%1""; removeHeadgear this;",_sCivUniform];
					_sInitString = "this addaction [localize ""STR_TRGM2_trendFunctions_TalkToLeader"",""RandFramework\TalkRebLead.sqf"", nil,1.5,true,true,"""",""true"",5]; this addEventHandler [""killed"", {_this execVM ""RandFramework\InsKilled.sqf"";}]; removeHeadgear this;";
					_bRebelLeaderPicked = true;
				}
				else {
					//_sInitString = format["this addEventHandler [""killed"", {_this execVM ""RandFramework\InsKilled.sqf"";}]; this forceAddUniform ""%1""; removeHeadgear this;Removevest this;",_sCivUniform];
					_sInitString = "this addEventHandler [""killed"", {_this execVM ""RandFramework\InsKilled.sqf"";}]; removeHeadgear this;Removevest this;";
				};
			}
			else {
				//_sInitString = format["this addEventHandler [""killed"", {_this execVM ""RandFramework\CivKilled.sqf"";}]; this addaction [""Search Civ"",""RandFramework\SearchGoodCiv.sqf"", nil,1.5,true,true,"""",""true"",5]; this forceAddUniform ""%1""; removeHeadgear this;Removevest this;",_sCivUniform];
				_sInitString = "this addEventHandler [""killed"", {_this execVM ""RandFramework\CivKilled.sqf"";}]; this addaction [localize ""STR_TRGM2_civillians_fnbadCivAddSearchAction_Button"",""RandFramework\SearchGoodCiv.sqf"", nil,1.5,true,true,"""",""true"",5]; removeHeadgear this;Removevest this;";
			};
		};
		_sideCivGroup = nil;
		if (_bIsRebels) then {
			_sideCivGroup = createGroup west;
		}
		else {
			_sideCivGroup = createGroup Civilian;
		};
		_allBuildingPos = _randBuilding buildingPos -1;

		if (_bIsRebels) then {
			_wayPosInit = selectRandom _allBuildingPos;
			if (!isNil "_wayPosInit") then {
				//_SpawnedRifleman = (_sideCivGroup createUnit [sRiflemanFriendInsurg, _wayPosInit, [], 10, "NONE"]);
				_SpawnedRifleman = (_sideCivGroup createUnit [sRiflemanFriendInsurg, _wayPosInit, [], 10, "NONE"]);
				[_SpawnedRifleman] joinSilent (_sideCivGroup);
				if (!_bRebelLeaderPicked) then {
					_SpawnedRifleman addaction [localize "STR_TRGM2_trendFunctions_TalkToLeader","RandFramework\TalkRebLead.sqf"];
					_SpawnedRifleman addEventHandler ["killed", {_this execVM "RandFramework\InsKilled.sqf";}];
					//_SpawnedRifleman forceAddUniform _sCivUniform;
					removeHeadgear _SpawnedRifleman;
					_bRebelLeaderPicked = true;
				}
				else {
					//_sInitString = format["this addEventHandler [""killed"", {_this execVM ""RandFramework\InsKilled.sqf"";}]; this forceAddUniform ""%1""; removeHeadgear this;Removevest this;",_sCivUniform];
					_sInitString = "this addEventHandler [""killed"", {_this execVM ""RandFramework\InsKilled.sqf"";}]; removeHeadgear this;Removevest this;";
					_SpawnedRifleman addEventHandler ["killed", {_this execVM "RandFramework\InsKilled.sqf";}];

					_SpawnedRifleman execVM "RandFramework\BadReb.sqf";

					Removevest _SpawnedRifleman;
					removeHeadgear _SpawnedRifleman;
					_SpawnedRifleman setVariable ["IsRebel", true, true];
					_bRebelLeaderPicked = true;
				};

			};
		}
		else {
			_wayPosInit = selectRandom _allBuildingPos;
			if (!isNil "_wayPosInit") then {
				_sCivClass = sCivilian;
				if (typeName _sCivClass == "ARRAY") then {
					_sCivClass = selectRandom sCivilian;
				};
				_sCivClass createUnit [_wayPosInit, _sideCivGroup, _sInitString];
			};
		};

		//set waypoints to other buildings
		_iCountWaypoints = 0;
		while {_iCountWaypoints <= 4} do
		{
			_randBuilding2 = selectRandom _allBuildings; //pick one building from our buildings array
			_allBuildingPos2 = _randBuilding2 buildingPos -1;

			_wpSideCiv = nil;
			//_wpSideCiv = _sideCivGroup addWaypoint [_randBuilding2 buildingPos (selectRandom _allBuildingPos2), 0]; //This line has error "0 eleemnts provided, 3 expected"
			try {
				//_wpSideCiv = _sideCivGroup addWaypoint [selectRandom _allBuildingPos2, 0]; //This line has error "0 eleemnts provided, 3 expected"
				_wayPosInit = selectRandom _allBuildingPos2;
				if (!isNil "_wayPosInit") then {
					_wpSideCiv = _sideCivGroup addWaypoint [_wayPosInit, 0]; //This line has error "0 eleemnts provided, 3 expected"
				}

			}
			catch {
				hint format ["Script issue: %1",selectRandom _allBuildingPos2];
			};
			//_wp1 = _group addWaypoint [_wp1Pos, 0];

			[_sideCivGroup, _iCountWaypoints] setWaypointSpeed "LIMITED";
			[_sideCivGroup, _iCountWaypoints] setWaypointBehaviour "SAFE";
			if (_iCountWaypoints == 4) then{[_sideCivGroup, 8] setWaypointType "CYCLE";};
			_iCountWaypoints = _iCountWaypoints + 1;
		};
		_sideCivGroup setBehaviour "SAFE";

		_iCount = _iCount + 1;
	};
};
//--------------------------------------------------------------------------------------
TREND_fnc_OccupyHouses = {
	_sidePos = _this select 0;
	_distFromCent = _this select 1;
	_unitCounts = _this select 2;
	_InsurgentSide = _this select 3;

	_unitCount = selectRandom _unitCounts;

	_iCount = 0; //_unitCount
	_allBuildings = nil;
	_sAreaMarkerName = nil;
	_randBuilding = nil;

	

	if (!bThisMissionCivsOnly) then {
		while {_iCount <= _unitCount} do
		{
			_allBuildings = nearestObjects [_sidePos, BasicBuildings, _distFromCent];
			//_allBuildings = nearestObjects [_sidePos, ["house"], _distFromCent];
			_randBuilding = selectRandom _allBuildings;
			_randBuildingPos = getPos _randBuilding;
			if ((_randBuilding distance getMarkerPos "mrkHQ") > BaseAreaRange && !(_randBuildingPos in OccupiedHousesPos)) then { //"mrkHQ", BaseAreaRange
			//if ((_randBuilding distance getMarkerPos "mrkHQ") > BaseAreaRange) then { //"mrkHQ", BaseAreaRange

				OccupiedHousesPos = OccupiedHousesPos + [_randBuildingPos];
				//hint format["test:%1",(_randBuilding distance getMarkerPos "mrkHQ")];
				//sleep 1;

				_thisGroup = nil;
				_thisGroup = createGroup _InsurgentSide;
				sRiflemanToUse createUnit [position _randBuilding, _thisGroup];
				if (selectRandom [true,false]) then {sRiflemanToUse createUnit [position _randBuilding, _thisGroup];};
					//HERE!!!! copy and paste the zen init script into a placed unig, then run and see if he is in building!!! (esc out of TRGM dialog)
				//sRiflemanToUse createUnit [position _randBuilding, _thisGroup, "[getPosATL this, units group this, 10, false, false] execVM ""RandFramework\Zen_OccupyHouse.sqf"";"];

				_teamLeaderUnit = _thisGroup createUnit [sRiflemanToUse,_randBuildingPos,[],0,"NONE"];
				[_randBuildingPos, units group _teamLeaderUnit, -1, true, false,true] execVM "RandFramework\Zen_OccupyHouse.sqf";



				_iCountNoOfCPs = selectRandom[0,0,0,0,1];  //number of checkpoints (so high chance of not being any, or one may be near an occupied building)
				if ((_sidePos distance _randBuilding) > 400) then {_iCountNoOfCPs = selectRandom[0,0,1];};
				//spawn inner random sentrys
				//if (!_bIsMainObjective) then {_iCountNoOfCPs = selectRandom [0,1];};
				if (_iCountNoOfCPs > 0) then {_dAngleAdustPerLoop = 360 / _iCountNoOfCPs;};
				while {_iCountNoOfCPs > 0} do {
					_thisAreaRange = 50;
					_checkPointGuidePos = _sidePos;
					_iCountNoOfCPs = _iCountNoOfCPs - 1;
					_flatPos = nil;
					_flatPos = [_checkPointGuidePos , 0, 50, 10, 0, 0.2, 0,CheckPointAreas + SentryAreas,[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;


					if (_flatPos select 0 > 0) then {
						_thisPosAreaOfCheckpoint = _flatPos;
						_thisRoadOnly = false;
						_thisSide = east;
						_thisUnitTypes = [sRiflemanToUse, sRiflemanToUse,sRiflemanToUse,sMachineGunManToUse, sAmmobearerToUse, sGrenadierToUse, sMedicToUse,sAAManToUse,sATManToUse];
						_thisAllowBarakade = selectRandom [false];
						_thisIsDirectionAwayFromAO = true;
						[_sidePos,_thisPosAreaOfCheckpoint,_thisAreaRange,_thisRoadOnly,_thisSide,_thisUnitTypes,_thisAllowBarakade,_thisIsDirectionAwayFromAO,false,UnarmedScoutVehicles,50,false] execVM "RandFramework\setCheckpoint.sqf";
					}
				};
			};


			_iCount = _iCount + 1;
		};
	};
};
//--------------------------------------------------------------------------------------

//one patrol that patrols around the ao
TREND_fnc_RadiusPatrol = {
	_sidePos = _this select 0;
	_distFromCent = _this select 1;
	_unitCounts = _this select 2;
	_IncludTeamLeader = _this select 3;
	_InsurgentSide = _this select 4;

	_unitCount = selectRandom _unitCounts;
	_group = Nil;
	_wayX = Nil;
	_wayY = Nil;

	_wp1Pos = Nil;
	_wp1bPos = Nil;
	_wp2Pos = Nil;
	_wp2bPos = Nil;
	_wp3Pos = Nil;
	_wp3bPos = Nil;
	_wp4Pos = Nil;
	_wp4bPos = Nil;
	_wp5Pos = Nil;

	_group = createGroup _InsurgentSide;
	_wayX = (_sidePos select 0);
	_wayY = (_sidePos select 1);

	_wp1Pos = [ _wayX + _distFromCent, _wayY + _distFromCent, 0];
	_wp1bPos = [ _wayX + _distFromCent, _wayY, 0];
	_wp2Pos = [ _wayX + _distFromCent, _wayY - _distFromCent, 0];
	_wp2bPos = [ _wayX, _wayY - _distFromCent, 0];
	_wp3Pos = [ _wayX - _distFromCent, _wayY - _distFromCent, 0];
	_wp3bPos = [ _wayX - _distFromCent, _wayY, 0];
	_wp4Pos = [ _wayX - _distFromCent, _wayY + _distFromCent, 0];
	_wp4bPos = [ _wayX, _wayY + _distFromCent, 0];
	_wp5Pos = [ _wayX + _distFromCent, _wayY + _distFromCent, 0];

	//Adjust waypoints so they are not in water
	_iToReduce = 10;
	while {surfaceIsWater _wp1Pos} do {
		_wp1Pos = [ _wayX + (_distFromCent - _iToReduce), _wayY + (_distFromCent - _iToReduce), 0];
		_wp5Pos = [ _wayX + (_distFromCent - _iToReduce), _wayY + (_distFromCent - _iToReduce), 0];
		_iToReduce = _iToReduce + 10;
	};
	_iToReduce = 10;
	while {surfaceIsWater _wp2Pos} do {
		_wp2Pos = [ _wayX + (_distFromCent - _iToReduce), _wayY - (_distFromCent - _iToReduce), 0];
		_iToReduce = _iToReduce + 10;
	};
	_iToReduce = 10;
	while {surfaceIsWater _wp3Pos} do {
		_wp3Pos = [ _wayX - (_distFromCent - _iToReduce), _wayY - (_distFromCent - _iToReduce), 0];
		_iToReduce = _iToReduce + 10;
	};
	_iToReduce = 10;
	while {surfaceIsWater _wp4Pos} do {
		_wp4Pos = [ _wayX - (_distFromCent - _iToReduce), _wayY + (_distFromCent - _iToReduce), 0];
		_iToReduce = _iToReduce + 10;
	};
	_iToReduce = 10;
	while {surfaceIsWater _wp1bPos} do {
		_wp1bPos = [ _wayX + (_distFromCent - _iToReduce), _wayY, 0];
		_iToReduce = _iToReduce + 10;
	};
	_iToReduce = 10;
	while {surfaceIsWater _wp2bPos} do {
		_wp2bPos = [ _wayX, _wayY - (_distFromCent - _iToReduce), 0];
		_iToReduce = _iToReduce + 10;
	};
	_iToReduce = 10;
	while {surfaceIsWater _wp3bPos} do {
		_wp3bPos = [ _wayX - (_distFromCent - _iToReduce), _wayY, 0];
		_iToReduce = _iToReduce + 10;
	};
	_iToReduce = 10;
	while {surfaceIsWater _wp4bPos} do {
		_wp4bPos = [ _wayX, _wayY + (_distFromCent - _iToReduce), 0];
		_iToReduce = _iToReduce + 10;
	};

	//Spawn in units

	_iCount = 0; //_unitCount
	while {_iCount <= _unitCount} do
	{
		[_wayX,_wayY,_group,_iCount,_IncludTeamLeader] spawn TREND_fnc_SpawnPatrolUnit;
		_iCount = _iCount + 1;
	};

	//add the waypoints (will start at a random one so it doesnt always start at the same pos (mainly for if we have more than one patrol), and cycle through them all)
	_iWaypointCount = selectRandom[1,2,3,4,5,6,7,8,9];
	_bWaypointsAdded = false;
	_iWaypointLoopCount = 1;
	while {!_bWaypointsAdded} do {
		if (_iWaypointCount == 1) then {
			_wp1 = _group addWaypoint [_wp1Pos, 0];
			if (bDebugging) then {[format["(%1 - %2)",_iWaypointCount, str(_wp1Pos)],_wp1Pos] spawn TRGM_fnc_debugDotMarker;};
		};
		if (_iWaypointCount == 2) then {
			_wp1b = _group addWaypoint [_wp1bPos, 0];
			if (bDebugging) then {[format["(%1 - %2)",_iWaypointCount, str(_wp1bPos)],_wp1bPos] spawn TRGM_fnc_debugDotMarker;};
		};
		if (_iWaypointCount == 3) then {
			_wp2 = _group addWaypoint [_wp2Pos, 0];
			if (bDebugging) then {[format["(%1 - %2)",_iWaypointCount, str(_wp2Pos)],_wp2Pos] spawn TRGM_fnc_debugDotMarker;};
		};
		if (_iWaypointCount == 4) then {
			_wp2b = _group addWaypoint [_wp2bPos, 0];
			if (bDebugging) then {[format["(%1 - %2)",_iWaypointCount, str(_wp2bPos)],_wp2bPos] spawn TRGM_fnc_debugDotMarker;};
		};
		if (_iWaypointCount == 5) then {
			_wp3 = _group addWaypoint [_wp3Pos, 0];
			if (bDebugging) then {[format["(%1 - %2)",_iWaypointCount, str(_wp3Pos)],_wp3Pos] spawn TRGM_fnc_debugDotMarker;};
		};
		if (_iWaypointCount == 6) then {
			_wp3b = _group addWaypoint [_wp3bPos, 0];
			if (bDebugging) then {[format["(%1 - %2)",_iWaypointCount, str(_wp3bPos)],_wp3bPos] spawn TRGM_fnc_debugDotMarker;};
		};
		if (_iWaypointCount == 7) then {
			_wp4 = _group addWaypoint [_wp4Pos, 0];
			if (bDebugging) then {[format["(%1 - %2)",_iWaypointCount, str(_wp4Pos)],_wp4Pos] spawn TRGM_fnc_debugDotMarker;};
		};
		if (_iWaypointCount == 8) then {
			_wp4b = _group addWaypoint [_wp4bPos, 0];
			if (bDebugging) then {[format["(%1 - %2)",_iWaypointCount, str(_wp4bPos)],_wp4bPos] spawn TRGM_fnc_debugDotMarker;};
		};
		if (_iWaypointCount == 9) then {
			_wp5 = _group addWaypoint [_wp5Pos, 0];
			if (bDebugging) then {[format["(%1 - %2)",_iWaypointCount, str(_wp5Pos)],_wp5Pos] spawn TRGM_fnc_debugDotMarker;};
		};
		_iWaypointCount = _iWaypointCount + 1;
		_iWaypointLoopCount = _iWaypointLoopCount + 1;

		if (_iWaypointLoopCount == 10) then {
			_bWaypointsAdded = true;
		};

		if (_iWaypointCount == 10) then {
			_iWaypointCount = 1;
		};
		//hint format["TEST: %1", _iWaypointLoopCount];
		//sleep 0.5;

	};
	[_group, 0] setWaypointSpeed "LIMITED";
	[_group, 0] setWaypointBehaviour "SAFE";
	[_group, 1] setWaypointSpeed "LIMITED";
	[_group, 1] setWaypointBehaviour "SAFE";
	[_group, 8] setWaypointType "CYCLE";
	_group setBehaviour "SAFE";
};

//--------------------------------------------------------------------------------------

//one patrol that patrols from random building to building
TREND_fnc_BuildingPatrol = {
	_sidePos = _this select 0;
	_distFromCent = _this select 1;
	_unitCounts = _this select 2;
	_IncludTeamLeader = _this select 3;
	_InsurgentSide = _this select 4;
	_buildingCount = _this select 5;

	_unitCount = selectRandom _unitCounts;
	_group = Nil;
	_wayX = Nil;
	_wayY = Nil;
	_group = createGroup _InsurgentSide;


	_flatPos = nil;
	_flatPos = [_sidePos , 100, _distFromCent, 4, 0, 0.5, 0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
	_wayX = (_flatPos select 0);
	_wayY = (_flatPos select 1);

	_allBuildings = nil;
	_allBuildings = nearestObjects [_sidePos, BasicBuildings, _distFromCent];

	//Spawn in units
	_iCount = 0; //_unitCount
	while {_iCount <= _unitCount} do
	{
		[_wayX,_wayY,_group,_iCount,_IncludTeamLeader] spawn TREND_fnc_SpawnPatrolUnit;
		_iCount = _iCount + 1;
	};

	//set waypoints to other buildings
	_iCountWaypoints = 0;
	while {_iCountWaypoints <= _buildingCount} do
	{
		_randBuilding2 = selectRandom _allBuildings; //pick one building from our buildings array
		_allBuildingPos2 = _randBuilding2 buildingPos -1;

		_wpSideBuildingPatrol = nil;
		try {
			_wayPosInit = selectRandom _allBuildingPos2;
			if (!isNil "_wayPosInit") then {
				_wpSideBuildingPatrol = _group addWaypoint [_wayPosInit, 0]; //This line has error "0 eleemnts provided, 3 expected"
			}

		}
		catch {
			hint format ["Script issue: %1",selectRandom _allBuildingPos2];
		};
		//_wp1 = _group addWaypoint [_wp1Pos, 0];

		[_group, _iCountWaypoints] setWaypointSpeed "LIMITED";
		[_group, _iCountWaypoints] setWaypointBehaviour "SAFE";
		if (_iCountWaypoints == _buildingCount) then{[_group, 8] setWaypointType "CYCLE";};
		_iCountWaypoints = _iCountWaypoints + 1;
	};
	_group setBehaviour "SAFE";
};


//--------------------------------------------------------------------------------------
//one patrol that patrols from AO to distance and back
TREND_fnc_BackForthPatrol = {
	_sidePos = _this select 0;
	_distFromCent = _this select 1;
	_unitCounts = _this select 2;
	_IncludTeamLeader = _this select 3;
	_InsurgentSide = _this select 4;

	_unitCount = selectRandom _unitCounts;
	_group = Nil;
	_wayX = Nil;
	_wayY = Nil;

	_wp1Pos = Nil;
	_wp1bPos = Nil;
	_wp2Pos = Nil;
	_wp2bPos = Nil;
	_wp3Pos = Nil;
	_wp3bPos = Nil;
	_wp4Pos = Nil;
	_wp4bPos = Nil;
	_wp5Pos = Nil;

	_group = createGroup _InsurgentSide;
	_wayX = (_sidePos select 0);
	_wayY = (_sidePos select 1);

	_wp1Pos = [ _wayX + _distFromCent, _wayY, 0];
	_wp1bPos = [ _wayX, _wayY, 0];
	_wp2Pos = [ _wayX, _wayY - _distFromCent, 0];
	_wp2bPos = [ _wayX, _wayY, 0];
	_wp3Pos = [ _wayX - _distFromCent, _wayY, 0];
	_wp3bPos = [ _wayX, _wayY, 0];
	_wp4Pos = [ _wayX - _distFromCent, _wayY + _distFromCent, 0];
	_wp4bPos = [ _wayX, _wayY, 0];
	_wp5Pos = [ _wayX + _distFromCent, _wayY + _distFromCent, 0];

	//Adjust waypoints so they are not in water
	_iToReduce = 10;
	while {surfaceIsWater _wp1Pos} do {
		_wp1Pos = [ _wayX + (_distFromCent - _iToReduce), _wayY + (_distFromCent - _iToReduce), 0];
		_wp5Pos = [ _wayX + (_distFromCent - _iToReduce), _wayY + (_distFromCent - _iToReduce), 0];
		_iToReduce = _iToReduce + 10;
	};
	_iToReduce = 10;
	while {surfaceIsWater _wp2Pos} do {
		_wp2Pos = [ _wayX + (_distFromCent - _iToReduce), _wayY - (_distFromCent - _iToReduce), 0];
		_iToReduce = _iToReduce + 10;
	};
	_iToReduce = 10;
	while {surfaceIsWater _wp3Pos} do {
		_wp3Pos = [ _wayX - (_distFromCent - _iToReduce), _wayY - (_distFromCent - _iToReduce), 0];
		_iToReduce = _iToReduce + 10;
	};
	_iToReduce = 10;
	while {surfaceIsWater _wp4Pos} do {
		_wp4Pos = [ _wayX - (_distFromCent - _iToReduce), _wayY + (_distFromCent - _iToReduce), 0];
		_iToReduce = _iToReduce + 10;
	};
	_iToReduce = 10;
	while {surfaceIsWater _wp1bPos} do {
		_wp1bPos = [ _wayX + (_distFromCent - _iToReduce), _wayY, 0];
		_iToReduce = _iToReduce + 10;
	};
	_iToReduce = 10;
	while {surfaceIsWater _wp2bPos} do {
		_wp2bPos = [ _wayX, _wayY - (_distFromCent - _iToReduce), 0];
		_iToReduce = _iToReduce + 10;
	};
	_iToReduce = 10;
	while {surfaceIsWater _wp3bPos} do {
		_wp3bPos = [ _wayX - (_distFromCent - _iToReduce), _wayY, 0];
		_iToReduce = _iToReduce + 10;
	};
	_iToReduce = 10;
	while {surfaceIsWater _wp4bPos} do {
		_wp4bPos = [ _wayX, _wayY + (_distFromCent - _iToReduce), 0];
		_iToReduce = _iToReduce + 10;
	};

	//Spawn in units

	_iCount = 0; //_unitCount
	while {_iCount <= _unitCount} do
	{
		[_wp1Pos select 0,_wp1Pos select 1,_group,_iCount,_IncludTeamLeader] spawn TREND_fnc_SpawnPatrolUnit;
		_iCount = _iCount + 1;
	};

	//add the waypoints (will start at a random one so it doesnt always start at the same pos (mainly for if we have more than one patrol), and cycle through them all)
	_iWaypointCount = selectRandom[1,2,3,4,5,6,7,8,9];
	_bWaypointsAdded = false;
	_iWaypointLoopCount = 1;
	while {!_bWaypointsAdded} do {
		if (_iWaypointCount == 1) then {
			_wp1 = _group addWaypoint [_wp1Pos, 0];
			if (bDebugging) then {[format["(%1 - %2)",_iWaypointCount, str(_wp1Pos)],_wp1Pos] spawn TRGM_fnc_debugDotMarker;};
		};
		if (_iWaypointCount == 2) then {
			_wp1b = _group addWaypoint [_wp1bPos, 0];
			if (bDebugging) then {[format["(%1 - %2)",_iWaypointCount, str(_wp1bPos)],_wp1bPos] spawn TRGM_fnc_debugDotMarker;};
		};
		if (_iWaypointCount == 3) then {
			_wp2 = _group addWaypoint [_wp2Pos, 0];
			if (bDebugging) then {[format["(%1 - %2)",_iWaypointCount, str(_wp2Pos)],_wp2Pos] spawn TRGM_fnc_debugDotMarker;};
		};
		if (_iWaypointCount == 4) then {
			_wp2b = _group addWaypoint [_wp2bPos, 0];
			if (bDebugging) then {[format["(%1 - %2)",_iWaypointCount, str(_wp2bPos)],_wp2bPos] spawn TRGM_fnc_debugDotMarker;};
		};
		if (_iWaypointCount == 5) then {
			_wp3 = _group addWaypoint [_wp3Pos, 0];
			if (bDebugging) then {[format["(%1 - %2)",_iWaypointCount, str(_wp3Pos)],_wp3Pos] spawn TRGM_fnc_debugDotMarker;};
		};
		if (_iWaypointCount == 6) then {
			_wp3b = _group addWaypoint [_wp3bPos, 0];
			if (bDebugging) then {[format["(%1 - %2)",_iWaypointCount, str(_wp3bPos)],_wp3bPos] spawn TRGM_fnc_debugDotMarker;};
		};
		if (_iWaypointCount == 7) then {
			_wp4 = _group addWaypoint [_wp4Pos, 0];
			if (bDebugging) then {[format["(%1 - %2)",_iWaypointCount, str(_wp4Pos)],_wp4Pos] spawn TRGM_fnc_debugDotMarker;};
		};
		if (_iWaypointCount == 8) then {
			_wp4b = _group addWaypoint [_wp4bPos, 0];
			if (bDebugging) then {[format["(%1 - %2)",_iWaypointCount, str(_wp4bPos)],_wp4bPos] spawn TRGM_fnc_debugDotMarker;};
		};
		if (_iWaypointCount == 9) then {
			_wp5 = _group addWaypoint [_wp5Pos, 0];
			if (bDebugging) then {[format["(%1 - %2)",_iWaypointCount, str(_wp5Pos)],_wp5Pos] spawn TRGM_fnc_debugDotMarker;};
		};
		_iWaypointCount = _iWaypointCount + 1;
		_iWaypointLoopCount = _iWaypointLoopCount + 1;

		if (_iWaypointLoopCount == 10) then {
			_bWaypointsAdded = true;
		};

		if (_iWaypointCount == 10) then {
			_iWaypointCount = 1;
		};

	};
	[_group, 0] setWaypointSpeed "LIMITED";
	[_group, 0] setWaypointBehaviour "SAFE";
	[_group, 1] setWaypointSpeed "LIMITED";
	[_group, 1] setWaypointBehaviour "SAFE";
	[_group, 8] setWaypointType "CYCLE";
	_group setBehaviour "SAFE";
};
//--------------------------------------------------------------------------------------
//four patrols (one quarter in size) that patrol a square shape on the N E S and W of the area
TREND_fnc_SquareOutsidePatrols = {
	sidePos = _this select 0;

};
//--------------------------------------------------------------------------------------
TREND_fnc_SpawnPatrolUnit = {
	_wayX = _this select 0;
	_wayY = _this select 1;
	_group = _this select 2;
	_index = _this select 3;
	_IncludTeamLeader = _this select 4;

	_startPos = [_wayX + 5 + floor random 10,_wayY + 5 + floor random 10];
	_sUnitType = selectRandom [sRiflemanToUse, sRiflemanToUse,sRiflemanToUse,sMachineGunManToUse, sAmmobearerToUse, sGrenadierToUse, sMedicToUse,sAAManToUse,sATManToUse];
	if (_index == 0 && _IncludTeamLeader) then {
		_sUnitType = sTeamleaderToUse;
	};
	_sUnitType createUnit [_startPos, _group];
}
//---------------------------------------------------------------------------------------