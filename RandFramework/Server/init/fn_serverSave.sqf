//Note: this will always save on the server, if local or single player, will save on client, otherwise, if dedicated, will save on dedicated server, reason, if player who has saved the mission
// disconnects, we will not be able to save it to the client, so we store that players ID and store it on the server (I think i have disabled this for single player... as they can save/load anyway)
// future update may allow this to be saved on single player, incase they want to run campaign on mixed maps

params["_SaveType","_IsFirstSave"];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;

//sInitialSLPlayerID
_SaveVersion = "";
if (_SaveType isEqualTo 1) then {
    _SaveVersion = worldName;
};
if (_SaveType isEqualTo 2) then {
    _SaveVersion = "GLOBAL";
};


if (_SaveVersion != "") then {
    //sInitialSLPlayerID
    TRGM_VAR_SaveType =  _SaveType; publicVariable "TRGM_VAR_SaveType";
    TRGM_VAR_SaveTypeString =  _SaveVersion; publicVariable "TRGM_VAR_SaveTypeString";

    sleep 0.1;
    [[], {
        _saveData = [
            TRGM_VAR_iMissionParamType,
            TRGM_VAR_iMissionParamObjective,
            TRGM_VAR_iAllowNVG,
            TRGM_VAR_iMissionParamRepOption,
            TRGM_VAR_iWeather,
            TRGM_VAR_iUseRevive,
            TRGM_VAR_iStartLocation,
            TRGM_VAR_BadPoints,
            TRGM_VAR_MaxBadPoints,
            TRGM_VAR_BadPointsReason,
            TRGM_VAR_iCampaignDay,
            TRGM_VAR_AdvancedSettings,
            TRGM_VAR_EnemyFactionData,
            TRGM_VAR_LoadoutData,
            TRGM_VAR_arrayTime
        ];
        profileNamespace setVariable [TRGM_VAR_sInitialSLPlayerID + ":" + TRGM_VAR_SaveTypeString,_saveData];
        saveProfileNamespace;
    }] remoteExec ["call", 2]; //Save this to server only


    TRGM_VAR_laptop1 remoteExec ["removeAllActions"];

    if (TRGM_VAR_SaveType isEqualTo 1) then {
        if (_IsFirstSave) then {[(localize "STR_TRGM2_ServerSave_Save1")] call TRGM_GLOBAL_fnc_notify;};
        [TRGM_VAR_laptop1, [localize "STR_TRGM2_ServerSave_SaveLocal",{[(localize "STR_TRGM2_ServerSave_SaveHint")] call TRGM_GLOBAL_fnc_notify}]] remoteExec ["addAction", 0];

    }
    else {
        if (_IsFirstSave) then {[(localize "STR_TRGM2_ServerSave_Save2")] call TRGM_GLOBAL_fnc_notify;};
        TRGM_VAR_laptop1 addAction [localize "STR_TRGM2_ServerSave_SaveGlobal",{[(localize "STR_TRGM2_ServerSave_SaveHint")] call TRGM_GLOBAL_fnc_notify}];
    };

    true;
}
else {
    [(localize "STR_TRGM2_ServerSave_SaveError")] call TRGM_GLOBAL_fnc_notify;
    false;
};

false;