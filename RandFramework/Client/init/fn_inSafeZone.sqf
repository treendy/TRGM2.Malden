format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;
while {true} do {
    if (getMarkerPos "mrkHQ" distance player < TRGM_VAR_PunishmentRadius) then {
        //if (!TRGM_VAR_bDebugMode) then { player allowDamage false};
    }
    else {
        //if (!TRGM_VAR_bDebugMode) then { player allowDamage true;};
        TRGM_VAR_PlayersHaveLeftStartingArea =  true; publicVariable "TRGM_VAR_PlayersHaveLeftStartingArea";
    };
    sleep 1;
};