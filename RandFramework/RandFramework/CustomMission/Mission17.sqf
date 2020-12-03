//These are only ever called by the server!

//MISSION 17: Secure and resupply area

fnc_CustomRequired = { //used to set any required details for the AO (example, a wide open space or factory nearby)... if this is not found in AO, the engine will scrap the area and loop around again with a different location
//be careful about using this, some maps may not have what you require, so the engine will never satisfy the requirements here (example, if no airports are on a map and that is what you require)
	_objectiveMainBuilding = _this select 0;
	_centralAO_x = _this select 1;
	_centralAO_y = _this select 2;

	_result = true; //always returing true, because we have in custom vars "_RequiresNearbyRoad" which will take care of our checks
	_result; //return value
};

fnc_CustomVars = { //This is called before the mission function is called below, and the variables below can be adjusted for your mission
	_RequiresNearbyRoad = false;
	_roadSearchRange = 100; //this is how far out the engine will check to make sure a road is within range (if your objective requires a nearby road)
	_allowFriendlyIns = false;
	_MissionTitle = localize "STR_TRGM2_ClearAreaMissionTitle"; //this is what shows in dialog mission selection
};

fnc_CustomMission = { //This function is the main script for your mission, some if the parameters passed in must not be changed!!!
	_markerType = _this select 0;
	_objectiveMainBuilding = _this select 1; //DO NOT EDIT THIS VALUE (this is the main building location selected within your AO)
	_centralAO_x = _this select 2; //DO NOT EDIT THIS VALUE
	_centralAO_y = _this select 3; //DO NOT EDIT THIS VALUE
	_roadSearchRange = _this select 4; //this is past in from the engine, and is the value you set above (DO NOT INREASE THE VALUE ON THIS LINE!!, you can decrease as it will pick a road within your range above)
	_bCreateTask = _this select 5; //the engine passes this in, it will be set to false for option sides mission, and the action to happen when this mission is complete is set in the lines at the bottom of this file
	_iTaskIndex = _this select 6; // for the engine, so it knows which index it is working on (do not change this value!!)
	_bIsMainObjective = _this select 7;
	if (_markerType != "empty") then { _markerType = "hd_objective"; }; //You can set the type of marker here, but if the player has selected to hide mission locations, then your marker will not show


	//_MissionTitle = format["Meeting Assassination: %1",name(_mainHVT)];	//you can adjust this here to change what shows as marker and task text
	_sTaskDescription = selectRandom[localize "STR_TRGM2_ClearAreaMissionDescription"]; //adjust this based on veh? and man? if van then if car then?

	_mainObjPos = getPos _objectiveMainBuilding;

	//spawn checkpoint with flag
	_thisAreaRange = 100;
	_checkPointGuidePos = _mainObjPos;
	_flatPos = _mainObjPos;
	_flatPos = [_checkPointGuidePos , 0, 50, 10, 0, 0.2, 0,[[getMarkerPos "mrkHQ", TREND_BaseAreaRange]] + TREND_CheckPointAreas + TREND_SentryAreas,[_mainObjPos,_mainObjPos]] call BIS_fnc_findSafePos;
	if (_flatPos select 0 > 0) then {
		_thisPosAreaOfCheckpoint = _flatPos;
		_thisRoadOnly = true;
		_thisSide = east;
		_thisUnitTypes = [sRifleman, sRifleman,sRifleman,sMachineGunMan, sEngineer, sEngineer, sMedic,sAAMan];
		_thisAllowBarakade = selectRandom [true];
		_thisIsDirectionAwayFromAO = true;
		[_mainObjPos,_thisPosAreaOfCheckpoint,_thisAreaRange,_thisRoadOnly,_thisSide,_thisUnitTypes,_thisAllowBarakade,_thisIsDirectionAwayFromAO,false,UnarmedScoutVehicles,50] spawn TREND_fnc_setCheckpoint;
	};

	//create flag and give its id
	_flag = selectRandom EnemyFlags createVehicle _flatPos;
	_flagName = format["ObjFlag%1",_iTaskIndex];
	_flag setVariable [_flagName, _flag, true];
	missionNamespace setVariable [format ["SupplyDropped_%1", _iTaskIndex], 0];
	missionNamespace setVariable [_flagName, _flag];
	_flag setflagAnimationPhase 1;
	_flag setFlagTexture "\A3\Data_F\Flags\flag_red_CO.paa";
	_flag setVariable ["TREND_flagSide", east];

	//attach addaction to lowerflag and call supplydrop
	[
		_flag,																							// Object the action is attached to
		localize "STR_TRGM2_FlagLowerCallSupply",														// Title of the action
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unbind_ca.paa",									// Idle icon shown on screen
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unbind_ca.paa",									// Progress icon shown on screen
		"_this distance _target < 35 && _target getVariable [""TREND_flagSide"", east] != west",		// Condition for the action to be shown
		"_caller distance _target < 35", 																// Condition for the action to progress
		{},																								// Code executed when action starts
		{
			params ["_flag", "_caller", "_actionId", "_arguments", "_progress", "_maxProgress"];
			_relProgress = _progress/_maxProgress;
			[[_flag, _relProgress], {
				if ((_this select 1) < 0.5) then {
					(_this select 0) setFlagAnimationPhase (1-(2*(_this select 1)));
				} else {
					if ((_this select 1) == 0.5) then {(_this select 0) setFlagTexture "\A3\Data_F\Flags\flag_blue_CO.paa"};
					(_this select 0) setFlagAnimationPhase ((2*(_this select 1))-1);
				};
			}] remoteExec ["call"];
		},																								// Code executed on every progress tick
		{
			params ["_flag", "_caller", "_actionId", "_arguments"];
			_arguments params ["_iTaskIndex"];
			_flag setVariable ["TREND_flagSide",west];
			_flag setVariable ["Lowered",true];
		},																								// Code executed on completion
		{
			params ["_flag", "_caller", "_actionId", "_arguments"];
			_flag setFlagAnimationPhase 1;
			_side = _flag getVariable ["TREND_flagSide",east];
			_flag setFlagTexture "\A3\Data_F\Flags\flag_red_CO.paa";
		},																								// Code executed on interrupted
		[_iTaskIndex],																					// Arguments passed to the scripts as _this select 3
		6,																								// Action duration [s]
		100,																							// Priority
		false,																							// Remove on completion
		false																							// Show in unconscious state
	] remoteExec ["BIS_fnc_holdActionAdd", 0, _flag];													// MP compatible implementation

	[_flag, _iTaskIndex] spawn {
		params ["_flag", "_iTaskIndex"];
		waitUntil { sleep 30; _flag getVariable ["Lowered",false]; };

		{
			_pos = getPos _flag;
			_group = _x;
			if (side _group == east || side _group == independent) then {
				_groupLeader = leader _group;
				if ((getPos _groupLeader) distance _pos < 1500) then {
					{
						_unit = _x;
						_unit setCombatMode "RED";
						_unit setBehaviour "AWARE";
						_unit setUnitPos "AUTO";
						_unit = _x;
						_unit forceSpeed -1;
						_unit doMove _pos;
					} forEach units _group;
				};
			};
		} forEach allGroups;

		[EAST, TREND_ReinforceStartPos1, getPos _flag, 3, true, true, true, true, false] spawn TREND_fnc_reinforcements;
		[EAST, TREND_ReinforceStartPos2, getPos _flag, 3, true, true, true, false, false] spawn TREND_fnc_reinforcements;
		sleep 10;
		if (TREND_AdvancedSettings select TREND_ADVSET_HIGHER_ENEMY_COUNT_IDX == 1 || (TREND_AdvancedSettings select TREND_ADVSET_HIGHER_ENEMY_COUNT_IDX == 0 && selectRandom[false,true])) then {
			[EAST, TREND_ReinforceStartPos1, getPos _flag, 3, true, true, true, true, false] spawn TREND_fnc_reinforcements;
			[EAST, TREND_ReinforceStartPos2, getPos _flag, 3, true, true, true, false, false] spawn TREND_fnc_reinforcements;
			sleep 10;
		};

		{hint (format[localize "STR_TRGM2_MinUntilSupplyChopperInArea", "5:00"]);} remoteExec ["bis_fnc_call", 0];
		if (!TREND_bDebugMode) then {
			sleep 300; //wait 5 mins before supply drop in area
		};
		{hint (localize "STR_TRGM2_SupplyChopperInbound");} remoteExec ["bis_fnc_call", 0];

		TREND_dropCrate = false; publicVariable "TREND_dropCrate";

		private _airToUse = selectRandom SupplySupportChopperOptions;
		private _heloGroup = createGroup west;
		private _spawnPos = _flag getRelPos [3000, random 360];
		private _exitPos = _flag getRelPos [25000, random 360];
		private _airDropHeloArray = [[(_spawnPos select 0), (_spawnPos select 1)], 45, _airToUse, _heloGroup] call BIS_fnc_spawnvehicle;
		airDropHelo1 = _airDropHeloArray select 0;

		airDropHelo1 flyInHeight 40;
		airDropHelo1 allowDamage false;
		airDropHelo1 enableAttack false;
		airDropHelo1 setBehaviour "CARELESS";
		airDropHelo1 setCombatMode "BLUE";
		airDropHelo1 disableAi "TARGET";
		airDropHelo1 disableAi "AUTOTARGET";
		airDropHelo1 disableAi "FSM";
		airDropHelo1 setCaptive true;

		private _v1wp1 = _heloGroup addWaypoint [[(_spawnPos select 0), (_spawnPos select 1)], 0];
		[_heloGroup, 0] setWaypointStatements ["true", "airDropHelo1 flyInHeight 200;"];
		[_heloGroup, 0] setWaypointSpeed "FULL";
		[_heloGroup, 0] setWaypointBehaviour "COMBAT";

		private _v1wp2 = _heloGroup addWaypoint [getPos _flag, 0];
		[_heloGroup, 1] setWaypointStatements ["true", "airDropHelo1 flyInHeight 200; "];
		[_heloGroup, 1] setWaypointSpeed "FULL";

		private _v1wp3 = _heloGroup addWaypoint [[(_exitPos select 0), (_exitPos select 1)], 0];
		[_heloGroup, 2] setWaypointStatements ["true", "airDropHelo1 flyInHeight 200; TREND_dropCrate = true; publicVariable ""TREND_dropCrate"";"];
		[_heloGroup, 2] setWaypointSpeed "FULL";

		waitUntil { TREND_dropCrate; };
		sleep 1;

		private _supplyObjectDummy = "B_supplyCrate_f" createVehicle [0,0,200];
		_supplyObjectDummy allowDamage false;
		_supplyObjectDummy setPos [getPos _flag select 0, getPos _flag select 1, 200];

		waitUntil { getPos _supplyObjectDummy select 2 < 75};

		private _para = "B_Parachute_02_F" createVehicle [getPos _flag select 0, getPos _flag select 1, 100];
		_supplyObjectDummy attachTo [_para, [0,0,-1]];
		_para setPos [getPos _flag select 0, getPos _flag select 1, 100];

		waitUntil { getPos _supplyObjectDummy select 2 >= 0 && getPos _supplyObjectDummy select 2 <= 1};

		detach _supplyObjectDummy;
		sleep 0.1;
		deleteVehicle _para;

		private _finalPos = getPosATL _supplyObjectDummy;
		sleep 0.1;
		deleteVehicle _supplyObjectDummy;
		"SmokeShellBlue" createVehicle _finalPos;
		sleep 0.1;
		private _supplyObject = "B_supplyCrate_f" createVehicle _finalPos;
		{
			{
				_supplyObject addMagazineCargoGlobal [_x, 2];
			} forEach magazines _x + primaryWeaponMagazine _x + secondaryWeaponMagazine _x + handgunMagazine _x;
		}  forEach units group player;
		_supplyObject allowDamage false;
		_supplyObject setPosATL _finalPos;
		_supplyObject setVectorUp surfaceNormal position _supplyObject;
		_supplyObject allowDamage true;
		TREND_dropCrate = false; publicVariable "TREND_dropCrate";
		{deleteVehicle _x;} forEach crew (vehicle airDropHelo1) + [vehicle airDropHelo1];
		missionNamespace setVariable [format ["SupplyDropped_%1", _iTaskIndex], 1];

		waitUntil { !TREND_dropCrate; };

		{hint (localize "STR_TRGM2_SupplyChopperInbound");} remoteExec ["bis_fnc_call", 0];

		_heloGroup = createGroup west;
		_spawnPos = _flag getRelPos [3000, random 360];
		_exitPos = _flag getRelPos [25000, random 360];
		_airDropHeloArray = [[(_spawnPos select 0), (_spawnPos select 1)], 45, _airToUse, _heloGroup] call BIS_fnc_spawnvehicle;
		airDropHelo2 = _airDropHeloArray select 0;

		airDropHelo2 flyInHeight 40;
		airDropHelo2 allowDamage false;
		airDropHelo2 enableAttack false;
		airDropHelo2 setBehaviour "CARELESS";
		airDropHelo2 setCombatMode "BLUE";
		airDropHelo2 disableAi "TARGET";
		airDropHelo2 disableAi "AUTOTARGET";
		airDropHelo2 disableAi "FSM";
		airDropHelo2 setCaptive true;

		_v1wp1 = _heloGroup addWaypoint [[(_spawnPos select 0), (_spawnPos select 1)], 0];
		[_heloGroup, 0] setWaypointStatements ["true", "airDropHelo2 flyInHeight 200;"];
		[_heloGroup, 0] setWaypointSpeed "FULL";
		[_heloGroup, 0] setWaypointBehaviour "COMBAT";

		_v1wp2 = _heloGroup addWaypoint [getPos _flag, 0];
		[_heloGroup, 1] setWaypointStatements ["true", "airDropHelo2 flyInHeight 200; "];
		[_heloGroup, 1] setWaypointSpeed "FULL";

		_v1wp3 = _heloGroup addWaypoint [[(_exitPos select 0), (_exitPos select 1)], 0];
		[_heloGroup, 2] setWaypointStatements ["true", "airDropHelo2 flyInHeight 200; TREND_dropCrate = true; publicVariable ""TREND_dropCrate"";"];
		[_heloGroup, 2] setWaypointSpeed "FULL";

		waitUntil { TREND_dropCrate; };
		sleep 1;

		_supplyObjectDummy = "B_supplyCrate_f" createVehicle [0,0,200];
		_supplyObjectDummy allowDamage false;
		_supplyObjectDummy setPos [getPos _flag select 0, getPos _flag select 1, 200];

		waitUntil { getPos _supplyObjectDummy select 2 < 75};

		_para = "B_Parachute_02_F" createVehicle [getPos _flag select 0, getPos _flag select 1, 100];
		_supplyObjectDummy attachTo [_para, [0,0,-1]];
		_para setPos [getPos _flag select 0, getPos _flag select 1, 100];

		waitUntil { getPos _supplyObjectDummy select 2 >= 0 && getPos _supplyObjectDummy select 2 <= 1};

		detach _supplyObjectDummy;
		sleep 0.1;
		deleteVehicle _para;

		_finalPos = getPosATL _supplyObjectDummy;
		sleep 0.1;
		deleteVehicle _supplyObjectDummy;
		"SmokeShellBlue" createVehicle _finalPos;
		sleep 0.1;
		_supplyObject = "B_supplyCrate_f" createVehicle _finalPos;
		{
			{
				_supplyObject addMagazineCargoGlobal [_x, 2];
			} forEach magazines _x + primaryWeaponMagazine _x + secondaryWeaponMagazine _x + handgunMagazine _x;
		}  forEach units group player;
		_supplyObject allowDamage false;
		_supplyObject setPosATL _finalPos;
		_supplyObject setVectorUp surfaceNormal position _supplyObject;
		_supplyObject allowDamage true;
		TREND_dropCrate = false; publicVariable "TREND_dropCrate";
		{deleteVehicle _x;} forEach crew (vehicle airDropHelo2) + [vehicle airDropHelo2];
		missionNamespace setVariable [format ["SupplyDropped_%1", _iTaskIndex], 2];
	};

	_customTaskClear = nil;
	_customTaskClear = createTrigger ["EmptyDetector", [0,0]];
	_customTaskClear setVariable ["DelMeOnNewCampaignDay",true];

	_sTaskCheck = format["missionNamespace getVariable ['SupplyDropped_%1', 0] == 2 && !(['InfSide%1'] call FHQ_fnc_ttAreTasksCompleted)",_iTaskIndex];

	if (!_bCreateTask) then {
		_sTaskComplete = format["[1, 'Area Cleared'] spawn TREND_fnc_AdjustMaxBadPoints; Hint ('Area Cleared, Rep increased'); TREND_ClearedPositions pushBack ([TREND_ObjectivePossitions, getPos objInformant%1 ] call BIS_fnc_nearestPosition); publicVariable 'TREND_ClearedPositions';",_iTaskIndex];
		_customTaskClear setTriggerStatements [_sTaskCheck, _sTaskComplete, ""];
	}
	else {
		_sTaskComplete = format["['InfSide%1', 'succeeded'] remoteExec ['FHQ_fnc_ttSetTaskState', 0]; TREND_ClearedPositions pushBack ([TREND_ObjectivePossitions, getPos objInformant%1] call BIS_fnc_nearestPosition); publicVariable 'TREND_ClearedPositions';",_iTaskIndex];
		_customTaskClear setTriggerStatements [_sTaskCheck, _sTaskComplete, ""];
	};
};