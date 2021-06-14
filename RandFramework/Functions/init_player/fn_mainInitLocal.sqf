format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;

waitUntil {!isNull player};
waitUntil {player isEqualTo player};

if !(player getVariable ["TREND_localInitOccured", false]) then {
	player setVariable ["TREND_localInitOccured", true];

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

	showCinemaBorder true;
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
	playMusic TREND_IntroMusic;
	[format["SelectLoop Music: %1", TREND_IntroMusic ], true] call TREND_fnc_log;

	[] spawn TREND_fnc_MissionSelectLoop;

	waitUntil {TREND_bOptionsSet};

	txt5Layer = "txt5" call BIS_fnc_rscLayer;
	_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.8' color='#Ffffff'>TRGM Redux</t>";
	[_texta, -0, 0.150, 7, 1,0,txt5Layer] spawn BIS_fnc_dynamicText;


	txt51Layer = "txt51" call BIS_fnc_rscLayer;
	_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.5' color='#ffffff'>" + localize "STR_TRGM2_TRGMInitPlayerLocal_CantHearMusic" + "</t>";
	[_texta, 0, 0.280, 7, 1,0,txt51Layer] spawn BIS_fnc_dynamicText;

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
				waitUntil {!visibleMap};
				if (!isNil "TREND_Mission1Loc") then {
					["mrkAoSelect1",  TREND_Mission1Loc, "ICON", "ColorRed", [1,1], "AO 1"] call AIS_Core_fnc_createLocalMarker;
				};

				if (TREND_iMissionParamType isEqualTo 0 || TREND_iMissionParamType isEqualTo 4 || TREND_iMissionParamType isEqualTo 11) then {
					titleText[localize "STR_TRGM2_tele_SelectPositionAO2", "PLAIN"];
					openMap true;
					onMapSingleClick "TREND_Mission2Loc = _pos; publicVariable 'TREND_Mission2Loc'; openMap false; onMapSingleClick ''; true;";
					sleep 1;
					waitUntil {!visibleMap};
					if (!isNil "TREND_Mission2Loc") then {
						["mrkAoSelect2",  TREND_Mission2Loc, "ICON", "ColorRed", [1,1], "AO 2"] call AIS_Core_fnc_createLocalMarker;
					};

					titleText[localize "STR_TRGM2_tele_SelectPositionAO3", "PLAIN"];
					openMap true;
					onMapSingleClick "TREND_Mission3Loc = _pos; publicVariable 'TREND_Mission3Loc'; openMap false; onMapSingleClick ''; true;";
					sleep 1;
					waitUntil {!visibleMap};
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
				waitUntil {!visibleMap};
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
	// 	if (TREND_iAllowGPS isEqualTo 0) then {
	// 		showGPS false;
	// 	};

	// };
	// [] spawn TREND_fnc_BasicInitAndRespawn;
	// player addEventHandler ["Respawn", { [] spawn TREND_fnc_BasicInitAndRespawn; }];

	waitUntil {TREND_bAndSoItBegins && TREND_CustomObjectsSet};

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

	[] spawn {
		5 fadeMusic 0;
		sleep 5;
		ace_hearing_disableVolumeUpdate = false;
		playMusic "";
	};

	_iEnableGroupManagement = TREND_AdvancedSettings select TREND_ADVSET_GROUP_MANAGE_IDX;
	if (_iEnableGroupManagement isEqualTo 1) then {
		["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;//Exec on client
	};

	[] spawn TREND_fnc_InitPostStarted;
	player addEventHandler ["Respawn", { [] spawn TREND_fnc_InitPostStarted; }];

	if (TREND_AdvancedSettings select TREND_ADVSET_VIRTUAL_ARSENAL_IDX isEqualTo 1) then {
		box1 addAction [localize "STR_TRGM2_startInfMission_VirtualArsenal", {["Open",true] spawn BIS_fnc_arsenal}];
	};

	TREND_bCirclesOfDeath = false;
	TREND_iCirclesOfDeath = 0; //("TREND_par_CirclesOfDeath" call BIS_fnc_getParamValue);
	if (TREND_iCirclesOfDeath isEqualTo 1) then {
		TREND_bCirclesOfDeath = true;
	};

	TREND_iMissionSetup = TREND_iMissionParamType;
	if (TREND_iMissionSetup isEqualTo 12 || TREND_iMissionSetup isEqualTo 20) then {
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

		//if (TREND_iMissionSetup isEqualTo 5 && !isMultiplayer) then {
		//	[player, 999] call BIS_fnc_respawnTickets;
		//	TREND_debugMessages = TREND_debugMessages + "\n" + "999 respawn tickets"
		//}
		//else {
		//	[player, 1] call BIS_fnc_respawnTickets;
		//};
	};


	[] spawn TREND_fnc_animateAnimals;
	player addEventHandler ["Respawn", { [] spawn TREND_fnc_animateAnimals; }];

	[] spawn TREND_fnc_GeneralPlayerLoop;
	player addEventHandler ["Respawn", { [] spawn TREND_fnc_GeneralPlayerLoop; }];

	[] spawn TREND_fnc_OnlyAllowDirectMapDraw;
	player addEventHandler ["Respawn", { [] spawn TREND_fnc_OnlyAllowDirectMapDraw; }];

	[] spawn TREND_fnc_InSafeZone;
	player addEventHandler ["Respawn", { [] spawn TREND_fnc_InSafeZone; }];

	[] spawn TREND_fnc_setNVG;
	player addEventHandler ["Respawn", { [] spawn TREND_fnc_setNVG; }];

	if (TREND_bCirclesOfDeath) then {

		[] spawn TREND_fnc_checkKilledRange;
		player addEventHandler ["Respawn", { [] spawn TREND_fnc_checkKilledRange; }];

		[] spawn TREND_fnc_drawKilledRanges;
		player addEventHandler ["Respawn", { [] spawn TREND_fnc_drawKilledRanges; }];

	};

	// if (TREND_sArmaGroup isEqualTo "TCF" && isMultiplayer) then {
	// 	//_handle=createdialog "DialogMessAround";
	// 	//titleText ["!!!WARNING!!!\n\nPoint system in place\n\nDO NOT mess around at base\n\nONLY fly if you know AFM, or are being trained.\n\nDestroying vehicles will mark points and ruin the experience for others!!!", "PLAIN"];
	// };

	[] spawn TREND_fnc_MissionOverAnimation;
	player addEventHandler ["Respawn", { [] spawn TREND_fnc_MissionOverAnimation; }];
};

true;
