		params [["_startId","initial"]];
		_isCampaign = (iMissionParamType == 5);
		if isNil("CoreCompleted") then {
			CoreCompleted = false;
			publicVariable "CoreCompleted";
		};

		waituntil {CoreCompleted};

		sleep 2;


		//the server decides if players start at an AO camp (and creates it), everyone else waits for that decision
		if (isServer) then {
			private _bServerMoveToAO = false;
			if (iStartLocation == 2) then {
				_bServerMoveToAO = selectRandom [true,false];
			};
			if (iStartLocation == 1) then {
				_bServerMoveToAO = true;
			};
			if (_bServerMoveToAO) then {
				call compile preprocessFileLineNumbers "RandFramework\functions\missionSetup\AoCampCreator.sqf";
			};
			TRGM_postStartInfo = [_startId, _bServerMoveToAO, if (isNil "AOCampPos") then {[0,0,0]} else {AOCampPos}];
			publicVariable "TRGM_postStartInfo";
		};
		waitUntil {sleep 0.2; !isNil "TRGM_postStartInfo" && {(TRGM_postStartInfo select 0) isEqualTo _startId}};
		TRGM_postStartInfo params ["", "_bMoveToAO", "_aoCampPos"];


_isHiddenObj = false;
		_mainAOPos = ObjectivePossitions select 0;
		if (! isNil "_mainAOPos") then {
			if (_mainAOPos in HiddenPossitions ) then {
				_isHiddenObj = true;
			};
		};

		_locationText = "";
		if (! isNil "_mainAOPos") then {
			_locationText = [_mainAOPos] call TRGM_fnc_getLocationName;
		};
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

		titleText ["", "BLACK IN", 5];
		if ((MaxBadPoints - BadPoints) >= 10) then {
			_LineTwo = (localize "STR_TRGM2_StartMission_Final") + CurrentZeroMissionTitle;
		};


		if (isNil "NewMissionMusic") then {
			NewMissionMusic = selectRandom ThemeAndIntroMusic;
			publicVariable "NewMissionMusic";
		};

		ace_hearing_disableVolumeUpdate = true;

		playMusic "";
		0 fadeMusic 1;
		playMusic NewMissionMusic;
		if (bDebugMode) then {[format["StartMission Music: %1", NewMissionMusic]] remoteExec ["systemChat", 0];};

		[_LineTwo, 0.6, 0.220, "txt1"] call TRGM_fnc_showLayerText;
		[_LineOne, 0.8, 0.150, "txt5"] call TRGM_fnc_showLayerText;
		[AdvancedSettings select ADVSET_GROUP_NAME_IDX, 0.8, 0.350, "txt6"] call TRGM_fnc_showLayerText;

		showcinemaborder true;

		_pos1 = nil;
		_pos2 = nil;
		if (_bMoveToAO) then {
			_pos1 = (_aoCampPos getPos [(floor(random 100))+50, (floor(random 360))]);
			_pos2 = (_aoCampPos getPos [(floor(random 100))+50, (floor(random 360))]);		
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
			_camera camPrepareTarget _aoCampPos;	
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


		if (bDebugMode) then {["FinalCleanup"] remoteExec ["systemChat", 0];};
		if (isServer) then {
			call compile preprocessFileLineNumbers "RandFramework\RandScript\FinalSetupCleaner.sqf";
		};

		sleep 2;
		
		if (_bMoveToAO && isServer) then { //setPos is global, so only the server moves the group
			if (!isnil "sl") then {
				sl setPos _aoCampPos;
				if (bDebugMode) then {["Moving Players"] remoteExec ["systemChat", 0];};
				sleep 1;
				{_x setpos _aoCampPos} forEach units group sl;
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

		