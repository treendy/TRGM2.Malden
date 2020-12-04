// #include "..\CustomMission\TRGMSetDefaultMissionSetupVars.sqf";

// Set relationships
west setFriend [east, 0];
west setFriend [resistance, 0];
east setFriend [west, 0];
east setFriend [resistance, 1];
resistance setFriend [west, 0];
resistance setFriend [east, 1];
civilian setFriend [west, 1];
civilian setFriend [east, 1];



if (isServer) then {
	TREND_SniperCount = 0; publicVariable "TREND_SniperCount";
	TREND_SniperAttemptCount = 0; publicVariable "TREND_SniperAttemptCount";
	TREND_SpotterCount = 0; publicVariable "TREND_SpotterCount";
	TREND_SpotterAttemptCount = 0; publicVariable "TREND_SpotterAttemptCount";
	TREND_friendlySentryCheckpointPos = []; publicVariable "TREND_friendlySentryCheckpointPos";
};


if (isNil "tracer1") then {
	tracer1 = (group (missionNamespace getvariable ["BIS_functions_mainscope",objnull])) createUnit ["ModuleTracers_F",[0,0,0],[],0,"CAN_COLLIDE"];
	tracer1 setVehicleVarName "tracer1";
	tracer1 setVariable ['Side',"0",true];
	tracer1 setVariable ['Min',"10",true];
	tracer1 setVariable ['Max',"20",true];
	tracer1 setVariable ['Weapon',"",true];
	tracer1 setVariable ['Magazine',"",true];
	tracer1 setVariable ['Target',"",true];
	tracer1 setvariable ["BIS_fnc_initModules_disableAutoActivation",true];
};
if (isNil "tracer2") then {
	tracer2 = (group (missionNamespace getvariable ["BIS_functions_mainscope",objnull])) createUnit ["ModuleTracers_F",[0,0,0],[],0,"CAN_COLLIDE"];
	tracer2 setVehicleVarName "tracer2";
	tracer2 setVariable ['Side',"2",true];
	tracer2 setVariable ['Min',"10",true];
	tracer2 setVariable ['Max',"20",true];
	tracer2 setVariable ['Weapon',"",true];
	tracer2 setVariable ['Magazine',"",true];
	tracer2 setVariable ['Target',"",true];
	tracer2 setvariable ["BIS_fnc_initModules_disableAutoActivation",true];
};
if (isNil "tracer3") then {
	tracer3 = (group (missionNamespace getvariable ["BIS_functions_mainscope",objnull])) createUnit ["ModuleTracers_F",[0,0,0],[],0,"CAN_COLLIDE"];
	tracer3 setVehicleVarName "tracer3";
	tracer3 setVariable ['Side',"0",true];
	tracer3 setVariable ['Min',"10",true];
	tracer3 setVariable ['Max',"20",true];
	tracer3 setVariable ['Weapon',"",true];
	tracer3 setVariable ['Magazine',"",true];
	tracer3 setVariable ['Target',"",true];
	tracer3 setvariable ["BIS_fnc_initModules_disableAutoActivation",true];
};
if (isNil "tracer4") then {
	tracer4 = (group (missionNamespace getvariable ["BIS_functions_mainscope",objnull])) createUnit ["ModuleTracers_F",[0,0,0],[],0,"CAN_COLLIDE"];
	tracer4 setVehicleVarName "tracer4";
	tracer4 setVariable ['Side',"0",true];
	tracer4 setVariable ['Min',"10",true];
	tracer4 setVariable ['Max',"20",true];
	tracer4 setVariable ['Weapon',"",true];
	tracer4 setVariable ['Magazine',"",true];
	tracer4 setVariable ['Target',"",true];
	tracer4 setvariable ["BIS_fnc_initModules_disableAutoActivation",true];
};
tracer1 setPos [99999,99999];
tracer2 setPos [99999,99999];
tracer3 setPos [99999,99999];
tracer4 setPos [99999,99999];


player createDiarySubject ["supportMe","Support Me"];
player createDiaryRecord ["supportMe", ["-", "<br /><font color='#5555FF'>www.trgm2.com</font><br /><br />Thank you for taking the time to read this : )
<br />
<br />
I love creating these missions and over the past few years have dedicated way too many hours to Arma 3 lol... nearly at the cost of my marriage!!! : S  

<br /><br />
<font color='#FFFF00'>Follow Me</font>
<br />If you want to support my work, there are quite a few ways to do so... if you visit my steam workshop page and give a thumbs up and comment, it really means a lot... these thumbs up ratings, and adding to fav help move my work up the workshop pages,
Follow me on steam, or my YouTube account, its nice to know my videos are being watched.
<br />
<br /><font color='#FFFF00'>
Donations : www.trgm2.com</font>
<br />
If you really want to, you can make a donation via my site www.trgm2.com (paypal link at top right of site).  I would also love to dedicate more time to the TRGM2 engine, making updates, fixes and new features, so would love to take some time off work to spend full days on my engine : )"]];


//hintSilent parseText "<t size='1.25' font='Zeppelin33' color='#ff0000'>test lives remaining.</t><a href='http://arma3.com'>A3</a>";



if (isServer) then { //adjust weather here so intro animation is different everytime
	[true] call TREND_fnc_SetTimeAndWeather;
};

waitUntil {time > 0};

showCinemaBorder  true;

_centerPos = getArray (configfile >> "CfgWorlds" >> worldName >> "centerPosition");
if !(isNil "TREND_CustomCenterPos") then {
	_centerPos = TREND_CustomCenterPos;
};

_pos1 = (_centerPos getPos [(floor(random 5000))+50, (floor(random 360))]);
_pos2 = (_centerPos getPos [(floor(random 5000))+50, (floor(random 360))]);
_pos1 = [_pos1 select 0,_pos1 select 1,selectRandom[200,300]];
_pos2 = [_pos2 select 0,_pos2 select 1,selectRandom[200,300]];
_camera = "camera" camCreate _pos1;
_camera cameraEffect ["internal","back"];
_camera camPreparePos _pos2;
_camera camPrepareTarget _centerPos;
_camera camPrepareFOV 0.4;
_camera camCommitPrepared 600;



_trgRatingAdjust = createTrigger ["EmptyDetector", [0,0]];
_trgRatingAdjust setTriggerArea [0, 0, 0, false];
_trgRatingAdjust setTriggerStatements ["((rating player) < 0)", "player addRating -(rating player)", ""];


if (!isDedicated) then {
	waitUntil {!isNull player};

	TransferProviders = {
		if !([] call TREND_fnc_isCbaLoaded) then {
			[[chopper1]] call TREND_fnc_addTransportActions;
		};

		_oldUnit = _this select 0;
		_oldProviders = _oldUnit getVariable ["BIS_SUPP_allProviderModules",[]];
		_HQ = _oldUnit getVariable ["BIS_SUPP_HQ",nil];

		if (isNil "_HQ") then {_HQ = HQMan;};

		if (isNil {player getVariable ["BIS_SUPP_HQ",nil]}) then {
			if ((count _oldProviders) > 0) then {
				{
					_providerModule = _x;
					{
						if (typeOf _x == "SupportRequester" && _oldUnit in (synchronizedObjects _x)) then {
							[player, _x, _providerModule] call BIS_fnc_addSupportLink;
						};
					}forEach synchronizedObjects _providerModule;
				}forEach _oldProviders;
			};

			player setVariable ["BIS_SUPP_transmitting", false];
			player kbAddTopic ["BIS_SUPP_protocol", "A3\Modules_F\supports\kb\protocol.bikb", "A3\Modules_F\supports\kb\protocol.fsm", {call compile preprocessFileLineNumbers "A3\Modules_F\supports\kb\protocol.sqf"}];
			player setVariable ["BIS_SUPP_HQ", _HQ];
		};

		{
			_used = _oldUnit getVariable [format ["BIS_SUPP_used_%1",_x], 0];
			player setVariable [format ["BIS_SUPP_used_%1", _x], _used, true]
		} forEach [
			"Artillery",
			"CAS_Heli",
			"CAS_Bombing",
			"UAV",
			"Drop",
			"Transport"
		];
	};


	_thread = [] spawn {
		_unit = player;
		while {true} do {
			waitUntil {_unit != player };
			group player selectLeader player;
			//hintSilent " Player has changed";
			[_unit] call TransferProviders;
			_unit = player;
		};
	};

};

// Instead of only doing this in SP, check if the HCs are empty and delete the unused ones.
if (!isNil "vs1")  then { deleteVehicle vs1; };
if (!isNil "vs2")  then { deleteVehicle vs2; };
if (!isNil "vs3")  then { deleteVehicle vs3; };
if (!isNil "vs4")  then { deleteVehicle vs4; };
if (!isNil "vs5")  then { deleteVehicle vs5; };
if (!isNil "vs6")  then { deleteVehicle vs6; };
if (!isNil "vs7")  then { deleteVehicle vs7; };
if (!isNil "vs8")  then { deleteVehicle vs8; };
if (!isNil "vs9")  then { deleteVehicle vs9; };
if (!isNil "vs10") then { deleteVehicle vs10; };

private _isAdmin = (!isMultiplayer || isMultiplayer && !isDedicated && isServer || isMultiplayer && !isServer && (call BIS_fnc_admin) != 0);
if (!isDedicated && _isAdmin) then {
	waitUntil {TREND_bOptionsSet};
	if (TREND_iMissionParamType != 5) then {	//if isCampaign, dont allow to select AO
		if (TREND_AdvancedSettings select TREND_ADVSET_SELECT_AO_IDX == 1) then {
			mrkAoSelect1 = nil;
			mrkAoSelect2 = nil;
			mrkAoSelect3 = nil;
			titleText [localize "STR_TRGM2_mainInit_Loading", "BLACK FADED"];
			_camera cameraEffect ["Terminate","back"];
			titleText[localize "STR_TRGM2_tele_SelectPositionAO1", "PLAIN"];
			openMap true;
			onMapSingleClick "Mission1Loc = _pos; publicVariable 'Mission1Loc'; openMap false; onMapSingleClick ''; true;";
			sleep 1;
			waitUntil {!visibleMap};
			["mrkAoSelect1",  Mission1Loc, "ICON", "ColorRed", [1,1], "AO 1"] call AIS_Core_fnc_createLocalMarker;

			if (TREND_iMissionParamType == 0 || TREND_iMissionParamType == 4) then {
				titleText[localize "STR_TRGM2_tele_SelectPositionAO2", "PLAIN"];
				openMap true;
				onMapSingleClick "Mission2Loc = _pos; publicVariable 'Mission2Loc'; openMap false; onMapSingleClick ''; true;";
				sleep 1;
				waitUntil {!visibleMap};
				["mrkAoSelect2",  Mission2Loc, "ICON", "ColorRed", [1,1], "AO 2"] call AIS_Core_fnc_createLocalMarker;

				titleText[localize "STR_TRGM2_tele_SelectPositionAO3", "PLAIN"];
				openMap true;
				onMapSingleClick "Mission3Loc = _pos; publicVariable 'Mission3Loc'; openMap false; onMapSingleClick ''; true;";
				sleep 1;
				waitUntil {!visibleMap};
				["mrkAoSelect3",  Mission3Loc, "ICON", "ColorRed", [1,1], "AO 3"] call AIS_Core_fnc_createLocalMarker;
			};

			if (getMarkerColor "mrkAoSelect1" != "") then {deleteMarker "mrkAoSelect1";};
			if (getMarkerColor "mrkAoSelect2" != "") then {deleteMarker "mrkAoSelect2";};
			if (getMarkerColor "mrkAoSelect3" != "") then {deleteMarker "mrkAoSelect3";};
		};

		if (TREND_AdvancedSettings select TREND_ADVSET_SELECT_AO_CAMP_IDX == 1) then {
			titleText [localize "STR_TRGM2_mainInit_Loading", "BLACK FADED"];
			_camera cameraEffect ["Terminate","back"];
			titleText[localize "STR_TRGM2_tele_SelectPosition_AO_Camp", "PLAIN"];
			openMap true;
			onMapSingleClick "AOCampLocation = _pos; publicVariable 'AOCampLocation'; openMap false; onMapSingleClick ''; true;";
			sleep 1;
			waitUntil {!visibleMap};
		};


	};
	TREND_bAndSoItBegins = true; publicVariable "TREND_bAndSoItBegins";
};




waitUntil {TREND_bAndSoItBegins};

private _coreCountSleep = 0.1;
systemChat format["Mission Core: %1", "Init"];
sleep _coreCountSleep;



if (isServer && TREND_AdvancedSettings select TREND_ADVSET_GROUP_MANAGE_IDX == 1) then {
	["Initialize"] call BIS_fnc_dynamicGroups;//Exec on Server
};

systemChat format["Mission Core: %1", "GroupManagementSet"];
sleep _coreCountSleep;

if (!isDedicated) then {
	titleText [localize "STR_TRGM2_mainInit_Loading", "BLACK FADED"];
	_camera cameraEffect ["Terminate","back"];
};

systemChat format["Mission Core: %1", "CameraTerminated"];
sleep _coreCountSleep;


[] call TREND_fnc_initUnitVars;

systemChat format["Mission Core: %1", "GlobalVarsSet"];
sleep _coreCountSleep;

if (isServer) then {
	[] call TREND_fnc_buildEnemyFaction;
	{systemChat format["Mission Core: %1", "EnemyGlobalVarsSet"];} remoteExec ["bis_fnc_call", 0];
	sleep _coreCountSleep;

	[] call TREND_fnc_buildFriendlyFaction;
	{systemChat format["Mission Core: %1", "FriendlyGlobalVarsSet"];} remoteExec ["bis_fnc_call", 0];
	sleep _coreCountSleep;

	// #include "..\CustomMission\TRGMSetEnemyFaction.sqf"; //if _useCustomEnemyFaction set to true within this sqf, will overright the above enemy faction data
	{systemChat format["Mission Core: %1", "EnemyFactionSet"];} remoteExec ["bis_fnc_call", 0];
	sleep _coreCountSleep;

	// #include "..\CustomMission\TRGMSetFriendlyLoadouts.sqf"; //as above, but for _useCustomFriendlyLoadouts
	{systemChat format["Mission Core: %1", "FriendlyLoadoutSet"];} remoteExec ["bis_fnc_call", 0];
	sleep _coreCountSleep;

	/*Fix any changed types	 */
	if (typeName sCivilian != "ARRAY") then {sCivilian = [sCivilian]};
	/*end */

	private _airTransClassName = selectRandom (SupplySupportChopperOptions select {getNumber(configFile >> "CfgVehicles" >> _x >> "transportSoldier") >= 10});
	if (_airTransClassName != typeOf chopper1) then {
		{deleteVehicle _x;} forEach crew (vehicle chopper1) + [vehicle chopper1];
		private _chopper1Arr = [getPos heliPad1, 0, _airTransClassName, WEST] call BIS_fnc_spawnVehicle;
		chopper1 = _chopper1Arr select 0;
		chopper1 setVehicleVarName "chopper1";
		publicVariable "chopper1";
		chopper1 allowDamage false;
		chopper1 setPos getPos heliPad1;
		chopper1 setdamage 0;
		chopper1 engineOn false;
		chopper1 lockDriver true;
		chopper1D = driver chopper1;
		chopper1D setVehicleVarName "chopper1D";
		chopper1D allowDamage false;
		chopper1D setCaptive true;
		chopper1D disableAI "AUTOTARGET";
		chopper1D disableAI "TARGET";
		chopper1D disableAI "SUPPRESSION";
		chopper1D disableAI "AUTOCOMBAT";
		chopper1D setBehaviour "CARELESS";
		publicVariable "chopper1D";
		private _totalTurrets = [_airTransClassName, true] call BIS_fnc_allTurrets;
		{chopper1 lockTurret [_x, true]} forEach _totalTurrets;
		{ doStop _x; } forEach (_chopper1Arr select 1);
	};

	private _airSupClassName = selectRandom FriendlyChopper;
	if (_airSupClassName != typeOf chopper2) then {
		{deleteVehicle _x;} forEach crew (vehicle chopper2) + [vehicle chopper2];
		private _chopper2Arr = [getPos airSupportHeliPad, 0, _airSupClassName, WEST] call BIS_fnc_spawnVehicle;
		chopper2 = _chopper2Arr select 0;
		chopper2 setVehicleVarName "chopper2";
		publicVariable "chopper2";
		chopper2 allowDamage false;
		chopper2 setPos getPos airSupportHeliPad;
		chopper2 setdamage 0;
		chopper2 engineOn false;
		chopper2 lockDriver true;
		chopper2D = driver chopper2;
		chopper2D setVehicleVarName "chopper2D";
		publicVariable "chopper2D";
		private _totalTurrets = [_airSupClassName, true] call BIS_fnc_allTurrets;
		{chopper2 lockTurret [_x, true]} forEach _totalTurrets;
		{ doStop _x; } forEach (_chopper2Arr select 1);
		chopper2 allowDamage true;
	};

	TREND_counter = 0;
	{
		if (_x isKindOf "LandVehicle" || _x isKindOf "Air" || _x isKindOf "Ship") then {
			private _faction = getText(configFile >> "CfgVehicles" >> typeOf _x >> "faction");
			private _friendlyFactionIndex = TREND_AdvancedSettings select TREND_ADVSET_FRIENDLY_FACTIONS_IDX;
			(TREND_WestFactionData select _friendlyFactionIndex) params ["_westClassName", "_westDisplayName"];
			if ((count crew _x) == 0 && getNumber(configFile >> "CfgFactionClasses" >> _faction >> "side") == 1 && _faction != _westClassName) then {
				private _newVehClass = [_x, WEST] call TREND_fnc_getFactionVehicle;
				private _pos = getPosATL _x;
				private _dir = getDir _x;
				deleteVehicle _x;
				sleep 0.01;
				private _newVeh = createVehicle [_newVehClass, _pos, [], 0, "NONE"];
				_newVeh setDir _dir;
				_newVeh allowDamage false;
				_newVeh setPos (_pos vectorAdd [0,0,0.1]);
				_newVeh allowDamage true;
				TREND_counter = TREND_counter + 1;
			};
		};
	} forEach vehicles;

	// [TREND_counter, "Vehicle spawn corrections"] spawn TREND_fnc_AdjustMaxBadPoints;

	TREND_CustomObjectsSet = true; publicVariable "TREND_CustomObjectsSet";
	// call compile preprocessFileLineNumbers "RandFramework\setFriendlyObjects.sqf";
	{systemChat format["Mission Core: %1", "FriendlyObjectsSet"];} remoteExec ["bis_fnc_call", 0];
	sleep _coreCountSleep;

/*
	if (TREND_EnemyFactionData != "") then {
		_errorMessage = "";
		_ObjectPairs = TREND_EnemyFactionData splitString ";";
		{
			_fullObj = _x;
			_pair = _x splitString "=";
			_title = str(((_pair select 0) splitString " ") select 0);
			_class = (_pair select 1 splitString """");

			if (!isNil("_class") && !isNil("_title")) then {
				if (count _class > 1) then {
 				 	_class = _class select 1;
				}
				else {
 			 		_class = _class select 0;
				};
				_classArray = [];
				if (typeName _class == "ARRAY") then {
					_classArray = _class;
				}
				else {
					_classArray = [_class];
				};

				{
					_className = _x;
					if (str(_className) != "") then {
						if (isClass (configFile >> "CfgVehicles" >> _className)) then {
							call compile _fullObj;
						}
						else {
							_errorMessage = _errorMessage + format[localize "STR_TRGM2_mainInit_ErrorClassExist",_fullObj,_x];
						};
					}
					else {
						_errorMessage = _errorMessage + format[localize "STR_TRGM2_mainInit_ErrorClassEmpty",_fullObj,_x];
					};

				} forEach _classArray;
			};
		} forEach _ObjectPairs;
		if (_errorMessage != "") then {
			hint _errorMessage;
			sleep 3;
		};
	};
*/
	{systemChat format["Mission Core: %1", "EnemyFactionDataProcessed"];} remoteExec ["bis_fnc_call", 0];
	sleep _coreCountSleep;

    _isAceRespawnWithGear = false;
 	if ([] call TREND_fnc_isCbaLoaded) then {
	   // check for ACE respawn with gear setting
  	   _isAceRespawnWithGear = "ace_respawn_savePreDeathGear" call CBA_settings_fnc_get;
	};

	{systemChat format["Mission Core: %1", "savePreDeathGear"];} remoteExec ["bis_fnc_call", 0];
	sleep _coreCountSleep;
	if (/*TREND_LoadoutData != "" || TREND_LoadoutDataDefault != ""*/true) then {
		{
			//_x setVariable ["UnitRole",_unitRole];
			_handle = [_x] call TREND_fnc_setLoadout;
			waitUntil {_handle};
			if (!isNil("_isAceRespawnWithGear")) then {
				if (!_isAceRespawnWithGear) then {
			   		_x addEventHandler ["Respawn", { [_this select 0] call TREND_fnc_setLoadout; }];
		        };
			};
		} forEach (if (isMultiplayer) then {playableUnits} else {switchableUnits});
		sleep 1;
	};
	{systemChat format["Mission Core: %1", "setLoadout ran"];} remoteExec ["bis_fnc_call", 0];
	sleep _coreCountSleep;

	if ([] call TREND_fnc_isAceLoaded) then {
		[box1,TREND_InitialBoxItemsWithAce] call bis_fnc_initAmmoBox;
	}
	else {
		[box1,TREND_InitialBoxItems] call bis_fnc_initAmmoBox;
	};

	box1 allowDamage false;
	{
		{
			box1 addMagazineCargoGlobal [_x, 2];
		} forEach magazines _x + primaryWeaponMagazine _x + secondaryWeaponMagazine _x;
		{
	   		box1 addItemCargoGlobal  [_x, 1];
		} forEach items _x;
		if (typeof(unitBackpack _x) != "") then {
			box1 addBackpackCargoGlobal [typeof(unitBackpack _x), 1];
		};
	}  forEach (if (isMultiplayer) then {playableUnits} else {switchableUnits});

	{systemChat format["Mission Core: %1", "boxCargo set"];} remoteExec ["bis_fnc_call", 0];
	sleep _coreCountSleep;


};

systemChat format["Mission Core: %1", "PreCustomObjectSet"];
sleep _coreCountSleep;

waitUntil {TREND_CustomObjectsSet};

systemChat format["Mission Core: %1", "PostCustomObjectSet"];
sleep _coreCountSleep;

if (!isNil "chopper1") then {
	[[chopper1]] call TREND_fnc_addTransportActions;
};

systemChat format["Mission Core: %1", "TransportScriptRun"];
sleep _coreCountSleep;

if (TREND_iUseRevive > 0 && isNil "AIS_MOD_ENABLED") then {
	[] call AIS_Core_fnc_preInit;
	[] call AIS_Core_fnc_postInit;
	[] call AIS_System_fnc_postInit;
};


systemChat format["Mission Core: %1", "AIS Script Run"];
sleep _coreCountSleep;


// Place in unit init to have them deleted in MP: this setVariable ["MP_ONLY", true, true];
if (!isMultiplayer) then {
	{
		if (_x getVariable ["MP_ONLY",false] && !isNil "_x") then {
			deleteVehicle _x;
		};
	} forEach allUnits;
};

systemChat format["Mission Core: %1", "DeleteMpOnlyVehicles"];
sleep _coreCountSleep;


player doFollow player;


systemChat format["Mission Core: %1", "DoFollowRun"];
sleep _coreCountSleep;

if (TREND_iMissionParamType == 5) then {
	if (isServer) then {
		call TREND_fnc_initCampaign;
	};
}
else {
	call TREND_fnc_StartMission;
};
systemChat format["Mission Core: %1", "InitCampaign/StartMission ran"];
sleep _coreCountSleep;

waitUntil {TREND_MissionLoaded};

systemChat format["Mission Core: %1", "TREND_MissionLoaded true"];
sleep _coreCountSleep;

TREND_fnc_CheckBadPoints = {
	if (isNil "TREND_BadPoints") then {TREND_BadPoints = 0; publicVariable "TREND_BadPoints";};
	_lastRepPoints = [TREND_MaxBadPoints - TREND_BadPoints,1] call BIS_fnc_cutDecimals;
	_lastBadPoints = TREND_BadPoints;
	_LastRank = 0;
	if (_lastRepPoints >= 10) then {_LastRank = 5;};
	if (_lastRepPoints < 10) then {_LastRank = 4;};
	if (_lastRepPoints < 7) then {_LastRank = 3;};
	if (_lastRepPoints < 5) then {_LastRank = 2;};
	if (_lastRepPoints < 3) then {_LastRank = 1;};
	if (_lastRepPoints < 1) then {_LastRank = 0;};
	while {true} do {
		_dCurrentRep = [TREND_MaxBadPoints - TREND_BadPoints,1] call BIS_fnc_cutDecimals;
		_CurrentRank = _LastRank;
		if (_dCurrentRep >= 10) then {_CurrentRank = 5;};
		if (_dCurrentRep < 10) then {_CurrentRank = 4;};
		if (_dCurrentRep < 7) then {_CurrentRank = 3;};
		if (_dCurrentRep < 5) then {_CurrentRank = 2;};
		if (_dCurrentRep < 3) then {_CurrentRank = 1;};
		if (_dCurrentRep < 1) then {_CurrentRank = 0;};
		if (_dCurrentRep != _lastRepPoints) then {
			if (TREND_SaveType != 0) then {
				[TREND_SaveType,false] spawn TREND_fnc_ServerSave;
				_lastRepPoints = _dCurrentRep;
			};
		};

		if (_lastBadPoints != TREND_BadPoints) then {

			_bRepWorse = false;
			if (TREND_BadPoints > _lastBadPoints) then {_bRepWorse = true};
			_lastBadPoints = TREND_BadPoints;
			if (TREND_iMissionParamType != 5) then {
				if (_dCurrentRep <= 0 && TREND_iMissionParamRepOption == 1) then {
					_iCurrentTaskCount = 0;
					["tskKeepAboveAverage", "failed"] call FHQ_fnc_ttSetTaskState;
					while {_iCurrentTaskCount < count TREND_ActiveTasks} do {
						if (!(TREND_ActiveTasks call FHQ_fnc_ttAreTasksCompleted)) then {
							[TREND_ActiveTasks select _iCurrentTaskCount, "failed"] call FHQ_fnc_ttSetTaskState;
							_iCurrentTaskCount = _iCurrentTaskCount + 1;
						};
					};
					sleep 2;

					[TREND_FriendlySide, ["DeBrief", localize "STR_TRGM2_mainInit_Debrief", "Debrief", ""]] call FHQ_fnc_ttAddTasks;
				};
				if (_dCurrentRep <= 0 && TREND_iMissionParamRepOption == 0) then { //note... when gaining rep, we increase the TREND_MaxBadPoints, and when lower, we incrase TREND_BadPoints (rep is calulated by the difference)
					["tskKeepAboveAverage", "failed"] call FHQ_fnc_ttSetTaskState;
				};
				if (_dCurrentRep > 0 && TREND_iMissionParamRepOption == 0) then {
					["tskKeepAboveAverage", "succeeded"] call FHQ_fnc_ttSetTaskState;
				};
			};
		};
		if (_LastRank != _CurrentRank) then {
			_bRepWorse = true;
			if (_CurrentRank > _LastRank) then {_bRepWorse = false};
			_LastRank = _CurrentRank;
			if (TREND_iMissionParamType == 5) then {
				_sRankIcon = "";
				_sRankMessage = "";
				//HERE HERE HERE!!!!!!!!!!!!!!!!!!!!!!!!!!!
				//!!!!!! rank cound go from 2.2 to 3.2 and would not show icon... so need to check if =< 3 and if rank has actually changed!
				if (_dCurrentRep >= 10) then {_sRankIcon = "<img image='RandFramework\Media\Rank5.jpg' size='3.5' />";};
				if (_dCurrentRep < 10) then {_sRankIcon = "<img image='RandFramework\Media\Rank4.jpg' size='3.5' />";};
				if (_dCurrentRep < 7) then {_sRankIcon = "<img image='RandFramework\Media\Rank3.jpg' size='3.5' />";};
				if (_dCurrentRep < 5) then {_sRankIcon = "<img image='RandFramework\Media\Rank2.jpg' size='3.5' />";};
				if (_dCurrentRep < 3) then {_sRankIcon = "<img image='RandFramework\Media\Rank1b.jpg' size='3.5' />";};
				if (_dCurrentRep <= 0) then {_sRankIcon = "<img image='RandFramework\Media\Rank0.jpg' size='3.5' />";};
				if (_bRepWorse) then {
					_sRankMessage = "<t color='#ff0000'>" + localize "STR_TRGM2_mainInit_ReputationDropped" + "</t><br /><br />" + _sRankIcon + "<br /><br />" + localize "STR_TRGM2_mainInit_ReputationText";
				}
				else {
					_sRankMessage = "<t color='#00ff00'>" + localize "STR_TRGM2_mainInit_ReputationIncreased" + "</t><br /><br />" + _sRankIcon + "<br /><br />" + localize "STR_TRGM2_mainInit_ReputationText";
				};

				if ((TREND_ActiveTasks call FHQ_fnc_ttAreTasksCompleted)) then { //if rank changed and tasks completed, then if now rank 5, need to reset board to show "Start final mission", otherwise, make sure shows "start next mission"
					["MISSION_COMPLETE"] remoteExec ["TREND_fnc_SetMissionBoardOptions",0,true];
				};

				[parseText _sRankMessage] remoteExec ["Hint", 0, true];
			};
		};

		//show "Current Reputation is X, Goal is X"
		if (isServer) then {
			"transportChopper" setMarkerPos getPos chopper1;
		};
		sleep 1;
	};
};
[] spawn TREND_fnc_CheckBadPoints;
player addEventHandler ["Respawn", { [] spawn TREND_fnc_CheckBadPoints; }];
systemChat format["Mission Core: %1", "BadPointsSet"];
sleep _coreCountSleep;



if (isServer) then {
	{
		_x setVariable ["DontDelete",true];
	} forEach nearestObjects [getMarkerPos "mrkHQ", ["all"], 2000];
	{systemChat format["Mission Core: %1", "DontDeleteSet"];} remoteExec ["bis_fnc_call", 0];
	sleep _coreCountSleep;

	if (isMultiplayer && !(TREND_iMissionParamType == 5)) then {
		TREND_fnc_CheckAnyPlayersAlive = {
			sleep 3;
			_bEnded = false;
			while {!_bEnded} do {
				_bAnyAlive = false;
				{
	   				if (isPlayer _x) then {
	   					_iRespawnTicketsLeft = [_x,nil,true] call BIS_fnc_respawnTickets;
	   					if (alive _x || _iRespawnTicketsLeft > 0) then {
	   						_bAnyAlive = true;
	   					};
	   				}
	   				else {
	   					if (alive _x) then {
	   						_bAnyAlive = true;
	   					};
	   				};
				} forEach (if (isMultiplayer) then {playableUnits} else {switchableUnits});
				if (!_bAnyAlive) then {
					["end3", true, 5] remoteExec ["BIS_fnc_endMission"];
					_bEnded = true;
					sleep 5;
				};
				sleep 3;
			};
		};
		[] spawn TREND_fnc_CheckAnyPlayersAlive;
 	};

	 {systemChat format["Mission Core: %1", "NonAliveEndCheckRunning"];} remoteExec ["bis_fnc_call", 0];
	sleep _coreCountSleep;



	if (TREND_iAllowNVG == 0) then {
		{
			 _x addPrimaryWeaponItem "acc_flashlight";
			 _x enableGunLights "forceOn";
			 _x unassignItem TREND_sFriendlyNVClassName;
			 _x removeItem TREND_sFriendlyNVClassName;
    		_x unassignItem TREND_sEnemyNVClassName;
			_x removeItem TREND_sEnemyNVClassName;

		} forEach allUnits;
	};
	{systemChat format["Mission Core: %1", "NVGStateSet"];} remoteExec ["bis_fnc_call", 0];
	sleep _coreCountSleep;

	TREND_fnc_PlayBaseRadioEffect = {
		while {true} do {
			playSound3D ["A3\Sounds_F\sfx\radio\" + selectRandom TREND_FriendlyRadioSounds + ".wss",baseRadio,false,getPosASL baseRadio,0.5,1,0];
			sleep selectRandom [20,30,40];
		};
	};
	[] spawn TREND_fnc_PlayBaseRadioEffect;

	TREND_fnc_SandStormEffect = {
		_iSandStormOption = TREND_AdvancedSettings select TREND_ADVSET_SANDSTORM_IDX;

		if (_iSandStormOption == 0 && selectRandom[true,false,false,false,false]) then { //Random
			StartWhen = selectRandom [990,1290,1710];
			sleep StartWhen;
			//work out how to deal with JIP if sandstorm already playing
			//Maybe store timer, and how long left... so if player JIP, it will fire off storm script if currently runnig and adjust the time to play to what is left
			SandStormTimer = selectRandom [150,390,630];
			publicVariable SandStormTimer;
			{nul = [SandStormTimer,false] execvm "RandFramework\RikoSandStorm\ROSSandstorm.sqf";} remoteExec ["bis_fnc_call", 0];
			//Set enemy skill
			{
				if (Side _x == East) then {
					_x setskill ["aimingAccuracy",0.01];
					_x setskill ["aimingShake",0.01];
					_x setskill ["aimingSpeed",0.01];
					_x setskill ["spotDistance",0.01];
					_x setskill ["spotTime",0.01];
				};
			} forEach allUnits;
			sleep SandStormTimer;
			//reset enemy skill
			{
				if (Side _x == East) then {
					_x setskill ["aimingAccuracy",0.15];
					_x setskill ["aimingShake",0.1];
					_x setskill ["aimingSpeed",0.2];
					_x setskill ["spotDistance",0.5];
					_x setskill ["spotTime",0.5];
				};
			} forEach allUnits;
		};
		if (_iSandStormOption == 1) then { //Always
			StartWhen = selectRandom [990,1290,1710];
			sleep StartWhen;
			//work out how to deal with JIP if sandstorm already playing
			//Maybe store timer, and how long left... so if player JIP, it will fire off storm script if currently runnig and adjust the time to play to what is left
			SandStormTimer = selectRandom [150,390,630];
			publicVariable "SandStormTimer";
			{nul = [SandStormTimer,false] execvm "RandFramework\RikoSandStorm\ROSSandstorm.sqf";} remoteExec ["bis_fnc_call", 0];
			//Set enemy skill
			{
				if (Side _x == East) then {
					_x setskill ["aimingAccuracy",0.01];
					_x setskill ["aimingShake",0.01];
					_x setskill ["aimingSpeed",0.01];
					_x setskill ["spotDistance",0.01];
					_x setskill ["spotTime",0.01];
				};
			} forEach allUnits;
			sleep SandStormTimer;
			//reset enemy skill
			{
				if (Side _x == East) then {
					_x setskill ["aimingAccuracy",0.15];
					_x setskill ["aimingShake",0.1];
					_x setskill ["aimingSpeed",0.2];
					_x setskill ["spotDistance",0.5];
					_x setskill ["spotTime",0.5];
				};
			} forEach allUnits;
		};
		if (_iSandStormOption == 3) then { //5 hours non stop
			//ok, if something is true, then in here we will start the sand storm and all clients!
			//work out how to deal with JIP if sandstorm already playing
			//Maybe store timer, and how long left... so if player JIP, it will fire off storm script if currently runnig and adjust the time to play to what is left
			{nul = [18030,false] execvm "RandFramework\RikoSandStorm\ROSSandstorm.sqf";} remoteExec ["bis_fnc_call", 0];
			//Set enemy skill
			{
				if (Side _x == East) then {
					_x setskill ["aimingAccuracy",0.01];
					_x setskill ["aimingShake",0.01];
					_x setskill ["aimingSpeed",0.01];
					_x setskill ["spotDistance",0.01];
					_x setskill ["spotTime",0.01];
				};
			} forEach allUnits;
			sleep 18030;
			//reset enemy skill
			{
				if (Side _x == East) then {
					_x setskill ["aimingAccuracy",0.15];
					_x setskill ["aimingShake",0.1];
					_x setskill ["aimingSpeed",0.2];
					_x setskill ["spotDistance",0.5];
					_x setskill ["spotTime",0.5];
				};
			} forEach allUnits;
			//reset enemy skill
		};

	};
	[] spawn TREND_fnc_SandStormEffect;

};

systemChat format["Mission Core: %1", "SandStormStateSet"];
sleep _coreCountSleep;

[] remoteExec ["TREND_fnc_animateAnimals",0,true];

systemChat format["Mission Core: %1", "AnimalStateSet"];
sleep _coreCountSleep;

 if (!isDedicated && (player != player)) then {
	waitUntil {player == player};
	waitUntil {time > 10};
	[] remoteExec ["TREND_fnc_animateAnimals",0,true];
	//hint "PING";
 };



systemChat format["Mission Core: %1", "CoreFinished"];
sleep _coreCountSleep;


TREND_CoreCompleted = true; publicVariable "TREND_CoreCompleted";

if (TREND_iMissionParamType != 5) then {
	[] call TREND_fnc_PostStartMission;
};


systemChat format["Mission Core: %1", "RunFlashLightState"];
sleep _coreCountSleep;

 _iEnemyFlashLightOption = TREND_AdvancedSettings select TREND_ADVSET_SELECT_ENEMY_FLASHLIGHTS_IDX;
if (_iEnemyFlashLightOption == 0) then {_iEnemyFlashLightOption = selectRandom [1,2]}; //1=yes, 2=no
if (_iEnemyFlashLightOption == 1) then {
	{
		if ((side _x) == East) then
		{
			if (isNil { _x getVariable "ambushUnit" }) then {
				_x addPrimaryWeaponItem "acc_flashlight";
				_x enableGunLights "forceOn";
				_x unassignItem TREND_sEnemyNVClassName;
				_x removeItem TREND_sEnemyNVClassName;
			};
		};
	} forEach allUnits;
};

systemChat format["Mission Core: %1", "Main Init Complete"];

true;