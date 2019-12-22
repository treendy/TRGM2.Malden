/*

Hint "Populating AO222 please wait...";
_percentage = 0;
while {_percentage < 100} do {
	Hint format["Populating AO please wait... %1 %", _percentage];
	_percentage = _percentage + 1;
	sleep 0.2;
};
*/
if (isServer) then {

	_mainAOPos = ObjectivePossitions select 0;
	HQPos = getMarkerPos "mrkHQ";

	_flatPos = nil;
	if (isNil "AOCampLocation") then {
		_flatPos = [_mainAOPos , 1300, 1700, 8, 0, 0.3, 0,AreasBlackList,[HQPos,HQPos]] call BIS_fnc_findSafePos;
		if (str(_flatPos) == "[0,0,0]") then {_flatPos = [_mainAOPos , 1300, 2000, 8, 0, 0.4, 0,AreasBlackList,[HQPos,HQPos]] call BIS_fnc_findSafePos;};
	//"Marker1" setMarkerPos _flatPos;
	}
	else {
		_flatPos = AOCampLocation;
	};

	_nearestAOStartRoads = _flatPos nearRoads 60;
	_bAOStartRoadFound = false;
	if (count _nearestAOStartRoads > 0) then {
		_bAOStartRoadFound = true;

		_thisPosAreaOfCheckpoint = _flatPos;
		_thisRoadOnly = true;
		_thisSide = west;
		_thisUnitTypes = FriendlyCheckpointUnits;
		_thisAllowBarakade = true;
		_thisIsDirectionAwayFromAO = false;
		[_flatPos,_flatPos,50,_thisRoadOnly,_thisSide,_thisUnitTypes,_thisAllowBarakade,_thisIsDirectionAwayFromAO,true,FriendlyScoutVehicles,500] execVM "RandFramework\setCheckpoint.sqf";
	};

	{systemChat "Mission Setup: 5";} remoteExec ["bis_fnc_call", 0];

	AOCampPos = _flatPos;
	_markerFastResponseStart = createMarker ["mrkFastResponseStart", _flatPos];
	_markerFastResponseStart setMarkerShape "ICON";

	_hideAoMarker = false;
	if (!isNil "HideAoMarker") then {
		_hideAoMarker = HideAoMarker;
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

	if (!AOCampOnlyAmmoBox) then {
		if (!_bAOStartRoadFound) then {
			
			_campFire = "Campfire_burning_F" createVehicle _flatPosCampFire;
			_campFire setDir (floor(random 360));

			_flatPosTent1 = nil;
			_flatPosTent1 = [_flatPosCampFire , 5, 10, 5, 0, 0.5, 0,[],[_behindBlockPos,_behindBlockPos]] call BIS_fnc_findSafePos;
			_Tent1 = "Land_TentA_F" createVehicle _flatPosTent1;
			_Tent1 setDir (floor(random 360));

			_flatPos2 = nil;
			_flatPos2 = [_flatPosCampFire , 5, 10, 5, 0, 0.5, 0,[],[_behindBlockPos,_behindBlockPos]] call BIS_fnc_findSafePos;
			_Tent2 = "Land_TentA_F" createVehicle _flatPos2;
			_Tent2 setDir (floor(random 360));

			[_Tent1, [localize "STR_TRGM2_startInfMission_RemoveVehicleFromTent",{_veh = selectRandom SmallTransportVehicle createVehicle (getPos (_this select 0));}]] remoteExec ["addAction", 0];
			[_Tent2, [localize "STR_TRGM2_startInfMission_RemoveVehicleFromTent",{_veh = selectRandom SmallTransportVehicle createVehicle (getPos (_this select 0));}]] remoteExec ["addAction", 0];
			//_Tent1 addAction [localize "STR_TRGM2_startInfMission_RemoveVehicleFromTent",{_veh = selectRandom SmallTransportVehicle createVehicle (getPos (_this select 0));}];
			//_Tent2 addAction [localize "STR_TRGM2_startInfMission_RemoveVehicleFromTent",{_veh = selectRandom SmallTransportVehicle createVehicle (getPos (_this select 0));}];

			_flatPos4 = nil;
			_flatPos4 = [_flatPosCampFire , 5, 10, 5, 0, 0.5, 0,[],[_behindBlockPos,_behindBlockPos]] call BIS_fnc_findSafePos;
			_Tent4 = "Land_WoodPile_F" createVehicle _flatPos4;
			_Tent4 setDir (floor(random 360));
		};



		if (iMissionParamType == 5) then {
			_flatPos4b = nil;
			_flatPos4b = [_flatPosCampFire , 5, 10, 3, 0, 0.5, 0,[],[_behindBlockPos,_behindBlockPos]] call BIS_fnc_findSafePos;
			endMissionBoard2 setPos _flatPos4b;
			_boardDirection = [_flatPosCampFire, endMissionBoard2] call BIS_fnc_DirTo;
			endMissionBoard2 setDir _boardDirection;

		};

		_flatPos5 = nil;
		_flatPos5 = [_flatPosCampFire, 12, 30, 12, 0, 0.5, 0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
		//_car1 = selectRandom FriendlyFastResponseVehicles createVehicle _flatPos5;
		_car1 = createVehicle [selectRandom FriendlyFastResponseVehicles, _flatPos5, [], 50, "NONE"];
		_car1 allowDamage false;
		_car1 setDir (floor(random 360));

		_flatPos6 = nil;
		_flatPos6 = [_flatPosCampFire, 12, 30, 12, 0, 0.5, 0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
		//_car2 = selectRandom FriendlyFastResponseVehicles createVehicle _flatPos6;
		_car2 = createVehicle [selectRandom FriendlyFastResponseVehicles, _flatPos5, [], 50, "NONE"];
		_car2 allowDamage false;
		_car2 setDir (floor(random 360));

		sleep 1;
		_car1 allowDamage true;
		_car2 allowDamage true;

		[_car1, [localize "STR_TRGM2_startInfMission_UnloadDingy","RandFramework\UnloadDingy.sqf"]] remoteExec ["addAction", 0];
		[_car2, [localize "STR_TRGM2_startInfMission_UnloadDingy","RandFramework\UnloadDingy.sqf"]] remoteExec ["addAction", 0];
		[_car1,FastResponseCarItems] call bis_fnc_initAmmoBox;
		[_car2,FastResponseCarItems] call bis_fnc_initAmmoBox;
	};

	_flatPos7 = nil;
	_flatPos7 = [_flatPosCampFire, 5, 12, 5, 0, 0.5, 0,[],[_behindBlockPos,_behindBlockPos]] call BIS_fnc_findSafePos;
	_AmmoBox1 = "C_T_supplyCrate_F" createVehicle _flatPos7;
	_AmmoBox1 allowDamage false;
	_AmmoBox1 setDir (floor(random 360));

	if (isClass(configFile >> "CfgPatches" >> "ace_main")) then {
		[_AmmoBox1,InitialBoxItemsWithAce] call bis_fnc_initAmmoBox;
	}
	else {
		[_AmmoBox1,InitialBoxItems] call bis_fnc_initAmmoBox;
	};

	{
		{
			_AmmoBox1 addMagazineCargoGlobal [_x, 3];
		} forEach magazines _x + primaryWeaponMagazine _x + secondaryWeaponMagazine _x;
		{
			_AmmoBox1 addItemCargoGlobal  [_x, 1];
		} forEach items _x;
		if (typeof(unitBackpack _x) != "") then {
			_AmmoBox1 addBackpackCargoGlobal [typeof(unitBackpack _x), 1];
		};
	}  forEach (if (isMultiplayer) then {playableUnits} else {switchableUnits});

	{systemChat "Mission Setup: 4";} remoteExec ["bis_fnc_call", 0];
	sleep 1;
	if (AdvancedSettings select ADVSET_VIRTUAL_ARSENAL_IDX == 1) then {
		//_AmmoBox1 addAction [localize "STR_TRGM2_startInfMission_VirtualArsenal", {["Open",true] spawn BIS_fnc_arsenal}];
		[_AmmoBox1, [localize "STR_TRGM2_startInfMission_VirtualArsenal",{["Open",true] spawn BIS_fnc_arsenal}]] remoteExec ["addAction", 0];
	};

	if (ISUNSUNG) then {
		_radio = selectRandom ["uns_radio2_radio","uns_radio2_transitor","uns_radio2_transitor02"] createVehicle _flatPos7;
	};

	{systemChat "Mission Setup: 3.7";} remoteExec ["bis_fnc_call", 0];
	sleep 1;

	//sl setPos [7772.8,20744.6,0];
	/*HERE WHY THIS CAUSE MASSIVE SLOWDOWN??????????????????????????????????????? */
	_flatPosUnits = _flatPosCampFire;
	{systemChat "Mission Setup: 3.5";} remoteExec ["bis_fnc_call", 0];
	sleep 1;

	_flatPosUnits = [_flatPosCampFire, 8, 17, 10, 0, 0.5, 0,[],[_behindBlockPos,_behindBlockPos]] call BIS_fnc_findSafePos;

	{systemChat "Mission Setup: 3.3";} remoteExec ["bis_fnc_call", 0];
	sleep 1;

	/* HERE ... why when this is uncommented does it cause slowdown?????
	//try create seperate file, and run this manually after fully loaded???

	//AOCampPos
	if (!isnil "sl") then {sl setPos _flatPosUnits};
	{systemChat "Mission Setup: 3.1.7";} remoteExec ["bis_fnc_call", 0];
	sleep 1;

	if (!isnil "k1_2") then {k1_2 setPos _flatPosUnits};
	{systemChat "Mission Setup: 3.1.6";} remoteExec ["bis_fnc_call", 0];
	sleep 1;

	if (!isnil "k1_3") then {k1_3  setPos _flatPosUnits};
	{systemChat "Mission Setup: 3.1.5";} remoteExec ["bis_fnc_call", 0];
	sleep 1;

	if (!isnil "k1_4") then {k1_4  setPos _flatPosUnits};
	{systemChat "Mission Setup: 3.1.4";} remoteExec ["bis_fnc_call", 0];
	sleep 1;

	if (!isnil "k1_5") then {k1_5  setPos _flatPosUnits};
	{systemChat "Mission Setup: 3.1.3";} remoteExec ["bis_fnc_call", 0];
	sleep 1;

	if (!isnil "k1_6") then {k1_6  setPos _flatPosUnits};
	{systemChat "Mission Setup: 3.1.2";} remoteExec ["bis_fnc_call", 0];
	sleep 1;

	if (!isnil "k1_7") then {k1_7  setPos _flatPosUnits};
	{systemChat "Mission Setup: 3.1.1";} remoteExec ["bis_fnc_call", 0];
	sleep 1;
	//*/



	MissionLoaded = true;
	publicVariable "MissionLoaded";

	{systemChat "Mission Setup: 3";} remoteExec ["bis_fnc_call", 0];
	[""] remoteExecCall ["Hint", 0];
};