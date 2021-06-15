
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;
_isCampaign = (TRGM_VAR_iMissionParamType isEqualTo 5);


_mrkHQPos = getMarkerPos "mrkHQ";
_AOCampPos = getPos endMissionBoard2;
bAllAtBase2 = ({(alive _x)&&((_x distance _mrkHQPos < 500)||(_x distance _AOCampPos < 500))} count (call BIS_fnc_listPlayers)) isEqualTo ({ (alive _x) } count (call BIS_fnc_listPlayers));




//Need to move the below to function that fires for player who called addAction, then inside that function can call StartMission for all
//Also... in this extra file, we can set a publicVariable for "IntroPlayed=false", then after played set IntroPlayed=true... so will only play when mission starts or next mission picked
_bAllowStart = true;
//if (_isCampaign && isMultiplayer) then {
//    _bSLAlive = false;
//    _bK1_1Alive = false;
//    if (!isnil "sl") then {
//        _bSLAlive = alive sl;
//    };
//    if (!isnil "k2_1") then {
//        _bK1_1Alive = alive k2_1;
//    };
//
//    if (_bSLAlive && str(player) != "sl") then {
//        ["The Kilo-1 teamleader needs to select this"] call TRGM_GLOBAL_fnc_notify;
//        _bAllowStart = false;
//    };
//
//    if (!_bSLAlive && _bK1_1Alive && str(player) != "k2_1") then {
//        ["The Kilo-2 teamleader needs to select this"] call TRGM_GLOBAL_fnc_notify;
//        _bAllowStart = false;
//    };
//    if (!_bSLAlive && !_bK1_1Alive && (leader (group player))!=player) then {
//            ["The assigned Kilo-1 teamleader needs to select this"] call TRGM_GLOBAL_fnc_notify;
//            _bAllowStart = false;
//    };
//};


if (_bAllowStart) then {

    if ((bAllAtBase2 && TRGM_VAR_ActiveTasks call FHQ_fnc_ttAreTasksCompleted) || !_isCampaign) then {
        player allowdamage false;
        // titleText [localize "STR_TRGM2_mainInit_Loading", "BLACK FADED", 5];
        //sleep 3;

        if (_isCampaign) then {
            ["NEW_MISSION"] remoteExec ["TRGM_SERVER_fnc_setMissionBoardOptions",0,true];
            if ((player getVariable ["calUAVActionID", -1]) != -1) then {
                player removeAction (player getVariable ["calUAVActionID", -1]);
                player setVariable ["calUAVActionID", nil];
                //["UAV no longer available"] call TRGM_GLOBAL_fnc_notify;
            };
        };

        //"Marker1" setMarkerPos getMarkerPos "mrkHQ";

        if (isServer && _isCampaign) then {

            if (!isNil("TRGM_VAR_WarColor")) then {
                TRGM_VAR_WarColor ppEffectEnable false;
                 ppEffectDestroy TRGM_VAR_WarColor;
            };
            if (!isNil("TRGM_VAR_WarGrain")) then {
                TRGM_VAR_WarGrain ppEffectEnable false;
                ppEffectDestroy TRGM_VAR_WarGrain;
            };
            if (!isNil("TRGM_VAR_WarEventActive")) then {
                TRGM_VAR_WarEventActive =  false; publicVariable "TRGM_VAR_WarEventActive";
            };
            if (!isNil("TRGM_VAR_WarzonePos")) then {
                TRGM_VAR_WarzonePos =  nil; publicVariable "TRGM_VAR_WarzonePos";
            };
            if (!isNil("TRGM_VAR_AOCampPos")) then {
                TRGM_VAR_AOCampPos =  nil; publicVariable "TRGM_VAR_AOCampPos";
            };



            al_aaa = false;
            publicVariable "al_aaa";
            al_search_light = false;
            publicVariable "al_search_light";

            tracer1 setPos [99999,99999];
            tracer2 setPos [99999,99999];
            tracer3 setPos [99999,99999];
            tracer4 setPos [99999,99999];

            TRGM_VAR_ATFieldPos =  []; publicVariable "TRGM_VAR_ATFieldPos";

            {
                _y = _x;
                {
                    //if (_y distance getPos _x > TRGM_VAR_PunishmentRadius) then {
                    _isZeuzModule = false;
                    if (["ModuleCurator", str(TypeOf (_x))] call BIS_fnc_inString) then {_isZeuzModule = true;};
                    if (["Zeus", str(_x)] call BIS_fnc_inString) then {_isZeuzModule = true;};
                    if !(isNil {_x getVariable "ObjectiveParams"}) then {
                        [_x, "canceled"] call TRGM_SERVER_fnc_updateTask;
                    };
                    if (!_isZeuzModule && !(_x getVariable ["IsFRT",false]) && !(_x getVariable ["DontDelete",false])) then {
                        deleteVehicle _x;
                    };
                    //};
                } forEach nearestObjects [_y, ["all"], 4000];
            } forEach TRGM_VAR_ObjectivePossitions;

            {
                _mrkPos = getMarkerPos _x;
                _mrkHQPos = getMarkerPos "mrkHQ";
                if (_mrkPos distance _mrkHQPos > TRGM_VAR_PunishmentRadius) then {
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


            TRGM_VAR_InfTaskCount =  0; publicVariable "TRGM_VAR_InfTaskCount";
            TRGM_VAR_ActiveTasks =  []; publicVariable "TRGM_VAR_ActiveTasks";
            TRGM_VAR_ObjectivePossitions =  []; publicVariable "TRGM_VAR_ObjectivePossitions";
            TRGM_VAR_bCommsBlocked =  false; publicVariable "TRGM_VAR_bCommsBlocked";
            TRGM_VAR_bBaseHasChopper =  false; publicVariable "TRGM_VAR_bBaseHasChopper";
            TRGM_VAR_ParaDropped =  false; publicVariable "TRGM_VAR_ParaDropped";
            TRGM_VAR_bHasCommsTower =  false; publicVariable "TRGM_VAR_bHasCommsTower";
            TRGM_VAR_CommsTowerPos =  [0,0]; publicVariable "TRGM_VAR_CommsTowerPos";
            TRGM_VAR_AODetails =  []; publicVariable "TRGM_VAR_AODetails";
            TRGM_VAR_CheckPointAreas =  []; publicVariable "TRGM_VAR_CheckPointAreas";
            TRGM_VAR_SentryAreas =  []; publicVariable "TRGM_VAR_SentryAreas";
            TRGM_VAR_bMortarFiring =  false; publicVariable "TRGM_VAR_bMortarFiring";
            TRGM_VAR_iCampaignDay =  TRGM_VAR_iCampaignDay + 1; publicVariable "TRGM_VAR_iCampaignDay";
            TRGM_VAR_IntelFound =  []; publicVariable "TRGM_VAR_IntelFound";
            TRGM_VAR_ClearedPositions =  []; publicVariable "TRGM_VAR_ClearedPositions";
            TRGM_VAR_AllowUAVLocateHelp =  false; publicVariable "TRGM_VAR_AllowUAVLocateHelp";
            TRGM_VAR_NewMissionMusic =  nil; publicVariable "TRGM_VAR_NewMissionMusic";

            //not saving when new day starts, we will save when points change (just incase day starts, but players exit anyway and nothing done on that day)
            //if (TRGM_VAR_SaveType != 0) then {
            //        [TRGM_VAR_SaveType,false] spawn TRGM_SERVER_fnc_serverSave;
            //};

        };


        if (isServer) then {
            TRGM_VAR_MissionLoaded =  false; publicVariable "TRGM_VAR_MissionLoaded";
            [false] call TRGM_SERVER_fnc_setTimeAndWeather;
            call TRGM_SERVER_fnc_startInfMission;
        };

    }
    else {
        {[(localize "STR_TRGM2_StartMission_Hint")] call TRGM_GLOBAL_fnc_notify;} remoteExec ["call", 0];
    };

    if (TRGM_VAR_iMissionParamType isEqualTo 5) then {
        [] remoteExec ["TRGM_SERVER_fnc_postStartMission"];
    };

};

true;