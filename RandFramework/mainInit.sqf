#include "..\CustomMission\TRGMSetDefaultMissionSetupVars.sqf";


civilian setFriend [east, 1];

//global defaults: each is only set if not already defined (every machine sets its own default, only the server broadcasts it)
{
	_x params ["_varName", "_defaultValue"];
	if (isNil _varName) then {
		missionNamespace setVariable [_varName, _defaultValue];
		if (isServer) then {publicVariable _varName;};
	};
} forEach [
	["CustomObjectsSet", false],
	["EnemyFactionData", ""],
	["LoadoutData", ""],
	["LoadoutDataDefault", ""],
	["bBreifingPrepped", false],
	["BadPoints", 0],
	["PlayersHaveLeftStartingArea", false],
	["KilledPlayers", []],
	["KilledPositions", []],
	["bBaseHasChopper", false],
	["BadPointsReason", ""],
	["InfTaskStarted", false],
	["InfTaskCount", 0],
	["ActiveTasks", []],
	["MaxBadPoints", 11],
	["ObjectivePossitions", []],
	["HiddenPossitions", []],
	["SpottedActiveFinished", true],
	["bCommsBlocked", false],
	["ParaDropped", false],
	["ATFieldPos", []],
	["AODetails", []], //AODetails = [[AOIndex,InfSpottedCount,VehSpottedCount,AirSpottedCount,bScoutCalled,patrolMoveCounter]], example [[1,0,0,0,False,0],[2,0,0,0,True,0]]
	["CheckPointAreas", []],
	["SentryAreas", []],
	["bMortarFiring", false],
	["bAndSoItBegins", false],
	["iMissionParamType", 9],
	["iMissionParamObjective", 0],
	["iMissionParamObjective2", 0],
	["iMissionParamObjective3", 0],
	["iAllowNVG", 2],
	["iMissionParamRepOption", 0],
	["iWeather", 1],
	["iUseRevive", 0],
	["iCampaignDay", 0],
	["CurrentZeroMissionTitle", ""],
	["debugMessages", ""],
	["SaveType", 0],
	["IntelFound", []],
	["iStartLocation", 2],
	["ClearedPositions", []],
	["AllowUAVLocateHelp", false],
	["EnemyID", 1],
	["FinalMissionStarted", false],
	["ForceEndSandStorm", false],
	["AOCampOnlyAmmoBox", false],
	["MainMissionTitle", ""],
	["ForceMissionSetup", false],
	["IsSnowMap", false],
	["MissionParamsSet", false],
	["IsFullMap", false],
	["bOptionsSet", false],
	["MissionLoaded", false]
];

if (isNil "AdvancedSettings") then {
	AdvancedSettings = DefaultAdvancedSettings;
	publicVariable "AdvancedSettings";
};
if (isNil "CommsTowerPos") then {
	bHasCommsTower = false;
	CommsTowerPos = [0,0];
	publicVariable "bHasCommsTower";
	publicVariable "CommsTowerPos";
};

if (isNil "ISUNSUNG") then {
		ISUNSUNG = false;
};

if (isServer) then {
	SniperCount = 0;
	SniperAttemptCount = 0;
	SpotterCount = 0;
	SpotterAttemptCount = 0;
	friendlySentryCheckpointPos = [];
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


if (isServer) then { //adjust weather here so intro animation is different everytime
		[true] execVM "RandFramework\SetTimeAndWeather.sqf";
};

 waitUntil {time > 0};

showCinemaBorder  true;

_centerPos = getArray (configfile >> "CfgWorlds" >> worldName >> "centerPosition");
if !(isNil "CustomCenterPos") then {
	_centerPos = CustomCenterPos;
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


_trgRatingAdjust = createTrigger ["EmptyDetector", [0,0], false];
_trgRatingAdjust setTriggerArea [0, 0, 0, false];
_trgRatingAdjust setTriggerStatements ["((rating player) < 0)", "player addRating -(rating player)", ""];


if (!isDedicated) then {
	waitUntil {!isNull player};

	TransferProviders = {
		//(the transport call action is re-added on respawn by TRGM_fnc_addPlayerActionPersistent)
		_oldUnit = _this select 0;
		_oldProviders = _oldUnit getVariable ["BIS_SUPP_allProviderModules",[]];
		_HQ = _oldUnit getVariable ["BIS_SUPP_HQ",nil];

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
			waitUntil {sleep 0.5; _unit != player };
			group player selectLeader player;
			[_unit] call TransferProviders;
			_unit = player;
		};
	};

};

if (!isMultiplayer) then {
	for "_i" from 1 to 10 do {
		deleteVehicle (missionNamespace getVariable [format["vs%1",_i], objNull]);
	};
};

//whoever chose the options (admin, host, or the SL fallback in TRGMInitPlayerLocal) does the AO selection and starts the mission
if (!isDedicated) then {
	waitUntil {sleep 0.5; bOptionsSet};
};
if (!isDedicated && !isNil "TRGM_iSetOptions") then {
	if (iMissionParamType != 5) then {	//if isCampaign, dont allow to select AO
		if (AdvancedSettings select ADVSET_SELECT_AO_IDX == 1) then {
			titleText [localize "STR_TRGM2_mainInit_Loading", "BLACK FADED"];
			_camera cameraEffect ["Terminate","back"];
			//AO 1 always, AO 2 and 3 only for mission types with three AOs
			_iAoCount = [1, 3] select (iMissionParamType == 0 || iMissionParamType == 4);
			for "_i" from 1 to _iAoCount do {
				_sLocVar = format["Mission%1Loc",_i];
				[_sLocVar, localize format["STR_TRGM2_tele_SelectPositionAO%1",_i]] call TRGM_fnc_selectMapPosition;
				[format["mrkAoSelect%1",_i], missionNamespace getVariable _sLocVar, "ICON", "ColorRed", [1,1], format["AO %1",_i]] call AIS_Core_fnc_createLocalMarker;
			};
			{
				if (getMarkerColor _x != "") then {deleteMarker _x;};
			} forEach ["mrkAoSelect1","mrkAoSelect2","mrkAoSelect3"];
		};

		if (AdvancedSettings select ADVSET_SELECT_AO_CAMP_IDX == 1 && iStartLocation == 1) then {
			titleText [localize "STR_TRGM2_mainInit_Loading", "BLACK FADED"];
			_camera cameraEffect ["Terminate","back"];
			["AOCampLocation", localize "STR_TRGM2_tele_SelectPosition_AO_Camp"] call TRGM_fnc_selectMapPosition;
		};
		

	};
	bAndSoItBegins = true;
	publicVariable "bAndSoItBegins";

};


waitUntil {sleep 0.5; bAndSoItBegins};

Private _coreCountSleep = 0.1;

systemChat format["Mission Core: %1", "Init"];
sleep _coreCountSleep;


if (isServer) then {
	_iEnableGroupManagement = AdvancedSettings select ADVSET_GROUP_MANAGE_IDX;
	if (_iEnableGroupManagement == 1) then {
		["Initialize"] call BIS_fnc_dynamicGroups;//Exec on Server
	};
	
};

systemChat format["Mission Core: %1", "GroupManagementSet"];
sleep _coreCountSleep;

if (!isDedicated) then {
	titleText [localize "STR_TRGM2_mainInit_Loading", "BLACK FADED"];
	_camera cameraEffect ["Terminate","back"];
};

systemChat format["Mission Core: %1", "CameraTerminated"];
sleep _coreCountSleep;


call compile preprocessFileLineNumbers "RandFramework\General\TRGMSetDefaultUnitGlobalVars.sqf";

systemChat format["Mission Core: %1", "GlobalVarsSet"];
sleep _coreCountSleep;

if (isServer) then {	
	call compile preprocessFileLineNumbers "RandFramework\General\TRGMSetEnemyUnitGlobalVars.sqf";
	if (bDebugMode) then {[format["Mission Core: %1", "EnemyGlobalVarsSet"]] remoteExec ["systemChat", 0];};
	sleep _coreCountSleep;

	call compile preprocessFileLineNumbers "RandFramework\General\TRGMSetFriendlyLoutoutsGlobalVars.sqf";
	if (bDebugMode) then {[format["Mission Core: %1", "FriendlyGlobalVarsSet"]] remoteExec ["systemChat", 0];};
	sleep _coreCountSleep;

	#include "..\CustomMission\TRGMSetEnemyFaction.sqf"; //if _useCustomEnemyFaction set to true within this sqf, will overright the above enemy faction data
	if (bDebugMode) then {[format["Mission Core: %1", "EnemyFactionSet"]] remoteExec ["systemChat", 0];};
	sleep _coreCountSleep;
	
	#include "..\CustomMission\TRGMSetFriendlyLoadouts.sqf"; //as above, but for _useCustomFriendlyLoadouts
	if (bDebugMode) then {[format["Mission Core: %1", "FriendlyLoadoutSet"]] remoteExec ["systemChat", 0];};
	sleep _coreCountSleep;

	/*Fix any changed types	 */
	if (typeName sCivilian != "ARRAY") then {sCivilian = [sCivilian]};
	/*end */


	//enemy classes that clients need for intel (showIntel), the rest of the faction data is only used on the server
	{publicVariable _x;} forEach ["sMortar","sMortarMilitia","sAAAVeh","sAAAVehMilitia","DestroyAAAVeh"];

	CustomObjectsSet = true;
	publicVariable "CustomObjectsSet";
	call compile preprocessFileLineNumbers "RandFramework\setFriendlyObjects.sqf";
	if (bDebugMode) then {[format["Mission Core: %1", "FriendlyObjectsSet"]] remoteExec ["systemChat", 0];};
	sleep _coreCountSleep;


	if (EnemyFactionData != "") then {
		_errorMessage = "";
		_ObjectPairs = EnemyFactionData splitString ";";
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
	if (bDebugMode) then {[format["Mission Core: %1", "EnemyFactionDataProcessed"]] remoteExec ["systemChat", 0];};
	sleep _coreCountSleep;

        _isAceRespawnWithGear = false;
 	if ([] call TRGM_fnc_isCbaLoaded) then {
	   // check for ACE respawn with gear setting
  	   _isAceRespawnWithGear = "ace_respawn_savePreDeathGear" call CBA_settings_fnc_get;
	};
	
	if (bDebugMode) then {[format["Mission Core: %1", "savePreDeathGear"]] remoteExec ["systemChat", 0];};
	sleep _coreCountSleep;
	if (LoadoutData != "" || LoadoutDataDefault != "") then {
		{
			_handle = [_x] spawn TRGM_fnc_setLoadout;
			waitUntil {scriptDone _handle};
			if (!isNil("_isAceRespawnWithGear")) then {
				if (!_isAceRespawnWithGear) then {
			   		_x addEventHandler ["Respawn", { [_this select 0] spawn TRGM_fnc_setLoadout; }];
		        };
			};
		} forEach (if (isMultiplayer) then {playableUnits} else {switchableUnits});
		sleep 1;
	};
	if (bDebugMode) then {[format["Mission Core: %1", "setLoadout ran"]] remoteExec ["systemChat", 0];};
	sleep _coreCountSleep;

	if ([] call TRGM_fnc_isAceLoaded) then {
		[box1,InitialBoxItemsWithAce] call bis_fnc_initAmmoBox;
	}
	else {
		[box1,InitialBoxItems] call bis_fnc_initAmmoBox;
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

	if (bDebugMode) then {[format["Mission Core: %1", "boxCargo set"]] remoteExec ["systemChat", 0];};
	sleep _coreCountSleep;


};

systemChat format["Mission Core: %1", "PreCustomObjectSet"];
sleep _coreCountSleep;

waitUntil {sleep 0.5; CustomObjectsSet};

systemChat format["Mission Core: %1", "PostCustomObjectSet"];
sleep _coreCountSleep;

[[chopper1]] call TRGM_fnc_addTransportActions;

systemChat format["Mission Core: %1", "TransportScriptRun"];
sleep _coreCountSleep;

if (iUseRevive > 0) then {
	[] call AIS_Core_fnc_preInit;
	[] call AIS_Core_fnc_postInit;
	[] call AIS_System_fnc_postInit;
};

systemChat format["Mission Core: %1", "AIS Script Run"];
sleep _coreCountSleep;


if (!isMultiplayer) then {
	{
		if (_x getVariable ["MP_ONLY",false]) then {
			deleteVehicle _x;
		};
	} forEach allUnits;
};

systemChat format["Mission Core: %1", "DeleteMpOnlyVehicles"];
sleep _coreCountSleep;


player doFollow player;


systemChat format["Mission Core: %1", "DoFollowRun"];
sleep _coreCountSleep;

if (iMissionParamType == 5) then {
	if (isServer) then {
		call compile preprocessFileLineNumbers  "RandFramework\Campaign\initCampaign.sqf";
	};
}
else {


	call compile preprocessFileLineNumbers  "RandFramework\Campaign\StartMission.sqf";

};
systemChat format["Mission Core: %1", "InitCampaign/StartMission ran"];
sleep _coreCountSleep;

waitUntil {sleep 0.5; MissionLoaded};

systemChat format["Mission Core: %1", "MissionLoaded true"];
sleep _coreCountSleep;

TREND_fnc_CheckBadPoints = {
	if (isNil "BadPoints") then {
			BadPoints = 0;
			publicVariable "BadPoints";
	};
	_lastRepPoints = [MaxBadPoints - BadPoints,1] call BIS_fnc_cutDecimals;
	_lastBadPoints = BadPoints;
	_LastRank = [_lastRepPoints] call TRGM_fnc_getRankFromRep;
	while {true} do {
		_dCurrentRep = [MaxBadPoints - BadPoints,1] call BIS_fnc_cutDecimals;
		_CurrentRank = [_dCurrentRep] call TRGM_fnc_getRankFromRep;
		if (_dCurrentRep != _lastRepPoints) then {
			if (SaveType != 0) then {
				[SaveType,false] execVM "RandFramework\Campaign\ServerSave.sqf";
				_lastRepPoints = _dCurrentRep;
			};
		};

		if (_lastBadPoints != BadPoints) then {

			_bRepWorse = false;
			if (BadPoints > _lastBadPoints) then {_bRepWorse = true};
			_lastBadPoints = BadPoints;
			if (iMissionParamType != 5) then {
				if (_dCurrentRep <= 0 && iMissionParamRepOption == 1) then {
					["tskKeepAboveAverage", "failed"] call FHQ_TT_setTaskState;
					{
						if (!([_x] call FHQ_TT_areTasksCompleted)) then {
							[_x, "failed"] call FHQ_TT_setTaskState;
						};
					} forEach ActiveTasks;
					sleep 2;

					[FriendlySide, ["DeBrief", localize "STR_TRGM2_mainInit_Debrief", "Debrief", ""]] call FHQ_TT_addTasks;
				};	
				if (_dCurrentRep <= 0 && iMissionParamRepOption == 0) then { //note... when gaining rep, we increase the MaxBadPoints, and when lower, we incrase BadPoints (rep is calulated by the difference)
					["tskKeepAboveAverage", "failed"] call FHQ_TT_setTaskState;
				};				
				if (_dCurrentRep > 0 && iMissionParamRepOption == 0) then {
					["tskKeepAboveAverage", "succeeded"] call FHQ_TT_setTaskState;					
				};				
			};
		};
		if (_LastRank != _CurrentRank) then {
			_bRepWorse = true;
			if (_CurrentRank > _LastRank) then {_bRepWorse = false};
			_LastRank = _CurrentRank;
			if (iMissionParamType == 5) then {
				_sRankMessage = "";
				//!!!!!! rank cound go from 2.2 to 3.2 and would not show icon... so need to check if =< 3 and if rank has actually changed!
				_sRankIcon = [_dCurrentRep] call TRGM_fnc_getRankIcon;
				if (_bRepWorse) then {
					_sRankMessage = "<t color='#ff0000'>" + localize "STR_TRGM2_mainInit_ReputationDropped" + "</t><br /><br />" + _sRankIcon + "<br /><br />" + localize "STR_TRGM2_mainInit_ReputationText";
				}
				else {
					_sRankMessage = "<t color='#00ff00'>" + localize "STR_TRGM2_mainInit_ReputationIncreased" + "</t><br /><br />" + _sRankIcon + "<br /><br />" + localize "STR_TRGM2_mainInit_ReputationText";
				};

				if ((ActiveTasks call FHQ_TT_areTasksCompleted)) then { //if rank changed and tasks completed, then if now rank 5, need to reset board to show "Start final mission", otherwise, make sure shows "start next mission"
					[["MISSION_COMPLETE"],"RandFramework\Campaign\SetMissionBoardOptions.sqf"] remoteExec ["BIS_fnc_execVM",0,"TRGM_missionBoardOptions"];
				};
				[parseText _sRankMessage] remoteExec ["Hint", 0];
			};
		};

		"transportChopper" setMarkerPos getPos chopper1;
		sleep 1;
	};
};
//server only, the task states, saves and hints in here are all global
if (isServer) then {
	[] spawn TREND_fnc_CheckBadPoints;
};
systemChat format["Mission Core: %1", "BadPointsSet"];
sleep _coreCountSleep;


if (isServer) then {
	{
		_x setVariable ["DontDelete",true];
	} forEach nearestObjects [getMarkerPos "mrkHQ", ["all"], 2000];
	if (bDebugMode) then {[format["Mission Core: %1", "DontDeleteSet"]] remoteExec ["systemChat", 0];};
	sleep _coreCountSleep;

	if (isMultiplayer && !(iMissionParamType == 5)) then {
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

	 if (bDebugMode) then {[format["Mission Core: %1", "NonAliveEndCheckRunning"]] remoteExec ["systemChat", 0];};
	sleep _coreCountSleep;


if (iAllowNVG == 0) then {
		{
			 _x addPrimaryWeaponItem "acc_flashlight";
			 _x enableGunLights "forceOn";
			 _x unassignItem sFriendlyNVClassName;
			 _x removeItem sFriendlyNVClassName;
    		_x unassignItem sEnemyNVClassName;
			_x removeItem sEnemyNVClassName;

		} forEach allUnits;
	};
	if (bDebugMode) then {[format["Mission Core: %1", "NVGStateSet"]] remoteExec ["systemChat", 0];};
	sleep _coreCountSleep;

	TREND_fnc_PlayBaseRadioEffect = {
		while {true} do {
			playSound3D ["A3\Sounds_F\sfx\radio\" + selectRandom FriendlyRadioSounds + ".wss",baseRadio,false,getPosASL baseRadio,0.5,1,0];
			sleep selectRandom [20,30,40];
		};
	};
	[] spawn TREND_fnc_PlayBaseRadioEffect;

	TREND_fnc_SandStormEffect = {
		_iSandStormOption = AdvancedSettings select ADVSET_SANDSTORM_IDX;

		if ((_iSandStormOption == 0 && selectRandom[true,false,false,false,false]) || _iSandStormOption == 1) then { //0 = Random, 1 = Always
			StartWhen = selectRandom [990,1290,1710];
			sleep StartWhen;
			//work out how to deal with JIP if sandstorm already playing
			//Maybe store timer, and how long left... so if player JIP, it will fire off storm script if currently runnig and adjust the time to play to what is left
			SandStormTimer = selectRandom [150,390,630];
			publicVariable "SandStormTimer";
			[[SandStormTimer,false],"RandFramework\RikoSandStorm\ROSsandstorm.sqf"] remoteExec ["BIS_fnc_execVM", 0];
			[true] call TRGM_fnc_setEnemySandstormSkill;
			sleep SandStormTimer;
			[false] call TRGM_fnc_setEnemySandstormSkill;
		};
		if (_iSandStormOption == 3) then { //5 hours non stop (each client starts the storm effect itself in TRGMInitPlayerLocal, which also covers JIP)
			[true] call TRGM_fnc_setEnemySandstormSkill;
			sleep 18030;
			[false] call TRGM_fnc_setEnemySandstormSkill;
		};

	};
	[] spawn TREND_fnc_SandStormEffect;

};

systemChat format["Mission Core: %1", "SandStormStateSet"];
sleep _coreCountSleep;

systemChat format["Mission Core: %1", "AnimalStateSet"];
sleep _coreCountSleep;



systemChat format["Mission Core: %1", "CoreFinished"];
sleep _coreCountSleep;


CoreCompleted = true;
publicVariable "CoreCompleted";

if (iMissionParamType != 5) then {
	["initial"] call compile preprocessFileLineNumbers  "RandFramework\Campaign\PostStartMission.sqf";
};


 systemChat format["Mission Core: %1", "RunFlashLightState"];
sleep _coreCountSleep;

 _iEnemyFlashLightOption = AdvancedSettings select ADVSET_SELECT_ENEMY_FLASHLIGHTS_IDX;
if (_iEnemyFlashLightOption == 0) then {_iEnemyFlashLightOption = selectRandom [1,2]}; //1=yes, 2=no
if (_iEnemyFlashLightOption == 1) then {
	{
		if ((side _x) == East) then
		{
			if (isNil { _x getVariable "ambushUnit" }) then {
				_x addPrimaryWeaponItem "acc_flashlight"; 
				_x enableGunLights "forceOn";
				_x unassignItem sEnemyNVClassName; 
				_x removeItem sEnemyNVClassName;
			}; 
		};
	} forEach allUnits;
};
