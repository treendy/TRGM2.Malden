#include "..\..\setUnitGlobalVars.sqf";

_actChooseMission = -1;

if (isNil "bAndSoItBegins") then {
	bAndSoItBegins = false;
	publicVariable "bAndSoItBegins";	
};


	waitUntil {!isNull player};
	waitUntil {player == player};

	sleep 4;

if (str player == "sl" && !bAndSoItBegins) then {
	[] execVM "RandFramework\GUI\openDialogMissionSelection.sqf";
	_actChooseMission = endMissionBoard addaction ["Select Mission Params", "RandFramework\GUI\openDialogMissionSelection.sqf"];
};


TREND_fnc_BasicInit = {
	
	//enableEngineArtillery false; 
						   
	if (iAllowNVG == 2) then {
		[] execVM "RandFramework\NVscript.sqf";
	};

	
	if (iMissionParamRepOption == 1) then {
		if (isClass(configFile >> "CfgPatches" >> "ace_main")) then {
			//myaction = ['ShowRepReport','Show reputation report','',{_justPlayers = allPlayers - entities "HeadlessClient_F";_iPlayerCount = count _justPlayers;_iPointsToAdd = 3 / ((_iPlayerCount / 3) * 1.8);_iPointsToAdd = [_iPointsToAdd,1] call BIS_fnc_cutDecimals;hint format["Current cost per life: %1\n\nBad reputation points: %2 out of %3\n\nTOTAL REP: %4 \n\nREASONS SO FAR: \n%5",_iPointsToAdd,BadPoints, MaxBadPoints, MaxBadPoints - BadPoints ,BadPointsReason]},{true}] call ace_interact_menu_fnc_createAction;
			//[player, 1, ["ACE_SelfActions"], myaction] call ace_interact_menu_fnc_addActionToObject;
			endMissionBoard addaction ["Show reputation report", {_justPlayers = allPlayers - entities "HeadlessClient_F";_iPlayerCount = count _justPlayers;_iPointsToAdd = 3 / ((_iPlayerCount / 3) * 1.8);_iPointsToAdd = [_iPointsToAdd,1] call BIS_fnc_cutDecimals;hint format["Current cost per life: %1\n\nBad reputation points: %2 out of %3\n\nTOTAL REP: %4 \n\nREASONS SO FAR: \n%5",_iPointsToAdd,BadPoints, MaxBadPoints, MaxBadPoints - BadPoints, BadPointsReason]}];
		}
		else {
			//player addaction ["Show reputation report", {_justPlayers = allPlayers - entities "HeadlessClient_F";_iPlayerCount = count _justPlayers;_iPointsToAdd = 3 / ((_iPlayerCount / 3) * 1.8);_iPointsToAdd = [_iPointsToAdd,1] call BIS_fnc_cutDecimals;hint format["Current cost per life: %1\n\nBad reputation points: %2 out of %3\n\nTOTAL REP: %4 \n\nREASONS SO FAR: \n%5",_iPointsToAdd,BadPoints, MaxBadPoints, MaxBadPoints - BadPoints, BadPointsReason]}];
			endMissionBoard addaction ["Show reputation report", {_justPlayers = allPlayers - entities "HeadlessClient_F";_iPlayerCount = count _justPlayers;_iPointsToAdd = 3 / ((_iPlayerCount / 3) * 1.8);_iPointsToAdd = [_iPointsToAdd,1] call BIS_fnc_cutDecimals;hint format["Current cost per life: %1\n\nBad reputation points: %2 out of %3\n\nTOTAL REP: %4 \n\nREASONS SO FAR: \n%5",_iPointsToAdd,BadPoints, MaxBadPoints, MaxBadPoints - BadPoints, BadPointsReason]}];
		};
	};

	if (str player == "sl" || str player == "k1_1" || str player == "k1_5" || str player == "d1_1" || str player == "d2_1" || str player == "pg1_1" || str player == "pg1_2" || str player == "pg1_3") then {
		if (isClass(configFile >> "CfgPatches" >> "ace_main")) then {
			//myaction = ['RequestArti','Request Arti','',{_handle=createdialog "DialogArtiRequest";},{true}] call ace_interact_menu_fnc_createAction;
			//[player, 1, ["ACE_SelfActions"], myaction] call ace_interact_menu_fnc_addActionToObject;
		}
		else {
			//player addaction ["Request Arti", {_handle=createdialog "DialogArtiRequest";}];
		};
	};
	if (isMultiplayer) then {
		execVM "RandFramework\NoVoice.sqf";
	};

	al_flare_intensity = 20;
	publicvariable "al_flare_intensity";
	// flare range, replace 500 with desired value
	al_flare_range = 300;
	publicvariable "al_flare_range";
	// If you want to use FLARE FIX do not edit or remove lines bellow
	player addEventHandler ["Fired",{private ["_al_flare"]; _al_flare = _this select 6;[[[_al_flare],"\RandFramework\AL_flare_fix\al_flare_enhance.sqf"],"BIS_fnc_execVM",true,true] spawn BIS_fnc_MP;}];
	// ^^^^^^^^^^ END FLARE fix ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

	iAllowGPS = ("OUT_par_AllowGPS" call BIS_fnc_getParamValue);
	if (iAllowGPS == 0) then {
		showGPS false;
	};

};
[] spawn TREND_fnc_BasicInit;
player addEventHandler ["Respawn", { [] spawn TREND_fnc_BasicInit; }];


waitUntil {bAndSoItBegins};

endMissionBoard removeAction _actChooseMission;






if (isNil "KilledPlayers") then {
	KilledPlayers = [];
	publicVariable "KilledPlayers";
};
if (isNil "KilledPositions") then {
	KilledPositions = [];
	publicVariable "KilledPositions";
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
		myaction = ['TraceBulletAction','Trace Bullets','',{},{true}] call ace_interact_menu_fnc_createAction;
		[player, 1, ["ACE_SelfActions"], myaction] call ace_interact_menu_fnc_addActionToObject;
		
		myaction = ['TraceBulletEnable','Enable','',{[player, 5] spawn BIS_fnc_traceBullets;},{true}] call ace_interact_menu_fnc_createAction;
		[player, 1, ["ACE_SelfActions", "TraceBulletAction"], myaction] call ace_interact_menu_fnc_addActionToObject;

		myaction = ['TraceBulletDisable','Disable','',{[player, 0] spawn BIS_fnc_traceBullets;},{true}] call ace_interact_menu_fnc_createAction;
		[player, 1, ["ACE_SelfActions", "TraceBulletAction"], myaction] call ace_interact_menu_fnc_addActionToObject;
	};
	
}
else {
	if (iMissionSetup == 5) then {
		[player, 999] call BIS_fnc_respawnTickets;
	}
	else {
		[player, 1] call BIS_fnc_respawnTickets;
	};
};


TREND_fnc_GetAnimalsMoving = {	
	[] execVM "RandFramework\animateAnimals.sqf";
};
[] spawn TREND_fnc_GetAnimalsMoving;
player addEventHandler ["Respawn", { [] spawn TREND_fnc_BasicInit; }];



TREND_fnc_OnlyAllowDirectMapDraw = {
	while {true} do {
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
							hint "!!!!!WARNING!!!!! YOU ARE NOT PERMITTED TO ENTER THIS ZONE... TURN AROUND NOW!";
							if (player distance (_x select 1) < KilledZoneInnerRadius) then {
								cutText ["Transfering... ","BLACK FADED", 0];
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