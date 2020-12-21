"Initplayerlocal.sqf" call TREND_fnc_log;
call TREND_fnc_initGlobalVars;

_actChooseMission = -1;

CODEINPUT = [];

waitUntil {!isNull player};
waitUntil {player == player};

sleep 5;

_isAdmin = (!isMultiplayer || isMultiplayer && !isDedicated && isServer || isMultiplayer && !isServer && (call BIS_fnc_admin) != 0);
if (_isAdmin && isNull TREND_AdminPlayer) then {
	TREND_AdminPlayer = player; publicVariable "TREND_AdminPlayer";
};

sleep 5;

if (!TREND_NeededObjectsAvailable) then {
	player allowDamage false;
	[player] spawn TREND_fnc_findValidHQPosition;

	waitUntil { sleep 10; TREND_NeededObjectsAvailable; };
};

showCinemaBorder  true;

_centerPos = getArray (configfile >> "CfgWorlds" >> worldName >> "centerPosition");
if !(isNil "TREND_CustomCenterPos") then {
	_centerPos = TREND_CustomCenterPos;
};

_pos1 = (_centerPos getPos [(floor(random 5000))+50, (floor(random 360))]);
_pos2 = (_centerPos getPos [(floor(random 5000))+50, (floor(random 360))]);
_pos1 = [_pos1 select 0,_pos1 select 1,selectRandom[200,300]];
_pos2 = [_pos2 select 0,_pos2 select 1,selectRandom[200,300]];
_camera = "camera" camCreate _pos1;
_camera cameraEffect ["internal","back"];
_camera camPreparePos _pos2;
_camera camPrepareTarget _centerPos;
_camera camPrepareFOV 0.4;
_camera camCommitPrepared 600;

TREND_fnc_MissionSelectLoop = {
	"TREND_fnc_MissionSelectLoop called" call TREND_fnc_log;
	sleep 3;
	playMusic TREND_IntroMusic;
	[format["SelectLoop Music: %1", TREND_IntroMusic ], true] call TREND_fnc_log;

	while {!TREND_bAndSoItBegins} do {

		if ((!isNull TREND_AdminPlayer && str player isEqualTo "sl") || (TREND_AdminPlayer isEqualTo player)) then {
			if (!dialog) then {
				sleep 1.5;
				if  (!dialog && !TREND_bOptionsSet) then { //seemed to show dialog twice... so havce added delay and double check its still not showing
					[] spawn TREND_fnc_openDialogMissionSelection;
				};
			};
			sleep 0.5;
		} else {
			if (!TREND_bOptionsSet && {!(TREND_AdminPlayer isEqualTo player)}) then {
				txt1Layer = "txt1" call BIS_fnc_rscLayer;
				_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.5' color='#ffffff'>" + localize "STR_TRGM2_TRGMInitPlayerLocal_PleaseWait1 Admin " + localize "STR_TRGM2_TRGMInitPlayerLocal_PleaseWait2" + "</t>";
				[_texta, 0, 0.220, 7, 1,0,txt1Layer] spawn BIS_fnc_dynamicText;
			} else {
				if (isNil "sl" && !isNull TREND_AdminPlayer) then {
					txt5Layer = "txt5" call BIS_fnc_rscLayer;
					_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.8' color='#Ffffff'>" + localize "STR_TRGM2_TRGMInitPlayerLocal_TopSlotMustFilled" + "</t>";
					[_texta, -0, 0.150, 7, 1,0,txt5Layer] spawn BIS_fnc_dynamicText;
				} else {
					if (!isPlayer sl && !isNull TREND_AdminPlayer) then {
						txt5Layer = "txt5" call BIS_fnc_rscLayer;
						_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.8' color='#Ffffff'>" + localize "STR_TRGM2_TRGMInitPlayerLocal_TopSlotMustPlayer" + "</t>";
						[_texta, -0, 0.150, 7, 1,0,txt5Layer] spawn BIS_fnc_dynamicText;
					} else {
						txt1Layer = "txt1" call BIS_fnc_rscLayer;
						_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.5' color='#ffffff'>" + localize "STR_TRGM2_TRGMInitPlayerLocal_PleaseWait1 Admin " + localize "STR_TRGM2_TRGMInitPlayerLocal_PleaseWait3" + "</t>";
						[_texta, 0, 0.220, 7, 1,0,txt1Layer] spawn BIS_fnc_dynamicText;
					};
				};
			};
		};
		sleep 5;
	};
	waitUntil {sleep 2; TREND_bOptionsSet};

	txt5Layer = "txt5" call BIS_fnc_rscLayer;
	_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.8' color='#Ffffff'>TRGM 2</t>";
	[_texta, -0, 0.150, 7, 1,0,txt5Layer] spawn BIS_fnc_dynamicText;


	txt51Layer = "txt51" call BIS_fnc_rscLayer;
	_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.5' color='#ffffff'>" + localize "STR_TRGM2_TRGMInitPlayerLocal_CantHearMusic" + "</t>";
	[_texta, 0, 0.280, 7, 1,0,txt51Layer] spawn BIS_fnc_dynamicText;
};
[] spawn TREND_fnc_MissionSelectLoop;

waitUntil {sleep 2; TREND_bOptionsSet};
// titleText [localize "STR_TRGM2_mainInit_Loading", "BLACK FADED"];
_camera cameraEffect ["Terminate","back"];
[format["Mission Core: %1", "CameraTerminated"], true] call TREND_fnc_log;
sleep 3;

if (!isDedicated && {(!isNull TREND_AdminPlayer && str player isEqualTo "sl") || (TREND_AdminPlayer isEqualTo player)}) then {
	if (TREND_iMissionParamType != 5) then {	//if isCampaign, dont allow to select AO
		if (call TREND_manualAOPlacement) then {
			mrkAoSelect1 = nil;
			mrkAoSelect2 = nil;
			mrkAoSelect3 = nil;
			titleText[localize "STR_TRGM2_tele_SelectPositionAO1", "PLAIN"];
			openMap true;
			onMapSingleClick "TREND_Mission1Loc = _pos; publicVariable 'TREND_Mission1Loc'; openMap false; onMapSingleClick ''; true;";
			sleep 1;
			waitUntil {sleep 1; !visibleMap};
			if (!isNil "TREND_Mission1Loc") then {
				["mrkAoSelect1",  TREND_Mission1Loc, "ICON", "ColorRed", [1,1], "AO 1"] call AIS_Core_fnc_createLocalMarker;
			};

			if (TREND_iMissionParamType isEqualTo 0 || TREND_iMissionParamType isEqualTo 4 || TREND_iMissionParamType isEqualTo 11) then {
				titleText[localize "STR_TRGM2_tele_SelectPositionAO2", "PLAIN"];
				openMap true;
				onMapSingleClick "TREND_Mission2Loc = _pos; publicVariable 'TREND_Mission2Loc'; openMap false; onMapSingleClick ''; true;";
				sleep 1;
				waitUntil {sleep 1; !visibleMap};
				if (!isNil "TREND_Mission2Loc") then {
					["mrkAoSelect2",  TREND_Mission2Loc, "ICON", "ColorRed", [1,1], "AO 2"] call AIS_Core_fnc_createLocalMarker;
				};

				titleText[localize "STR_TRGM2_tele_SelectPositionAO3", "PLAIN"];
				openMap true;
				onMapSingleClick "TREND_Mission3Loc = _pos; publicVariable 'TREND_Mission3Loc'; openMap false; onMapSingleClick ''; true;";
				sleep 1;
				waitUntil {sleep 1; !visibleMap};
				if (!isNil "TREND_Mission3Loc") then {
					["mrkAoSelect2",  TREND_Mission3Loc, "ICON", "ColorRed", [1,1], "AO 2"] call AIS_Core_fnc_createLocalMarker;
				};
			};

			if (getMarkerColor "mrkAoSelect1" != "") then {deleteMarker "mrkAoSelect1";};
			if (getMarkerColor "mrkAoSelect2" != "") then {deleteMarker "mrkAoSelect2";};
			if (getMarkerColor "mrkAoSelect3" != "") then {deleteMarker "mrkAoSelect3";};
		};

		if (call TREND_manualCampPlacement) then {
			titleText[localize "STR_TRGM2_tele_SelectPosition_AO_Camp", "PLAIN"];
			openMap true;
			onMapSingleClick "TREND_AOCampLocation = _pos; publicVariable 'TREND_AOCampLocation'; openMap false; onMapSingleClick ''; true;";
			sleep 1;
			waitUntil {sleep 1; !visibleMap};
		};


	};
	TREND_bAndSoItBegins = true; publicVariable "TREND_bAndSoItBegins";
};

// TREND_fnc_BasicInitAndRespawn = {
// 	"TREND_fnc_BasicInitAndRespawn called" call TREND_fnc_log;

// 	if (isMultiplayer) then
// 	{
// 		waitUntil {!(isNull (findDisplay 46))};

// 		player setspeaker "NoVoice";
// 		//ShowRad = showRadio false;
// 		//EnabRad = enableRadio false;
// 		player disableConversation true;

// 		player addEventHandler
// 		[
// 		"respawn",
// 			{
// 			player setspeaker "NoVoice";
// 			//ShowRad = showRadio false;
// 			//EnabRad = enableRadio false;
// 			player disableConversation true
// 			}
// 		];
// 	};

// 	TREND_iAllowGPS = ("OUT_par_AllowGPS" call BIS_fnc_getParamValue);
// 	if (TREND_iAllowGPS == 0) then {
// 		showGPS false;
// 	};

// };
// [] spawn TREND_fnc_BasicInitAndRespawn;
// player addEventHandler ["Respawn", { [] spawn TREND_fnc_BasicInitAndRespawn; }];

waitUntil {sleep 2; TREND_bAndSoItBegins && TREND_CustomObjectsSet};

removeAllActions endMissionBoard;
removeAllActions endMissionBoard2;

[player] spawn TREND_fnc_setLoadout;

_isAceRespawnWithGear = false;
if (call TREND_fnc_isCbaLoaded) then {
	 // check for ACE respawn with gear setting
   _isAceRespawnWithGear = "ace_respawn_savePreDeathGear" call CBA_settings_fnc_get;
};
if (!isNil("_isAceRespawnWithGear")) then {
	if (!_isAceRespawnWithGear) then {
		player addEventHandler ["Respawn", { [player] spawn TREND_fnc_setLoadout; }];
	};
};

5 fadeMusic 0;
[] spawn {
	sleep 5;
	ace_hearing_disableVolumeUpdate = false;
	playMusic "";
};

_iEnableGroupManagement = TREND_AdvancedSettings select TREND_ADVSET_GROUP_MANAGE_IDX;
if (_iEnableGroupManagement == 1) then {
	["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;//Exec on client
};

// if (TREND_bUseRevive) then {

// 	// TcB AIS Wounding System --------------------------------------------------------------------------
// 	//if (!isDedicated) then {
// 	//	TCB_AIS_PATH = "ais_injury\";
// 	//	{[_x] call compile preprocessFile (TCB_AIS_PATH+"init_ais.sqf")} forEach (if (isMultiplayer) then {playableUnits} else {switchableUnits});		// execute for every playable unit
// 	//};
// 	// --------------------------------------------------------------------------------------------------------------
// };

TREND_fnc_InitPostStarted = {
	"TREND_fnc_InitPostStarted called" call TREND_fnc_log;

	if (side player == civilian) then {

		0 enableChannel false;
		1 enableChannel false;
		2 enableChannel false;
		3 enableChannel false;
		4 enableChannel false;
		5 enableChannel false;

		//hint "CC";

		//player removeAllActions;

		player setVariable ["tf_unable_to_use_radio", true];
		player setVariable ["tf_globalVolume", 0];

		player addEventHandler ["GetInMan",{player action ["Eject",vehicle player];}];

		[player, true] remoteExec ["hideObjectGlobal", 2];

		player addaction ["tele",{titleText[localize "STR_TRGM2_tele_SelectPosition", "PLAIN"]; onMapSingleClick "vehicle player setPos _pos; onMapSingleClick '';true;";}];
		player addaction ["Toggle Fast Run",{
			_bCurrentFastRun = player getVariable ["fastRun",false];
			player setVariable ["fastRun",!_bCurrentFastRun];
		}];

		[player, true] remoteExec ["hideObjectGlobal", 2];
		while {(alive(player))} do
		{
			//hint format["speed:%1",speed player];
			player enableFatigue false;
			player enableStamina false;
			removeAllWeapons player;

			if (speed player > 16) then {
				//hint "test2";
				if (player getVariable ["fastRun",false]) then {
					player setAnimSpeedCoef 6;
					player allowDamage false;
					sleep 0.4;
				};
			}
			else {
				player setAnimSpeedCoef 1;
				player allowDamage false;
				sleep 0.4;
			};
		};

	};

	if (TREND_iMissionSetup == 5 && isMultiplayer && str player == "sl") then {
			if (TREND_SaveType == 0) then {
				laptop1 addaction [localize "STR_TRGM2_TRGMInitPlayerLocal_SaveLocal",{[1,true] spawn TREND_fnc_ServerSave;}];
				laptop1 addaction [localize "STR_TRGM2_TRGMInitPlayerLocal_SaveGlobal",{[2,true] spawn TREND_fnc_ServerSave;}];
			};
			if (TREND_SaveType == 1) then {
				hint (localize "STR_TRGM2_ServerSave_Save1");
				laptop1 addAction [localize "STR_TRGM2_ServerSave_SaveLocal",{hint (localize "STR_TRGM2_ServerSave_SaveHint")}];
			};
			if (TREND_SaveType == 2) then {
				hint (localize "STR_TRGM2_ServerSave_Save2");
				laptop1 addAction [localize "STR_TRGM2_ServerSave_SaveGlobal",{hint (localize "STR_TRGM2_ServerSave_SaveHint2")}];
			};
	};
	if (TREND_iAllowNVG == 2) then {
		call TREND_fnc_NVscript;
	};

	endMissionBoard addaction [localize "STR_TRGM2_SetMissionBoardOptions_ShowRepLong", {[true] spawn TREND_fnc_ShowRepReport;}];

	_trg = createTrigger["EmptyDetector", getPos player];
	_trg setTriggerActivation["ALPHA", "PRESENT", true];
	_trg setTriggerText "illuminate your position for 5 mins (eta 60 seconds)";
	_trg setTriggerStatements["this", "[player] spawn TREND_fnc_fireIllumFlares;", ""];

	// I don't know if this is required anymore since MainInit remoteExec's this...
	// _iSandStormOption = [2, call TREND_sandStormOption] select (call TREND_WeatherOption < 11);
	// if (_iSandStormOption == 3) then { //5 hours non stop
	// 	nul = [18030,false] execVM "RandFramework\RikoSandStorm\ROSSandstorm.sqf";
	// };
};
[] spawn TREND_fnc_InitPostStarted;
player addEventHandler ["Respawn", { [] spawn TREND_fnc_InitPostStarted; }];


if (TREND_AdvancedSettings select TREND_ADVSET_VIRTUAL_ARSENAL_IDX == 1) then {
	box1 addAction [localize "STR_TRGM2_startInfMission_VirtualArsenal", {["Open",true] spawn BIS_fnc_arsenal}];
};

TREND_bCirclesOfDeath = false;
TREND_iCirclesOfDeath = 0; //("TREND_par_CirclesOfDeath" call BIS_fnc_getParamValue);
if (TREND_iCirclesOfDeath == 1) then {
	TREND_bCirclesOfDeath = true;
};

TREND_iMissionSetup = TREND_iMissionParamType;
if (TREND_iMissionSetup == 12 || TREND_iMissionSetup == 20) then {
	//training
	[player, 100] call BIS_fnc_respawnTickets;

	if (call TREND_fnc_isAceLoaded) then {
		myaction = ['TraceBulletAction',localize 'STR_TRGM2_TRGMInitPlayerLocal_TraceBullets','',{},{true}] call ace_interact_menu_fnc_createAction;
		[player, 1, ["ACE_SelfActions"], myaction] call ace_interact_menu_fnc_addActionToObject;

		myaction = ['TraceBulletEnable',localize 'STR_TRGM2_TRGMInitPlayerLocal_Enable','',{[player, 5] spawn BIS_fnc_traceBullets;},{true}] call ace_interact_menu_fnc_createAction;
		[player, 1, ["ACE_SelfActions", "TraceBulletAction"], myaction] call ace_interact_menu_fnc_addActionToObject;

		myaction = ['TraceBulletDisable',localize 'STR_TRGM2_TRGMInitPlayerLocal_Disable','',{[player, 0] spawn BIS_fnc_traceBullets;},{true}] call ace_interact_menu_fnc_createAction;
		[player, 1, ["ACE_SelfActions", "TraceBulletAction"], myaction] call ace_interact_menu_fnc_addActionToObject;
	};

}
else {
	_iTicketCount = TREND_AdvancedSettings select TREND_ADVSET_RESPAWN_TICKET_COUNT_IDX;
	[player, _iTicketCount] call BIS_fnc_respawnTickets;

	_iRespawnTimer = TREND_AdvancedSettings select TREND_ADVSET_RESPAWN_TIMER_IDX;
	setPlayerRespawnTime _iRespawnTimer;

	//if (TREND_iMissionSetup == 5 && !isMultiplayer) then {
	//	[player, 999] call BIS_fnc_respawnTickets;
	//	TREND_debugMessages = TREND_debugMessages + "\n" + "999 respawn tickets"
	//}
	//else {
	//	[player, 1] call BIS_fnc_respawnTickets;
	//};
};


[] spawn TREND_fnc_animateAnimals;
player addEventHandler ["Respawn", { [] spawn TREND_fnc_animateAnimals; }];

TREND_fnc_GeneralPlayerLoop = {
	"TREND_fnc_GeneralPlayerLoop called" call TREND_fnc_log;
	while {true} do {
		if (side player != civilian) then {
			if (count TREND_ObjectivePossitions > 0 && TREND_AllowUAVLocateHelp) then {
				if ((Player distance (TREND_ObjectivePossitions select 0)) < 25) then {
					if ((Player getVariable ["calUAVActionID", -1]) == -1) then {
						hint (localize "STR_TRGM2_TRGMInitPlayerLocal_UAVAvailable");
						_actionID = player addAction [localize "STR_TRGM2_TRGMInitPlayerLocal_CallUAV",{[] spawn TREND_fnc_callUAVFindObjective}];
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
			if (leader (group (vehicle player)) == player && TREND_AdvancedSettings select TREND_ADVSET_SUPPORT_OPTION_IDX == 1) then {
				if (TREND_iMissionSetup == 5) then {
					if (TREND_CampaignInitiated) then {

						_dCurrentRep = [TREND_MaxBadPoints - TREND_BadPoints,1] call BIS_fnc_cutDecimals;
						//TESTTEST = format["A:%1 - B:%2 - C:%3",TREND_MaxBadPoints,TREND_BadPoints,_dCurrentRep];
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
	"TREND_fnc_OnlyAllowDirectMapDraw called" call TREND_fnc_log;
	while {isMultiplayer && (TREND_AdvancedSettings select TREND_ADVSET_MAP_DRAW_DIRECT_ONLY_IDX == 1)} do {
		{
			//WaitUntil {count allMapMarkers > 0};
	   		_sTest = _x splitString "/";
			if (count _sTest > 2) then {
		 		if (str(_sTest select 2) != str("5")) then {
					deleteMarker _x;
				};
			};
		} forEach allMapMarkers;
		sleep 1;
	};
};
[] spawn TREND_fnc_OnlyAllowDirectMapDraw;
player addEventHandler ["Respawn", { [] spawn TREND_fnc_OnlyAllowDirectMapDraw; }];

TREND_fnc_InSafeZone = {
	"TREND_fnc_InSafeZone called" call TREND_fnc_log;
	while {true} do {
		if (getMarkerPos "mrkHQ" distance player < TREND_PunishmentRadius) then {
			//if (!TREND_bDebugMode) then { player allowDamage false};
		}
		else {
			//if (!TREND_bDebugMode) then { player allowDamage true;};
			TREND_PlayersHaveLeftStartingArea =  true; publicVariable "TREND_PlayersHaveLeftStartingArea";
		};
		sleep 1;
	};
};
[] spawn TREND_fnc_InSafeZone;
player addEventHandler ["Respawn", { [] spawn TREND_fnc_InSafeZone; }];


TREND_fnc_setNVG = {
	"TREND_fnc_setNVG called" call TREND_fnc_log;
	if (TREND_iAllowNVG == 0) then {
		player addPrimaryWeaponItem "acc_flashlight";
		player enableGunLights "forceOn";
		{player unassignItem _x; player removeItem _x;} forEach TREND_aNVClassNames;
	};
};
[] spawn TREND_fnc_setNVG;
player addEventHandler ["Respawn", { [] spawn TREND_fnc_setNVG; }];

if (TREND_bCirclesOfDeath) then {

	TREND_fnc_checkKilledRange = {
		"TREND_fnc_checkKilledRange called" call TREND_fnc_log;
		//loop here, sleep 5 (doesnt need to be too fast looping!!)
		while {true} do {
			if (getPlayerUID player in TREND_KilledPlayers && (vehicle player == player) && alive(player)) then {
				{
					if (getPlayerUID player == _x select 0) then {
						//_forEachIndex
						if (player distance (_x select 1) < TREND_KilledZoneRadius) then {
							hint (localize "STR_TRGM2_TRGMInitPlayerLocal_WarningArea");
							if (player distance (_x select 1) < TREND_KilledZoneInnerRadius) then {
								cutText [localize "STR_TRGM2_TRGMInitPlayerLocal_Transfering","BLACK FADED", 0];
								sleep 1;
								player setPos [(getMarkerPos "respawn_west"), (getMarkerPos "respawn_west_HQ")] select (isNil "respawn_west");
							};
						};
					};
				} forEach TREND_KilledPositions;
			};
			sleep 5;
		};
	};
	[] spawn TREND_fnc_checkKilledRange;
	player addEventHandler ["Respawn", { [] spawn TREND_fnc_checkKilledRange; }];



	TREND_fnc_drawKilledRanges = {
		"TREND_fnc_drawKilledRanges called" call TREND_fnc_log;
		if (getPlayerUID player in TREND_KilledPlayers) then {
			{
				if (getPlayerUID player == TREND_KilledPlayers select _forEachIndex) then {
					//draw marker at TREND_KilledPositions select _forEachIndex
					_color = "ColorBlack";
					_mrkPos = createMarkerLocal [format["mrkNoGoA%1",_forEachIndex], _x select 1];
					_mrkPos setMarkerShapeLocal "ELLIPSE";
					_mrkPos setMarkerSizeLocal [TREND_KilledZoneRadius,TREND_KilledZoneRadius];
					_mrkPos setMarkerColorLocal "ColorRed";
					_mrkPos setMarkerAlphaLocal 0.5;

					_mrkPos2 = createMarkerLocal [format["mrkNoGoB%1",_forEachIndex], _x select 1];
					_mrkPos2 setMarkerShapeLocal "ELLIPSE";
					_mrkPos2 setMarkerSizeLocal [TREND_KilledZoneInnerRadius,TREND_KilledZoneInnerRadius];
					_mrkPos2 setMarkerColorLocal _color;
					_mrkPos2 setMarkerAlphaLocal 0.5;
				};

			} forEach TREND_KilledPositions;
		};

	};
	[] spawn TREND_fnc_drawKilledRanges;
	player addEventHandler ["Respawn", { [] spawn TREND_fnc_drawKilledRanges; }];

};

TOUR_fnc_startingMove = {
	private ["_unit","_move"];
	"TOUR_fnc_startingMove called" call TREND_fnc_log;
	_unit = [_this,0,objNull,[objNull]] call BIS_fnc_param;
	_move = [_this,1,"AmovPercMstpSlowWrflDnon",[""]] call BIS_fnc_param;
	if !(isNull _unit) then
	{
		_unit switchMove _move;
	};
};


TREND_fnc_introCamera = {
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
	[[],{player spawn TOUR_fnc_startingMove;}] remoteExec ["call", 0, true];

	////WAIT A SECOND
	sleep 1;

	////DESTROY CAMERA
	_cam cameraEffect ["Terminate", "BACK"];
	_cam camCommit 0;
	waitUntil { camCommitted _cam };
	camDestroy _cam;

	////FADE IN FROM BLACK SCREEN
	cutText ["","BLACK IN",3];
};
[] spawn TREND_fnc_introCamera;

// if (TREND_sArmaGroup == "TCF" && isMultiplayer) then {
// 	//_handle=createdialog "DialogMessAround";
// 	//titleText ["!!!WARNING!!!\n\nPoint system in place\n\nDO NOT mess around at base\n\nONLY fly if you know AFM, or are being trained.\n\nDestroying vehicles will mark points and ruin the experience for others!!!", "PLAIN"];
// };


TREND_fnc_MissionOverAnimation = {
	"TREND_fnc_MissionOverAnimation called" call TREND_fnc_log;
	sleep 60;
	_bEnd = false;
	while {!_bEnd} do {
		_bMissionEndedAndPlayersOutOfAO = false;
		_bMissionEnded = false;
		_bAnyPlayersInAOAndAlive = false;

		if (TREND_iMissionSetup == 5) then {
			_dCurrentRep = [TREND_MaxBadPoints - TREND_BadPoints,1] call BIS_fnc_cutDecimals;
			if (TREND_ActiveTasks call FHQ_fnc_ttAreTasksCompleted && _dCurrentRep >= 10 && TREND_FinalMissionStarted) then {_bMissionEnded = true};
		}
		else {
			if (TREND_ActiveTasks call FHQ_fnc_ttAreTasksCompleted) then {_bMissionEnded = true};
		};

		_justPlayers = allPlayers - entities "HeadlessClient_F";
		{
			_currentPlayer = _x;
			{
				if (alive(_currentPlayer) && _currentPlayer distance _x < 2000) then {
					_bAnyPlayersInAOAndAlive = true;
				};
			} forEach TREND_ObjectivePossitions;
		} forEach _justPlayers;
		if (_bMissionEnded && !_bAnyPlayersInAOAndAlive) then {_bMissionEndedAndPlayersOutOfAO = true};
		if (_bMissionEndedAndPlayersOutOfAO) then {
			_bEnd = true;
			ace_hearing_disableVolumeUpdate = true;
			2 fadeSound 0.1;
			playMusic "";
			0 fadeMusic 1;
			playMusic selectRandom TREND_ThemeAndIntroMusic;
			//Hint format["InitPlayer Music: %1",TREND_ThemeAndIntroMusic];
			sleep 8;
			["<t font='PuristaMedium' align='center' size='2.9' color='#ffffff'>TRGM 2</t><br/><t font='PuristaMedium' align='center' size='1' color='#ffffff'>" + localize "STR_TRGM2_TRGMInitPlayerLocal_TRGM2Title" + "</t>",-1,0.2,6,1,0,789] spawn BIS_fnc_dynamicText;
			sleep 10;
			["<t font='PuristaMedium' align='center' size='2.9' color='#ffffff'>" + (TREND_AdvancedSettings select TREND_ADVSET_GROUP_NAME_IDX) + "</t><br/><t font='PuristaMedium' align='center' size='1' color='#ffffff'><br />" + localize "STR_TRGM2_TRGMInitPlayerLocal_RTBDebreif" + "</t>",-1,0.2,6,1,0,789] spawn BIS_fnc_dynamicText;
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


true;