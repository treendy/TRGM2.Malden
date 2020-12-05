
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;
TREND_WaitTimeCommsDown = (floor random 300) + 60; //any time up to 5 mins plus 60 seconds
publicVariable "TREND_WaitTimeCommsDown";
sleep TREND_WaitTimeCommsDown;

[[HQMan,"EnemyCommsDown"],"sideRadio",true,true] call BIS_fnc_MP;

true;