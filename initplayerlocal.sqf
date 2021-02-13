"Initplayerlocal.sqf" call TREND_fnc_log;
call TREND_fnc_initGlobalVars;

_actChooseMission = -1;

CODEINPUT = [];

[] spawn TREND_fnc_mainInitLocal;