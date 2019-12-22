/*
Add Script to individual units spawned by COS.
_unit = unit. Refer to Unit as _unit.
*/

_unit =(_this select 0);

_mainAOPos = ObjectivePossitions select 0;
_distanceFromAO = "FAR"; //4000+=FAR; 1500-3999=MED, 500-1499=CLOSE; 0-499=VERYCLOSE
_AODirection = [_unit, _mainAOPos] call BIS_fnc_DirTo;
_AODistance = _unit distance _mainAOPos;
_chanceOfBad = [false,false,false,false,false,false,false,false,false,true];

if (_AODistance<4000) then {
	_distanceFromAO = "MED";
	_chanceOfBad = [false,false,false,false,false,false,false,true];
};
if (_AODistance<1500) then {
	_distanceFromAO = "CLOSE";
	_chanceOfBad = [false,false,false,false,false,true];
};
if (_AODistance<500) then {
	_distanceFromAO = "VERYCLOSE";
	_chanceOfBad = [false,false,false,false,true];
};

_isBad = selectRandom _chanceOfBad;

if (!_isBad) then {
	_unit addEventHandler ["killed", {_this execVM "RandFramework\CivKilled.sqf";}];
}
else {
	_unit execVM "RandFramework\BadCiv.sqf";
};


[
				_unit,											// Object the action is attached to
				localize "STR_TRGM2_CivTalk",										// Title of the action
				"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",	// Idle icon shown on screen
				"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",	// Progress icon shown on screen
				"_this distance _target < 5",						// Condition for the action to be shown
				"_caller distance _target < 5",						// Condition for the action to progress
				{},													// Code executed when action starts
				{	
					_thisUnit = _this select 0;
					_thisPlayer = _this select 1;
					_thisUnit disableAI "MOVE";
					_directionToPlayer = [_thisUnit, _thisPlayer] call BIS_fnc_DirTo;
					_thisUnit setDir _directionToPlayer;
					_tempGroup1 = createGroup WEST;
					{[_x] joinSilent _tempGroup1} forEach (units group _thisUnit);
					while {(count (waypoints group _thisUnit)) > 0} do {
						deleteWaypoint ((waypoints group _thisUnit) select 0);
					};
				},			// Code executed on every progress tick
				{
					_thisUnit = _this select 0;
					_thisPlayer = _this select 1;
					_distanceFromAO = (_this select 3) select 0;
					_AODirection = (_this select 3) select 1;

					_locationText = [ObjectivePossitions select 0] call TRGM_fnc_getLocationName;
					_locationDirection = format [localize "STR_TRGM2_location_fngetLocationName_DirOfName",[_AODirection,true] call TRGM_fnc_directionToText," Here"];

					_potentialIntel = format["%1: I dont have anything of interest to tell you", name _thisUnit];

					if (_distanceFromAO == "FAR" && selectRandom [true,false]) then {
						_potentialIntel = format["After talking to %2, you discover something is happening far to the %1",_locationDirection, name _thisUnit];
					};	
					if (_distanceFromAO == "MED") then {
						if (selectRandom [true,true,false]) then {
							_potentialIntel = format["After talking to %2, you discover something is happening around %1",_locationText, name _thisUnit];
						};
						if (selectRandom [true,false,false]) then {
							_potentialIntel = format["After talking to %0, you discover something is happening not too far to the %1",_locationDirection, name _thisUnit];
						};	
					};	
					if (_distanceFromAO == "CLOSE") then {
						if (selectRandom [true,false]) then {
							_potentialIntel = format["After talking to %1, you discover our Objective is: %2", name _thisUnit, CurrentZeroMissionTitle];
						};		
						if (selectRandom [true,false,false,false]) then {
							_potentialIntel = format["After talking to %2, you discover something is happening close to the %1",_locationDirection, name _thisUnit];
						};
					};
					if (_distanceFromAO == "VERYCLOSE") then {
						if (selectRandom [true]) then {
							_potentialIntel = format["After talking to %1, you discover our objective is: %2", name _thisUnit, CurrentZeroMissionTitle];
						};		
						if (selectRandom [true,false]) then {
							_potentialIntel = format["After talking to %0, you discover something is happening very close to the %1",_locationDirection, name _thisUnit];
						};				
					};

					if (alive _thisUnit) then {
						_intelGiven = _thisUnit getVariable ["intelGiven", ""];
						if (_intelGiven != "" && _distanceFromAO != "VERYCLOSE") then {
							hint _intelGiven;
						}
						else {
							_intelGiven = _potentialIntel;
							hint _intelGiven;
							_thisUnit setVariable ["intelGiven", _intelGiven, true];
						};
					}
					else {
						hint localize "STR_TRGM2_CivTalkDead";
					};
					sleep 6;
					_thisUnit enableAI "MOVE";
					
				},				// Code executed on completion
				{
					_thisUnit = _this select 0;
					_thisUnit enableAI "MOVE";
				},													// Code executed on interrupted
				[_distanceFromAO,_AODirection],						// Arguments passed to the scripts as _this select 3
				3,													// Action duration [s]
				90,													// Priority
				false,												// Remove on completion
				false												// Show in unconscious state 
			] remoteExec ["BIS_fnc_holdActionAdd", 0, _unit];	// MP compatible implementation