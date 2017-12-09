#include "..\setUnitGlobalVars.sqf";

civilian setFriend [east, 1];

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
	MaxBadPoints = 10;
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
if (isNil "CampPos") then {
	bHasCamp = false;
	CampPos = [0,0];
	publicVariable "bHasCamp";	
	publicVariable "CampPos";	
};
if (isNil "CommsTowerPos") then {
	bHasCommsTower = false;
	CommsTowerPos = [0,0];
	publicVariable "bHasCommsTower";	
	publicVariable "CommsTowerPos";	
};
if (isNil "DownedChopperPos") then {
	bHasDownedChopper = false;
	DownedChopperPos = [0,0];
	publicVariable "bHasDownedChopper";	
	publicVariable "DownedChopperPos";	
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
	iMissionParamType = 0;
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
	iMissionParamRepOption = 1;
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


_trgRatingAdjust = createTrigger ["EmptyDetector", [0,0]];
_trgRatingAdjust setTriggerArea [0, 0, 0, false];	
_trgRatingAdjust setTriggerStatements ["((rating player) < 0)", "player addRating -(rating player)", ""];

if (isServer) then {
	box1 allowDamage false;
	if (isClass(configFile >> "CfgPatches" >> "ace_main")) then {
		[box1,InitialBoxItemsWithAce] call bis_fnc_initAmmoBox;
	}
	else {
		[box1,InitialBoxItems] call bis_fnc_initAmmoBox;
	};
};

//this setVariable ["MP_ONLY", true, true];
if (!isMultiplayer) then {
	{
		if (_x getVariable ["MP_ONLY",false]) then {
			deleteVehicle _x;
		};
	} forEach allUnits;
};

[[chopper1, ["Custom LZ","RandFramework\SelectLZ.sqf"]],"addAction",true,true] call BIS_fnc_MP;


waitUntil {bAndSoItBegins};

if (iMissionParamType == 5) then {
	if (isServer) then {
		call compile preprocessFileLineNumbers  "RandFramework\Campaign\initCampaign.sqf";
	};
}
else {
	if (isServer) then {
		call compile preprocessFileLineNumbers  "RandFramework\SetTimeAndWeather.sqf";
		call compile preprocessFileLineNumbers  "RandFramework\startInfMission.sqf";
	};
};

TREND_fnc_CheckBadPoints = {
	if (isNil "BadPoints") then {
			BadPoints = 0;
			publicVariable "BadPoints";
	};
	_lastBadPoints = BadPoints;
	while {true} do {
		if (_lastBadPoints != BadPoints) then {
			_lastBadPoints = BadPoints;
			//[format["Points have been marked against your team. Current points: %1 out of %2\n\nREASONS SO FAR: \n%3",BadPoints, MaxBadPoints, BadPointsReason]] remoteExec ["Hint", 0, true];
			if (BadPoints >= MaxBadPoints && iMissionParamRepOption == 1) then {
				iCurrentTaskCount = 0;
				while {iCurrentTaskCount < count ActiveTasks} do {
					[ActiveTasks select iCurrentTaskCount, "failed"] call FHQ_TT_setTaskState;
					iCurrentTaskCount = iCurrentTaskCount + 1;
				};
					
			};
		};
		sleep 1;
	};
};
[] spawn TREND_fnc_CheckBadPoints;
player addEventHandler ["Respawn", { [] spawn TREND_fnc_CheckBadPoints; }];




if (isServer) then {
 
	//_tfarCreate = "TF_NATO_Radio_Crate" createVehicle getPos endMissionBoard;

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
};


[[],"RandFramework\animateAnimals.sqf"] remoteExec ["BIS_fnc_execVM",0,true];

 if (!isDedicated && (player != player)) then {
	waitUntil {player == player}; 
	waitUntil {time > 10}; 
	[[],"RandFramework\animateAnimals.sqf"] remoteExec ["BIS_fnc_execVM",0,true];
	//hint "PING";
 };