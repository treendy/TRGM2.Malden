
#include "..\setUnitGlobalVars.sqf";


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
	iMissionParamType = 3;
	publicVariable "iMissionParamType";	
};
if (isNil "iMissionParamObjective") then {
	iMissionParamObjective = 0;
	publicVariable "iMissionParamObjective";	
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


if (! isDedicated) then {
waitUntil {!isNull player};

TransferProviders = {

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








//[markerPos "Marker1"," This is the part to change for the sitrep",300,200,180,0,[],1] spawn BIS_fnc_establishingShot;

//hint "AAAA";
//sleep 3;
//player cameraEffect ["terminate","back"];
//hint "BBBB";





waitUntil {bAndSoItBegins};

if (!isDedicated) then {
	titleText ["Loading mission...", "BLACK FADED"];
	_camera cameraEffect ["Terminate","back"];
};





//#include "RandFramework\General\TRGMSetEnemyUnitGlobalVars.sqf";


if (isServer) then {
	call compile preprocessFileLineNumbers "RandFramework\General\TRGMSetDefaultUnitGlobalVars.sqf";
	call compile preprocessFileLineNumbers "RandFramework\General\TRGMSetEnemyUnitGlobalVars.sqf";
	call compile preprocessFileLineNumbers "RandFramework\General\TRGMSetFriendlyLoutoutsGlobalVars.sqf";
	CustomObjectsSet = true;
	publicVariable "CustomObjectsSet";
	call compile preprocessFileLineNumbers "RandFramework\setFriendlyObjects.sqf";

	[chopper1] call TRGM_fnc_addTransportAction;

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
							_errorMessage = _errorMessage + format["\nClass doesnt exist: %1 - class: %2 ",_fullObj,_x];
						};
					}
					else {
						_errorMessage = _errorMessage + format["\nClass is empty: %1 - class: %2 ",_fullObj,_x];
					};
					
				} forEach _classArray;
			};
		} forEach _ObjectPairs;
		if (_errorMessage != "") then {
			hint _errorMessage;
			sleep 3;
		};
	};


	if (LoadoutData != "" || LoadoutDataDefault != "") then {
		{
			[_x] execVM "RandFramework\setLoadout.sqf";
			_x addEventHandler ["Respawn", { [_x] execVM "RandFramework\setLoadout.sqf"; }];
		} forEach (if (isMultiplayer) then {playableUnits} else {switchableUnits});
	};
	if (isClass(configFile >> "CfgPatches" >> "ace_main")) then {
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
		box1 addBackpackCargoGlobal [typeof(unitBackpack _x), 1];
	}  forEach (if (isMultiplayer) then {playableUnits} else {switchableUnits});


};

waitUntil {CustomObjectsSet};

if (iUseRevive > 0) then {
	[] call AIS_Core_fnc_preInit;
	[] call AIS_Core_fnc_postInit;
	[] call AIS_System_fnc_postInit;
};


//this setVariable ["MP_ONLY", true, true];
if (!isMultiplayer) then {
	{
		if (_x getVariable ["MP_ONLY",false]) then {
			deleteVehicle _x;
		};
	} forEach allUnits;
};


player doFollow player; 



if (iMissionParamType == 5) then {
	if (isServer) then {
		call compile preprocessFileLineNumbers  "RandFramework\Campaign\initCampaign.sqf";
	};
}
else {
	
	//[] execVM "RandFramework\StartMission.sqf";
	
	call compile preprocessFileLineNumbers  "RandFramework\Campaign\StartMission.sqf";
	//HERE HERE HERE !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!It calls the script above, but doesnt start the actual mission?????????????????????


	//if (isServer) then {
	//	call compile preprocessFileLineNumbers  "RandFramework\SetTimeAndWeather.sqf";
	//	call compile preprocessFileLineNumbers  "RandFramework\startInfMission.sqf";
	//};
};

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
				if (BadPoints > MaxBadPoints && iMissionParamRepOption == 1) then {
					iCurrentTaskCount = 0;
					["tskKeepAboveAverage", "failed"] call FHQ_TT_setTaskState;		
					while {iCurrentTaskCount < count ActiveTasks} do {
						if (!(ActiveTasks call FHQ_TT_areTasksCompleted)) then {
							[ActiveTasks select iCurrentTaskCount, "failed"] call FHQ_TT_setTaskState;
							iCurrentTaskCount = iCurrentTaskCount + 1;
						};
					};						
					sleep 2;
					[FriendlySide, ["DeBrief", "Return to HQ to debrief", "Debrief", ""]] call FHQ_TT_addTasks;
				};	
				if (BadPoints > MaxBadPoints && iMissionParamRepOption == 0) then { //note... when gaining rep, we increase the MaxBadPoints, and when lower, we incrase BadPoints (rep is calulated by the difference)
					["tskKeepAboveAverage", "failed"] call FHQ_TT_setTaskState;
				};				
				if (BadPoints <= MaxBadPoints && iMissionParamRepOption == 0) then {
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
					_sRankMessage = "<t color='#ff0000'>Your reputation has dropped.  Team rank now: </t><br /><br />" + _sRankIcon + "<br /><br />Check the notice board at base for your report";
				}
				else {
					_sRankMessage = "<t color='#00ff00'>Your reputation has increased.  Team rank now: </t><br /><br />" + _sRankIcon + "<br /><br />Check the notice board at base for your report";
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




if (isServer) then {
	{
		_x setVariable ["DontDelete",true];
	} forEach nearestObjects [getMarkerPos "mrkHQ", ["all"], 2000];

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

	TREND_fnc_PlayBaseRadioEffect = {
		while {true} do {
			playSound3D ["A3\Sounds_F\sfx\radio\" + selectRandom FriendlyRadioSounds + ".wss",baseRadio,false,getPosASL baseRadio,0.5,1,0];
			sleep selectRandom [10,15,20,30];
		};
	};
	[] spawn TREND_fnc_PlayBaseRadioEffect;

	TREND_fnc_SandStormEffect = {
		_iSandStormOption = AdvancedSettings select ADVSET_SANDSTORM_IDX;

		if (_iSandStormOption == 0 && selectRandom[true,false,false,false]) then { //Random
			StartWhen = selectRandom [990,1290,1710];
			sleep StartWhen;
			//work out how to deal with JIP if sandstorm already playing
			//Maybe store timer, and how long left... so if player JIP, it will fire off storm script if currently runnig and adjust the time to play to what is left
			SandStormTimer = selectRandom [150,390,630];
			publicVariable SandStormTimer;
			{nul = [SandStormTimer] execvm "RandFramework\RikoSandStorm\ROSSandstorm.sqf";} remoteExec ["bis_fnc_call", 0];
			//Set enemy skill
			{
				if (Side _x == East) then {
					_x setskill ["aimingAccuracy",0.1];
					_x setskill ["aimingShake",0.1];
					_x setskill ["aimingSpeed",0.4];
					_x setskill ["spotDistance",0.3];
				};
			} forEach allUnits;
			sleep SandStormTimer;
			//reset enemy skill
			{
				if (Side _x == East) then {
					_x setskill ["aimingAccuracy",0.5];
					_x setskill ["aimingShake",0.5];
					_x setskill ["aimingSpeed",0.5];
					_x setskill ["spotDistance",0.5];
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
			{nul = [SandStormTimer] execvm "RandFramework\RikoSandStorm\ROSSandstorm.sqf";} remoteExec ["bis_fnc_call", 0];
			//Set enemy skill
			{
				if (Side _x == East) then {
					_x setskill ["aimingAccuracy",0.1];
					_x setskill ["aimingShake",0.1];
					_x setskill ["aimingSpeed",0.4];
					_x setskill ["spotDistance",0.3];
				};
			} forEach allUnits;
			sleep SandStormTimer;
			//reset enemy skill
			{
				if (Side _x == East) then {
					_x setskill ["aimingAccuracy",0.5];
					_x setskill ["aimingShake",0.5];
					_x setskill ["aimingSpeed",0.5];
					_x setskill ["spotDistance",0.5];
				};
			} forEach allUnits;
		};
		if (_iSandStormOption == 3) then { //5 hours non stop
			//ok, if something is true, then in here we will start the sand storm and all clients!
			//work out how to deal with JIP if sandstorm already playing
			//Maybe store timer, and how long left... so if player JIP, it will fire off storm script if currently runnig and adjust the time to play to what is left
			{nul = 18030 execvm "RandFramework\RikoSandStorm\ROSSandstorm.sqf";} remoteExec ["bis_fnc_call", 0];
			//Set enemy skill
			{
				if (Side _x == East) then {
					_x setskill ["aimingAccuracy",0.1];
					_x setskill ["aimingShake",0.1];
					_x setskill ["aimingSpeed",0.4];
					_x setskill ["spotDistance",0.3];
				};
			} forEach allUnits;
			sleep 18030;
			//reset enemy skill
			{
				if (Side _x == East) then {
					_x setskill ["aimingAccuracy",0.5];
					_x setskill ["aimingShake",0.5];
					_x setskill ["aimingSpeed",0.5];
					_x setskill ["spotDistance",0.5];
				};
			} forEach allUnits;
			//reset enemy skill
		};
		
	};
	[] spawn TREND_fnc_SandStormEffect;
	
};


[[],"RandFramework\animateAnimals.sqf"] remoteExec ["BIS_fnc_execVM",0,true];

 if (!isDedicated && (player != player)) then {
	waitUntil {player == player}; 
	waitUntil {time > 10}; 
	[[],"RandFramework\animateAnimals.sqf"] remoteExec ["BIS_fnc_execVM",0,true];
	//hint "PING";
 };


 
