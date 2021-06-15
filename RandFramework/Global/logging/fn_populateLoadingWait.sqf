params[["_percentageIncrement", 100]];

if (isNil "TRGM_VAR_PopulateLoadingWait_percentage") then { TRGM_VAR_PopulateLoadingWait_percentage = 0; publicVariable "TRGM_VAR_PopulateLoadingWait_percentage"; };

private _coreCountSleep = 0.1;
sleep _coreCountSleep;

if (TRGM_VAR_PopulateLoadingWait_percentage > 100) exitWith {};

TRGM_VAR_PopulateLoadingWait_percentage = _percentageIncrement + TRGM_VAR_PopulateLoadingWait_percentage;
if (_percentageIncrement >= 100) then {
    TRGM_VAR_PopulateLoadingWait_percentage = 100;
};
TRGM_VAR_PopulateLoadingWait_percentage = ceil(TRGM_VAR_PopulateLoadingWait_percentage);
publicVariable "TRGM_VAR_PopulateLoadingWait_percentage";

[format["Generating mission please wait... %1 percent", TRGM_VAR_PopulateLoadingWait_percentage], {TRGM_VAR_PopulateLoadingWait_percentage <= 100}, 100] call TRGM_GLOBAL_fnc_notifyGlobal;

if (TRGM_VAR_PopulateLoadingWait_percentage >= 100 || _percentageIncrement >= 100) then {
    TRGM_VAR_PopulateLoadingWait_percentage = 101; publicVariable "TRGM_VAR_PopulateLoadingWait_percentage";
};

true;