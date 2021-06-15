
"Exit.sqf" call TRGM_GLOBAL_fnc_log;
if (TRGM_VAR_SaveType != 0) then {
    [TRGM_VAR_SaveType,false] spawn TRGM_GLOBAL_fnc_serverSave;
};


true;