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

			{
				_y = _x;
				{
					//if (_y distance getPos _x > PunishmentRadius) then {
					if (!(_x getVariable ["IsFRT",false]) && !(_x getVariable ["DontDelete",false])) then {
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
			[] execVM "RandFramework\startInfMission.sqf";
		};

		if isNil("MissionLoaded") then {
			MissionLoaded = false;
			publicVariable "MissionLoaded";
		};

		waituntil {MissionLoaded};
		publicVariable "MissionLoaded";

		sleep 2;

		_locationText = [ObjectivePossitions select 0] call TRGM_fnc_getLocationName;
		_hour = floor daytime;
		_minute = floor ((daytime - _hour) * 60);

		_strHour = str(_hour);
		_strMinute = str(_minute);
		_lenHour = count (_strHour);
		_lenMin = count (_strMinute);
		if (_lenHour == 1) then {
			_strHour = format["0%1",_strHour];
		};
		if (_lenMin == 1) then {
			_strMinute = format["0%1",_strMinute];
		};
		_time24 = text format ["%1:%2",_strHour,_strMinute];

		if (!isDedicated) then {
		sleep 5;
		};


		_LineOne = format [localize "STR_TRGM2_StartMission_Day",str(iCampaignDay)];
		_LineTwo = (localize "STR_TRGM2_StartMission_Mission") + CurrentZeroMissionTitle;
		_LineThree = _locationText;
		_LineFour = (localize "STR_TRGM2_StartMission_Time") + str(_time24);

		if (!_isCampaign) then {
			_LineOne = "TRGM 2"
		};

		if (MaxBadPoints >= 10) then {
			titleText ["", "BLACK IN", 5];
			_LineTwo = (localize "STR_TRGM2_StartMission_Final") + CurrentZeroMissionTitle;
			//titleText [format["Day %1 - %2\nFinal Objective: %3\nLocation: %4",iCampaignDay,_time24,CurrentZeroMissionTitle,_locationText], "BLACK IN", 5];
		}
		else {
			titleText ["", "BLACK IN", 5];
			//titleText [format["Day %1 - %2.\nObjective: %3\nLocation: %4",iCampaignDay,_time24,CurrentZeroMissionTitle,_locationText], "BLACK IN", 5];
		};


		if (isNil "NewMissionMusic") then {
			NewMissionMusic = selectRandom ThemeAndIntroMusic;
			publicVariable "NewMissionMusic";
		};

		ace_hearing_disableVolumeUpdate = true;

		playMusic "";
		0 fadeMusic 1;
		playMusic selectRandom ThemeAndIntroMusic;


		txt1Layer = "txt1" call BIS_fnc_rscLayer;
		txt2Layer = "txt2" call BIS_fnc_rscLayer;


	    _texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.6' color='#ffffff'>" + _LineTwo +"</t>";
	    [_texta, 0, 0.220, 7, 1,0,txt1Layer] spawn BIS_fnc_dynamicText;


		txt5Layer = "txt5" call BIS_fnc_rscLayer;
		txt6Layer = "txt6" call BIS_fnc_rscLayer;


	    _texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.8' color='#Ffffff'>" + _LineOne +"</t>";
	    [_texta, -0, 0.150, 7, 1,0,txt5Layer] spawn BIS_fnc_dynamicText;

	    _texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.8' color='#Ffffff'>" + (AdvancedSettings select ADVSET_GROUP_NAME_IDX) + "</t>";
	    [_texta, -0, 0.350, 7, 1,0,txt6Layer] spawn BIS_fnc_dynamicText;

		showcinemaborder true;

		_pos1 = (player getPos [(floor(random 100))+50, (floor(random 360))]);
		_pos2 = (player getPos [(floor(random 100))+50, (floor(random 360))]);
		_pos1 = [_pos1 select 0,_pos1 select 1,selectRandom[10,20]];
		_pos2 = [_pos2 select 0,_pos2 select 1,selectRandom[10,20]];

		_camera = "camera" camCreate _pos1;
		_camera cameraEffect ["internal","back"];

		_camera camPreparePos _pos2;
		_camera camPrepareTarget player;
		_camera camPrepareFOV 0.4;
		_camera camCommitPrepared 46;

		sleep 3;
		 any= [_LineThree,_LineFour]spawn BIS_fnc_infotext;

		sleep 3;
		titleCut ["", "BLACK out", 5];

		8 fadeMusic 0;
		[] spawn {
			sleep 8;
			ace_hearing_disableVolumeUpdate = false;
			playMusic "";
		};
		sleep 5;


		titleCut ["", "BLACK in", 5];
		_camera cameraEffect ["Terminate","back"];
		sleep 10;

		player allowdamage true;


	}
	else {

		{hint (localize "STR_TRGM2_StartMission_Hint");} remoteExec ["bis_fnc_call", 0];
	};

	player doFollow player;

	sleep 3;
	saveGame;
	sleep 1;

	player doFollow player;
};