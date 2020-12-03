
_bAllow = true;

if (isMultiplayer) then {

	_bSLAlive = false;
	_bK1_1Alive = false;
	if (!isnil "sl") then { //sl is leader of K1 - k2_1 is leader of K2
		_bSLAlive = alive sl;
	};
	if (!isnil "k2_1") then {
		_bK1_1Alive = alive k2_1;
	};

	if (_bSLAlive && str(player) != "sl") then {
		hint (localize "STR_TRGM2_attemptendmission_Kilo1");
		_bAllow = false;
	};

	if (!_bSLAlive && _bK1_1Alive && str(player) != "k2_1") then {
		hint (localize "STR_TRGM2_attemptendmission_Kilo2");
		_bAllow = false;
	};
	if (!_bSLAlive && !_bK1_1Alive && (leader (group player))!=player) then {
			hint (localize "STR_TRGM2_attemptendmission_Kilo1");
			_bAllow = false;
	};


};


if (_bAllow) then {
	//Fail current mission
	_iCurrentTaskCount = 0;
	while {_iCurrentTaskCount < count TREND_ActiveTasks} do {
		if (!(TREND_ActiveTasks call FHQ_fnc_ttAreTasksCompleted)) then {
			[TREND_ActiveTasks select _iCurrentTaskCount, "failed"] call FHQ_fnc_ttSetTaskState;
			_iCurrentTaskCount = _iCurrentTaskCount + 1;
		};
	};
	//lower rep
	[0.3, format[localize "STR_TRGM2_startInfMission_DayTurnedIn",str(TREND_iCampaignDay)]] spawn TREND_fnc_AdjustBadPoints;

	sleep 3;

	//tp trtansport choppers to base
	//"transportChopper" setMarkerPos getPos chopper1;
	//airSupportHeliPad
	//heliPad1
	_escortPilot1 = driver chopper1;
	{
		deleteWaypoint _x
	} foreach waypoints group _escortPilot1;
	chopper1 setVariable ["baseLZ", getPos heliPad1, true];
	[chopper1] spawn TREND_fnc_flyToBase;
	chopper1 setPos getPos heliPad1;
	chopper2 setPos getPos airSupportHeliPad;
	"transportChopper" setMarkerPos getPos chopper1;
	chopper1 engineOn false;
	chopper2 engineOn false;
	_escortPilot = driver chopper2;
	{
		deleteWaypoint _x
	} foreach waypoints group _escortPilot;

	sleep 0.2;
	//[] remoteExec ["TREND_fnc_StartMission",0,true];
	//hint (localize "STR_TRGM2_attemptendmission_Ending");
	//[] spawn TREND_fnc_endMission;
};

true;