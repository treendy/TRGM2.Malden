//These are only ever called by the server!

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
	
	//trigger, that will fire if enemy number is less than X

	//when triggered, get all enemy (even ones in houses) to move to center, then move random

	//and also, call in chopper for supply drops and extraction chopper

	//when supply dropped and players are rtb, mission is success


	//spawn checkpoint with flag
	_thisAreaRange = 50;
	_checkPointGuidePos = _mainObjPos;
	_flatPos = nil;
	_flatPos = [_checkPointGuidePos , 0, 50, 10, 0, 0.2, 0,[[getMarkerPos "mrkHQ", BaseAreaRange]] + CheckPointAreas + SentryAreas,[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
	if (_flatPos select 0 > 0) then {
		_thisPosAreaOfCheckpoint = _flatPos;
		_thisRoadOnly = true;
		_thisSide = east;
		_thisUnitTypes = [sRifleman, sRifleman,sRifleman,sMachineGunMan, sAmmobearer, sAmmobearer, sMedic,sAAMan];
		_thisAllowBarakade = selectRandom [true];
		_thisIsDirectionAwayFromAO = true;
		[_mainObjPos,_thisPosAreaOfCheckpoint,_thisAreaRange,_thisRoadOnly,_thisSide,_thisUnitTypes,_thisAllowBarakade,_thisIsDirectionAwayFromAO,false,UnarmedScoutVehicles,50] execVM "RandFramework\setCheckpoint.sqf";
	};
	
	//create flag and give its id
	_flag = selectRandom EnemyFlags createVehicle _flatPos;
	_flagName = format["ObjFlag%1",_iTaskIndex];
	_flag setVariable [_flagName, _flag, true];
	missionNamespace setVariable [_flagName, _flag];

	//attach addaction to lowerflag and call supplydrop
	[
		_flag,											// Object the action is attached to
		localize "STR_TRGM2_FlagLowerCallSupply",			// Title of the action
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unbind_ca.paa",	// Idle icon shown on screen
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unbind_ca.paa",	// Progress icon shown on screen
		"_this distance _target < 35",						// Condition for the action to be shown
		"_caller distance _target < 35",						// Condition for the action to progress
		{},													// Code executed when action starts
		{},													// Code executed on every progress tick
		{
			_args = _this select 3;
			_iTaskIndex = _args select 0;
			_flag = _this select 0;
			_pos = getPos _flag; 
			deleteVehicle _flag;
			_flagName = format["ObjFlag%1",_iTaskIndex];			
			_newFlag = createVehicle ["FlagPole_F", _pos, [], 0, "CAN_COLLIDE"];
			_newFlag setVariable [_flagName, _newFlag, true];
			missionNamespace setVariable [_flagName, _newFlag];
			_newFlag setVariable ["Lowered",true];
			//WRITE SCRIPT HERE TO CALL SUPPLYDROP!
			private _heliclass = "B_Heli_Transport_03_F";
			private _boxclass = "B_supplyCrate_F";
			private _chuteType = "B_Parachute_02_F";
			private _boxCode = compile "null = [_this] spawn fnc_dropboxinit;";
			private _helistart = getMarkerPos "mrkHQ";// marker where the heli spawns or position array [posX,posY,posZ]
			
			null = [[_flag,getPos(_flag),_heliclass,_boxclass,_chuteType,_boxCode,_helistart,west],
			
			_AirToUse = selectRandom FriendlyChopper;
			

		},													// Code executed on completion
		{},													// Code executed on interrupted
		[_iTaskIndex],										// Arguments passed to the scripts as _this select 3
		6,													// Action duration [s]
		100,												// Priority
		false,												// Remove on completion
		false												// Show in unconscious state 
	] remoteExec ["BIS_fnc_holdActionAdd", 0, _flag];	// MP compatible implementation


	_customTaskClear = nil;
	_customTaskClear = createTrigger ["EmptyDetector", [0,0]];
	_customTaskClear setVariable ["DelMeOnNewCampaignDay",true];
	
	_customTaskClearCondition = format["ObjFlag%1 getVariable [""SomethingOrCheckSupBoxInArea"", false]",_iTaskIndex];

	if (!_bCreateTask) then {
		_customTaskClear setTriggerStatements [_customTaskClearCondition, " [1, ""Cache Destroyed""] execVM ""RandFramework\AdjustMaxBadPoints.sqf""; Hint (""Cache Destroyed, Rep increased""); ClearedPositions pushBack ([ObjectivePossitions, getPos objInformant" + str(_iTaskIndex) + "] call BIS_fnc_nearestPosition); publicVariable ""ClearedPositions"";", ""];			
	}
	else {		
		_sTaskComplete = format["[""InfSide%1"", ""succeeded""] remoteExec [""FHQ_TT_setTaskState"", 0]; ClearedPositions pushBack ([ObjectivePossitions, getPos objInformant%1] call BIS_fnc_nearestPosition); publicVariable ""ClearedPositions"";",_iTaskIndex];
		_customTaskClear setTriggerStatements [_customTaskClearCondition, _sTaskComplete, ""];	
	};
};
