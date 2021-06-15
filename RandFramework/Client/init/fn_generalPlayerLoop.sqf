format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;
while {true} do {
    if (side player != civilian) then {
        if (count TRGM_VAR_ObjectivePossitions > 0 && TRGM_VAR_AllowUAVLocateHelp) then {
            if ((Player distance (TRGM_VAR_ObjectivePossitions select 0)) < 25) then {
                if ((Player getVariable ["calUAVActionID", -1]) isEqualTo -1) then {
                    [(localize "STR_TRGM2_TRGMInitPlayerLocal_UAVAvailable")] call TRGM_GLOBAL_fnc_notify;
                    _actionID = player addAction [localize "STR_TRGM2_TRGMInitPlayerLocal_CallUAV",{[] spawn TRGM_GLOBAL_fnc_callUAVFindObjective}];
                    player setVariable ["calUAVActionID",_actionID];
                };
            };
            //else {
            //    if ((Player getVariable ["calUAVActionID", -1]) != -1) then {
            //        player removeAction (Player getVariable ["calUAVActionID", -1]);
            //        player setVariable ["calUAVActionID", nil];
            //        ["UAV no longer available"] call TRGM_GLOBAL_fnc_notify;
            //    };
            //};
        };
        if (leader (group (vehicle player)) isEqualTo player && TRGM_VAR_AdvancedSettings select TRGM_VAR_ADVSET_SUPPORT_OPTION_IDX isEqualTo 1) then {
            if (TRGM_VAR_iMissionSetup isEqualTo 5) then {
                if (TRGM_VAR_CampaignInitiated) then {

                    _dCurrentRep = [TRGM_VAR_MaxBadPoints - TRGM_VAR_BadPoints,1] call BIS_fnc_cutDecimals;
                    //TESTTEST = format["A:%1 - B:%2 - C:%3",TRGM_VAR_MaxBadPoints,TRGM_VAR_BadPoints,_dCurrentRep];
                    //[TESTTEST] call TRGM_GLOBAL_fnc_notify;
                    if (_dCurrentRep >= 1) then {
                        //["hmm2"] call TRGM_GLOBAL_fnc_notify;
                        [player, supReqSupply] call BIS_fnc_addSupportLink;
                        sleep 1;
                    };
                    if (_dCurrentRep >= 3) then {
                        //["hmm2"] call TRGM_GLOBAL_fnc_notify;
                        [player, supReq] call BIS_fnc_addSupportLink;
                        sleep 1;
                    };
                    if (_dCurrentRep >= 7) then {
                        //["hmm3"] call TRGM_GLOBAL_fnc_notify;
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