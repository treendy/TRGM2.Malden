
params ["_posOfAO",["_roadRange",2000],["_showMarker",false],["_forceTrap",false],["_objTarget",nil],["_isCache",false],["_isMainTask",false]];

_ieds = CivCars;

fnc_AddToDirection = {
	params ["_origDirection","_addToDirection"];

	_iResult = _origDirection + _addToDirection;
	//hint format["result:%1",_iResult];
	//sleep 2;
	if (_iResult > 360) then {
		_iResult = _iResult - 360;
	};
	if (_origDirection+_addToDirection < 0) then {
		_iResult = 360 + _iResult ;
	};

	_iResult;
};

_objectiveCreated = false;

_nearestRoads = _posOfAO nearRoads _roadRange;

//TARGETTEST = format["here333: %1", str(_isCache)];

if (!_isCache && count _nearestRoads > 0) then {	

	_eventLocationPos = [0,0,0]; //getPos (selectRandom _nearestRoads);
	_eventPosFound = false;	
	_iAttemptLimit = 15;		
	while {!_eventPosFound && _iAttemptLimit > 0} do {
		_iAttemptLimit = _iAttemptLimit - 1;
		_eventLocationPos = getPos (selectRandom _nearestRoads);
		_farEnoughFromAo = _eventLocationPos distance _posOfAO > 500;
		_farEnoughFromWarzone = true;
		if (!isNil "WarzonePos") then {_farEnoughFromWarzone = (_eventLocationPos distance WarzonePos > 500)};
		if (_isMainTask || (_farEnoughFromWarzone && _farEnoughFromAo)) then {_eventPosFound = true;};		
	};	
	if (!_eventPosFound) then {
		_eventLocationPos = getPos (selectRandom _nearestRoads);
	};


	if (_eventLocationPos select 0 > 0) then {
		_thisAreaRange = 50;
		_nearestRoads = _eventLocationPos nearRoads _thisAreaRange;

		_nearestRoad = nil;
		_roadConnectedTo = nil;
		_connectedRoad = nil;
		_direction = nil;
		_PosFound = false;
		_iAttemptLimit = 5;

		_direction = nil;
		while {!_PosFound && _iAttemptLimit > 0 && count _nearestRoads > 0} do {
			_nearestRoad = selectRandom _nearestRoads;
			_roadConnectedTo = roadsConnectedTo _nearestRoad;
			if (count _roadConnectedTo > 0) then {	
				_connectedRoad = _roadConnectedTo select 0;
				_direction = [_nearestRoad, _connectedRoad] call BIS_fnc_DirTo;	
				_PosFound = true;		
			}
			else {
				_iAttemptLimit = _iAttemptLimit - 1;
			};
		};
	//hint format["A: %1 - %2",_iteration,_eventLocationPos];
		if (_PosFound) then {
			_objectiveCreated = true;
			
			_roadBlockPos =  getPos _nearestRoad;
			_roadBlockSidePos = _nearestRoad getPos [3, ([_direction,90] call fnc_AddToDirection)];

			_mainVeh = nil;
			if (isNil "_objTarget") then {
				_mainVeh = createVehicle [selectRandom TargetVehicles,_roadBlockSidePos,[],50,"NONE"];
			}
			else {
				_mainVeh = _objTarget;
				_mainVeh setPos _roadBlockSidePos;
			};
			//_mainVeh setVehicleLock "LOCKED";
			_mainVehDirection =  ([_direction,(selectRandom[0,-10,10])] call fnc_AddToDirection);
			_mainVeh setDir _mainVehDirection;
			clearItemCargoGlobal _mainVeh;		

		//if not within 200 of main AO, then have patrol, and guards, if over 1k, then chance of checkpoint to


		if (_posOfAO distance (getPos _mainVeh) > 150 ) then {

			if (_showMarker) then {
				//here, make circle, and random
				_centerPos = _mainVeh getPos [ (random 150) , (random 360) ];

				_markerstrcacheZone = createMarker [format ["IEDLocZone%1",_centerPos select 0],_centerPos];
				_markerstrcacheZone setMarkerShape "ELLIPSE";
				_markerstrcacheZone setMarkerBrush "DIAGGRID";
				_markerstrcacheZone setMarkerColor "ColorYellow";
				_markerstrcacheZone setMarkerSize [150, 150];


				_markerstrcache = createMarker [format ["IEDLoc%1",_centerPos select 0],_centerPos];
				_markerstrcache setMarkerShape "ICON";
				_markerstrcache setMarkerText localize "STR_TRGM2_TargetMarkerText";	
				_markerstrcache setMarkerType "hd_dot";
			};
			
			_posOfTarget = getPos _mainVeh;

			{systemChat "Mission Events: Target 6";} remoteExec ["bis_fnc_call", 0];
			
			if (selectRandom[true,false,false]) then {
				[_posOfTarget] execVM "RandFramework\RandScript\createEnemySniper.sqf";
			};

			_spawnedUnitTarget1 = ((createGroup east) createUnit [sRiflemanToUse, _posOfTarget, [], 10, "NONE"]);
			_directionTarget1 = [_mainVeh,_spawnedUnitTarget1] call BIS_fnc_DirTo;
			_spawnedUnitTarget1 setDir _directionTarget1;
			_spawnedUnitTarget1 setFormDir _directionTarget1;

			_spawnedUnitTarget2 = ((createGroup east) createUnit [sRiflemanToUse, _posOfTarget, [], 10, "NONE"]);
			_directionTarget2 = [_mainVeh,_spawnedUnitTarget2] call BIS_fnc_DirTo;
			_spawnedUnitTarget2 setDir _directionTarget2;
			_spawnedUnitTarget2 setFormDir _directionTarget2;



			_thisAreaRange = 20;
			_flatPos = nil;
			_flatPos = [_posOfTarget , 0, 20, 10, 0, 0.2, 0,[[getMarkerPos "mrkHQ", BaseAreaRange]] + CheckPointAreas + SentryAreas,[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
			if (_flatPos select 0 > 0) then {
				_thisPosAreaOfCheckpoint = _flatPos;
				_thisRoadOnly = true;
				_thisSide = east; 
				_thisUnitTypes = [sRiflemanToUse, sRiflemanToUse,sRiflemanToUse,sMachineGunManToUse, sAmmobearerToUse, sGrenadierToUse, sMedicToUse,sAAManToUse,sATManToUse];
				_thisAllowBarakade = true;
				_thisIsDirectionAwayFromAO = true;
				[_posOfTarget,_thisPosAreaOfCheckpoint,_thisAreaRange,_thisRoadOnly,_thisSide,_thisUnitTypes,_thisAllowBarakade,_thisIsDirectionAwayFromAO,true,UnarmedScoutVehicles,100,true,selectRandom[false,false,true],false] execVM "RandFramework\setCheckpoint.sqf";
			};

			{systemChat "Mission Events: Target 4";} remoteExec ["bis_fnc_call", 0];

		};
		//HERE 23_09_2019 : look at SetIEDEvent, or startInfMission line 541 (where we create triggers for ammotrucks)
		//need to get this to give rep points if not a main mission
		//and nothing, if is main mission (as the mission setup file (mission15.sqf) will check if these three are alive)
		/*
		_trg = createTrigger ["EmptyDetector", position _mainVeh];
		_trg setVariable ["DelMeOnNewCampaignDay",true];
		_trg setTriggerArea [100, 100, 0, false];
		_sSTringPos = format["%1,%2", position _mainVeh select 0, position _mainVeh select 1];
		_sTriggerString = "!alive(nearestObject [[" + _sSTringPos + "], '" + TowerClassName + "'])";

		_trg setTriggerStatements [_sTriggerString, "bCommsBlocked = true; publicVariable ""bCommsBlocked""; [this] execVM ""RandFramework\RandScript\commsBlocked.sqf"";", ""];
		*/




		}
		else {
		}	
	}
	else {

	};
};



if (_isCache) then {

	_buildings = nearestObjects [_posOfAO, BasicBuildings, _roadRange];
	_infBuilding = selectRandom _buildings;
	//TARGETTEST = "here";
	_eventPosFound = false;
	_iAttemptLimit = 15;		
	while {!_eventPosFound && _iAttemptLimit > 0} do {
		_iAttemptLimit = _iAttemptLimit - 1;
		_infBuilding = selectRandom _buildings;
		_eventLocationPos = getPos _infBuilding;
		_farEnoughFromAo = _eventLocationPos distance _posOfAO > 500;
		_farEnoughFromWarzone = true;
		if (!isNil "WarzonePos") then {_farEnoughFromWarzone = (_eventLocationPos distance WarzonePos > 500)};
		if (_isMainTask || (_farEnoughFromWarzone && _farEnoughFromAo)) then {_eventPosFound = true;};		
	};	
	if (!_eventPosFound) then {
		//TARGETTEST = "oh crap";
		_infBuilding = selectRandom _buildings;
	};
	//TARGETTEST = format["%1 : %2",TARGETTEST,_iAttemptLimit];

	_infBuilding setDamage 0;
	_allBuildingPos = _infBuilding buildingPos -1;
	_inf1X = position _infBuilding select 0;
	_inf1Y = position _infBuilding select 1;

	if (count _allBuildingPos > 2) then {
		_objectiveCreated = true;
		_mainVeh = nil;
		if (isNil "_objTarget") then {
			_mainVeh = createVehicle [selectRandom TargetCaches,[0,0,500],[],0,"NONE"];
		}
		else {
			_mainVeh = _objTarget;
		};
		_mainVeh setPosATL (selectRandom _allBuildingPos);

		_posCache = getPos _mainVeh;	

		if (_showMarker) then {
			_markerstrcache = createMarker [format ["IEDLoc%1",_posCache select 0],_posCache];
			_markerstrcache setMarkerShape "ICON";
			_markerstrcache setMarkerText localize "STR_TRGM2_CacheMarkerText";	
			_markerstrcache setMarkerType "hd_dot";
		};		

		if (selectRandom[true,false,false]) then {
			[_posCache] execVM "RandFramework\RandScript\createEnemySniper.sqf";
		};

		_thisAreaRange = 20;
		_flatPos = nil;
		_flatPos = [_posCache , 0, 20, 10, 0, 0.2, 0,[[getMarkerPos "mrkHQ", BaseAreaRange]] + CheckPointAreas + SentryAreas,[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
		if (_flatPos select 0 > 0) then {
			_thisPosAreaOfCheckpoint = _flatPos;
			_thisRoadOnly = false;
			_thisSide = east; 
			_thisUnitTypes = [sRiflemanToUse, sRiflemanToUse,sRiflemanToUse,sMachineGunManToUse, sAmmobearerToUse, sGrenadierToUse, sMedicToUse,sAAManToUse,sATManToUse];
			_thisAllowBarakade = false;
			_thisIsDirectionAwayFromAO = false;
			[_posCache,_thisPosAreaOfCheckpoint,_thisAreaRange,_thisRoadOnly,_thisSide,_thisUnitTypes,_thisAllowBarakade,_thisIsDirectionAwayFromAO,true,UnarmedScoutVehicles,100,true,selectRandom[false,false,true],false] execVM "RandFramework\setCheckpoint.sqf";
		};

		//two guards at door!!!
		_building = (nearestBuilding _posCache);
		_spawnedUnit = ((createGroup east) createUnit [sRiflemanToUse, [-135,-253,0], [], 0, "NONE"]);
		_spawnedUnit setpos (_building buildingExit 0);

		_direction = [_building,_spawnedUnit] call BIS_fnc_DirTo;
		_spawnedUnit setDir _direction;
		_spawnedUnit setFormDir _direction;

		_i = 1;
		_minDis = 7;
		_doLoop = true;
		_checkedPositions = [];
		while {_doLoop && _i < 20} do
		{
			_newPos = (_building buildingExit _i);
			_allowed = true;
			{
				if !(_x distance _newPos > _minDis) then {
					_allowed = false;
				};				
			} forEach _checkedPositions;
			_checkedPositions pushBack _newPos;
			if (_allowed) then {
				//_doLoop = false;
				_spawnedUnit2 = ((createGroup east) createUnit [sRiflemanToUse, _newPos, [], 0, "NONE"]);
				_direction2 = [_building,_spawnedUnit2] call BIS_fnc_DirTo;
				_spawnedUnit2 setDir _direction2;
				_spawnedUnit2 setFormDir _direction2;
			};
			_i = _i + 1;		
		};

		_spawnedUnit3 = ((createGroup east) createUnit [sRiflemanToUse, [-135,-253,0], [], 0, "NONE"]);
		[getPos _building, [_spawnedUnit3], -1, false, false,false] execVM "RandFramework\Zen_OccupyHouse.sqf";

		if (selectRandom[true,false]) then {
			_spawnedUnit4 = ((createGroup east) createUnit [sRiflemanToUse, [-135,-253,0], [], 0, "NONE"]);
			[getPos _building, [_spawnedUnit4], -1, false, false,false] execVM "RandFramework\Zen_OccupyHouse.sqf";
		};
	}
	else {
		_objectiveCreated = false;
	};
};

if (!_objectiveCreated) then {
	_flatPosPolice1 = nil;

	if (_isMainTask) then {
		_flatPosPolice1 = [_posOfAO , 20, 400, 10, 0, 0.5, 0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
	}
	else {
		_eventPosFound = false;
		_iAttemptLimit = 15;		
		while {!_eventPosFound && _iAttemptLimit > 0} do {
			_iAttemptLimit = _iAttemptLimit - 1;
			_flatPosPolice1 = [_posOfAO , 500, 1500, 10, 0, 0.5, 0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
			_farEnoughFromWarzone = true;
			if (!isNil "WarzonePos") then {_farEnoughFromWarzone = (_flatPosPolice1 distance WarzonePos > 500)};
			if (_isMainTask || _farEnoughFromWarzone) then {_eventPosFound = true;};		
		};	
		if (!_eventPosFound) then {
			_flatPosPolice1 = [_posOfAO , 500, 1500, 10, 0, 0.5, 0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
		};
	};

	_mainVeh = nil;
	if (isNil "_objTarget") then {
		_mainVeh = createVehicle [selectRandom TargetCaches,_flatPosPolice1,[],50,"NONE"];
	}
	else {
		_objTarget setPos _flatPosPolice1;
		_mainVeh = _objTarget;
	};

	_posObj = getPos _mainVeh;

	if (_posOfAO distance (getPos _mainVeh) > 150 ) then {

		if (true) then { //if we failed the above trying to find a pos, then if we place in random place, just show marker
			_markerstrcache = createMarker [format ["IEDLoc%1",_posObj select 0],_posObj];
			_markerstrcache setMarkerShape "ICON";
			_markerstrcache setMarkerText localize "STR_TRGM2_CacheMarkerText";	
			_markerstrcache setMarkerType "hd_dot";
		};
	};

	_thisAreaRange = 20;
	_flatPos = nil;
	_flatPos = [_posObj , 0, 20, 5, 0, 0.2, 0,[[getMarkerPos "mrkHQ", BaseAreaRange]] + CheckPointAreas + SentryAreas,[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
	if (_flatPos select 0 > 0) then {
		_thisPosAreaOfCheckpoint = _flatPos;
		_thisRoadOnly = false;
		_thisSide = east; 
		_thisUnitTypes = [sRiflemanToUse, sRiflemanToUse,sRiflemanToUse,sMachineGunManToUse, sAmmobearerToUse, sGrenadierToUse, sMedicToUse,sAAManToUse,sATManToUse];
		_thisAllowBarakade = true;
		_thisIsDirectionAwayFromAO = true;
		[_posObj,_thisPosAreaOfCheckpoint,_thisAreaRange,_thisRoadOnly,_thisSide,_thisUnitTypes,_thisAllowBarakade,_thisIsDirectionAwayFromAO,true,UnarmedScoutVehicles,100,true,selectRandom[false,false,true],false,true] execVM "RandFramework\setCheckpoint.sqf";
	};



	if (selectRandom[true,false,false]) then {
		[_posObj] execVM "RandFramework\RandScript\createEnemySniper.sqf";
	};

	_spawnedUnitTarget1 = ((createGroup east) createUnit [sRiflemanToUse, _posObj, [], 10, "NONE"]);
	_directionTarget1 = [_mainVeh,_spawnedUnitTarget1] call BIS_fnc_DirTo;
	_spawnedUnitTarget1 setDir _directionTarget1;
	_spawnedUnitTarget1 setFormDir _directionTarget1;

	_spawnedUnitTarget2 = ((createGroup east) createUnit [sRiflemanToUse, _posObj, [], 10, "NONE"]);
	_directionTarget2 = [_mainVeh,_spawnedUnitTarget2] call BIS_fnc_DirTo;
	_spawnedUnitTarget2 setDir _directionTarget2;
	_spawnedUnitTarget2 setFormDir _directionTarget2;

	_NoRoadsOrBuildingsNear = false;
	_nearestHouseCount = count(nearestObjects [_posObj, ["building"],400]);
	if (_nearestHouseCount == 0) then {_NoRoadsOrBuildingsNear = true;};

	if (_NoRoadsOrBuildingsNear) then {
		_centerPos = _mainVeh getPos [ (random 150) , (random 360) ];
		_markerstrcacheZone = createMarker [format ["IEDLocZone%1",_centerPos select 0],_centerPos];
		_markerstrcacheZone setMarkerShape "ELLIPSE";
		_markerstrcacheZone setMarkerBrush "DIAGGRID";
		_markerstrcacheZone setMarkerColor "ColorYellow";
		_markerstrcacheZone setMarkerSize [150, 150];
	};
};
