
_isCampaign = (iMissionParamType == 5);


_mrkHQPos = getMarkerPos "mrkHQ";
_AOCampPos = getPos endMissionBoard2;
bAllAtBase2 = ({(alive _x)&&((_x distance _mrkHQPos < 500)||(_x distance _AOCampPos < 500))} count (call BIS_fnc_listPlayers))==({ (alive _x) } count (call BIS_fnc_listPlayers));


//Need to move the below to function that fires for player who called addAction, then inside that function can call StartMission for all
//Also... in this extra file, we can set a publicVariable for "IntroPlayed=false", then after played set IntroPlayed=true... so will only play when mission starts or next mission picked
_bAllowStart = true;


if (_bAllowStart) then {

	if ((bAllAtBase2 && ActiveTasks call FHQ_TT_areTasksCompleted) || !_isCampaign) then {


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


al_aaa = false;
			publicVariable "al_aaa";
			al_search_light = false;
			publicVariable "al_search_light";

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

	}
	else {

		hint (localize "STR_TRGM2_StartMission_Hint"); //this script already runs on every machine
	};

	if (iMissionParamType == 5) then {
		call compile preprocessFileLineNumbers  "RandFramework\Campaign\PostStartMission.sqf";
	};

};