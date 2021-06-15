format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;
while {isMultiplayer && (TRGM_VAR_AdvancedSettings select TRGM_VAR_ADVSET_MAP_DRAW_DIRECT_ONLY_IDX isEqualTo 1)} do {
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