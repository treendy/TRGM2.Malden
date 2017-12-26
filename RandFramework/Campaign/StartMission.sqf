#include "..\..\setUnitGlobalVars.sqf";

//HERE: tasks created day 1 day 2 etc... 
//		DONE - make sure completed before next task created!
//		DONE - make sure no playble units are outside the main base
//		- only allow main leader to start and end missions
//		- lose points if mission not completed and next selected
//		- 

//NOTE: what happsn if die.... give options (1: mission fails and poitns drop, 2: respawn and points drop, 3: mp, respawn at base, cant leave until task ended)
//	- Start Mission (if rep is 10 or more, then start main objective with two optional intel sides)
//	- create random mission
//	- if current task not completed, the fail it
//	- Fade out and in showing "Day X, time X:X - Mission Title (SE of Town Name)"
//	- player short 5 second intro sound
//	- AddAction to board: End mission <<< if not a success will lower rep, clear current mission and load next mission... (show message warning player)

_isCampaign = (iMissionParamType == 5);




if ((bAllAtBase && ActiveTasks call FHQ_TT_areTasksCompleted) || !_isCampaign) then {
	player allowdamage false;


	titleText ["Loading mission...", "BLACK FADED", 5];
	//sleep 3;
	
	if (_isCampaign) then {
		[["NEW_MISSION"],"RandFramework\Campaign\SetMissionBoardOptions.sqf"] remoteExec ["BIS_fnc_execVM",0,true];
	};

	//"Marker1" setMarkerPos getMarkerPos "mrkHQ";



	

	if (isServer && _isCampaign) then {

		{	
			_y = _x;
			{
				//if (_y distance getPos _x > PunishmentRadius) then {
				if (!(_x getVariable ["IsFRT",false])) then {
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
		bHasCamp = false;
		CampPos = [0,0];
		publicVariable "bHasCamp";	
		publicVariable "CampPos";	
		bHasCommsTower = false;
		CommsTowerPos = [0,0];
		publicVariable "bHasCommsTower";	
		publicVariable "CommsTowerPos";	
		bHasDownedChopper = false;
		DownedChopperPos = [0,0];
		publicVariable "bHasDownedChopper";	
		publicVariable "DownedChopperPos";	
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

		
	};

	if (isServer) then {
		[] execVM "RandFramework\SetTimeAndWeather.sqf";
	
		[] execVM "RandFramework\startInfMission.sqf";
	};

	sleep 2;
	_fnc_dirToText = {
		params [
				["_direction",-1,[0]],  // direction 0 to 360
				["_words",false,[false]] // use word style instead of acronyms
			];

		if (_direction < 0 ||_direction > 360) then {
			"";
		};
		
		_val = round(_direction/45);
		if (_words) then {
			switch(_val) do {
				case 8;
				case 0: {"North"};
				case 1: {"North East"};
				case 2: {"East"};
				case 3: {"South East"};
				case 4: {"South"};
				case 5: {"South West"};
				case 6: {"West"};
				case 7: {"North West"};
			};
		} else {
			switch(_val) do {
				case 8;
				case 0: {"N"};
				case 1: {"NE"};
				case 2: {"E"};
				case 3: {"SE"};
				case 4: {"S"};
				case 5: {"SW"};
				case 6: {"W"};
				case 7: {"NW"};
			};
		};
	};

	


	_fnc_getLocationName = {
		params["_position"];

		_location = (nearestLocations [ _position, [ "NameVillage", "NameCity","NameCityCapital","NameMarine","Hill"],5000,_position]) select 0; 
		_locationName =  text (_location);
		_locationPosition = position _location;

		_text = "";
		if (_position distance2D _locationPosition > 300) then {
			_relDir = _locationPosition getDir _position;
			_text = format ["%1 of %2",[_relDir,true] call _fnc_dirToText,_locationName];
		} else {
			_text = format ["%1",_locationName];
		};
		_text;
	};
	
	//fade in
	

	_locationText = [ObjectivePossitions select 0] call _fnc_getLocationName;
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


	_LineOne = "Day " + str(iCampaignDay);
	_LineTwo = "Mission: " + CurrentZeroMissionTitle;
	_LineThree = _locationText;
	_LineFour = "Time: " + str(_time24);

	if (!_isCampaign) then {
		_LineOne = "TRGM 2"
	};

	if (MaxBadPoints >= 10) then {
		titleText ["", "BLACK IN", 5];
		_LineTwo = "Final Objective: " + CurrentZeroMissionTitle;
		//titleText [format["Day %1 - %2\nFinal Objective: %3\nLocation: %4",iCampaignDay,_time24,CurrentZeroMissionTitle,_locationText], "BLACK IN", 5];
	}
	else {
		titleText ["", "BLACK IN", 5];
		//titleText [format["Day %1 - %2.\nObjective: %3\nLocation: %4",iCampaignDay,_time24,CurrentZeroMissionTitle,_locationText], "BLACK IN", 5];
	};


	txt1Layer = "txt1" call BIS_fnc_rscLayer;
	txt2Layer = "txt2" call BIS_fnc_rscLayer;


    _texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.6' color='#ffffff'>" + _LineTwo +"</t>"; 
    [_texta,/* poz x */ 0,/* poz y */ 0.220,/*durata*/ 7,/* fade in?*/ 1,0,txt1Layer] spawn BIS_fnc_dynamicText;


	txt5Layer = "txt5" call BIS_fnc_rscLayer;
	txt6Layer = "txt6" call BIS_fnc_rscLayer;


    _texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.8' color='#Ffffff'>" + _LineOne +"</t>"; 
    [_texta,/* poz x */ -0,/* poz y */ 0.150,/*durata*/ 7,/* fade in?*/ 1,0,txt5Layer] spawn BIS_fnc_dynamicText;

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
	sleep 5;


	titleCut ["", "BLACK in", 5];
	_camera cameraEffect ["Terminate","back"];
	sleep 10;

	player allowdamage true;
}
else {

	{hint "All players need to be at base, and current task needs to be completed or failed";} remoteExec ["bis_fnc_call", 0];
};

player doFollow player; 

sleep 3;
saveGame;
sleep 1;

player doFollow player; 