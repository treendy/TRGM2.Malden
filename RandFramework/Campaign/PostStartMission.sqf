		_isCampaign = (iMissionParamType == 5);
		if isNil("CoreCompleted") then {
			CoreCompleted = false;
			publicVariable "CoreCompleted";
		};

		waituntil {CoreCompleted};

		sleep 2;



		_bMoveToAO = false;
		if (iStartLocation == 2) then {
			_bMoveToAO = selectRandom [true,false];
		};
		if (iStartLocation == 1) then {
			_bMoveToAO = true;
		};
		if (_bMoveToAO) then {
			call compile preprocessFileLineNumbers "RandFramework\functions\MissionSetup\AoCampCreator.sqf";
			//[] execVM "RandFramework\functions\MissionSetup\AoCampCreator.sqf";
		}
		else {
			/*TREND_fnc_PopulateLoadingWait = {
				Hint "Populating AO please wait...";
				_percentage = 0;
				while {_percentage < 100} do {
					[format["Populating AO please wait... Percentage: %1", _percentage]] remoteExecCall ["Hint", 0];
					//Hint format["Populating AO please wait... %1 %", _percentage];
					_percentage = _percentage + 1;
					sleep 0.2;
				};
				[""] remoteExecCall ["Hint", 0];
				MissionLoaded = true;
				publicVariable "MissionLoaded";
			};
			[_sTargetName] spawn TREND_fnc_PopulateLoadingWait;*/
		};






		_isHiddenObj = false;
		_mainAOPos = ObjectivePossitions select 0;
		if (! isNil "_mainAOPos") then {
			if (_mainAOPos in HiddenPossitions ) then {
				_isHiddenObj = true;
			};
		};

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

		if (_isHiddenObj) then {
			_LineTwo = (localize "STR_TRGM2_StartMission_Mission") + "Unknown";
			_LineThree = "location unknown"
		};

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
		playMusic NewMissionMusic;
		{systemChat format["StartMission Music: %1", NewMissionMusic];} remoteExec ["bis_fnc_call", 0];

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

		_pos1 = nil;
		_pos2 = nil;
		if (_bMoveToAO) then {
			_pos1 = (AOCampPos getPos [(floor(random 100))+50, (floor(random 360))]);
			_pos2 = (AOCampPos getPos [(floor(random 100))+50, (floor(random 360))]);		
		}
		else {
			_pos1 = (player getPos [(floor(random 100))+50, (floor(random 360))]);
			_pos2 = (player getPos [(floor(random 100))+50, (floor(random 360))]);		
		};
		_pos1 = [_pos1 select 0,_pos1 select 1,selectRandom[10,20]];
		_pos2 = [_pos2 select 0,_pos2 select 1,selectRandom[10,20]];


		_camera = "camera" camCreate _pos1;
		_camera cameraEffect ["internal","back"];

		_camera camPreparePos _pos2;
		if (_bMoveToAO) then {
			_camera camPrepareTarget AOCampPos;	
		}
		else {
			_camera camPrepareTarget player;
		};
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
		sleep 3;


		{systemChat "FinalCleanup";} remoteExec ["bis_fnc_call", 0];
		call compile preprocessFileLineNumbers "RandFramework\RandScript\FinalSetupCleaner.sqf";

		sleep 2;
		
		if (_bMoveToAO) then {
			//AOCampPos
			if (!isnil "sl") then {
				sl setPos AOCampPos;
				{systemChat "Moving Players";} remoteExec ["bis_fnc_call", 0];
				sleep 1;
				{_x setpos AOCampPos} forEach units group sl;
			};
		};





		titleCut ["", "BLACK in", 5];
		_camera cameraEffect ["Terminate","back"];
		sleep 10;

		player allowdamage true;

			
		player doFollow player;

		sleep 3;
		saveGame;
		sleep 1;

		player doFollow player;

		