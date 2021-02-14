format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;

sleep 60;
hideBody (_this select 0);
sleep 5;
deleteVehicle (_this select 0);