
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;
_isCampaign = (TREND_iMissionParamType isEqualTo 5);


_mrkHQPos = getMarkerPos "mrkHQ";
_AOCampPos = getPos endMissionBoard2;
bAllAtBase2 = ({(alive _x)&&((_x distance _mrkHQPos < 500)||(_x distance _AOCampPos < 500))} count (call BIS_fnc_listPlayers)) isEqualTo ({ (alive _x) } count (call BIS_fnc_listPlayers));




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
//		["The Kilo-1 teamleader needs to select this"] call TREND_fnc_notify;
//		_bAllowStart = false;
//	};
//
//	if (!_bSLAlive && _bK1_1Alive && str(player) != "k2_1") then {
//		["The Kilo-2 teamleader needs to select this"] call TREND_fnc_notify;
//		_bAllowStart = false;
//	};
//	if (!_bSLAlive && !_bK1_1Alive && (leader (group player))!=player) then {
//			["The assigned Kilo-1 teamleader needs to select this"] call TREND_fnc_notify;
//			_bAllowStart = false;
//	};
//};


if (_bAllowStart) then {

	if ((bAllAtBase2 && TREND_ActiveTasks call FHQ_fnc_ttAreTasksCompleted) || !_isCampaign) then {
		player allowdamage false;
		// titleText [localize "STR_TRGM2_mainInit_Loading", "BLACK FADED", 5];
		//sleep 3;

		if (_isCampaign) then {
			["NEW_MISSION"] remoteExec ["TREND_fnc_SetMissionBoardOptions",0,true];
			if ((player getVariable ["calUAVActionID", -1]) != -1) then {
				player removeAction (player getVariable ["calUAVActionID", -1]);
				player setVariable ["calUAVActionID", nil];
				//["UAV no longer available"] call TREND_fnc_notify;
			};
		};

		//"Marker1" setMarkerPos getMarkerPos "mrkHQ";

		if (isServer && _isCampaign) then {

			if (!isNil("TREND_WarColor")) then {
				TREND_WarColor ppEffectEnable false;
	 			ppEffectDestroy TREND_WarColor;
			};
			if (!isNil("TREND_WarGrain")) then {
    			TREND_WarGrain ppEffectEnable false;
			    ppEffectDestroy TREND_WarGrain;
			};
			if (!isNil("TREND_WarEventActive")) then {
    			TREND_WarEventActive =  false; publicVariable "TREND_WarEventActive";
			};
			if (!isNil("TREND_WarzonePos")) then {
    			TREND_WarzonePos =  nil; publicVariable "TREND_WarzonePos";
			};
			if (!isNil("TREND_AOCampPos")) then {
    			TREND_AOCampPos =  nil; publicVariable "TREND_AOCampPos";
			};



			al_aaa = false;
			publicVariable "al_aaa";
			al_search_light = false;
			publicVariable "al_search_light";

			tracer1 setPos [99999,99999];
			tracer2 setPos [99999,99999];
			tracer3 setPos [99999,99999];
			tracer4 setPos [99999,99999];

			TREND_ATFieldPos =  []; publicVariable "TREND_ATFieldPos";

			{
				_y = _x;
				{
					//if (_y distance getPos _x > TREND_PunishmentRadius) then {
					_isZeuzModule = false;
					if (["ModuleCurator", str(TypeOf (_x))] call BIS_fnc_inString) then {_isZeuzModule = true;};
					if (["Zeus", str(_x)] call BIS_fnc_inString) then {_isZeuzModule = true;};
					if !(isNil {_x getVariable "ObjectiveParams"}) then {
						[_x, "canceled"] call TREND_fnc_updateTask;
					};
					if (!_isZeuzModule && !(_x getVariable ["IsFRT",false]) && !(_x getVariable ["DontDelete",false])) then {
						deleteVehicle _x;
					};
					//};
				} forEach nearestObjects [_y, ["all"], 4000];
			} forEach TREND_ObjectivePossitions;

			{
				_mrkPos = getMarkerPos _x;
				_mrkHQPos = getMarkerPos "mrkHQ";
				if (_mrkPos distance _mrkHQPos > TREND_PunishmentRadius) then {
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


			TREND_InfTaskCount =  0; publicVariable "TREND_InfTaskCount";
			TREND_ActiveTasks =  []; publicVariable "TREND_ActiveTasks";
			TREND_ObjectivePossitions =  []; publicVariable "TREND_ObjectivePossitions";
			TREND_bCommsBlocked =  false; publicVariable "TREND_bCommsBlocked";
			TREND_bBaseHasChopper =  false; publicVariable "TREND_bBaseHasChopper";
			TREND_ParaDropped =  false; publicVariable "TREND_ParaDropped";
			TREND_bHasCommsTower =  false; publicVariable "TREND_bHasCommsTower";
			TREND_CommsTowerPos =  [0,0]; publicVariable "TREND_CommsTowerPos";
			TREND_AODetails =  []; publicVariable "TREND_AODetails";
			TREND_CheckPointAreas =  []; publicVariable "TREND_CheckPointAreas";
			TREND_SentryAreas =  []; publicVariable "TREND_SentryAreas";
			TREND_bMortarFiring =  false; publicVariable "TREND_bMortarFiring";
			TREND_iCampaignDay =  TREND_iCampaignDay + 1; publicVariable "TREND_iCampaignDay";
			TREND_IntelFound =  []; publicVariable "TREND_IntelFound";
			TREND_ClearedPositions =  []; publicVariable "TREND_ClearedPositions";
			TREND_AllowUAVLocateHelp =  false; publicVariable "TREND_AllowUAVLocateHelp";
			TREND_NewMissionMusic =  nil; publicVariable "TREND_NewMissionMusic";

			//not saving when new day starts, we will save when points change (just incase day starts, but players exit anyway and nothing done on that day)
			//if (TREND_SaveType != 0) then {
			//		[TREND_SaveType,false] spawn TREND_fnc_ServerSave;
			//};

		};


		if (isServer) then {
			TREND_MissionLoaded =  false; publicVariable "TREND_MissionLoaded";
			[false] call TREND_fnc_SetTimeAndWeather;
			call TREND_fnc_startInfMission;
		};

	}
	else {
		{[(localize "STR_TRGM2_StartMission_Hint")] call TREND_fnc_notify;} remoteExec ["call", 0];
	};

	if (TREND_iMissionParamType isEqualTo 5) then {
		call TREND_fnc_PostStartMission;
	};

};

true;