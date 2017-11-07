#include "..\setUnitGlobalVars.sqf";
#include "..\RandFramework\RandScript\trendFunctions.sqf";

//This is only ever called on server!!!!

TRGM_Logic setVariable ["DeathRunning", false, true];
TRGM_Logic setVariable ["PointsUpdating", false, true];




_ThisTaskTypes = nil;
_IsMainObjs = nil;
_MarkerTypes = nil;
_CreateTasks = nil;

_MainMissionTasksToUse = MainMissionTasks;
_SideMissionTasksToUse = SideMissionTasks;
if (iMissionParamObjective > 0) then {
	_MainMissionTasksToUse = [iMissionParamObjective];
	_SideMissionTasksToUse = [iMissionParamObjective];
};

iMissionSetup = iMissionParamType;
if (iMissionSetup == 0) then {
	_ThisTaskTypes = [selectRandom _MainMissionTasksToUse,selectRandom SideMissionTasks,selectRandom SideMissionTasks];
	_IsMainObjs = [true,false,false]; //if false, then chacne of no enemu, or civs only etc.... if true, then more chacne of bad shit happening
	_MarkerTypes = ["mil_objective","hd_dot","hd_dot"];
	_CreateTasks = [true,false,false];
	MaxBadPoints = 3;
};
if (iMissionSetup == 1) then {
	_ThisTaskTypes = [selectRandom _MainMissionTasksToUse,selectRandom SideMissionTasks,selectRandom SideMissionTasks];
	_IsMainObjs = [true,false,false]; //if false, then chacne of no enemu, or civs only etc.... if true, then more chacne of bad shit happening
	_MarkerTypes = ["empty","hd_dot","hd_dot"];
	_CreateTasks = [true,false,false];
	MaxBadPoints = 4;
};
if (iMissionSetup == 2) then {
	_ThisTaskTypes = [selectRandom _MainMissionTasksToUse];
	_IsMainObjs = [true]; //if false, then chacne of no enemu, or civs only etc.... if true, then more chacne of bad shit happening
	_MarkerTypes = ["mil_objective"];
	_CreateTasks = [true];
	MaxBadPoints = 3;
};
if (iMissionSetup == 3) then {
	_ThisTaskTypes = [selectRandom _SideMissionTasksToUse];
	_IsMainObjs = [false]; //if false, then chacne of no enemu, or civs only etc.... if true, then more chacne of bad shit happening
	_MarkerTypes = ["mil_objective"];
	_CreateTasks = [true];
	MaxBadPoints = 2;
};
if (iMissionSetup == 4) then {
	_ThisTaskTypes = [selectRandom _SideMissionTasksToUse,selectRandom _SideMissionTasksToUse,selectRandom _SideMissionTasksToUse];
	_IsMainObjs = [false,false,false]; //if false, then chacne of no enemu, or civs only etc.... if true, then more chacne of bad shit happening
	_MarkerTypes = ["mil_objective","mil_objective","mil_objective"];
	_CreateTasks = [true,true,true];
	MaxBadPoints = 4;
};



publicVariable "MaxBadPoints";


_trgComplete = createTrigger ["EmptyDetector", [0,0]];
_trgComplete setTriggerArea [0, 0, 0, false];
_trgComplete setTriggerStatements ["ActiveTasks call FHQ_TT_areTasksCompleted;", "[FriendlySide, [""DeBrief"", ""Return to HQ to debrief"", ""Debrief"", """"]] call FHQ_TT_addTasks; ", ""];			


while {InfTaskCount < count _ThisTaskTypes} do {

	_iThisTaskType = nil;
	if (InfTaskCount == 0) then {
		_iThisTaskType = _ThisTaskTypes select InfTaskCount;
	}
	else {
		_iThisTaskType = _ThisTaskTypes select InfTaskCount;
	};
	
	_bIsMainObjective = _IsMainObjs select InfTaskCount;  //more chance of bad things, and set middle area stuff around (comms, base etc...)
	_MarkerType = _MarkerTypes select InfTaskCount; //"Empty" or other
	_bCreateTask = _CreateTasks select InfTaskCount;
	_allowFriendlyIns = true;
	


	//hint "c";


	//if (!InfTaskStarted) then {
	if (true) then {
		InfTaskStarted = true;
		publicVariable "InfTaskStarted";

		//InfTaskCount = InfTaskCount + 1;
		//publicVariable "InfTaskCount";
		
			//InformantStuff	
			SideCompleted = [];
			publicVariable "SideCompleted";
			
				SideCompleted pushBack False;
				publicVariable "SideCompleted";
				_bInfor1Found = false;

				_MissionTitle = "";
				if (_iThisTaskType == 1) then {_MissionTitle = "Hack Data"};
				if (_iThisTaskType == 2) then {_MissionTitle = "Steal data from research vehicle"};
				if (_iThisTaskType == 3) then {_MissionTitle = "Destroy Ammo Trucks"};
				if (_iThisTaskType == 4) then {_MissionTitle = "Speak with informant"};
				if (_iThisTaskType == 5) then {_MissionTitle = "interrogate officer"};
				if (_iThisTaskType == 6) then {_MissionTitle = "Transmit Enemy Comms to HQ"};
				if (_iThisTaskType == 7) then {_MissionTitle = "Eliminate Officer"}; //gain 1 point if side, if main, need to id him before complete
				if (_iThisTaskType == 8) then {_MissionTitle = "Assasinate weapon dealer"}; //gain 1 point if side, no intel from him... if main need to id him before complete
				if (_iThisTaskType == 9) then {_MissionTitle = "Destroy AAA vehicles"}; //gain 1 point if side, no intel from him... if main need to id him before complete
				if (_iThisTaskType == 10) then {_MissionTitle = "Destroy Artillery vehicles"}; //gain one point if side (player can call arti strikes on them, cost 0.3 points but gains one if complete)


				//kill leader (he will run away in car to AO)    ::   save stranded guys    ::      
				while {!_bInfor1Found} do {
					_markerInformant1 = nil;
					
					_randInfor1X = 0 + (floor random 25000);
					_randInfor1Y = 0 + (floor random 25000);
					_buildings = nearestObjects [[_randInfor1X,_randInfor1Y], BasicBuildings, 200];

					if ((getMarkerPos "mrkHQ" distance [_randInfor1X, _randInfor1Y]) > SideMissionMinDistFromBase && (count _buildings) > 0) then {


						_bInfor1Found = true;
						_infBuilding = selectRandom _buildings;
						_allBuildingPos = _infBuilding buildingPos -1;
						_inf1X = position _infBuilding select 0;
						_inf1Y = position _infBuilding select 1;
						if (count _allBuildingPos > 2) then { 

							_roadSearchRange = 20;
							if (_iThisTaskType == 3) then {_roadSearchRange = 100;};
							_nearestRoads = [_inf1X,_inf1Y] nearRoads _roadSearchRange;
							
							
							if (_iThisTaskType == 2 || _iThisTaskType == 3) then { //2 = retrive tank << so we need a nearby road									
								if (count _nearestRoads == 0) then {
									_bInfor1Found = false;
								}
								else {
							
									
									
								};
							};
							if (_bInfor1Found) then {
								ObjectivePossitions pushBack [_inf1X,_inf1Y]; 
								publicVariable "ObjectivePossitions";	
								//###################################### Hack Data ###################
								if (_iThisTaskType == 1) then { 
									_allpositionsLaptop1 = _infBuilding buildingPos -1;
									_sLaptop1Name = format["objLaptop%1",InfTaskCount];
									_objLaptop1 = "Land_Laptop_device_F" createVehicle [0,0,500];
									_objLaptop1 setVariable [_sLaptop1Name, _objLaptop1, true];
									missionNamespace setVariable [_sLaptop1Name, _objLaptop1];
									_objLaptop1 setPosATL (selectRandom _allpositionsLaptop1);

									if (selectRandom[true,false]) then {
										_sIED1Name = format["objIED%1",InfTaskCount];
										_objIED1 = selectRandom IEDClassNames createVehicle [0,0,500];
										_objIED1 setVariable [_sIED1Name, _objIED1, true];
										missionNamespace setVariable [_sIED1Name, _objIED1];
										_objIED1 setPosATL (selectRandom _allpositionsLaptop1);
									};
									[[_objLaptop1, ["Hack intel","RandFramework\hackIntel1.sqf",[InfTaskCount,_bCreateTask]]],"addAction",true,true] call BIS_fnc_MP;
								};
								//###################################### Steal data from research vehicle ###################
								if (_iThisTaskType == 2) then { 
									if (_MarkerType != "empty") then { _MarkerType = "hd_unknown"; };
									_nearestRoad = nil;
									_nearestRoad = [[_inf1X,_inf1Y], _roadSearchRange, []] call BIS_fnc_nearestRoad;
									_roadConnectedTo = nil;
									_roadConnectedTo = roadsConnectedTo _nearestRoad;
									_objVehicle = selectRandom sideResarchTruck createVehicle [0,0,500];
									_objVehicle setPosATL getPosATL _nearestRoad;
									[[_objVehicle, ["Download research data","RandFramework\downloadResearchData.sqf",[InfTaskCount,_bCreateTask]]],"addAction",true,true] call BIS_fnc_MP;
									if (count _roadConnectedTo > 0) then {
										_connectedRoad = _roadConnectedTo select 0;
										_direction = [_nearestRoad, _connectedRoad] call BIS_fnc_DirTo;
										_objVehicle setDir (_direction);
									};
								};
								//###################################### Destroy Ammo Trucks ###################
								if (_iThisTaskType == 3) then { 
									_allowFriendlyIns = false;
									if (_MarkerType != "empty") then { _MarkerType = "hd_unknown"; };
									_nearestRoad = nil;
									_nearestRoad = selectRandom _nearestRoads;
									_roadConnectedTo = nil;
									_roadConnectedTo = roadsConnectedTo _nearestRoad;
									_sTargetName = format["objInformant%1",InfTaskCount];
									_sTargetName2 = format["objInformant2_%1",InfTaskCount];

									_objVehicle = nil;
									_truckType = selectRandom sideAmmoTruck ;
									_objVehicle = _truckType createVehicle [0,0,500];
									_objVehicle setVariable [_sTargetName, _objVehicle, true];
									missionNamespace setVariable [_sTargetName, _objVehicle];
									_objVehicle setPosATL getPosATL _nearestRoad;
									if (count _roadConnectedTo > 0) then {
										_connectedRoad = _roadConnectedTo select 0;
										_direction = [_nearestRoad, _connectedRoad] call BIS_fnc_DirTo;
										_objVehicle setDir (_direction);
									};

									_roadsTooCloseToRoad2 = getPosATL _nearestRoad nearRoads 20; 
									_nearestRoad2 = [getPosATL _nearestRoad, _roadSearchRange, _roadsTooCloseToRoad2] call BIS_fnc_nearestRoad;
									_objVehicle2 = nil;
									_objVehicle2 = _truckType createVehicle [20,20,500];
									_objVehicle2 setVariable [_sTargetName2, _objVehicle2, true];
									missionNamespace setVariable [_sTargetName2, _objVehicle2];
									if (isNil "_nearestRoad2") then {
										_flatPos = nil;
										_flatPos = [[_inf1X,_inf1Y,0] , 10, 40, 7, 0, 0.5, 0,[],[[_inf1X,_inf1Y,0],[_inf1X,_inf1Y,0]]] call BIS_fnc_findSafePos;
										_objVehicle2 setPos _flatPos;
									}
									else {
										_objVehicle2 setPosATL getPosATL _nearestRoad2;
										_roadConnectedTo2 = roadsConnectedTo _nearestRoad2;
										//hint format ["roadsConnected: %1",str(_roadConnectedTo2)];
										if (count _roadConnectedTo2 > 0) then {
											_connectedRoad2 = _roadConnectedTo2 select 0;
											_direction = [_nearestRoad2, _connectedRoad2] call BIS_fnc_DirTo;
											_objVehicle2 setDir (_direction);
										};
									};
									_triggerAmmoTruckClear = nil;
									_triggerAmmoTruckClear = createTrigger ["EmptyDetector", [0,0]];
									if (!_bCreateTask) then {
										_triggerAmmoTruckClear setTriggerStatements [format["!alive(%1) && !alive(%2)",_sTargetName,_sTargetName2], " MaxBadPoints = MaxBadPoints + 1; publicVariable ""MaxBadPoints""; Hint ""You have destroyed enemy ammo trucks, reputation increased""; ", ""];			
									}
									else {
										_sKillOfficerTaskComplete = format["[""InfSide%1"", ""succeeded""] remoteExec [""FHQ_TT_setTaskState"", 0];",InfTaskCount];
										_triggerAmmoTruckClear setTriggerStatements [format["!alive(%1) && !alive(%2)",_sTargetName,_sTargetName2], _sKillOfficerTaskComplete, ""];	
									};
								};
								//###################################### Destroy AAA ###################
								if (_iThisTaskType == 9) then { 
									_allowFriendlyIns = false;
									if (_MarkerType != "empty") then { _MarkerType = "hd_unknown"; };
									
									_sTargetName = format["objInformant%1",InfTaskCount];
									_sTargetName2 = format["objInformant2_%1",InfTaskCount];
									_sTargetName3 = format["objInformant3_%1",InfTaskCount];
									_truckType = sAAAVeh ;
									sAliveCheck = format["!alive(%1) && !alive(%2)",_sTargetName,_sTargetName2];

									_flatPos = nil;
									_flatPos = [[_inf1X,_inf1Y,0] , 15, 200, 12, 0, 0.5, 0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
									if (str(_flatPos) == "[0,0,0]") then {_flatPos = [[_inf1X,_inf1Y,0] , 15, 250, 7, 0, 0.5, 0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;};
									_objVehicle = nil;
									_objVehicle = _truckType createVehicle [0,0,500];
									_objVehicle setVariable [_sTargetName, _objVehicle, true];
									createVehicleCrew _objVehicle;
									missionNamespace setVariable [_sTargetName, _objVehicle];
									_objVehicle setPos _flatPos;
									_objVehicle disableAI "MOVE";
									TREND_fnc_AAARadioLoop1 = {		
										_radioName = _this select 0;
										while {true} do {
											//hint format["radio: %1",_radioName];
											_missiondir = call { private "_arr"; _arr = toArray str missionConfigFile; _arr resize (count _arr - 15); toString _arr };
											playSound3D [_missiondir + "sound\enemyChatter.ogg",call compile _radioName,false,getPosASL call compile _radioName,0.4,1,0];
											sleep 558;
										};
									};
									[_sTargetName] spawn TREND_fnc_AAARadioLoop1;

									_flatPos2 = nil;
									_flatPos2 = [[_inf1X,_inf1Y,0] , 15, 200, 12, 0, 0.5, 0,[[_flatPos,100]],[[_inf1X,_inf1Y,0],[_inf1X,_inf1Y,0]]] call BIS_fnc_findSafePos;
									if (str(_flatPos2) == "[0,0,0]") then {
										sAliveCheck = format["!alive(%1)",_sTargetName];
									}
									else {
										_objVehicle2 = nil;
										_objVehicle2 = _truckType createVehicle [20,20,500];
										_objVehicle2 setVariable [_sTargetName2, _objVehicle2, true];
										createVehicleCrew _objVehicle2;
										missionNamespace setVariable [_sTargetName2, _objVehicle2];
										_objVehicle2 setPos _flatPos2;
										_objVehicle2 disableAI "MOVE";
										TREND_fnc_AAARadioLoop2 = {		
											_radioName = _this select 0;
											while {true} do {
												//hint format["radio: %1",_radioName];
												_missiondir = call { private "_arr"; _arr = toArray str missionConfigFile; _arr resize (count _arr - 15); toString _arr };
												playSound3D [_missiondir + "sound\enemyChatter.ogg",call compile _radioName,false,getPosASL call compile _radioName,0.4,1,0];
												sleep 558;
											};
										};
										[_sTargetName2] spawn TREND_fnc_AAARadioLoop2;
									};
									
									_triggerAmmoTruckClear = nil;
									_triggerAmmoTruckClear = createTrigger ["EmptyDetector", [0,0]];
									if (!_bCreateTask) then {
										_triggerAmmoTruckClear setTriggerStatements [sAliveCheck, " MaxBadPoints = MaxBadPoints + 1; publicVariable ""MaxBadPoints""; Hint ""You have destroyed enemy ammo trucks, reputation increased""; ", ""];			
									}
									else {
										_sKillOfficerTaskComplete = format["[""InfSide%1"", ""succeeded""] remoteExec [""FHQ_TT_setTaskState"", 0];",InfTaskCount];
										_triggerAmmoTruckClear setTriggerStatements [sAliveCheck, _sKillOfficerTaskComplete, ""];	
									};

								};
								//###################################### Destroy Arti ###################
								if (_iThisTaskType == 10) then { 
									_allowFriendlyIns = false;
									if (_MarkerType != "empty") then { _MarkerType = "hd_unknown"; };
									
									_sTargetName = format["objInformant%1",InfTaskCount];
									_sTargetName2 = format["objInformant2_%1",InfTaskCount];
									_truckType = sArtilleryVeh ;
									sAliveCheck = format["!alive(%1) && !alive(%2)",_sTargetName,_sTargetName2];

									_flatPos = nil;
									_flatPos = [[_inf1X,_inf1Y,0] , 15, 200, 12, 0, 0.5, 0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
									if (str(_flatPos) == "[0,0,0]") then {_flatPos = [[_inf1X,_inf1Y,0] , 15, 250, 7, 0, 0.5, 0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;};
									_objVehicle = nil;
									_objVehicle = _truckType createVehicle [0,0,500];
									_objVehicle setVariable [_sTargetName, _objVehicle, true];
									createVehicleCrew _objVehicle;
									missionNamespace setVariable [_sTargetName, _objVehicle];
									_objVehicle setPos _flatPos;
									_objVehicle disableAI "MOVE";
									TREND_fnc_ArtiFireLoop1 = {		
											_radioName = _this select 0;
											_Ammo = getArtilleryAmmo [_radioName] select 0;
											while {true} do {
												_flatPos = nil;
												_flatPos = [getMarkerPos "mrkHQ", 1000, 1200, 20, 0, 0.5, 0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
												[[_radioName, 1],"setVehicleAmmo",true,false] call BIS_fnc_MP;
												[[_radioName, [_flatPos, _Ammo, 1]],"commandArtilleryFire",false,false] call BIS_fnc_MP;
												sleep selectRandom[10,30,60,120,240];
											};
										};
										[_objVehicle] spawn TREND_fnc_ArtiFireLoop1;

									_flatPos2 = nil;
									_flatPos2 = [[_inf1X,_inf1Y,0] , 15, 200, 12, 0, 0.5, 0,[[_flatPos,100]],[[_inf1X,_inf1Y,0],[_inf1X,_inf1Y,0]]] call BIS_fnc_findSafePos;
									if (str(_flatPos2) == "[0,0,0]") then {
										sAliveCheck = format["!alive(%1)",_sTargetName];
									}
									else {
										_objVehicle2 = nil;
										_objVehicle2 = _truckType createVehicle [20,20,500];
										_objVehicle2 setVariable [_sTargetName2, _objVehicle2, true];
										createVehicleCrew _objVehicle2;
										missionNamespace setVariable [_sTargetName2, _objVehicle2];
										_objVehicle2 setPos _flatPos2;
										_objVehicle2 disableAI "MOVE";
										TREND_fnc_ArtiFireLoop2 = {		
											_radioName = _this select 0;
											_Ammo = getArtilleryAmmo [_radioName] select 0;
											while {true} do {
												_flatPos = nil;
												_flatPos = [getMarkerPos "mrkHQ", 1000, 1200, 20, 0, 0.5, 0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
												[[_radioName, 1],"setVehicleAmmo",true,false] call BIS_fnc_MP;
												[[_radioName, [_flatPos, _Ammo, 1]],"commandArtilleryFire",false,false] call BIS_fnc_MP;
												sleep selectRandom[10,30,60,120,240];
											};
										};
										[_objVehicle2] spawn TREND_fnc_ArtiFireLoop2;
									};
									
									_triggerAmmoTruckClear = nil;
									_triggerAmmoTruckClear = createTrigger ["EmptyDetector", [0,0]];
									if (!_bCreateTask) then {
										_triggerAmmoTruckClear setTriggerStatements [sAliveCheck, " MaxBadPoints = MaxBadPoints + 1; publicVariable ""MaxBadPoints""; Hint ""You have destroyed enemy ammo trucks, reputation increased""; ", ""];			
									}
									else {
										_sKillOfficerTaskComplete = format["[""InfSide%1"", ""succeeded""] remoteExec [""FHQ_TT_setTaskState"", 0];",InfTaskCount];
										_triggerAmmoTruckClear setTriggerStatements [sAliveCheck, _sKillOfficerTaskComplete, ""];	
									};

									//ATTACH RADIO COMMS SOUND! (but quite)... but will need to stop sound when destroyied
								};
								 //###################################### informant,intorigate officer, weapon dealer or kill officer #########################################
								if (_iThisTaskType == 4 || _iThisTaskType == 5 || _iThisTaskType == 7 || _iThisTaskType == 8) then { //if informant,intorigate officer, weapon dealer or kill officer
									_allpositionsLaptop1 = _infBuilding buildingPos -1;
									
									_sInformant1Name = format["objInformant%1",InfTaskCount];
									_infClassToUse = "";
									_sideToUse = EnemySide;

									if (_iThisTaskType == 4) then { //if informant
										_infClassToUse = selectRandom InformantClasses;
										_sideToUse = Civilian;
									};
									if (_iThisTaskType == 8) then { //if weapon dealer
										_infClassToUse = selectRandom WeaponDealerClasses;
										_sideToUse = Civilian;
									};
									if (_iThisTaskType == 5 || _iThisTaskType == 7) then { //if interogate officer or eleminate officer 
										_infClassToUse = selectRandom InterogateOfficerClasses;
										_sideToUse = EnemySide;
									};
	
									_objInformant = createGroup _sideToUse createUnit [_infClassToUse,[0,0,500],[],0,"NONE"];
									_objInformant setVariable [_sInformant1Name, _objInformant, true];
									missionNamespace setVariable [_sInformant1Name, _objInformant];
									_initPos = selectRandom _allpositionsLaptop1;
									_flatPosInform = nil;
									_flatPosInform = [_initPos , 10, 75, 7, 0, 0.5, 0,[],[_initPos,_initPos]] call BIS_fnc_findSafePos;	
									if (count _flatPosInform == 3) then {
										//if pos is [x,x] instead of [x,x,x] then dont setPosATL!
										_objInformant setPosATL (_flatPosInform);
									}
									else {
										_objInformant setPos (_flatPosInform);
									};
									
									//_objInformant setPosATL (_initPos);
									_objInformant allowDamage false;

									[[_objInformant, ["HitPart",
										{
											_thisInformant = ((_this select 0) select 0);
											_thisShooter =((_this select 0) select 1);
											_hitLocation = ((_this select 0) select 5) select 0;
											if (bDebugMode) then {hint format["ARHH2:%1",_hitLocation];};
												if (side (_thisShooter) == West && alive(_thisInformant)) then {
													_thisInformant allowDamage true;
													_bDone = false;
													group _thisInformant setBehaviour "ALERT";
													_thisInformant switchMove "";
													if (_hitLocation == "head" || _hitLocation == "neck" || _hitLocation == "spine1" || _hitLocation == "spine2" || _hitLocation == "spine3" || _hitLocation == "body" ) then {
														_thisInformant setDamage 1;
														_bDone = true;
													};
													if (_hitLocation == "leftleg" || _hitLocation == "rightleg") then {
														//_thisInformant setDamage 1;
														_thisInformant setHit ['legs',1];
														_bDone = true;
													};
													if (!_bDone) then {
														_thisInformant setDamage 0.8;
													};
												};

											//if (alive(_thisInformant)) then {
											//	if (side (_thisShooter) != West) then {
											//		_thisInformant setDamage 0;
											//	}
											//	else {
											//		_thisInformant switchMove "";
											//	}
											//}
										}
									]],"addEventHandler",true,true] call BIS_fnc_MP;

									
									if (_iThisTaskType == 5 || _iThisTaskType == 8 || _iThisTaskType == 7) then { //if interrogate officer or kill weapon dealer or eleminate officer
										if (_iThisTaskType == 5 || _iThisTaskType == 7) then {  //only give weapon if officer (not weapon dealer)
											_grpName = createGroup EnemySide;
											[_objInformant] joinSilent _grpName;
											_objInformant addMagazine "30Rnd_9x21_Mag_SMG_02";
											_objInformant addMagazine "30Rnd_9x21_Mag_SMG_02";
											_objInformant addWeapon "SMG_02_F";
										};
										if (_iThisTaskType == 5) then {
											[[_objInformant, ["Get Intel","RandFramework\interrogateOfficer.sqf",[InfTaskCount,_bCreateTask],10,true,true,"","_this distance _target < 3"]],"addAction",true,true] call BIS_fnc_MP;
										};
										if (_iThisTaskType == 5 || _iThisTaskType == 8 || _iThisTaskType == 7) then {
											
											TREND_fnc_WalkingGuyLoop = {		
												_objManName = _this select 0;
												_thisInitPos = _this select 1;
												_objMan = missionNamespace getVariable _objManName;
												
												group _objMan setSpeedMode "LIMITED";
												group _objMan setBehaviour "SAFE";

												while {true && alive(_objMan)} do {
													if (behaviour _objMan != "COMBAT") then {
														[_objManName,_thisInitPos,_objMan,75] execVM "RandFramework\HVTWalkAround.sqf";
														sleep 2;
														waitUntil {sleep 1; speed _objMan < 0.5};
														sleep 10;
													};
												};
											};
											[_sInformant1Name,_initPos] spawn TREND_fnc_WalkingGuyLoop;

											if (_bIsMainObjective) then {
												[[_objInformant, ["Search for ID","RandFramework\IdentifyHVT.sqf",[InfTaskCount,_bCreateTask],10,true,true,"","_this distance _target < 3"]],"addAction",true,true] call BIS_fnc_MP;
											}
											else {
												_trgKillOfficer = nil;
												_trgKillOfficer = createTrigger ["EmptyDetector", [0,0]];
												_trgKillOfficer setTriggerArea [0, 0, 0, false];
												//_trgKillOfficer setTriggerStatements [format["!alive(%1)",_sInformant1Name], " MaxBadPoints = MaxBadPoints + 1; publicVariable ""MaxBadPoints""; Hint ""A HVT has been eliminated, reputation increased""; ", ""];			
												if (!_bCreateTask) then {
													_trgKillOfficer setTriggerStatements [format["!alive(%1)",_sInformant1Name], " MaxBadPoints = MaxBadPoints + 1; publicVariable ""MaxBadPoints""; Hint ""A HVT has been eliminated, reputation increased""; ", ""];			
												}
												else {
													_sKillOfficerTaskComplete = format["[""InfSide%1"", ""succeeded""] remoteExec [""FHQ_TT_setTaskState"", 0];",InfTaskCount];
													//sleep 2;
													//hint _sKillOfficerTaskComplete;
													//sleep 2;
													_trgKillOfficer setTriggerStatements [format["!alive(%1)",_sInformant1Name], _sKillOfficerTaskComplete, ""];	
												};
											};
											
										};
									}
									else {
										[[_objInformant, ["Get Intel","RandFramework\SpeakInformant.sqf",[InfTaskCount,_bCreateTask],1,false,true,"","_this distance _target < 2"]],"addAction",true,true] call BIS_fnc_MP;
									};
								};
								if (_iThisTaskType == 6) then {
									_allpositionsRadio1 = _infBuilding buildingPos -1;
									_sRadio1Name = format["objRadio%1",InfTaskCount];
									_objRadio1 = selectRandom SideRadioClassNames createVehicle [0,0,500];
									_objRadio1 setVariable [_sRadio1Name, _objRadio1, true];
									missionNamespace setVariable [_sRadio1Name, _objRadio1];
									_objRadio1 setPosATL (selectRandom _allpositionsRadio1);

									[[_objRadio1, ["Send transmission to HQ","RandFramework\bugRadio1.sqf",[InfTaskCount,_bCreateTask]]],"addAction",true,true] call BIS_fnc_MP;
								
									TREND_fnc_RadioLoop = {		
										_radioName = _this select 0;
										while {true} do {
											//hint format["radio: %1",_radioName];
											_missiondir = call { private "_arr"; _arr = toArray str missionConfigFile; _arr resize (count _arr - 15); toString _arr };
											playSound3D [_missiondir + "sound\enemyChatter.ogg",call compile _radioName,false,getPosASL call compile _radioName,0.5,1,0];
											_radName = "objRadio2";
											sleep 558;
										};
									};
									[_sRadio1Name] spawn TREND_fnc_RadioLoop;

								};

								if (_bIsMainObjective) then {
									_markerInformant1 = createMarker [format["mrkMainObjective%1",InfTaskCount], [_inf1X,_inf1Y]];
								}
								else {
									_markerInformant1 = createMarker [format["Informant%1",InfTaskCount], [_inf1X,_inf1Y]];

								};

								_markerInformant1 setMarkerShape "ICON";
								_markerInformant1 setMarkerType _MarkerType;
								//_markerInformant1 setMarkerText _MissionTitle;
								if (_bIsMainObjective) then {
									_markerInformant1 setMarkerText format["(Main) %1 ",_MissionTitle];
								}
								else {
									_markerInformant1 setMarkerText format["(Optional) %1 ",_MissionTitle];
								};
								


								[[_inf1X,_inf1Y],_iThisTaskType,_infBuilding,_bIsMainObjective, InfTaskCount, _allowFriendlyIns] spawn TREND_fnc_PopulateSideMission;
	

								
								if (_bCreateTask) then {
									
									[FriendlySide,[format["InfSide%1",InfTaskCount], "", format["%1 : %2",InfTaskCount+1,_MissionTitle],"Description Here"]] call FHQ_TT_addTasks;
									ActiveTasks pushBack format["InfSide%1",InfTaskCount]; 
									publicVariable "ActiveTasks";	
									
								};

								//_triggerSidePassClear = createTrigger ["EmptyDetector", [_inf1X,_inf1Y]];
								//_triggerSidePassClear setTriggerArea [2000, 2000, 0, false];
								//_triggerSidePassClear setTriggerStatements ["false", "{deleteVehicle _x} forEach nearestObjects [this, [""all""], 2000]", ""];		
								

							};	
						}
						else {
							_bInfor1Found = false;
						};

					};
				};
				InfTaskCount = InfTaskCount + 1;
			
			//};

	};
};


//now we have all our location positinos, we can set other area stuff
[] execVM "RandFramework\RandScript\TREND_fnc_setOtherAreaStuff.sqf";


hint "Almost loaded...";
sleep 20;

[[],"RandFramework\animateAnimals.sqf"] remoteExec ["BIS_fnc_execVM",0,true];



hint "And so it begins!";
