
TREND_fnc_AnimateWildLife = {
	sleep 10;
	params ["_pos"];
	{
	   _x playMove "Dog_Sit";
	} forEach nearestObjects [_pos, ["Fin_random_F"], 2500];
	sleep 1;
	{
	   _x playMove "Goat_Walk";
	}
	forEach nearestObjects [_pos, ["Goat_random_F"], 2500];
	sleep 1; 
	{
	   _x playMove "Dog_Idle_Stop";
	} forEach nearestObjects [_pos, ["Fin_random_F"], 2500];
	sleep 1;
	{
	   _x playMove "Goat_Idle_Stop";
	} forEach nearestObjects [_pos, ["Goat_random_F"], 2500];
};

{
	[_x] spawn TREND_fnc_AnimateWildLife;
} forEach ObjectivePossitions;