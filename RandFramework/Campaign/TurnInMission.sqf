
_bAllow = [] call TRGM_fnc_isPlayerAllowedToLead;

if (_bAllow) then {
	//Fail current mission
	{
		if (!([_x] call FHQ_TT_areTasksCompleted)) then {
			[_x, "failed"] call FHQ_TT_setTaskState;
		};
	} forEach ActiveTasks;
	//lower rep
	[0.3, format[localize "STR_TRGM2_startInfMission_DayTurnedIn",str(iCampaignDay)]] call TRGM_fnc_adjustBadPoints;

	sleep 3;

	//tp transport choppers to base
	[true] call TRGM_fnc_resetTransportChoppers;
	
	sleep 0.2;
};