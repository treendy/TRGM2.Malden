#include "../setUnitGlobalVars.sqf";

params [
	"_thisAOPos",
	"_thisPosAreaOfCheckpoint",
	"_thisAreaRange",
	"_thisRoadOnly",
	"_thisSide",
	"_thisUnitTypes",
	"_thisAllowBarakade",
	"_thisIsDirectionAwayFromAO",
	"_thisIsCheckPoint", // only used to store possitions in our checkpointareas and sentryareas arrays
	"_thisScoutVehicles",
	"_thisAreaAroundCheckpointSpacing",
	["_AllowAnimation", true]
];

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

if (isNil "CheckPointAreas") then {
		CheckPointAreas = [];
		publicVariable "CheckPointAreas";
};
if (isNil "SentryAreas") then {
		SentryAreas = [];
		publicVariable "SentryAreas";
};

if (isNil "ISUNSUNG") then {
		ISUNSUNG = false;
};




//{deleteVehicle _x} forEach nearestObjects [player, ["all"], 200];



_startPos = _thisPosAreaOfCheckpoint;
_nearestRoads = _startPos nearRoads _thisAreaRange;

_nearestRoad = nil;
_roadConnectedTo = nil;


_connectedRoad = nil;
_direction = nil;
//hint "2";
//sleep 1;

_PosFound = false;
_iAttemptLimit = 5;

if (_thisRoadOnly) then {

	while {!_PosFound && _iAttemptLimit > 0 && count _nearestRoads > 0} do {
		_nearestRoad = selectRandom _nearestRoads;
		_roadConnectedTo = roadsConnectedTo _nearestRoad;
		if (count _roadConnectedTo == 2) then {


			_connectedRoad = _roadConnectedTo select 0;
			_generalDirection = [_thisAOPos, _nearestRoad] call BIS_fnc_DirTo;
			_direction1 = [_nearestRoad, _connectedRoad] call BIS_fnc_DirTo;
			_direction2 = _direction1-180;
			if (_direction2 < 0) then {_direction2 = _direction2 + 360};
			_direction = 0;

			_dif1 = 0;
			_dif1A = _direction1 - _generalDirection;
			if (_dif1A < 0) then {_dif1A = _dif1A + 360};
			_dif1B = _generalDirection - _direction1;
			if (_dif1B < 0) then {_dif1B = _dif1B + 360};
			if (_dif1A < _dif1B) then {
				_dif1 = _dif1A;
			}
			else {
				_dif1 = _dif1B;
			};

			_dif2 = 0;
			_dif2A = _direction2 - _generalDirection;
			if (_dif2A < 0) then {_dif2A = _dif2A + 360};
			_dif2B = _generalDirection - _direction2;
			if (_dif2B < 0) then {_dif2B = _dif2B + 360};
			if (_dif2A < _dif2B) then {
				_dif2 = _dif2A;
			}
			else {
				_dif2 = _dif2B;
			};



			//hint format["AOAwayDir:%1 - dir1:%2 - dir2:%3  \nDif1:%4 - dif2:%5",_generalDirection,_direction1,_direction2,_dif1,_dif2];
			//sleep 5;


			if (_dif1 < _dif2) then {
				_direction = _direction1
			}
			else {
				_direction = _direction2
			};
			_PosFound = true;

		}
		else {
			//run loop again
			//Hint "Too many roads";

			_iAttemptLimit = _iAttemptLimit - 1;
		};
	};
};

if (!_thisRoadOnly || !_PosFound) then {
	_thisRoadOnly = false;
	_thisIsCheckPoint = false;
	_generalDirection = [_thisAOPos, _thisPosAreaOfCheckpoint] call BIS_fnc_DirTo;
	_dirAdd = 0;
	if (selectRandom[true,false]) then {
		_dirAdd = floor(random 40);
	}
	else {
		_dirAdd = -floor(random 40);
	};
	_direction = ([_generalDirection,_dirAdd] call fnc_AddToDirection);
	_PosFound = true;
	//hint format["DIR:%1",_direction];
	//sleep 3;
};

if (_PosFound) then {



	if (!_thisIsDirectionAwayFromAO) then {
		_direction = ([_direction,180] call fnc_AddToDirection);
	};
	_RoadSideBarricadesHigh = ["Land_Barricade_01_4m_F"];
	_RoadSideBarricadesLow = ["Land_BagFence_Long_F","Land_BagBunker_Small_F"];
	_FullRoadBarricades = ["Land_Barricade_01_10m_F"];
	_DefensiveObjects = ["Land_Barricade_01_4m_F","Land_BagFence_Long_F","FlagCarrierTakistan_EP1"];

	_initItem = nil;
	_BarrierToUse = "";

	_iBarricadeType = selectRandom ["HIGH","FULL","LOW","LOW"];

	_roadBlockPos =  nil;
	_roadBlockSidePos = nil;

	_NoRoadsOrBuildingsNear = false;

	if (_thisRoadOnly) then {
		_roadBlockPos =  getPos _nearestRoad;
		_roadBlockSidePos = _nearestRoad getPos [10, ([_direction,90] call fnc_AddToDirection)];
	}
	else {
		_flatPos = nil;
		_flatPos = [_thisPosAreaOfCheckpoint , 0, 50, 20, 0, 0.2, 0,[],[_thisPosAreaOfCheckpoint,_thisPosAreaOfCheckpoint]] call BIS_fnc_findSafePos;
		_roadBlockPos = _flatPos;
		_roadBlockSidePos = _flatPos;
		_allRoadsNear = _flatPos nearRoads 500;
		_nearestHouseCount = count(nearestObjects [_flatPos, ["building"],500]);
		if (count _allRoadsNear == 0 && _nearestHouseCount == 0) then {_NoRoadsOrBuildingsNear = true;};
	};

	if (_thisIsCheckPoint && _thisSide == east) then {
		//CheckPointAreas
		CheckPointAreas = CheckPointAreas + [[_roadBlockPos,_thisAreaAroundCheckpointSpacing]]; //the ,_thisAreaAroundCheckpointSpacing is for when we use BIS_fnc_findSafePos to make sure no other road block is within 100 meters
		publicVariable "CheckPointAreas";
	}
	else {
		//SentryAreas
		SentryAreas = SentryAreas + [[_roadBlockPos,_thisAreaAroundCheckpointSpacing]];
	};


	_slope = abs(((getTerrainHeightASL _roadBlockSidePos)) - ((getTerrainHeightASL  _roadBlockPos)));
	if (_slope > 0.6) then {
		_iBarricadeType = "FULL"; //if slope too much, then bunker and other barricades on side of road will have gap on one side
	};

	_nearestHouseObjectDist = (nearestObject [_roadBlockSidePos, "building"]) distance _roadBlockSidePos;
	//_nearestWallObjectDist = (nearestObject [_roadBlockSidePos, "wall"]) distance _roadBlockSidePos;
	//hint format["nearestWallObjectDist: %1",_nearestHouseObjectDist];
	//sleep 2;
	if (_nearestHouseObjectDist < 10) then {
		_iBarricadeType = "FULL"; //if slope too much, then bunker and other barricades on side of road will have gap on one side
	};
	if (_NoRoadsOrBuildingsNear) then {
		_iBarricadeType = "LOW";
	};
	if (!_thisAllowBarakade) then {
		_iBarricadeType = "NONE";
	};

	if (_iBarricadeType == "HIGH") then {
		_initItem = selectRandom _RoadSideBarricadesHigh createVehicle _roadBlockSidePos;
		_initItem setDir ([_direction,180] call fnc_AddToDirection);
	};
	if (_iBarricadeType == "FULL") then {
		_initItem = selectRandom _FullRoadBarricades createVehicle _roadBlockPos;
		_initItem setDir ([_direction,180] call fnc_AddToDirection);
	};
	if (_iBarricadeType == "LOW") then {
		_initItem = selectRandom _RoadSideBarricadesLow createVehicle _roadBlockSidePos;
		_initItem setDir ([_direction,180] call fnc_AddToDirection);

		if (_thisSide == east) then {
			_NearTurret1 = createVehicle [selectRandom["CUP_O_KORD_high_TK"], _initItem getPos [1,_direction+180], [], 0, "CAN_COLLIDE"];
			_NearTurret1 setDir (_direction);
			createVehicleCrew _NearTurret1;
		};
	};
	if (_iBarricadeType == "NONE") then {  //if none, then either use flag or defensive object
		//FlagCarrierTakistan_EP1, FlagCarrierTKMilitia_EP1
		if (!(isOnRoad _roadBlockSidePos) && selectRandom[true,false]) then {
			_initItem = selectRandom _DefensiveObjects createVehicle _roadBlockSidePos;
			_initItem setDir ([_direction,180] call fnc_AddToDirection);
		}
		else {
			_initItem = "Land_HelipadEmpty_F" createVehicle _roadBlockSidePos;
			_initItem setDir ([_direction,180] call fnc_AddToDirection);
		};

	};
	if (!ISUNSUNG) then {
		if (_iBarricadeType != "NONE" && selectRandom [true,false]) then {
			[_initItem,_thisSide] spawn {
				_initItem = _this select 0;
				_thisSide = _this select 1;
				while {alive(_initItem)} do {
					_soundToPlay = selectRandom EnemyRadioSounds;
					if (_thisSide == west) then {_soundToPlay = selectRandom FriendlyRadioSounds};
					playSound3D ["A3\Sounds_F\sfx\radio\" + _soundToPlay + ".wss",_initItem,false,getPosASL _initItem,0.5,1,0];
					sleep selectRandom [10,15,20,30];
				};
			};
		};
	};

	_bHasParkedCar = false;
	_ParkedCar = nil;
	if (selectRandom [true,true,true,false] || _thisSide == west) then {
		_behindBlockPos = _initItem getPos [10,([_direction,180] call fnc_AddToDirection)];
		_flatPos = nil;
		_flatPos = [_behindBlockPos , 0, 10, 10, 0, 0.5, 0,[],[_behindBlockPos,_behindBlockPos]] call BIS_fnc_findSafePos;
		_ParkedCar = selectRandom _thisScoutVehicles createVehicle _flatPos;
		_ParkedCar setDir (floor(random 360));
		_bHasParkedCar = true;
	};
	if (_NoRoadsOrBuildingsNear) then {
		if (selectRandom [true,true,true,false]) then {
			_behindBlockPos = _initItem getPos [15,([_direction,180] call fnc_AddToDirection)];
			_flatPos = nil;
			_flatPos = [_behindBlockPos , 0, 15, 10, 0, 0.5, 0,[],[_behindBlockPos,_behindBlockPos]] call BIS_fnc_findSafePos;
			_Tent1 = "Land_TentA_F" createVehicle _flatPos;
			_Tent1 setDir (floor(random 360));

			_flatPos2 = nil;
			_flatPos2 = [getPos _Tent1 , 0, 10, 10, 0, 0.5, 0,[],[_behindBlockPos,_behindBlockPos]] call BIS_fnc_findSafePos;
			_Tent2 = "Land_TentA_F" createVehicle _flatPos2;
			_Tent2 setDir (floor(random 360));

			_flatPos3 = nil;
			_flatPos3 = [getPos _Tent1 , 0, 10, 10, 0, 0.5, 0,[],[_behindBlockPos,_behindBlockPos]] call BIS_fnc_findSafePos;
			_Tent3 = "Campfire_burning_F" createVehicle _flatPos2;
			_Tent3 setDir (floor(random 360));

			_flatPos4 = nil;
			_flatPos4 = [getPos _Tent1 , 0, 10, 10, 0, 0.5, 0,[],[_behindBlockPos,_behindBlockPos]] call BIS_fnc_findSafePos;
			_Tent4 = "Land_WoodPile_F" createVehicle _flatPos2;
			_Tent4 setDir (floor(random 360));

		}
	};
	_behindBlockPos2 = _initItem getPos [3,([_direction,180] call fnc_AddToDirection)];
	if (selectRandom [true,true,true,false]) then {

		_flatPos = nil;
		_flatPos = [_behindBlockPos2 , 0, 5, 7, 0, 0.5, 0,[],[_behindBlockPos2,_behindBlockPos2]] call BIS_fnc_findSafePos;
		_FloodLight = selectRandom ["Land_PortableLight_single_F"] createVehicle _flatPos;
		_FloodLight setDir (([_direction,180] call fnc_AddToDirection));
	};
	//Land_PortableLight_single_F

	if (ISUNSUNG) then {
		if (selectRandom [true,true,true]) then {
			_flatPos = nil;
			_flatPos = [_behindBlockPos2 , 0, 5, 7, 0, 0.5, 0,[],[_behindBlockPos2,_behindBlockPos2]] call BIS_fnc_findSafePos;
			_radio = nil;
			if (_thisSide == west) then {
				_radio = selectRandom ["uns_radio2_radio","uns_radio2_transitor","uns_radio2_transitor02"] createVehicle _flatPos;
			}
			else {
				_radio = selectRandom ["uns_radio2_transitor_NVA","uns_radio2_transitor_NVA","uns_radio2_nva_radio","uns_radio2_recorder"] createVehicle _flatPos;
			};
			_radio setDir (([_direction,180] call fnc_AddToDirection));
		};
	};


	//_pos1 = _initItem getPos [3,100];
	_pos1 = _initItem getPos [3,([_direction,100] call fnc_AddToDirection)];

	_pos2 = _initItem getPos [4,([_direction,80] call fnc_AddToDirection)];
	_group = createGroup _thisSide;
	_group setFormDir _direction;

	_sUnitType = selectRandom _thisUnitTypes;
	_guardUnit1 = _group createUnit [_sUnitType,_pos1,[],0,"NONE"];
	doStop [_guardUnit1];
	_guardUnit1 setDir (_direction);
 	if (_AllowAnimation) then {[_guardUnit1,"WATCH","ASIS"] call BIS_fnc_ambientAnimCombat;};
	//hint "HMM2";
	if (selectRandom [true,true,false]) then {
		_sUnitType = selectRandom _thisUnitTypes;
		_guardUnit2 = _group createUnit [_sUnitType,_pos2,[],0,"NONE"];
		doStop [_guardUnit2];
		_guardUnit2 setDir (_direction);
		//[_guardUnit2,"STAND","ASIS"] call BIS_fnc_ambientAnimCombat;
	}
	else {
		_pos3 = [_behindBlockPos2 , 0, 10, 10, 0, 0.5, 0,[],[_behindBlockPos2,_behindBlockPos2]] call BIS_fnc_findSafePos;
		_pos4 = [_behindBlockPos2 , 0, 10, 10, 0, 0.5, 0,[],[_behindBlockPos2,_behindBlockPos2]] call BIS_fnc_findSafePos;


		_chatDir1 = [_pos3, _pos4] call BIS_fnc_DirTo;
		_chatDir2 = [_pos4, _pos3] call BIS_fnc_DirTo;

		_group2 = createGroup _thisSide;
		_group2 setFormDir _chatDir1;
		_group3 = createGroup _thisSide;
		_group3 setFormDir _chatDir2;

		_sUnitType = selectRandom _thisUnitTypes;
		_guardUnit3 = _group2 createUnit [_sUnitType,_pos3,[],0,"NONE"];
		doStop [_guardUnit3];
		_guardUnit3 setDir (_chatDir1);

		_sUnitType = selectRandom _thisUnitTypes;
		_guardUnit4 = _group3 createUnit [_sUnitType,_pos4,[],0,"NONE"];
		doStop [_guardUnit4];
		_guardUnit4 setDir (_chatDir2);


		//[_guardUnit3,"STAND","ASIS"] call BIS_fnc_ambientAnimCombat;

		if (_AllowAnimation) then {
			if (!_bHasParkedCar) then {
				[_guardUnit4,"STAND_IA","ASIS"] call BIS_fnc_ambientAnimCombat;
			}
			else {
				_LeanDir = ([direction _ParkedCar,45] call fnc_AddToDirection);
				_group3 setFormDir _LeanDir;
				doStop [_guardUnit4];
				_guardUnit4 setDir (_LeanDir);
				sleep 0.1;
				_LeanPos = _ParkedCar getPos [1,_LeanDir];
				sleep 0.1;
				_guardUnit4 setPos _LeanPos;
				sleep 0.1;
				[_guardUnit4,"LEAN","ASIS"] call BIS_fnc_ambientAnimCombat;
			};
		};
	};

	_group4 = createGroup _thisSide;
	_sCheckpointGuyName = format["objCheckpointGuyName%1",(floor(random 999999))];


	_pos5 = [_behindBlockPos2 , 0, 10, 10, 0, 0.5, 0,[],[_behindBlockPos2,_behindBlockPos2]] call BIS_fnc_findSafePos;

	_guardUnit5 = _group4 createUnit [_sUnitType,_pos5,[],0,"NONE"];
	_guardUnit5 setVariable [_sCheckpointGuyName, _guardUnit5, true];
	missionNamespace setVariable [_sCheckpointGuyName, _guardUnit5];
	if (_thisSide == west) then {
		[[_guardUnit5, [localize "STR_TRGM2_setCheckpoint_Ask","RandFramework\SpeakToFriendlyCheckpoint.sqf",[_pos5]]],"addAction",true,true] call BIS_fnc_MP;
		if (selectRandom [true,true,false]) then {
			_test = nil;
			_test = createMarker [format["MrkFriendCheckpoint%1%2",_roadBlockPos select 0, _roadBlockPos select 1], _roadBlockPos];
			_test setMarkerShape "ICON";
			_test setMarkerType "b_inf";
			_test setMarkerText (localize "STR_TRGM2_setCheckpoint_MarkerText");
		};
	};
	TREND_fnc_WalkingGuyLoop = {
		_objManName = _this select 0;
		_thisInitPos = _this select 1;
		_objMan = missionNamespace getVariable _objManName;

		group _objMan setSpeedMode "LIMITED";
		group _objMan setBehaviour "SAFE";

		while {true && alive(_objMan)} do {
			if (behaviour _objMan != "COMBAT") then {
				[_objManName,_thisInitPos,_objMan,35] execVM "RandFramework\HVTWalkAround.sqf";
				sleep 2;
				waitUntil {sleep 1; speed _objMan < 0.5};
				sleep 10;
			};
		};
	};
	[_sCheckpointGuyName,_pos5] spawn TREND_fnc_WalkingGuyLoop;
};


