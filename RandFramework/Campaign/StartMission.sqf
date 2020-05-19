#include "..\..\setUnitGlobalVars.sqf";

_isCampaign = (iMissionParamType == 5);


_mrkHQPos = getMarkerPos "mrkHQ";
_AOCampPos = getPos endMissionBoard2;
bAllAtBase2 = ({(alive _x)&&((_x distance _mrkHQPos < 500)||(_x distance _AOCampPos < 500))} count (call BIS_fnc_listPlayers))==({ (alive _x) } count (call BIS_fnc_listPlayers));




//Need to move the below to function that fires for player who called addAction, then inside that function can call StartMission for all
//Also... in this extra file, we can set a publicVariable for "IntroPlayed=false", then after played set IntroPlayed=true... so will only play when mission starts or next mission picked
_bAllowStart = true;
//if (_isCampaign && isMultiplayer) then {
//	_bSLAlive = false;
//	_bK1_1Alive = false;
//	if (!isnil "sl") then {
//		_bSLAlive = alive sl;
//	};
//	if (!isnil "k2_1") then {
//		_bK1_1Alive = alive k2_1;
//	};
//
//	if (_bSLAlive && str(player) != "sl") then {
//		hint "The Kilo-1 teamleader needs to select this";
//		_bAllowStart = false;
//	};
//
//	if (!_bSLAlive && _bK1_1Alive && str(player) != "k2_1") then {
//		hint "The Kilo-2 teamleader needs to select this";
//		_bAllowStart = false;
//	};
//	if (!_bSLAlive && !_bK1_1Alive && (leader (group player))!=player) then {
//			hint "The assigned Kilo-1 teamleader needs to select this";
//			_bAllowStart = false;
//	};
//};


if (_bAllowStart) then {

	if ((bAllAtBase2 && ActiveTasks call FHQ_TT_areTasksCompleted) || !_isCampaign) then {


		player allowdamage false;


		titleText [localize "STR_TRGM2_mainInit_Loading", "BLACK FADED", 5];
		//sleep 3;

		if (_isCampaign) then {
			[["NEW_MISSION"],"RandFramework\Campaign\SetMissionBoardOptions.sqf"] remoteExec ["BIS_fnc_execVM",0,true];
			if ((Player getVariable ["calUAVActionID", -1]) != -1) then {
				player removeAction (Player getVariable ["calUAVActionID", -1]);
				player setVariable ["calUAVActionID", nil];
				//hint "UAV no longer available";
			};
		};

		//"Marker1" setMarkerPos getMarkerPos "mrkHQ";





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
					//if (_y distance getPos _x > PunishmentRadius) then {
					_isZeuzModule = false;
					if (["ModuleCurator", str(TypeOf (_x))] call BIS_fnc_inString) then {_isZeuzModule = true;};
					if (["Zeus", str(_x)] call BIS_fnc_inString) then {_isZeuzModule = true;};
					if (!_isZeuzModule && !(_x getVariable ["IsFRT",false]) && !(_x getVariable ["DontDelete",false])) then {
						deleteVehicle _x;
					};
					//};
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



			//not saving when new day starts, we will save when points change (just incase day starts, but players exit anyway and nothing done on that day)
			//if (SaveType != 0) then {
			//		[SaveType,false] execVM "RandFramework\Campaign\ServerSave.sqf";
			//};
			
		};


		if (isServer) then {
			MissionLoaded = false;
			publicVariable "MissionLoaded";
			[] execVM "RandFramework\SetTimeAndWeather.sqf";
			call compile preprocessFileLineNumbers  "RandFramework\startInfMission.sqf";
		};

	}
	else {

		{hint (localize "STR_TRGM2_StartMission_Hint");} remoteExec ["bis_fnc_call", 0];
	};

	if (iMissionParamType == 5) then {
		call compile preprocessFileLineNumbers  "RandFramework\Campaign\PostStartMission.sqf";
	};

};