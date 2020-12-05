//call script to start campaign if campaign picked
//show noticboard to player
//	- Current Reputation Points and report
//	- a random mission will have started, when RTB, welldone message and tell to go to board for next assignment (when picked, fade out and in with new weather/time settings)
//			- show label on screen as fade in "Day 2 : 18:46 PM - Destroy Cache near XXX"
//	- option to request asset or recrute unit
//	- if 10 rep, then the mission to load will be a main mission, with 2 optional sides for intel only!  (may have to be negative 10??? instead of rewritig the rep stuff)

format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;





if (TREND_SaveType == 0) then {
	["INIT"] remoteExec ["TREND_fnc_SetMissionBoardOptions",0,true];
	TREND_MaxBadPoints =  1; publicVariable "TREND_MaxBadPoints";
}
else {
	["MISSION_COMPLETE"] remoteExec ["TREND_fnc_SetMissionBoardOptions",0,true];
};

{
	if (!isPlayer _x) then {
		deleteVehicle _x;
	};
} forEach (if (isMultiplayer) then {playableUnits} else {switchableUnits});

TREND_CampaignInitiated =  true; publicVariable "TREND_CampaignInitiated";

//hint "go to the board to get started"



true;