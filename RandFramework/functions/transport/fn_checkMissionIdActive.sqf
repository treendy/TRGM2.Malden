params ["_vehicle","_checkToMissionNumber"];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;
(_checkToMissionNumber == (_vehicle getVariable ["missionNr",-1]));