
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;
TRGM_VAR_WaitTimeCommsDown = (floor random 300) + 60; //any time up to 5 mins plus 60 seconds
publicVariable "TRGM_VAR_WaitTimeCommsDown";
sleep TRGM_VAR_WaitTimeCommsDown;

[HQMan,"EnemyCommsDown"] remoteExec ["sideRadio", 0, true];

true;