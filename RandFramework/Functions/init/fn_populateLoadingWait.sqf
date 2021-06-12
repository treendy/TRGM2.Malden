params[["_percentageIncrement", 100]];

if (isNil "TREND_PopulateLoadingWait_percentage") then { TREND_PopulateLoadingWait_percentage = 0; publicVariable "TREND_PopulateLoadingWait_percentage"; };

private _coreCountSleep = 0.1;
sleep _coreCountSleep;

if (TREND_PopulateLoadingWait_percentage > 100) exitWith {};

TREND_PopulateLoadingWait_percentage = _percentageIncrement + TREND_PopulateLoadingWait_percentage;
if (_percentageIncrement >= 100) then {
	TREND_PopulateLoadingWait_percentage = 100;
};
TREND_PopulateLoadingWait_percentage = ceil(TREND_PopulateLoadingWait_percentage);
publicVariable "TREND_PopulateLoadingWait_percentage";

[format["Generating mission please wait... %1 percent", TREND_PopulateLoadingWait_percentage], {TREND_PopulateLoadingWait_percentage <= 100}, 100] call TREND_fnc_notifyGlobal;

if (TREND_PopulateLoadingWait_percentage >= 100 || _percentageIncrement isEqualTo 100) then {
	TREND_PopulateLoadingWait_percentage = 101; publicVariable "TREND_PopulateLoadingWait_percentage";
};

true;