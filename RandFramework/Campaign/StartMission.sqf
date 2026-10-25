#include "..\..\setUnitGlobalVars.sqf"; //this can be replayed for joining players before init.sqf has run, so make sure the globals exist (guarded, only runs once)

params [["_startId","initial"]];
_isCampaign = (iMissionParamType == 5);

//in a campaign StartMissionPreCheck.sqf has already checked everyone is at base with the tasks done
if (true) then {

	if (true) then {


		player allowdamage false;


		titleText [localize "STR_TRGM2_mainInit_Loading", "BLACK FADED", 5];

		if (_isCampaign) then {
			if (isServer) then {
				[["NEW_MISSION"],"RandFramework\Campaign\SetMissionBoardOptions.sqf"] remoteExec ["BIS_fnc_execVM",0,"TRGM_missionBoardOptions"];
			};
			if ((Player getVariable ["calUAVActionID", -1]) != -1) then {
				player removeAction (Player getVariable ["calUAVActionID", -1]);
				player setVariable ["calUAVActionID", nil];
			};
		};


if (isServer && _isCampaign) then {

			if (!isNil("WarColor")) then {
				WarColor ppEffectEnable false;
	 			ppEffectDestroy WarColor;
			};
			if (!isNil("WarGrain")) then {
    			WarGrain ppEffectEnable false;
			    ppEffectDestroy WarGrain;
			};
			if (!isNil("WarEventActive")) then {
    			WarEventActive = false;
			};
			if (!isNil("WarzonePos")) then {
    			WarzonePos = nil;
			};
			if (!isNil("AOCampPos")) then {
    			AOCampPos = nil;
			};



			tracer1 setPos [99999,99999];
			tracer2 setPos [99999,99999];
			tracer3 setPos [99999,99999];
			tracer4 setPos [99999,99999];

			ATFieldPos = [];

			{
				_y = _x;
				{
					_isZeuzModule = false;
					if (["ModuleCurator", str(TypeOf (_x))] call BIS_fnc_inString) then {_isZeuzModule = true;};
					if (["Zeus", str(_x)] call BIS_fnc_inString) then {_isZeuzModule = true;};
					if (!_isZeuzModule && !(_x getVariable ["IsFRT",false]) && !(_x getVariable ["DontDelete",false])) then {
						deleteVehicle _x;
					};
				} forEach nearestObjects [_y, ["all"], 4000];
			} forEach ObjectivePossitions;

			{
				_mrkPos = getMarkerPos _x;
				_mrkHQPos = getMarkerPos "mrkHQ";
				if (_mrkPos distance _mrkHQPos > PunishmentRadius) then {
					deleteMarker _x;
				};
			} forEach allMapMarkers;

			{
				if (_x getVariable ["DelMeOnNewCampaignDay",false]) then {
					deleteVehicle _x;
				};
			} forEach allMissionObjects "EmptyDetector";

			{
    			deleteGroup _x
			} forEach allGroups select {count units _x isEqualTo 0};


			InfTaskCount = 0;
			publicVariable "InfTaskCount";
			ActiveTasks = [];
			publicVariable "ActiveTasks";
			ObjectivePossitions = [];
			publicVariable "ObjectivePossitions";
			SpottedActiveFinished = true;
			publicVariable "SpottedActiveFinished";
			bCommsBlocked = false;
			publicVariable "bCommsBlocked";
			bBaseHasChopper = false;
			publicVariable "bBaseHasChopper";
			ParaDropped = false;
			publicVariable "ParaDropped";
			bHasCommsTower = false;
			CommsTowerPos = [0,0];
			publicVariable "bHasCommsTower";
			publicVariable "CommsTowerPos";
			AODetails = [];
			publicVariable "AODetails";
			CheckPointAreas = [];
			publicVariable "CheckPointAreas";
			SentryAreas = [];
			publicVariable "SentryAreas";
			bMortarFiring = false;
			publicVariable "bMortarFiring";
			iCampaignDay = iCampaignDay + 1;
			publicVariable "iCampaignDay";
			IntelFound = [];
			publicVariable "IntelFound";
			ClearedPositions = [];
			publicVariable "ClearedPositions";
			AllowUAVLocateHelp = false;
			publicVariable "AllowUAVLocateHelp";

			NewMissionMusic = nil;
			publicVariable "NewMissionMusic";


};


		if (isServer) then {
			MissionLoaded = false;
			publicVariable "MissionLoaded";
			[] execVM "RandFramework\SetTimeAndWeather.sqf";
			call compile preprocessFileLineNumbers  "RandFramework\startInfMission.sqf";
		};

	};

	if (iMissionParamType == 5) then {
		[_startId] call compile preprocessFileLineNumbers  "RandFramework\Campaign\PostStartMission.sqf";
	};

};