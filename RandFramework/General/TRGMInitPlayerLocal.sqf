#include "..\..\setUnitGlobalVars.sqf";

_actChooseMission = -1;

if (isNil "bAndSoItBegins") then {
	bAndSoItBegins = false;
	publicVariable "bAndSoItBegins";
};

if (isNil "CustomObjectsSet") then {
	CustomObjectsSet = false;
	publicVariable "CustomObjectsSet";
};

if (isNil "IntroMusic") then {
	IntroMusic = selectRandom ThemeAndIntroMusic;
	publicVariable "IntroMusic";
};

if (isNil "FinalMissionStarted") then {
	FinalMissionStarted = false;
	publicVariable "FinalMissionStarted";	
};



	waitUntil {!isNull player};
	waitUntil {player == player};

	sleep 4;


	TREND_fnc_MissionSelectLoop = {
		sleep 3;
		if (!bAndSoItBegins) then {playMusic IntroMusic;};
		while {!bAndSoItBegins} do {

			if (str player == "sl") then {
				if  (!dialog) then {
					[] spawn {
						sleep 1.5;
						if  (!dialog && !bAndSoItBegins) then { //seemed to show dialog twice... so havce added delay and double check its still not showing
							[] execVM "RandFramework\GUI\openDialogMissionSelection.sqf";
							//_actChooseMission = endMissionBoard addaction ["Select Mission Params", "RandFramework\GUI\openDialogMissionSelection.sqf"];
						};
					};
				};
				sleep 0.5;
			}
			else {

				if (isNil "sl") then {
					txt5Layer = "txt5" call BIS_fnc_rscLayer;
			    	_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.8' color='#Ffffff'>" + localize "STR_TRGM2_TRGMInitPlayerLocal_TopSlotMustFilled" + "</t>";
			    	[_texta, -0, 0.150, 7, 1,0,txt5Layer] spawn BIS_fnc_dynamicText;
				}
				else {
					if (!isPlayer sl) then {
						txt5Layer = "txt5" call BIS_fnc_rscLayer;
				    	_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.8' color='#Ffffff'>" + localize "STR_TRGM2_TRGMInitPlayerLocal_TopSlotMustPlayer" + "</t>";
				    	[_texta, -0, 0.150, 7, 1,0,txt5Layer] spawn BIS_fnc_dynamicText;
					}
					else {
						txt1Layer = "txt1" call BIS_fnc_rscLayer;
				    	_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.5' color='#ffffff'>" + localize "STR_TRGM2_TRGMInitPlayerLocal_PleaseWait1" + name sl + " " + localize "STR_TRGM2_TRGMInitPlayerLocal_PleaseWait2" + "</t>";
				    	[_texta, 0, 0.220, 7, 1,0,txt1Layer] spawn BIS_fnc_dynamicText;

						txt5Layer = "txt5" call BIS_fnc_rscLayer;
				    	_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.8' color='#Ffffff'>TRGM 2</t>";
				    	[_texta, -0, 0.150, 7, 1,0,txt5Layer] spawn BIS_fnc_dynamicText;


				    	txt51Layer = "txt51" call BIS_fnc_rscLayer;
				    	_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.5' color='#ffffff'>" + localize "STR_TRGM2_TRGMInitPlayerLocal_CantHearMusic" + "</t>";
				    	[_texta, 0, 0.280, 7, 1,0,txt51Layer] spawn BIS_fnc_dynamicText;

				    };
			    };
			    sleep 5;
			};

		};
	};
	[] spawn TREND_fnc_MissionSelectLoop;



TREND_fnc_BasicInitAndRespawn = {

	if (isMultiplayer) then {
		execVM "RandFramework\NoVoice.sqf";
	};

	iAllowGPS = ("OUT_par_AllowGPS" call BIS_fnc_getParamValue);
	if (iAllowGPS == 0) then {
		showGPS false;
	};

};
[] spawn TREND_fnc_BasicInitAndRespawn;
player addEventHandler ["Respawn", { [] spawn TREND_fnc_BasicInitAndRespawn; }];

waitUntil {bAndSoItBegins && CustomObjectsSet};

endMissionBoard removeAction _actChooseMission;

[player] execVM "RandFramework\setLoadout.sqf";
player addEventHandler ["Respawn", { [player] execVM "RandFramework\setLoadout.sqf"; }];


5 fadeMusic 0;
[] spawn {
	sleep 5;
	ace_hearing_disableVolumeUpdate = false;
	playMusic "";
};


if (isNil "KilledPlayers") then {
	KilledPlayers = [];
	publicVariable "KilledPlayers";
};
if (isNil "KilledPositions") then {
	KilledPositions = [];
	publicVariable "KilledPositions";
};

_iEnableGroupManagement = AdvancedSettings select ADVSET_GROUP_MANAGE_IDX;
if (_iEnableGroupManagement == 1) then {
	["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;//Exec on client
};

if (bUseRevive) then {

	// TcB AIS Wounding System --------------------------------------------------------------------------
	//if (!isDedicated) then {
	//	TCB_AIS_PATH = "ais_injury\";
	//	{[_x] call compile preprocessFile (TCB_AIS_PATH+"init_ais.sqf")} forEach (if (isMultiplayer) then {playableUnits} else {switchableUnits});		// execute for every playable unit
	//};
	// --------------------------------------------------------------------------------------------------------------
};



TREND_fnc_InitPostStarted = {	

	if (side player == civilian) then {
		[] execvm "RandFramework\InitCameraMan.sqf";
	};

	if (iMissionSetup == 5 && isMultiplayer && str player == "sl") then {
			if (SaveType == 0) then {
				laptop1 addaction [localize "STR_TRGM2_TRGMInitPlayerLocal_SaveLocal",{[1,true] execVM "RandFramework\Campaign\ServerSave.sqf";}];
				laptop1 addaction [localize "STR_TRGM2_TRGMInitPlayerLocal_SaveGlobal",{[2,true] execVM "RandFramework\Campaign\ServerSave.sqf";}];
			};
			if (SaveType == 1) then {
				hint (localize "STR_TRGM2_ServerSave_Save1");
				laptop1 addAction [localize "STR_TRGM2_ServerSave_SaveLocal",{hint (localize "STR_TRGM2_ServerSave_SaveHint")}];
			};
			if (SaveType == 2) then {
				hint (localize "STR_TRGM2_ServerSave_Save2");
				laptop1 addAction [localize "STR_TRGM2_ServerSave_SaveGlobal",{hint (localize "STR_TRGM2_ServerSave_SaveHint2")}];
			};
	};
	if (iAllowNVG == 2) then {
		[] execVM "RandFramework\NVscript.sqf";
	};

	endMissionBoard addaction [localize "STR_TRGM2_SetMissionBoardOptions_ShowRepLong", {_justPlayers = allPlayers - entities "HeadlessClient_F";_iPlayerCount = count _justPlayers;_iPointsToAdd = 3 / ((_iPlayerCount / 3) * 1.8);_iPointsToAdd = [_iPointsToAdd,1] call BIS_fnc_cutDecimals;hint parseText format[localize "STR_TRGM2_TRGMInitPlayerLocal_FullReputationReport",_iPointsToAdd,BadPoints, MaxBadPoints, MaxBadPoints - BadPoints, BadPointsReason]}];

	_iSandStormOption = AdvancedSettings select ADVSET_SANDSTORM_IDX;
	if (_iSandStormOption == 3) then { //5 hours non stop
		nul = [18030] execvm "RandFramework\RikoSandStorm\ROSSandstorm.sqf";
	};
};
[] spawn TREND_fnc_InitPostStarted;
player addEventHandler ["Respawn", { [] spawn TREND_fnc_InitPostStarted; }];


if (AdvancedSettings select ADVSET_VIRTUAL_ARSENAL_IDX == 1) then {
	box1 addAction [localize "STR_TRGM2_startInfMission_VirtualArsenal", {["Open",true] spawn BIS_fnc_arsenal}];
};




bCirclesOfDeath = false;
iCirclesOfDeath = 0; //("TREND_par_CirclesOfDeath" call BIS_fnc_getParamValue);
if (iCirclesOfDeath == 1) then {
	bCirclesOfDeath = true;
};

iMissionSetup = iMissionParamType;
if (iMissionSetup == 12 || iMissionSetup == 20) then {
	//training
	[player, 100] call BIS_fnc_respawnTickets;

	if (isClass(configFile >> "CfgPatches" >> "ace_main")) then {
		myaction = ['TraceBulletAction',localize 'STR_TRGM2_TRGMInitPlayerLocal_TraceBullets','',{},{true}] call ace_interact_menu_fnc_createAction;
		[player, 1, ["ACE_SelfActions"], myaction] call ace_interact_menu_fnc_addActionToObject;

		myaction = ['TraceBulletEnable',localize 'STR_TRGM2_TRGMInitPlayerLocal_Enable','',{[player, 5] spawn BIS_fnc_traceBullets;},{true}] call ace_interact_menu_fnc_createAction;
		[player, 1, ["ACE_SelfActions", "TraceBulletAction"], myaction] call ace_interact_menu_fnc_addActionToObject;

		myaction = ['TraceBulletDisable',localize 'STR_TRGM2_TRGMInitPlayerLocal_Disable','',{[player, 0] spawn BIS_fnc_traceBullets;},{true}] call ace_interact_menu_fnc_createAction;
		[player, 1, ["ACE_SelfActions", "TraceBulletAction"], myaction] call ace_interact_menu_fnc_addActionToObject;
	};

}
else {
	_iTicketCount = AdvancedSettings select ADVSET_RESPAWN_TICKET_COUNT_IDX;
	[player, _iTicketCount] call BIS_fnc_respawnTickets;

	_iRespawnTimer = AdvancedSettings select ADVSET_RESPAWN_TIMER_IDX;
	setPlayerRespawnTime _iRespawnTimer;

	//if (iMissionSetup == 5 && !isMultiplayer) then {
	//	[player, 999] call BIS_fnc_respawnTickets;
	//	debugMessages = debugMessages + "\n" + "999 respawn tickets"
	//}
	//else {
	//	[player, 1] call BIS_fnc_respawnTickets;
	//};
};


TREND_fnc_GetAnimalsMoving = {
	[] execVM "RandFramework\animateAnimals.sqf";
};
[] spawn TREND_fnc_GetAnimalsMoving;
player addEventHandler ["Respawn", { [] spawn TREND_fnc_GetAnimalsMoving; }];

//[player, supReq] call BIS_fnc_addSupportLink;

TREND_fnc_GeneralPlayerLoop = {
	while {true} do {

		if (side player != civilian) then {
			if (count ObjectivePossitions > 0 && AllowUAVLocateHelp) then {
				if ((Player distance (ObjectivePossitions select 0)) < 25) then {
					if ((Player getVariable ["calUAVActionID", -1]) == -1) then {
						hint (localize "STR_TRGM2_TRGMInitPlayerLocal_UAVAvailable");
						_actionID = player addAction [localize "STR_TRGM2_TRGMInitPlayerLocal_CallUAV","RandFramework\callUAVFindObjective.sqf"];
						player setVariable ["calUAVActionID",_actionID];
					};
				};
				//else {
				//	if ((Player getVariable ["calUAVActionID", -1]) != -1) then {
				//		player removeAction (Player getVariable ["calUAVActionID", -1]);
				//		player setVariable ["calUAVActionID", nil];
				//		hint "UAV no longer available";
				//	};
				//};
			};

			if (leader (group (vehicle player)) == player && AdvancedSettings select ADVSET_SUPPORT_OPTION_IDX == 1) then {
				if (iMissionSetup == 5) then {
					if (isNil "CampaignInitiated") then {
						CampaignInitiated = false;
						publicVariable "CampaignInitiated";
					};
					if (CampaignInitiated) then {

						_dCurrentRep = [MaxBadPoints - BadPoints,1] call BIS_fnc_cutDecimals;
						//TESTTEST = format["A:%1 - B:%2 - C:%3",MaxBadPoints,BadPoints,_dCurrentRep];
						//hint TESTTEST;
						if (_dCurrentRep >= 1) then {
							//hint "hmm2";
							[player, supReqSupply] call BIS_fnc_addSupportLink;
							sleep 1;
						};
						if (_dCurrentRep >= 3) then {
							//hint "hmm2";
							[player, supReq] call BIS_fnc_addSupportLink;
							sleep 1;
						};
						if (_dCurrentRep >= 7) then {
							//hint "hmm3";
							[player, supReqAir] call BIS_fnc_addSupportLink;
							sleep 1;
						};
					};
				}
				else {
					[player, supReqSupply] call BIS_fnc_addSupportLink;
					sleep 1;
					[player, supReq] call BIS_fnc_addSupportLink;
					sleep 1;
					[player, supReqAir] call BIS_fnc_addSupportLink;
					sleep 1;
				}
			};
		};
		sleep 10;
	};
};
[] spawn TREND_fnc_GeneralPlayerLoop;
player addEventHandler ["Respawn", { [] spawn TREND_fnc_GeneralPlayerLoop; }];



TREND_fnc_OnlyAllowDirectMapDraw = {
	while {isMultiplayer && (AdvancedSettings select ADVSET_MAP_DRAW_DIRECT_ONLY_IDX == 1)} do {
		{
			//WaitUntil {count allMapMarkers > 0};
	   		_sTest = _x splitString "/";
			if (count _sTest > 2) then {
		 		if (str(_sTest select 2) != str("5")) then {
					deleteMarker _x;
				};
			};
		} forEach allMapMarkers;
	};
};
[] spawn TREND_fnc_OnlyAllowDirectMapDraw;
player addEventHandler ["Respawn", { [] spawn TREND_fnc_OnlyAllowDirectMapDraw; }];

TREND_fnc_InSafeZone = {
	if (isNil "PlayersHaveLeftStartingArea") then {
			PlayersHaveLeftStartingArea = false;
			publicVariable "PlayersHaveLeftStartingArea";
	};

	while {true} do {
		if (getMarkerPos "mrkHQ" distance player < PunishmentRadius) then {
			//if (!bDebugMode) then { player allowDamage false};
		}
		else {
			//if (!bDebugMode) then { player allowDamage true;};
			PlayersHaveLeftStartingArea = true;
			publicVariable "PlayersHaveLeftStartingArea";
		};
		sleep 1;
	};
};
[] spawn TREND_fnc_InSafeZone;
player addEventHandler ["Respawn", { [] spawn TREND_fnc_InSafeZone; }];


TREND_fnc_setNVG = {
	if (iAllowNVG == 0) then {
			 player addPrimaryWeaponItem "acc_flashlight";
			 player enableGunLights "forceOn";
			 player unassignItem sFriendlyNVClassName;
			 player removeItem sFriendlyNVClassName;
	};
};
[] spawn TREND_fnc_setNVG;
player addEventHandler ["Respawn", { [] spawn TREND_fnc_setNVG; }];













if (bCirclesOfDeath) then {

	TREND_fnc_checkKilledRange = {
		//loop here, sleep 5 (doesnt need to be too fast looping!!)
		while {true} do {
			if (getPlayerUID player in KilledPlayers && (vehicle player == player) && alive(player)) then {
				{
					if (getPlayerUID player == _x select 0) then {
						//_forEachIndex
						if (player distance (_x select 1) < KilledZoneRadius) then {
							hint (localize "STR_TRGM2_TRGMInitPlayerLocal_WarningArea");
							if (player distance (_x select 1) < KilledZoneInnerRadius) then {
								cutText [localize "STR_TRGM2_TRGMInitPlayerLocal_Transfering","BLACK FADED", 0];
								sleep 1;
								player setPos (getMarkerPos "respawn_west");
							};
						};
					};
				} forEach KilledPositions;
			};
			sleep 5;
		};
	};
	[] spawn TREND_fnc_checkKilledRange;
	player addEventHandler ["Respawn", { [] spawn TREND_fnc_checkKilledRange; }];



	TREND_fnc_drawKilledRanges = {
		if (getPlayerUID player in KilledPlayers) then {
			{
				if (getPlayerUID player == KilledPlayers select _forEachIndex) then {
					//draw marker at KilledPositions select _forEachIndex
					_color = "ColorBlack";
					_mrkPos = createMarkerLocal [format["mrkNoGoA%1",_forEachIndex], _x select 1];
					_mrkPos setMarkerShapeLocal "ELLIPSE";
					_mrkPos setMarkerSizeLocal [KilledZoneRadius,KilledZoneRadius];
					_mrkPos setMarkerColorLocal "ColorRed";
					_mrkPos setMarkerAlphaLocal 0.5;

					_mrkPos2 = createMarkerLocal [format["mrkNoGoB%1",_forEachIndex], _x select 1];
					_mrkPos2 setMarkerShapeLocal "ELLIPSE";
					_mrkPos2 setMarkerSizeLocal [KilledZoneInnerRadius,KilledZoneInnerRadius];
					_mrkPos2 setMarkerColorLocal _color;
					_mrkPos2 setMarkerAlphaLocal 0.5;
				};

			} forEach KilledPositions;
		};

	};
	[] spawn TREND_fnc_drawKilledRanges;
	player addEventHandler ["Respawn", { [] spawn TREND_fnc_drawKilledRanges; }];

};
















TOUR_fnc_startingMove = {
	private ["_unit","_move"];
	_unit = [_this,0,objNull,[objNull]] call BIS_fnc_param;
	_move = [_this,1,"AmovPercMstpSlowWrflDnon",[""]] call BIS_fnc_param;
	if !(isNull _unit) then
	{
		_unit switchMove _move;
	};
};

////INSTANT FADE TO BLACK SCREEN
cutText ["","BLACK FADED",1];

////CREATE CAMERA
private ["_cam"];
_cam = "camera" camCreate (getPosATL player);
_cam cameraEffect ["External","BACK"];

////WAIT FOR BRIEFING TO END
sleep 0.1;
doStop player;

////INITIATE ANIMATION OVER NETWORK
[[player],"TOUR_fnc_startingMove",true] spawn BIS_fnc_MP;

////WAIT A SECOND
sleep 1;

////DESTROY CAMERA
_cam cameraEffect ["Terminate", "BACK"];
_cam camCommit 0;
waitUntil { camCommitted _cam };
camDestroy _cam;

////FADE IN FROM BLACK SCREEN
cutText ["","BLACK IN",3];


//sleep 0.1;
//doStop player;
//waitUntil {!isNull player};
//waitUntil {player == player};
//[[player],"TOUR_fnc_startingMove",true] spawn BIS_fnc_MP;



if (sArmaGroup == "TCF" && isMultiplayer) then {
	//_handle=createdialog "DialogMessAround";
	//titleText ["!!!WARNING!!!\n\nPoint system in place\n\nDO NOT mess around at base\n\nONLY fly if you know AFM, or are being trained.\n\nDestroying vehicles will mark points and ruin the experience for others!!!", "PLAIN"];
};


TREND_fnc_MissionOverAnimation = {
	sleep 60;
	_bEnd = false;
	while {!_bEnd} do {
		_bMissionEndedAndPlayersOutOfAO = false;
		_bMissionEnded = false;
		_bAnyPlayersInAOAndAlive = false;

		if (iMissionSetup == 5) then {
			_dCurrentRep = [MaxBadPoints - BadPoints,1] call BIS_fnc_cutDecimals;
			if (ActiveTasks call FHQ_TT_areTasksCompleted && _dCurrentRep >= 10 && FinalMissionStarted) then {_bMissionEnded = true};
		}
		else {
			if (ActiveTasks call FHQ_TT_areTasksCompleted) then {_bMissionEnded = true};
		};

		_justPlayers = allPlayers - entities "HeadlessClient_F";
		{
			_currentPlayer = _x;
			{
				if (alive(_currentPlayer) && _currentPlayer distance _x < 2000) then {
					_bAnyPlayersInAOAndAlive = true;
				};
			} forEach ObjectivePossitions;
		} forEach _justPlayers;
		if (_bMissionEnded && !_bAnyPlayersInAOAndAlive) then {_bMissionEndedAndPlayersOutOfAO = true};
		if (_bMissionEndedAndPlayersOutOfAO) then {
			_bEnd = true;
			ace_hearing_disableVolumeUpdate = true;
			2 fadeSound 0.1;
			playMusic "";
			0 fadeMusic 1;
			playMusic selectRandom ThemeAndIntroMusic;
			sleep 8;
			["<t font='PuristaMedium' align='center' size='2.9' color='#ffffff'>TRGM 2</t><br/><t font='PuristaMedium' align='center' size='1' color='#ffffff'>" + localize "STR_TRGM2_TRGMInitPlayerLocal_TRGM2Title" + "</t>",-1,0.2,6,1,0,789] spawn BIS_fnc_dynamicText;
			sleep 10;
			["<t font='PuristaMedium' align='center' size='2.9' color='#ffffff'>" + (AdvancedSettings select ADVSET_GROUP_NAME_IDX) + "</t><br/><t font='PuristaMedium' align='center' size='1' color='#ffffff'><br />" + localize "STR_TRGM2_TRGMInitPlayerLocal_RTBDebreif" + "</t>",-1,0.2,6,1,0,789] spawn BIS_fnc_dynamicText;
			sleep 10;
			_stars = "";
			_iCount = 0;
			{
				_iCount = _iCount + 1;
				if (_iCount == count allPlayers) then {
					_stars = _stars + name _x; // format [_stars,name _x, "|%2"];
				}
				else {
					_stars = _stars + name _x + " | "; // format [_stars,name _x, "|%2"];
				};
			} forEach allPlayers;
			[format ["<t font='PuristaMedium' align='center' size='2.9' color='#ffffff'>Starring</t><br/><t font='PuristaMedium' align='center' size='1' color='#ffffff'><br />%1</t>",_stars],-1,0.2,6,1,0,789] spawn BIS_fnc_dynamicText;

			sleep 10;
			8 fadeMusic 0;
			8 fadeSound 1;
			[] spawn {
				sleep 8;
				ace_hearing_disableVolumeUpdate = false;
				playMusic "";
			};
		};
		sleep 5;
	};
};
[] spawn TREND_fnc_MissionOverAnimation;
player addEventHandler ["Respawn", { [] spawn TREND_fnc_MissionOverAnimation; }];





