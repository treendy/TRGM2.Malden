WaitTimeCommsDown = (floor random 300) + 60; //any time up to 5 mins plus 60 seconds
publicVariable "WaitTimeCommsDown";
sleep WaitTimeCommsDown;

[[HQMan,"EnemyCommsDown"],"sideRadio",true,true] call BIS_fnc_MP;