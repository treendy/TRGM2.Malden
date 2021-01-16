/*

["Populating AO222 please wait..."] call TREND_fnc_notify;
_percentage = 0;
while {_percentage < 100} do {
	[format["Populating AO please wait... %1 %", _percentage]] call TREND_fnc_notify;
	_percentage = _percentage + 1;
	sleep 0.2;
};
*/
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;
if (isServer) then {

	_mainAOPos = TREND_ObjectivePossitions select 0;
	TREND_HQPos = getMarkerPos "mrkHQ";

	_flatPos = nil;
	if (isNil "TREND_AOCampLocation") then {
		_flatPos = [_mainAOPos , 1300, 1700, 8, 0, 0.3, 0,TREND_AreasBlackList,[TREND_HQPos,TREND_HQPos]] call TREND_fnc_findSafePos;
		if (str(_flatPos) == "[0,0,0]") then {_flatPos = [_mainAOPos , 1300, 2000, 8, 0, 0.4, 0,TREND_AreasBlackList,[TREND_HQPos,TREND_HQPos]] call TREND_fnc_findSafePos;};
	//"Marker1" setMarkerPos _flatPos;
	}
	else {
		_flatPos = TREND_AOCampLocation;
	};

	_nearestAOStartRoads = _flatPos nearRoads 60;
	_bAOStartRoadFound = false;
	if (count _nearestAOStartRoads > 0) then {
		_bAOStartRoadFound = true;

		_thisPosAreaOfCheckpoint = _flatPos;
		_thisRoadOnly = true;
		_thisSide = west;
		_thisUnitTypes = (call FriendlyCheckpointUnits);
		_thisAllowBarakade = true;
		_thisIsDirectionAwayFromAO = false;
		[_flatPos,_flatPos,50,_thisRoadOnly,_thisSide,_thisUnitTypes,_thisAllowBarakade,_thisIsDirectionAwayFromAO,true,(call FriendlyScoutVehicles),500] spawn TREND_fnc_setCheckpoint;
	};

	["Mission Setup: 5", true] call TREND_fnc_log;

	TREND_AOCampPos = _flatPos;
	_markerFastResponseStart = createMarker ["mrkFastResponseStart", _flatPos];
	_markerFastResponseStart setMarkerShape "ICON";

	_hideAoMarker = false;
	if (!isNil "TREND_HideAoMarker") then {
		_hideAoMarker = TREND_HideAoMarker;
	};
	if (_hideAoMarker) then {
		_markerFastResponseStart setMarkerType "empty";
	}
	else {
		_markerFastResponseStart setMarkerType "hd_dot";
	};

	_markerFastResponseStart setMarkerText (localize "STR_TRGM2_startInfMission_KiloCamp");
	//k1Car1 setPos _flatPos;
	//k1Car2 setPos _flatPos;

	_behindBlockPos = _flatPos;
	_flatPosCampFire = _behindBlockPos;

	if (!TREND_AOCampOnlyAmmoBox) then {
		if (!_bAOStartRoadFound) then {

			_campFire = "Campfire_burning_F" createVehicle _flatPosCampFire;
			_campFire setDir (floor(random 360));

			_flatPosTent1 = nil;
			_flatPosTent1 = [_flatPosCampFire , 5, 10, 5, 0, 0.5, 0,[],[_behindBlockPos,_behindBlockPos],"Land_TentA_F"] call TREND_fnc_findSafePos;
			_Tent1 = "Land_TentA_F" createVehicle _flatPosTent1;
			_Tent1 setDir (floor(random 360));

			_flatPos2 = nil;
			_flatPos2 = [_flatPosCampFire , 5, 10, 5, 0, 0.5, 0,[],[_behindBlockPos,_behindBlockPos],"Land_TentA_F"] call TREND_fnc_findSafePos;
			_Tent2 = "Land_TentA_F" createVehicle _flatPos2;
			_Tent2 setDir (floor(random 360));

			[_Tent1, [localize "STR_TRGM2_startInfMission_RemoveVehicleFromTent",{_veh = selectRandom TREND_SmallTransportVehicle createVehicle (getPos (_this select 0));}]] remoteExec ["addAction", 0];
			[_Tent2, [localize "STR_TRGM2_startInfMission_RemoveVehicleFromTent",{_veh = selectRandom TREND_SmallTransportVehicle createVehicle (getPos (_this select 0));}]] remoteExec ["addAction", 0];
			//_Tent1 addAction [localize "STR_TRGM2_startInfMission_RemoveVehicleFromTent",{_veh = selectRandom TREND_SmallTransportVehicle createVehicle (getPos (_this select 0));}];
			//_Tent2 addAction [localize "STR_TRGM2_startInfMission_RemoveVehicleFromTent",{_veh = selectRandom TREND_SmallTransportVehicle createVehicle (getPos (_this select 0));}];

			_flatPos4 = nil;
			_flatPos4 = [_flatPosCampFire , 5, 10, 5, 0, 0.5, 0,[],[_behindBlockPos,_behindBlockPos],"Land_WoodPile_F"] call TREND_fnc_findSafePos;
			_Tent4 = "Land_WoodPile_F" createVehicle _flatPos4;
			_Tent4 setDir (floor(random 360));
		};



		if (TREND_iMissionParamType == 5) then {
			_flatPos4b = nil;
			_flatPos4b = [_flatPosCampFire , 5, 10, 3, 0, 0.5, 0,[],[_behindBlockPos,_behindBlockPos],endMissionBoard2] call TREND_fnc_findSafePos;
			endMissionBoard2 setPos _flatPos4b;
			_boardDirection = [_flatPosCampFire, endMissionBoard2] call BIS_fnc_DirTo;
			endMissionBoard2 setDir _boardDirection;

		};

		_flatPos5 = nil;
		_flatPos5 = [_flatPosCampFire, 12, 30, 12, 0, 0.5, 0,[],[[0,0,0],[0,0,0]],selectRandom (call FriendlyFastResponseVehicles)] call TREND_fnc_findSafePos;
		//_car1 = selectRandom (call FriendlyFastResponseVehicles) createVehicle _flatPos5;
		_car1 = createVehicle [selectRandom (call FriendlyFastResponseVehicles), _flatPos5, [], 50, "NONE"];
		_car1 allowDamage false;
		_car1 setDir (floor(random 360));

		_flatPos6 = nil;
		_flatPos6 = [_flatPosCampFire, 12, 30, 12, 0, 0.5, 0,[],[[0,0,0],[0,0,0]],selectRandom (call FriendlyFastResponseVehicles)] call TREND_fnc_findSafePos;
		//_car2 = selectRandom (call FriendlyFastResponseVehicles) createVehicle _flatPos6;
		_car2 = createVehicle [selectRandom (call FriendlyFastResponseVehicles), _flatPos5, [], 50, "NONE"];
		_car2 allowDamage false;
		_car2 setDir (floor(random 360));

		sleep 1;
		_car1 allowDamage true;
		_car2 allowDamage true;

		[_car1, [localize "STR_TRGM2_startInfMission_UnloadDingy",{[_this select 0, _this select 1, _this select 2, _this select 3] spawn TREND_fnc_UnloadDingy;}]] remoteExec ["addAction", 0];
		[_car2, [localize "STR_TRGM2_startInfMission_UnloadDingy",{[_this select 0, _this select 1, _this select 2, _this select 3] spawn TREND_fnc_UnloadDingy;}]] remoteExec ["addAction", 0];
		[_car1,TREND_FastResponseCarItems] call bis_fnc_initAmmoBox;
		[_car2,TREND_FastResponseCarItems] call bis_fnc_initAmmoBox;
	};

	_flatPos7 = nil;
	_flatPos7 = [_flatPosCampFire, 5, 12, 5, 0, 0.5, 0,[],[_behindBlockPos,_behindBlockPos],"C_T_supplyCrate_F"] call TREND_fnc_findSafePos;
	_AmmoBox1 = "C_T_supplyCrate_F" createVehicle _flatPos7;
	_AmmoBox1 allowDamage false;
	_AmmoBox1 setDir (floor(random 360));

	[_AmmoBox1] call TREND_fnc_initAmmoBox;

	["Mission Setup: 4", true] call TREND_fnc_log;
	sleep 1;
	if (TREND_AdvancedSettings select TREND_ADVSET_VIRTUAL_ARSENAL_IDX == 1) then {
		//_AmmoBox1 addAction [localize "STR_TRGM2_startInfMission_VirtualArsenal", {["Open",true] spawn BIS_fnc_arsenal}];
		[_AmmoBox1, [localize "STR_TRGM2_startInfMission_VirtualArsenal",{["Open",true] spawn BIS_fnc_arsenal}]] remoteExec ["addAction", 0];
	};

	if (TREND_ISUNSUNG) then {
		_radio = selectRandom ["uns_radio2_radio","uns_radio2_transitor","uns_radio2_transitor02"] createVehicle _flatPos7;
	};

	["Mission Setup: 3.7", true] call TREND_fnc_log;
	sleep 1;

	//sl setPos [7772.8,20744.6,0];
	/*HERE WHY THIS CAUSE MASSIVE SLOWDOWN??????????????????????????????????????? */
	// _flatPosUnits = _flatPosCampFire;
	// ["Mission Setup: 3.5", true] call TREND_fnc_log;
	// sleep 1;

	// _flatPosUnits = [_flatPosCampFire, 8, 17, 10, 0, 0.5, 0,[],[_behindBlockPos,_behindBlockPos]] call TREND_fnc_findSafePos;

	// ["Mission Setup: 3.3", true] call TREND_fnc_log;
	// sleep 1;

	/* HERE ... why when this is uncommented does it cause slowdown?????
	//try create seperate file, and run this manually after fully loaded???

	//AOCampPos
	if (!isnil "sl") then {sl setPos _flatPosUnits};
	["Mission Setup: 3.1.7", true] call TREND_fnc_log;
	sleep 1;

	if (!isnil "k1_2") then {k1_2 setPos _flatPosUnits};
	["Mission Setup: 3.1.6", true] call TREND_fnc_log;
	sleep 1;

	if (!isnil "k1_3") then {k1_3  setPos _flatPosUnits};
	["Mission Setup: 3.1.5", true] call TREND_fnc_log;
	sleep 1;

	if (!isnil "k1_4") then {k1_4  setPos _flatPosUnits};
	["Mission Setup: 3.1.4", true] call TREND_fnc_log;
	sleep 1;

	if (!isnil "k1_5") then {k1_5  setPos _flatPosUnits};
	["Mission Setup: 3.1.3", true] call TREND_fnc_log;
	sleep 1;

	if (!isnil "k1_6") then {k1_6  setPos _flatPosUnits};
	["Mission Setup: 3.1.2", true] call TREND_fnc_log;
	sleep 1;

	if (!isnil "k1_7") then {k1_7  setPos _flatPosUnits};
	["Mission Setup: 3.1.1", true] call TREND_fnc_log;
	sleep 1;
	//*/

	TREND_MissionLoaded =  true; publicVariable "TREND_MissionLoaded";

	["Mission Setup: 3", true] call TREND_fnc_log;
	[""] remoteExecCall ["Hint", 0];
};

true;