#include "..\CustomMission\TRGMSetDefaultMissionSetupVars.sqf";
#include "..\setUnitGlobalVars.sqf";

//call compile preprocessFileLineNumbers "RandFramework\General\TRGMSetDefaultUnitGlobalVars.sqf";

civilian setFriend [east, 1];

if (isNil("CustomObjectsSet")) then {
	CustomObjectsSet = false;
	publicVariable "CustomObjectsSet";
};

if (isNil("EnemyFactionData")) then {
	EnemyFactionData = "";
	publicVariable "EnemyFactionData";
};
if (isNil("LoadoutData")) then {
	LoadoutData = "";
	publicVariable "LoadoutData";
};
if (isNil("LoadoutDataDefault")) then {
	LoadoutDataDefault = "";
	publicVariable "LoadoutDataDefault";
};

if (isNil "bBreifingPrepped") then {
			bBreifingPrepped = false;
			publicVariable "bBreifingPrepped";
};
if (isNil "BadPoints") then {
			BadPoints = 0;
			publicVariable "BadPoints";
};

if (isNil "PlayersHaveLeftStartingArea") then {
			PlayersHaveLeftStartingArea = false;
			publicVariable "PlayersHaveLeftStartingArea";
};

if (isNil "KilledPlayers") then {
	KilledPlayers = [];
	publicVariable "KilledPlayers";
};
if (isNil "KilledPositions") then {
	KilledPositions = [];
	publicVariable "KilledPositions";
};


if (isNil "bBaseHasChopper") then {
	bBaseHasChopper = false;
	publicVariable "bBaseHasChopper";
};

if (isNil "BadPointsReason") then {
		BadPointsReason = "";
		publicVariable "BadPointsReason";
};

if (isNil "InfTaskStarted") then {
		InfTaskStarted = false;
		publicVariable "InfTaskStarted";
};
if (isNil "InfTaskCount") then {
		InfTaskCount = 0;
		publicVariable "InfTaskCount";
};

if (isNil "ActiveTasks") then {
	ActiveTasks = [];
	publicVariable "ActiveTasks";
};

if (isNil "MaxBadPoints") then {
	MaxBadPoints = 11;
	publicVariable "MaxBadPoints";
};


if (isNil "ObjectivePossitions") then {
	ObjectivePossitions = [];
	publicVariable "ObjectivePossitions";
};

if (isNil "HiddenPossitions") then {
	HiddenPossitions = [];
	publicVariable "HiddenPossitions";
};

if (isNil "SpottedActiveFinished") then {
	SpottedActiveFinished = true;
	publicVariable "SpottedActiveFinished";
};
if (isNil "bCommsBlocked") then {
	bCommsBlocked = false;
	publicVariable "bCommsBlocked";
};
if (isNil "bBaseHasChopper") then {
	bBaseHasChopper = false;
	publicVariable "bBaseHasChopper";
};
if (isNil "ParaDropped") then {
	ParaDropped = false;
	publicVariable "ParaDropped";
};
if (isNil "ATFieldPos") then {
	ATFieldPos = [];
	publicVariable "ATFieldPos";
};
if (isNil "CommsTowerPos") then {
	bHasCommsTower = false;
	CommsTowerPos = [0,0];
	publicVariable "bHasCommsTower";
	publicVariable "CommsTowerPos";
};
if (isNil "AODetails") then {
	//AODetails = [[AOIndex,InfSpottedCount,VehSpottedCount,AirSpottedCount,bScoutCalled,patrolMoveCounter]]
	//example AODetails [[1,0,0,0,False,0],[2,0,0,0,True,0]]
	AODetails = [];
	publicVariable "AODetails";
};

if (isNil "CheckPointAreas") then {
		CheckPointAreas = [];
		publicVariable "CheckPointAreas";
};
if (isNil "SentryAreas") then {
		SentryAreas = [];
		publicVariable "SentryAreas";
};
if (isNil "bMortarFiring") then {
	bMortarFiring = false;
	publicVariable "bMortarFiring";
};

if (isNil "bAndSoItBegins") then {
	bAndSoItBegins = false;
	publicVariable "bAndSoItBegins";
};

if (isNil "iMissionParamType") then {
	iMissionParamType = 9;
	publicVariable "iMissionParamType";
};
if (isNil "iMissionParamObjective") then {
	iMissionParamObjective = 0;
	publicVariable "iMissionParamObjective";
};
if (isNil "iMissionParamObjective2") then {
	iMissionParamObjective2 = 0;
	publicVariable "iMissionParamObjective2";
};
if (isNil "iMissionParamObjective3") then {
	iMissionParamObjective3 = 0;
	publicVariable "iMissionParamObjective3";
};

if (isNil "iAllowNVG") then {
	iAllowNVG = 2;
	publicVariable "iAllowNVG";
};

if (isNil "iMissionParamRepOption") then {
	iMissionParamRepOption = 0;
	publicVariable "iMissionParamRepOption";
};
if (isNil "iWeather") then {
	iWeather = 1;
	publicVariable "iWeather";
};
if (isNil "iUseRevive") then {
	iUseRevive = 0;
	publicVariable "iUseRevive";
};
if (isNil "iCampaignDay") then {
	iCampaignDay = 0;
	publicVariable "iCampaignDay";
};
if (isNil "CurrentZeroMissionTitle") then {
	CurrentZeroMissionTitle = "";
	publicVariable "CurrentZeroMissionTitle";
};

if (isNil "debugMessages") then {
	debugMessages = "";
	publicVariable "debugMessages";
};

if (isNil "SaveType") then {
			SaveType = 0;
			publicVariable "SaveType";
};
if (isNil "IntelFound") then {
			IntelFound = [];
			publicVariable "IntelFound";
};
if (isNil "iStartLocation") then {
			iStartLocation = 2;
			publicVariable "iStartLocation";
};
if (isNil "AdvancedSettings") then {
			AdvancedSettings = DefaultAdvancedSettings;
			publicVariable "AdvancedSettings";

};
if (isNil "ClearedPositions") then {
			ClearedPositions = [];
			publicVariable "ClearedPositions";
};
if (isNil "AllowUAVLocateHelp") then {
			AllowUAVLocateHelp = false;
			publicVariable "AllowUAVLocateHelp";
};
if (isNil "EnemyID") then {
			EnemyID = 1;
			publicVariable "EnemyID";
};
if (isNil "FinalMissionStarted") then {
	FinalMissionStarted = false;
	publicVariable "FinalMissionStarted";	
};

if (isNil "ISUNSUNG") then {
		ISUNSUNG = false;
};
if (isNil("ForceEndSandStorm")) then {
	ForceEndSandStorm = false;
	publicVariable "ForceEndSandStorm";
};


if (isNil("AOCampOnlyAmmoBox")) then {
	AOCampOnlyAmmoBox = false;
	publicVariable "AOCampOnlyAmmoBox";
};
if (isNil("MainMissionTitle")) then {
	MainMissionTitle = "";
	publicVariable "MainMissionTitle";
};
if (isNil("ForceMissionSetup")) then {
	ForceMissionSetup = false;
	publicVariable "ForceMissionSetup";
};
if (isNil "IsSnowMap") then {
		IsSnowMap = false;
		publicVariable "IsSnowMap";
};
if (isNil "MissionParamsSet") then {
	MissionParamsSet = false;
	publicVariable "MissionParamsSet";
};
if (isNil "IsFullMap") then {
	IsFullMap = false;
	publicVariable "IsFullMap";
};
if (isNil "bOptionsSet") then {
	bOptionsSet = false;
	publicVariable "bOptionsSet";
};
if (isNil "MissionLoaded") then {
	MissionLoaded = false;
	publicVariable "MissionLoaded";
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


//hintSilent parseText "<t size='1.25' font='Zeppelin33' color='#ff0000'>test lives remaining.</t><a href='http://arma3.com'>A3</a>";




if (isServer) then { //adjust weather here so intro animation is different everytime
		[true] execVM "RandFramework\SetTimeAndWeather.sqf";
};


showcinemaborder true;

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



_trgRatingAdjust = createTrigger ["EmptyDetector", [0,0]];
_trgRatingAdjust setTriggerArea [0, 0, 0, false];
_trgRatingAdjust setTriggerStatements ["((rating player) < 0)", "player addRating -(rating player)", ""];


if (!isDedicated) then {
	waitUntil {!isNull player};

	TransferProviders = {
		if !([] call TRGM_fnc_isCbaLoaded) then {
			[[chopper1]] call TRGM_fnc_addTransportActions;
		};
		//player addAction [localize "STR_TRGM2_TRGMInitPlayerLocal_CallHeliTransport","[chopper1,true] spawn TRGM_fnc_selectLZ",0,0];	

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
			waitUntil {_unit != player };
			group player selectLeader player;
			//hintSilent " Player has changed";
			[_unit] call TransferProviders;
			_unit = player;
		};
	};

};

if (!isMultiplayer) then {
	deleteVehicle vs1;
	deleteVehicle vs2;
	deleteVehicle vs3;
	deleteVehicle vs4;
	deleteVehicle vs5;
	deleteVehicle vs6;
	deleteVehicle vs7;
	deleteVehicle vs8;
	deleteVehicle vs9;
	deleteVehicle vs10;
};

_isAdmin = (!isMultiplayer || isMultiplayer && !isDedicated && isServer || isMultiplayer && !isServer && (call BIS_fnc_admin) != 0);
if (!isDedicated && _isAdmin) then {
	waitUntil {bOptionsSet};
	if (iMissionParamType != 5) then {	//if isCampaign, dont allow to select AO
		if (AdvancedSettings select ADVSET_SELECT_AO_IDX == 1) then {
			mrkAoSelect1 = nil;
			mrkAoSelect2 = nil;
			mrkAoSelect3 = nil;
			titleText [localize "STR_TRGM2_mainInit_Loading", "BLACK FADED"];
			_camera cameraEffect ["Terminate","back"];
			titleText[localize "STR_TRGM2_tele_SelectPositionAO1", "PLAIN"];
			openMap true;
			onMapSingleClick "Mission1Loc = _pos; publicVariable 'Mission1Loc'; openMap false; onMapSingleClick '';true;";
			sleep 1;
			waitUntil {!visibleMap};
			//if (!isNil("mrkAoSelect1")) then {
				["mrkAoSelect1",  Mission1Loc, "ICON", "ColorRed", [1,1], "AO 1"] call AIS_Core_fnc_createLocalMarker;
			//};
			if (iMissionParamType == 0 || iMissionParamType == 4) then {
				titleText[localize "STR_TRGM2_tele_SelectPositionAO2", "PLAIN"];
				openMap true;
				onMapSingleClick "Mission2Loc = _pos; publicVariable 'Mission2Loc'; openMap false; onMapSingleClick '';true;";
				sleep 1;
				waitUntil {!visibleMap};
				//if (!isNil("mrkAoSelect2")) then {
					["mrkAoSelect2",  Mission2Loc, "ICON", "ColorRed", [1,1], "AO 2"] call AIS_Core_fnc_createLocalMarker;
				//};		

				titleText[localize "STR_TRGM2_tele_SelectPositionAO3", "PLAIN"];
				openMap true;
				onMapSingleClick "Mission3Loc = _pos; publicVariable 'Mission3Loc'; openMap false; onMapSingleClick '';true;";
				sleep 1;
				waitUntil {!visibleMap};
				//if (!isNil("mrkAoSelect3")) then {
					["mrkAoSelect3",  Mission3Loc, "ICON", "ColorRed", [1,1], "AO 3"] call AIS_Core_fnc_createLocalMarker;
				//};
			};
			if (getMarkerColor "mrkAoSelect1" != "") then {deleteMarker "mrkAoSelect1";};
			if (getMarkerColor "mrkAoSelect2" != "") then {deleteMarker "mrkAoSelect2";};
			if (getMarkerColor "mrkAoSelect3" != "") then {deleteMarker "mrkAoSelect3";};
		};

		if (AdvancedSettings select ADVSET_SELECT_AO_CAMP_IDX == 1 && iStartLocation == 1) then {
			titleText [localize "STR_TRGM2_mainInit_Loading", "BLACK FADED"];
			_camera cameraEffect ["Terminate","back"];
			titleText[localize "STR_TRGM2_tele_SelectPosition_AO_Camp", "PLAIN"];
			openMap true;
			onMapSingleClick "AOCampLocation = _pos; publicVariable 'AOCampLocation'; openMap false; onMapSingleClick '';true;";
			sleep 1;
			waitUntil {!visibleMap};
		};
		

	};
	bAndSoItBegins = true;
	publicVariable "bAndSoItBegins";

};




waitUntil {bAndSoItBegins};

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




//#include "RandFramework\General\TRGMSetEnemyUnitGlobalVars.sqf";

call compile preprocessFileLineNumbers "RandFramework\General\TRGMSetDefaultUnitGlobalVars.sqf";

systemChat format["Mission Core: %1", "GlobalVarsSet"];
sleep _coreCountSleep;

if (isServer) then {	
	call compile preprocessFileLineNumbers "RandFramework\General\TRGMSetEnemyUnitGlobalVars.sqf";
	{systemChat format["Mission Core: %1", "EnemyGlobalVarsSet"];} remoteExec ["bis_fnc_call", 0];
	sleep _coreCountSleep;

	call compile preprocessFileLineNumbers "RandFramework\General\TRGMSetFriendlyLoutoutsGlobalVars.sqf";
	{systemChat format["Mission Core: %1", "FriendlyGlobalVarsSet"];} remoteExec ["bis_fnc_call", 0];
	sleep _coreCountSleep;

	#include "..\CustomMission\TRGMSetEnemyFaction.sqf"; //if _useCustomEnemyFaction set to true within this sqf, will overright the above enemy faction data
	{systemChat format["Mission Core: %1", "EnemyFactionSet"];} remoteExec ["bis_fnc_call", 0];
	sleep _coreCountSleep;
	
	#include "..\CustomMission\TRGMSetFriendlyLoadouts.sqf"; //as above, but for _useCustomFriendlyLoadouts
	{systemChat format["Mission Core: %1", "FriendlyLoadoutSet"];} remoteExec ["bis_fnc_call", 0];
	sleep _coreCountSleep;

	/*Fix any changed types	 */
	if (typeName sCivilian != "ARRAY") then {sCivilian = [sCivilian]};
	/*end */


	CustomObjectsSet = true;
	publicVariable "CustomObjectsSet";
	call compile preprocessFileLineNumbers "RandFramework\setFriendlyObjects.sqf";
	{systemChat format["Mission Core: %1", "FriendlyObjectsSet"];} remoteExec ["bis_fnc_call", 0];
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
	{systemChat format["Mission Core: %1", "EnemyFactionDataProcessed"];} remoteExec ["bis_fnc_call", 0];
	sleep _coreCountSleep;

        _isAceRespawnWithGear = false;
 	if ([] call TRGM_fnc_isCbaLoaded) then {
	   // check for ACE respawn with gear setting
  	   _isAceRespawnWithGear = "ace_respawn_savePreDeathGear" call CBA_settings_fnc_get;
	};
	
	{systemChat format["Mission Core: %1", "savePreDeathGear"];} remoteExec ["bis_fnc_call", 0];
	sleep _coreCountSleep;
	if (LoadoutData != "" || LoadoutDataDefault != "") then {
		{
			//_x setVariable ["UnitRole",_unitRole];
			_handle = [_x] execVM "RandFramework\setLoadout.sqf";
			waitUntil {scriptDone _handle};
			if (!isNil("_isAceRespawnWithGear")) then {
				if (!_isAceRespawnWithGear) then {
			   		_x addEventHandler ["Respawn", { [_this select 0] execVM "RandFramework\setLoadout.sqf"; }];
		        };
			};
		} forEach (if (isMultiplayer) then {playableUnits} else {switchableUnits});
		sleep 1;
	};
	{systemChat format["Mission Core: %1", "setLoadout ran"];} remoteExec ["bis_fnc_call", 0];
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

	{systemChat format["Mission Core: %1", "boxCargo set"];} remoteExec ["bis_fnc_call", 0];
	sleep _coreCountSleep;


};

systemChat format["Mission Core: %1", "PreCustomObjectSet"];
sleep _coreCountSleep;

waitUntil {CustomObjectsSet};

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


//this setVariable ["MP_ONLY", true, true];
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

waitUntil {MissionLoaded};

systemChat format["Mission Core: %1", "MissionLoaded true"];
sleep _coreCountSleep;

TREND_fnc_CheckBadPoints = {
	if (isNil "BadPoints") then {
			BadPoints = 0;
			publicVariable "BadPoints";
	};
	_lastRepPoints = [MaxBadPoints - BadPoints,1] call BIS_fnc_cutDecimals;
	_lastBadPoints = BadPoints;
	_LastRank = 0;
	if (_lastRepPoints >= 10) then {_LastRank = 5;};
	if (_lastRepPoints < 10) then {_LastRank = 4;};
	if (_lastRepPoints < 7) then {_LastRank = 3;};
	if (_lastRepPoints < 5) then {_LastRank = 2;};
	if (_lastRepPoints < 3) then {_LastRank = 1;};
	if (_lastRepPoints < 1) then {_LastRank = 0;};
	while {true} do {
		_dCurrentRep = [MaxBadPoints - BadPoints,1] call BIS_fnc_cutDecimals;
		_CurrentRank = _LastRank;
		if (_dCurrentRep >= 10) then {_CurrentRank = 5;};
		if (_dCurrentRep < 10) then {_CurrentRank = 4;};
		if (_dCurrentRep < 7) then {_CurrentRank = 3;};
		if (_dCurrentRep < 5) then {_CurrentRank = 2;};
		if (_dCurrentRep < 3) then {_CurrentRank = 1;};
		if (_dCurrentRep < 1) then {_CurrentRank = 0;};
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
					_iCurrentTaskCount = 0;
					["tskKeepAboveAverage", "failed"] call FHQ_TT_setTaskState;
					while {_iCurrentTaskCount < count ActiveTasks} do {
						if (!(ActiveTasks call FHQ_TT_areTasksCompleted)) then {
							[ActiveTasks select _iCurrentTaskCount, "failed"] call FHQ_TT_setTaskState;
							_iCurrentTaskCount = _iCurrentTaskCount + 1;
						};
					};
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

				if ((ActiveTasks call FHQ_TT_areTasksCompleted)) then { //if rank changed and tasks completed, then if now rank 5, need to reset board to show "Start final mission", otherwise, make sure shows "start next mission"
					[["MISSION_COMPLETE"],"RandFramework\Campaign\SetMissionBoardOptions.sqf"] remoteExec ["BIS_fnc_execVM",0,true];
				};
				//hint parseText _sRankMessage;
				[parseText _sRankMessage] remoteExec ["Hint", 0, true];
				//hintSilent parseText format["<t size='1.25' font='Zeppelin33' color='#ff0000'>%1 lives remaining.</t><a href='http://arma3.com'>A3</a>%2", 12, _sRankMessage];
				//[format["Points have been marked against your team. Current points: %1 out of %2\n\nREASONS SO FAR: \n%3",BadPoints, MaxBadPoints, BadPointsReason]] remoteExec ["Hint", 0, true];
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

	 {systemChat format["Mission Core: %1", "NonAliveEndCheckRunning"];} remoteExec ["bis_fnc_call", 0];
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
	{systemChat format["Mission Core: %1", "NVGStateSet"];} remoteExec ["bis_fnc_call", 0];
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

[[],"RandFramework\animateAnimals.sqf"] remoteExec ["BIS_fnc_execVM",0,true];

systemChat format["Mission Core: %1", "AnimalStateSet"];
sleep _coreCountSleep;

 if (!isDedicated && (player != player)) then {
	waitUntil {player == player};
	waitUntil {time > 10};
	[[],"RandFramework\animateAnimals.sqf"] remoteExec ["BIS_fnc_execVM",0,true];
	//hint "PING";
 };



systemChat format["Mission Core: %1", "CoreFinished"];
sleep _coreCountSleep;


CoreCompleted = true;
publicVariable "CoreCompleted";

if (iMissionParamType != 5) then {
	call compile preprocessFileLineNumbers  "RandFramework\Campaign\PostStartMission.sqf";
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
