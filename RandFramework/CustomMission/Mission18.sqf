//These are only ever called by the server!

//MISSION 18: Secure Comms Tower
//A comms tower is spawned on high, flat, dry ground within about 350m of the AO building and becomes the centre of the AO. Players activate an uplink at it, then must keep at least one player within 10m of it until the progress bar reaches 100% (5 minutes).
//The enemy is called to the tower as soon as the uplink starts. If all players die before 100% the mission fails.
//Once the bar is full, friendly jets fly an airstrike pass past the tower (effect only).

fnc_CustomRequired = { //used to set any required details for the AO (example, a wide open space or factory nearby)... if this is not found in AO, the engine will scrap the area and loop around again with a different location
//be careful about using this, some maps may not have what you require, so the engine will never satisfy the requirements here (example, if no airports are on a map and that is what you require)
	_objectiveMainBuilding = _this select 0;
	_centralAO_x = _this select 1;
	_centralAO_y = _this select 2;

	_result = true; //always returing true, because if there is no tower near the AO we spawn one
	_result; //return value
};

fnc_CustomVars = { //This is called before the mission function is called below, and the variables below can be adjusted for your mission
	_RequiresNearbyRoad = false;
	_roadSearchRange = 100; //this is how far out the engine will check to make sure a road is within range (if your objective requires a nearby road)
	_allowFriendlyIns = false;
	_MissionTitle = localize "STR_TRGM2_CommsTowerMissionTitle"; //this is what shows in dialog mission selection
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

	_sTaskDescription = selectRandom[localize "STR_TRGM2_CommsTowerMissionDescription"];

	private _mainObjPos = getPos _objectiveMainBuilding;

	//find a sensible place for a comms tower near the AO building: dry, flat, clear of trees/buildings/roads and well away from the shore, taking the highest ground found
	private _spawnTowerPos = [];
	private _bestHeight = -100000;
	private _validCount = 0;
	private _usedFallback = false;
	for "_i" from 1 to 80 do {
		private _candidate = _mainObjPos getPos [50 + random 300, random 360];
		private _isGood = !(surfaceIsWater _candidate)
			&& {(getMarkerPos "mrkHQ") distance2D _candidate > BaseAreaRange}
			&& {((surfaceNormal _candidate) select 2) > 0.97}
			&& {count nearestObjects [_candidate, ["Building","House"], 20] == 0}
			&& {count nearestTerrainObjects [_candidate, ["TREE","SMALL TREE","BUSH","BUILDING","HOUSE","ROCK","ROCKS","WALL","FENCE","ROAD","MAIN ROAD","TRACK"], 10] == 0};
		if (_isGood) then {
			private _nearWater = ([40,80] findIf {private _dist = _x; [0,45,90,135,180,225,270,315] findIf {surfaceIsWater (_candidate getPos [_dist, _x])} > -1}) > -1;
			if (!_nearWater) then {
				_validCount = _validCount + 1;
				if ((getTerrainHeightASL _candidate) > _bestHeight) then {
					_bestHeight = getTerrainHeightASL _candidate;
					_spawnTowerPos = _candidate;
				};
			};
		};
	};
	//nothing suitable found, so use the engine's general flat position search around the building
	if (count _spawnTowerPos == 0) then {
		_usedFallback = true;
		_spawnTowerPos = [_mainObjPos, 15, 80, 12, 0, 0.15, 2, [[getMarkerPos "mrkHQ", BaseAreaRange]] + CheckPointAreas + SentryAreas, [[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
		if (_spawnTowerPos select 0 <= 0 || {surfaceIsWater _spawnTowerPos}) then {
			_spawnTowerPos = _mainObjPos getPos [30, random 360];
			if (surfaceIsWater _spawnTowerPos) then {_spawnTowerPos = _mainObjPos;};
		};
	};
	private _tower = createVehicle ["Land_TTowerBig_2_F", _spawnTowerPos, [], 0, "CAN_COLLIDE"];
	_tower setDir (random 360);
	private _towerPos = getPos _tower;

	missionNamespace setVariable [format["objInformant%1",_iTaskIndex], _tower];

	//this tower is the objective, so keep it out of the "check enemy comms" intel feature (see TREND_fnc_setOtherAreaStuff.sqf)
	if (isNil "ObjectiveCommsTowers") then {ObjectiveCommsTowers = [];};
	ObjectiveCommsTowers pushBack _tower;

	//make the tower the centre of the AO instead of the building the engine picked: startInfMission.sqf reads this and uses it for the AO marker, patrols and sentries
	missionNamespace setVariable [format["CustomMissionAoPos%1",_iTaskIndex], [_towerPos select 0, _towerPos select 1]];
	private _oldAoPos = [_centralAO_x, _centralAO_y];
	private _newAoPos = [_towerPos select 0, _towerPos select 1];
	private _aoIndex = ObjectivePossitions find _oldAoPos;
	if (_aoIndex >= 0) then {
		ObjectivePossitions set [_aoIndex, _newAoPos];
		publicVariable "ObjectivePossitions";
	};
	if (!isNil "HiddenPossitions") then {
		private _hiddenIndex = HiddenPossitions find _oldAoPos;
		if (_hiddenIndex >= 0) then {
			HiddenPossitions set [_hiddenIndex, _newAoPos];
			publicVariable "HiddenPossitions";
		};
	};

	//shared state, public so every client can read it for the progress bar
	missionNamespace setVariable [format["CommsTowerActive%1",_iTaskIndex], false, true];
	missionNamespace setVariable [format["CommsTowerProgress%1",_iTaskIndex], 0, true];
	missionNamespace setVariable [format["CommsTowerPaused%1",_iTaskIndex], false, true];
	missionNamespace setVariable [format["CommsTowerDone%1",_iTaskIndex], false, true];

	//activation hold action (same hold action as the IED actions, with the progress ring), added to every player and JIP player.
	//It is attached to the player with a flat distance check to the tower: the tower's own position is high up the structure, and a tall object is awkward to aim an action at.
	missionNamespace setVariable [format["CommsTowerObj%1",_iTaskIndex], _tower, true];
	[
		[_iTaskIndex],
		{
			params ["_iTaskIndex"];
			if (!hasInterface) exitWith {};
			[_iTaskIndex] spawn {
				params ["_iTaskIndex"];
				waitUntil {!isNull player};
				private _sAddActionVar = format["CommsTowerAddAction%1", _iTaskIndex];
				missionNamespace setVariable [_sAddActionVar, {
					params ["_iTaskIndex"];
					[
						player,											// Object the action is attached to
						localize "STR_TRGM2_CommsTowerActivate",				// Title of the action
						"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_hack_ca.paa",	// Idle icon shown on screen
						"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_hack_ca.paa",	// Progress icon shown on screen
						format["!(missionNamespace getVariable ['CommsTowerActive%1', false]) && {!isNull (missionNamespace getVariable ['CommsTowerObj%1', objNull]) && {_this distance2D (missionNamespace getVariable ['CommsTowerObj%1', objNull]) < 10}}", _iTaskIndex],	// Condition for the action to be shown
						format["_caller distance2D (missionNamespace getVariable ['CommsTowerObj%1', objNull]) < 10", _iTaskIndex],	// Condition for the action to progress
						{},											// Code executed when action starts
						{},											// Code executed on every progress tick
						{
							missionNamespace setVariable [format["CommsTowerActive%1", (_this select 3) select 0], true, true];
						},											// Code executed on completion
						{},											// Code executed on interrupted
						[_iTaskIndex],									// Arguments passed to the scripts as _this select 3
						6,												// Action duration [s]
						100,											// Priority
						false,											// Remove on completion
						false											// Show in unconscious state
					] call BIS_fnc_holdActionAdd;
				}];
				[_iTaskIndex] call (missionNamespace getVariable _sAddActionVar);
				//a respawned player is a new unit, so add the action again
				player addEventHandler ["Respawn", format["[%1] call %2;", _iTaskIndex, _sAddActionVar]];
			};
		}
	] remoteExec ["bis_fnc_call", 0, format["CommsTowerAction%1", _iTaskIndex]];

	//setup message in the same style as the other "Mission Events" messages, so a tester can find the tower
	[[mapGridPosition _towerPos, round (_mainObjPos distance2D _towerPos)], {systemChat format["Mission Events: Comms tower objective at grid %1 (AO centred on it, %2m from the original AO building)", _this select 0, _this select 1];}] remoteExec ["bis_fnc_call", 0];

	//debug text for testers: in the debug console run   copyToClipboard TRGM_Mission18Debug   and send the result
	private _sDebugBase = format["v%1 | original AO building at grid %2 %3 | tower at grid %4 %5, %6m from the building, %7m ASL",
		missionNamespace getVariable ["TRGM_Version","?"], mapGridPosition _mainObjPos, [round (_mainObjPos select 0), round (_mainObjPos select 1)],
		mapGridPosition _towerPos, [round (_towerPos select 0), round (_towerPos select 1)], round (_mainObjPos distance2D _towerPos), round (getTerrainHeightASL _towerPos)];
	_sDebugBase = _sDebugBase + format[" | valid tower spots %1 of 80, fallback used %2 | AO centre sent to engine %3",
		_validCount, _usedFallback, missionNamespace getVariable [format["CustomMissionAoPos%1",_iTaskIndex], []]];
	[_iTaskIndex, _sDebugBase] call TRGM_fnc_mission18DebugSet;

	//a while later, record what the engine did with the AO centre and how far the enemy groups really are from the tower and from the original building
	[_iTaskIndex, _towerPos, _mainObjPos, _sDebugBase] spawn {
		params ["_iTaskIndex","_towerPos","_mainObjPos","_sDebugBase"];
		sleep 90;
		private _enemyPositions = ((allGroups select {side _x == east && {count units _x > 0}}) apply {getPos leader _x});
		private _fnc_countWithin = {
			params ["_centre","_range"];
			{_x distance2D _centre < _range} count _enemyPositions
		};
		private _markerName = ["mrkMainObjective","Informant"] apply {format["%1%2",_x,_iTaskIndex]};
		private _markerPos = [];
		{if (markerType _x != "") exitWith {_markerPos = getMarkerPos _x;};} forEach _markerName;
		private _sMore = format[" | engine: %1 | ObjectivePossitions %2 | AO marker at %3 (%4m from tower)",
			missionNamespace getVariable [format["CustomMissionAoDebug%1",_iTaskIndex], "hook did NOT apply"],
			ObjectivePossitions apply {[round (_x select 0), round (_x select 1)]},
			_markerPos apply {round _x}, if (count _markerPos > 1) then {round (_markerPos distance2D _towerPos)} else {"?"}];
		_sMore = _sMore + format[" | enemy groups total %1; within 300/600/1000/2000m of the TOWER: %2/%3/%4/%5",
			count _enemyPositions,
			[_towerPos,300] call _fnc_countWithin, [_towerPos,600] call _fnc_countWithin, [_towerPos,1000] call _fnc_countWithin, [_towerPos,2000] call _fnc_countWithin];
		_sMore = _sMore + format[" | within 300/600/1000/2000m of the ORIGINAL BUILDING: %1/%2/%3/%4",
			[_mainObjPos,300] call _fnc_countWithin, [_mainObjPos,600] call _fnc_countWithin, [_mainObjPos,1000] call _fnc_countWithin, [_mainObjPos,2000] call _fnc_countWithin];
		[_iTaskIndex, _sDebugBase + _sMore] call TRGM_fnc_mission18DebugSet;
		[[], {systemChat "Mission Events: Mission 18 debug ready - in the debug console run: copyToClipboard TRGM_Mission18Debug";}] remoteExec ["bis_fnc_call", 0];
	};

	//trigger only exists so this mission stops running if the campaign day is reset (same cleanup flag the other missions use)
	private _lifeTrigger = createTrigger ["EmptyDetector", [0,0]];
	_lifeTrigger setVariable ["DelMeOnNewCampaignDay",true];

	[_tower, _iTaskIndex, _bCreateTask, _lifeTrigger] spawn {
		params ["_tower","_iTaskIndex","_bCreateTask","_lifeTrigger"];

		private _activeVar = format["CommsTowerActive%1",_iTaskIndex];
		private _progressVar = format["CommsTowerProgress%1",_iTaskIndex];
		private _pausedVar = format["CommsTowerPaused%1",_iTaskIndex];
		private _doneVar = format["CommsTowerDone%1",_iTaskIndex];
		private _hudJipId = format["CommsTowerHud%1",_iTaskIndex];
		private _fullTimeSeconds = 300; //5 minutes to fill from 0 to 100%

		waitUntil {sleep 1; isNull _lifeTrigger || {missionNamespace getVariable [_activeVar, false]}};
		if (isNull _lifeTrigger) exitWith {};

		//enemy reacts as soon as the uplink starts
		[getPos _tower, 1500] call TRGM_fnc_callEnemiesToPos;

		[["STR_TRGM2_CommsTowerStarted"], {hint localize (_this select 0);}] remoteExec ["bis_fnc_call", 0];

		//progress bar for every player (and JIP) - runs on the clients and reads the public variables above
		[
			[_iTaskIndex],
			{
				params ["_iTaskIndex"];
				if (!hasInterface) exitWith {};
				[_iTaskIndex] spawn {
					params ["_iTaskIndex"];
					private _progressVar = format["CommsTowerProgress%1",_iTaskIndex];
					private _pausedVar = format["CommsTowerPaused%1",_iTaskIndex];
					private _doneVar = format["CommsTowerDone%1",_iTaskIndex];
					while {!(missionNamespace getVariable [_doneVar, false])} do {
						private _progress = floor (missionNamespace getVariable [_progressVar, 0]);
						private _filled = round (_progress / 5);
						private _bar = "";
						for "_i" from 1 to 20 do {
							_bar = _bar + (if (_i <= _filled) then {"|"} else {"."});
						};
						private _text = format["<t size='1.1' color='#ffcc00'>%1</t><br/><t size='1.2' font='EtelkaMonospacePro'>[%2]</t>", format[localize "STR_TRGM2_CommsTowerProgress", _progress], _bar];
						if (missionNamespace getVariable [_pausedVar, false]) then {
							_text = _text + format["<br/><t size='0.9' color='#ff5555'>%1</t>", localize "STR_TRGM2_CommsTowerPaused"];
						};
						"CommsTowerBar" cutText [_text, "PLAIN DOWN", 0.1, true, true];
						sleep 0.5;
					};
					"CommsTowerBar" cutText ["", "PLAIN"];
				};
			}
		] remoteExec ["bis_fnc_call", 0, _hudJipId];

		private _progress = 0;
		private _wasPaused = false;
		private _failed = false;
		while {_progress < 100 && !_failed && !(isNull _lifeTrigger)} do {
			sleep 1;

			//test hook: lets a tester jump the bar to a value from the debug console (see the console lines in the chat reply / commit message)
			private _sDebugSetVar = format["CommsTowerDebugSet%1",_iTaskIndex];
			private _debugSetTo = missionNamespace getVariable [_sDebugSetVar, -1];
			if (_debugSetTo >= 0) then {
				_progress = (_progress max _debugSetTo) min 100;
				missionNamespace setVariable [_sDebugSetVar, -1];
				missionNamespace setVariable [_progressVar, _progress, true];
			};

			private _livingPlayers = (allPlayers - entities "HeadlessClient_F") select {alive _x};
			if (count _livingPlayers == 0) then {
				_failed = true;
			}
			else {
				//only fills while a living player is within 10m (on the ground) of the tower
				private _isPaused = count (_livingPlayers select {_x distance2D _tower < 10}) == 0;
				if (!_isPaused) then {
					_progress = (_progress + (100 / _fullTimeSeconds)) min 100;
					missionNamespace setVariable [_progressVar, _progress, true];
				};
				if (_isPaused != _wasPaused) then {
					_wasPaused = _isPaused;
					missionNamespace setVariable [_pausedVar, _isPaused, true];
				};
			};
		};

		missionNamespace setVariable [_doneVar, true, true];
		[] remoteExec ["", _hudJipId]; //stop JIP players getting the progress bar replayed

		if (_progress >= 100) then {
			[["STR_TRGM2_CommsTowerComplete"], {hint localize (_this select 0);}] remoteExec ["bis_fnc_call", 0];

			if (_bCreateTask) then {
				[format["InfSide%1",_iTaskIndex], "succeeded"] remoteExec ["FHQ_TT_setTaskState", 0];
			}
			else {
				[1, localize "STR_TRGM2_CommsTowerMissionTitle"] execVM "RandFramework\AdjustMaxBadPoints.sqf";
			};
			ClearedPositions pushBack ([ObjectivePossitions, getPos _tower] call BIS_fnc_nearestPosition);
			publicVariable "ClearedPositions";

			//airstrike effect: 5 friendly jets fly past the tower from ~2km on one side to ~10km on the other
			[getPos _tower] spawn {
				params ["_towerPos"];
				private _dir = random 360;
				private _startPos = _towerPos getPos [2000, _dir + 180];
				private _endPos = _towerPos getPos [10000, _dir];
				private _jetGroup = createGroup west;
				for "_i" from 0 to 4 do {
					private _lateral = (_i - 2) * 250 + (random 100 - 50); //spread the jets out, the middle one passes close to the tower
					private _back = _i * 150; //stagger them along the track
					private _spawnPos = (_startPos getPos [_back, _dir + 180]) getPos [_lateral, _dir + 90];
					_spawnPos set [2, 400];
					private _moveToPos = _endPos getPos [_lateral, _dir + 90];
					private _jetData = [_spawnPos, _dir, selectRandom FriendlyJet, _jetGroup] call BIS_fnc_spawnVehicle;
					private _jet = _jetData select 0;
					_jet allowDamage false;
					_jet setCaptive true;
					{_x allowDamage false; _x setCaptive true;} forEach crew _jet;
					_jet flyInHeight 350;
					_jet setBehaviour "CARELESS";
					_jet setSpeedMode "FULL";
					_jet doMove _moveToPos;

					[_jet, _moveToPos] spawn {
						params ["_jet","_moveToPos"];
						private _timeout = time + 240;
						waitUntil {sleep 2; isNull _jet || {_jet distance2D _moveToPos < 800} || {time > _timeout}};
						if (!isNull _jet) then {
							{deleteVehicle _x;} forEach crew _jet;
							deleteVehicle _jet;
						};
					};
				};
			};
		};

		if (_failed) then {
			[["STR_TRGM2_CommsTowerFailed"], {hint localize (_this select 0);}] remoteExec ["bis_fnc_call", 0];
			if (_bCreateTask) then {
				[format["InfSide%1",_iTaskIndex], "failed"] remoteExec ["FHQ_TT_setTaskState", 0];
			};
			ClearedPositions pushBack ([ObjectivePossitions, getPos _tower] call BIS_fnc_nearestPosition);
			publicVariable "ClearedPositions";
		};
	};
};
