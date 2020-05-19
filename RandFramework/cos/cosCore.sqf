if (!isServer) exitWith {};
private ["_groupCount","_localGrpCount","_grp","_rdCount","_n","_r","_tempUnit","_tempVeh"];
_mkr= (_this select 0);
_pos = (_this select 1);

//Hint format["TESTTEST2: %1", _pos];
//sleep 3;

if (isNil "bAndSoItBegins") then {
	bAndSoItBegins = false;
	publicVariable "bAndSoItBegins";
};
if (isNil "CustomObjectsSet") then {
	CustomObjectsSet = false;
	publicVariable "CustomObjectsSet";
};

waitUntil {bAndSoItBegins && CustomObjectsSet};

if (!MissionLoaded) exitWith {};

//hint "test";

_mainObjPos = ObjectivePossitions select 0;
_mrkHQPos = getMarkerPos "mrkHQ";
if isNil("MissionLoaded") then {
	MissionLoaded = false;
	publicVariable "MissionLoaded";
};
if (_pos distance _mainObjPos < 1500) exitWith {};
if (_pos distance _mrkHQPos < 1500) exitWith {};


// Get trigger status
_trigID=format["trig%1", _mkr];
_isActive=server getvariable _trigID;




// Get stored town variables
_popVar=format["population%1", _mkr];
_information=server getvariable _popVar;
	_civilians=(_information select 0);
	_vehicles=(_information select 1);
	_parked=(_information select 2);
	_roadPosArray=(_information select 3);


 IF (debugCOS) 
		then {
	COSGlobalSideChat=[_civilians,_vehicles,_parked, _mkr];publicvariable "COSGlobalSideChat";
	player groupChat (format ["Town:%4 .Civilians:%1 .Vehicles:%2 .Parked:%3",_civilians,_vehicles,_parked, _mkr]);//for singleplayer
		};	

_showRoads=false;				
	IF (_showRoads) 
		then {
			{
	_txt=format["roadMkr%1",_x];
	_debugMkr=createMarker [_txt,getpos _x];
	_debugMkr setMarkerShape "ICON";
	_debugMkr setMarkerType "hd_dot";
			}foreach _roadPosArray;
		};
					

_glbGrps=server getvariable "cosGrpCount";
_townGrp=createGroup DefaultSide;
_localGrps=1;

waituntil {!populating_COS};
populating_COS=true;
_glbGrps=server getvariable "cosGrpCount";


//SPAWN CIVILIANS NOW
_civilianArray=[];
_vehicleArray=[];
_PatrolVehArray=[];
_ParkedArray=[];

_roadPosArray=_roadPosArray call BIS_fnc_arrayShuffle;	
_UnitList=COScivPool call BIS_fnc_arrayShuffle;	
_vehList=COSmotPool call BIS_fnc_arrayShuffle;
_countVehPool=count _vehList;
_countPool=count _UnitList;
_v=0;
_n=0;
_rdCount=0;

// SPAWN PEDESTRIANS
for "_i" from 1 to _civilians do {
	if (!(server getvariable _trigID)) exitwith {_isActive=false;};
		
		if (_i >= _countPool) 
			then {
				if (_n >= _countPool) then {_n=0;};
					_tempUnit=_UnitList select _n;
					_n=_n+1;
				};
		if (_i < _countPool) 
			then {
			_tempUnit=_UnitList select _i;
				};						
						
		_tempPos=_roadPosArray select _rdCount;
		_rdCount=_rdCount+1;
		
		if (COSmaxGrps < (_glbGrps+_localGrps+1)) 
					then {
			_grp=_townGrp;	
					}else{
				_grp=createGroup DefaultSide;
				_localGrps=_localGrps+1;
						};
						
		_unit = _grp createUnit [_tempUnit, _tempPos, [], 0, "NONE"];	
		_civilianArray set [count _civilianArray,_grp];
									
				null =[_unit] execVM "RandFramework\cos\addScript_Unit.sqf";
					
					IF (debugCOS) then {
				_txt=format["INF%1,MKR%2",_i,_mkr];
				_debugMkr=createMarker [_txt,getpos _unit];
				_debugMkr setMarkerShape "ICON";
				_debugMkr setMarkerType "hd_dot";
				_debugMkr setMarkerText "Civ Spawn";
						};
					};
												
// SPAWN VEHICLES
for "_i" from 1 to _vehicles do {

if (!(server getvariable _trigID)) exitwith {_isActive=false;};

		if (_i >= _countVehPool) 
			then {
				if (_v >= _countVehPool) then {_v=0;};
					_tempVeh=_vehList select _v;
					_v=_v+1;
				};
		if (_i < _countVehPool) 
			then {
			_tempVeh=_vehList select _i;
				};

		if (_i >= _countPool) 
			then {
				if (_n >= _countPool) then {_n=0;};
					_tempUnit=_UnitList select _n;
					_n=_n+1;
				};
		if (_i < _countPool) 
			then {
			_tempUnit=_UnitList select _i;
				};
				
		_tempPos=_roadPosArray select _rdCount;
		_rdCount=_rdCount+1;		
		_roadConnectedTo = roadsConnectedTo _tempPos;
		_connectedRoad = _roadConnectedTo select 0;
		_direction = [_tempPos, _connectedRoad] call BIS_fnc_DirTo;
				
	if (COSmaxGrps < (_glbGrps+_localGrps+1)) 
		then {
			_grp=_townGrp;	
				}else{
			_grp=createGroup DefaultSide;
			_localGrps=_localGrps+1;
				};
						
	_veh = createVehicle [_tempVeh, _tempPos, [], 0, "NONE"];
	_unit = _grp createUnit [_tempUnit, getpos _veh, [], 0, "CAN_COLLIDE"];
		_veh setdir _direction;
				
			_unit assignAsDriver _veh;
			_unit moveInDriver _veh;
					
				_vehPack=[_veh,_unit,_grp];
				_PatrolVehArray set [count _PatrolVehArray,_grp];
				_vehicleArray set [count _vehicleArray,_vehPack];

								
null =[_veh] execVM "RandFramework\cos\addScript_Vehicle.sqf";
null =[_unit] execVM "RandFramework\cos\addScript_Unit.sqf";
										
		IF (debugCOS) then {
			_txt=format["veh%1,mkr%2",_i,_mkr];
			_debugMkr=createMarker [_txt,getpos _unit];
			_debugMkr setMarkerShape "ICON";
			_debugMkr setMarkerType "hd_dot";
			_debugMkr setMarkerText "VEH Spawn";
						};
			};

				
// SPAWN PARKED VEHICLES
for "_i" from 1 to _parked do {

if (!(server getvariable _trigID)) exitwith {_isActive=false;};

		if (_i >= _countVehPool) 
			then {
				if (_v >= _countVehPool) then {_v=0;};
					_tempVeh=_vehList select _v;
					_v=_v+1;
				};
		if (_i < _countVehPool) 
			then {
			_tempVeh=_vehList select _i;
				};
	
		_tempPos=_roadPosArray select _rdCount;
		_rdCount=_rdCount+1;
		_roadConnectedTo = roadsConnectedTo _tempPos;
		_connectedRoad = _roadConnectedTo select 0;
		_direction = [_tempPos, _connectedRoad] call BIS_fnc_DirTo;
			
			_veh = createVehicle [_tempVeh, _tempPos, [], 0, "NONE"];
			_veh setdir _direction;
			_veh setPos [(getPos _veh select 0)-6, getPos _veh select 1, getPos _veh select 2];
								
		_ParkedArray set [count _ParkedArray,_veh];

		
null =[_veh] execVM "RandFramework\cos\addScript_Vehicle.sqf";

	IF (debugCOS) then {
		_txt=format["Park%1,mkr%2",_i,_mkr];
		_debugMkr=createMarker [_txt,getpos _veh];
		_debugMkr setMarkerShape "ICON";
		_debugMkr setMarkerType "hd_dot";
		_debugMkr setMarkerText "Park Spawn";
					};
			};

			
// Apply Patrol script to all units
null =[_civilianArray,_PatrolVehArray,_roadPosArray] execVM "RandFramework\cos\CosPatrol.sqf";

if (debugCOS) then {player sidechat  (format ["Roads used:%1. Roads Stored %2",_rdCount,count _roadPosArray])};		
			
// Count groups 		
_glbGrps=server getvariable "cosGrpCount";
_glbGrps=_glbGrps+_localGrps;
server setvariable ["cosGrpCount",_glbGrps];
populating_COS=false;

// Show town label if town still active
if (showTownLabel and (server getvariable _trigID)) 
	then {
	
	COSTownLabel=[(_civilians+_vehicles),_mkr];PUBLICVARIABLE "COSTownLabel";
	_population=format ["Population: %1",_civilians+_vehicles];
		0=[markerText _mkr,_population] spawn BIS_fnc_infoText;// FOR USE IN SINGLEPLAYER
		};

		
// Check every second until trigger is deactivated
 while {_isActive} do
		{
	_isActive=server getvariable _trigID;
		if (!_isActive) exitwith {};
		sleep 1;
		};

// If another town is populating wait until it has finished before deleting population
waituntil {!populating_COS};

// Delete all pedestrians
 _counter=0;		
			{
	_grp=_x;
	_counter=_counter+1;
		if (debugCOS) then { deletemarker (format["INF%1,MKR%2",_counter,_mkr]);};
		{ deleteVehicle _x } forEach units _grp;
		deleteGroup _grp;  
				}foreach _civilianArray;

				
// Delete all vehicles and crew	
 _counter=0;
		{
	_veh=_x select 0;
	_unit=_x select 1;
	_grp=_x select 2;
	_counter=_counter+1;
		if (debugCOS) then {deletemarker (format["veh%1,mkr%2",_counter,_mkr]);};

 
// CHECK VEHICLE IS NOT TAKEN BY PLAYER
	if ({isPlayer _veh} count (crew _veh) == 0) 
	 then {
	{deleteVehicle _x} forEach (crew _veh); deleteVehicle _veh;
		}; 
	deletevehicle _unit;
	deletegroup _grp;
	
	}foreach _vehicleArray;

// Delete all parked vehicles
 _counter=0;
		{
	_counter=_counter+1;
	 if (debugCOS) then {deletemarker (format["Park%1,mkr%2",_counter,_mkr]);};
 
  // CHECK VEHICLE IS NOT TAKEN BY PLAYER
	if ({isPlayer _x} count (crew _x) == 0) 
		then {
		deletevehicle _x;
			}; 
		}foreach _ParkedArray;

deletegroup _townGrp;

// Update global groups
_glbGrps=server getvariable "cosGrpCount";
_glbGrps=_glbGrps-_localGrps;
server setvariable ["cosGrpCount",_glbGrps];
