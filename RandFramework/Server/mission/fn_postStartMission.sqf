
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;
_isCampaign = (TRGM_VAR_iMissionParamType isEqualTo 5);

waituntil {sleep 2; TRGM_VAR_CoreCompleted};

sleep 2;



_bMoveToAO = false;
if (TRGM_VAR_iStartLocation isEqualTo 2) then {
	_bMoveToAO = random 1 < .50;
};
if (TRGM_VAR_iStartLocation isEqualTo 1) then {
	_bMoveToAO = true;
};
if (_bMoveToAO) then {
	call TRGM_SERVER_fnc_aoCampCreator;
};

TRGM_VAR_MissionLoaded = true; publicVariable "TRGM_VAR_MissionLoaded";

_isHiddenObj = false;
_mainAOPos = TRGM_VAR_ObjectivePossitions select 0;
if (! isNil "_mainAOPos") then {
	if (_mainAOPos in TRGM_VAR_HiddenPossitions ) then {
		_isHiddenObj = true;
	};
};

_locationText = [TRGM_VAR_ObjectivePossitions select 0] call TRGM_GLOBAL_fnc_getLocationName;
_hour = floor daytime;
_minute = floor ((daytime - _hour) * 60);

_strHour = str(_hour);
_strMinute = str(_minute);
_lenHour = count (_strHour);
_lenMin = count (_strMinute);
if (_lenHour isEqualTo 1) then {
	_strHour = format["0%1",_strHour];
};
if (_lenMin isEqualTo 1) then {
	_strMinute = format["0%1",_strMinute];
};
_time24 = text format ["%1:%2",_strHour,_strMinute];

if (!isDedicated) then {
sleep 5;
};


_LineOne = format [localize "STR_TRGM2_StartMission_Day",str(TRGM_VAR_iCampaignDay)];
_LineTwo = (localize "STR_TRGM2_StartMission_Mission") + TRGM_VAR_CurrentZeroMissionTitle;
_LineThree = _locationText;
_LineFour = (localize "STR_TRGM2_StartMission_Time") + str(_time24);

if (_isHiddenObj) then {
	_LineTwo = (localize "STR_TRGM2_StartMission_Mission") + "Unknown";
	_LineThree = "location unknown"
};

if (!_isCampaign) then {
	_LineOne = "TRGM Redux"
};

if (TRGM_VAR_MaxBadPoints >= 10) then {
	titleText ["", "BLACK IN", 5];
	_LineTwo = (localize "STR_TRGM2_StartMission_Final") + TRGM_VAR_CurrentZeroMissionTitle;
	//titleText [format["Day %1 - %2\nFinal Objective: %3\nLocation: %4",TRGM_VAR_iCampaignDay,_time24,TRGM_VAR_CurrentZeroMissionTitle,_locationText], "BLACK IN", 5];
}
else {
	titleText ["", "BLACK IN", 5];
	//titleText [format["Day %1 - %2.\nObjective: %3\nLocation: %4",TRGM_VAR_iCampaignDay,_time24,TRGM_VAR_CurrentZeroMissionTitle,_locationText], "BLACK IN", 5];
};

ace_hearing_disableVolumeUpdate = true;

playMusic "";
0 fadeMusic 1;
if (isNil "TRGM_VAR_NewMissionMusic") then {TRGM_VAR_NewMissionMusic = selectRandom TRGM_VAR_ThemeAndIntroMusic; publicVariable "TRGM_VAR_NewMissionMusic";};
playMusic TRGM_VAR_NewMissionMusic;
format["StartMission Music: %1", TRGM_VAR_NewMissionMusic] call TRGM_GLOBAL_fnc_log;

txt1Layer = "txt1" call BIS_fnc_rscLayer;
txt2Layer = "txt2" call BIS_fnc_rscLayer;


_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.6' color='#ffffff'>" + _LineTwo +"</t>";
[_texta, 0, 0.220, 7, 1,0,txt1Layer] spawn BIS_fnc_dynamicText;


txt5Layer = "txt5" call BIS_fnc_rscLayer;
txt6Layer = "txt6" call BIS_fnc_rscLayer;


_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.8' color='#Ffffff'>" + _LineOne +"</t>";
[_texta, -0, 0.150, 7, 1,0,txt5Layer] spawn BIS_fnc_dynamicText;

_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.8' color='#Ffffff'>" + (TRGM_VAR_AdvancedSettings select TRGM_VAR_ADVSET_GROUP_NAME_IDX) + "</t>";
[_texta, -0, 0.350, 7, 1,0,txt6Layer] spawn BIS_fnc_dynamicText;

showcinemaborder true;

_pos1 = nil;
_pos2 = nil;
if (_bMoveToAO) then {
	_pos1 = (TRGM_VAR_AOCampPos getPos [(floor(random 100))+50, (floor(random 360))]);
	_pos2 = (TRGM_VAR_AOCampPos getPos [(floor(random 100))+50, (floor(random 360))]);
}
else {
	_pos1 = (player getPos [(floor(random 100))+50, (floor(random 360))]);
	_pos2 = (player getPos [(floor(random 100))+50, (floor(random 360))]);
};
_pos1 = [_pos1 select 0,_pos1 select 1,selectRandom[10,20]];
_pos2 = [_pos2 select 0,_pos2 select 1,selectRandom[10,20]];


private _camera = "camera" camCreate _pos1;
_camera cameraEffect ["internal","back"];

_camera camPreparePos _pos2;
if (_bMoveToAO) then {
	_camera camPrepareTarget TRGM_VAR_AOCampPos;
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

getNumber(configfile >> "CfgMusic" >> TRGM_VAR_NewMissionMusic >> "duration") fadeMusic 0;
[] spawn {
	sleep getNumber(configfile >> "CfgMusic" >> TRGM_VAR_NewMissionMusic >> "duration");
	ace_hearing_disableVolumeUpdate = false;
	playMusic "";
};
sleep 3;


"FinalCleanup" call TRGM_GLOBAL_fnc_log;
call TRGM_SERVER_fnc_finalSetupCleaner;

sleep 2;

if (_bMoveToAO) then {
	//AOCampPos
	if (!isnil "sl") then {
		sl setPos TRGM_VAR_AOCampPos;
		"Moving Players" call TRGM_GLOBAL_fnc_log;
		sleep 1;
		{_x setpos TRGM_VAR_AOCampPos} forEach units group sl;
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

"Mission setup finished!" call TRGM_GLOBAL_fnc_log;
TRGM_VAR_AllInitScriptsFinished = true; publicVariable "TRGM_VAR_AllInitScriptsFinished";

true;