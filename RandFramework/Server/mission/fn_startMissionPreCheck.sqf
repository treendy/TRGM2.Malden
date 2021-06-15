_isFinal = _this select 0;
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;

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
		[(localize "STR_TRGM2_attemptendmission_Kilo1")] call TRGM_GLOBAL_fnc_notify;
		_bAllow = false;
	};

	if (!_bSLAlive && _bK1_1Alive && str(player) != "k2_1") then {
		[(localize "STR_TRGM2_attemptendmission_Kilo2")] call TRGM_GLOBAL_fnc_notify;
		_bAllow = false;
	};
	if (!_bSLAlive && !_bK1_1Alive && (leader (group player))!=player) then {
			[(localize "STR_TRGM2_attemptendmission_Kilo1")] call TRGM_GLOBAL_fnc_notify;
			_bAllow = false;
	};


};

if (_bAllow) then {
	if (_isFinal) then {
		TRGM_VAR_FinalMissionStarted=true; publicVariable "TRGM_VAR_FinalMissionStarted";
	};

	chopper1 setVariable ["baseLZ", getPos heliPad1, true];
	[chopper1] spawn TRGM_GLOBAL_fnc_flyToBase;
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
	[] remoteExec ["TRGM_SERVER_fnc_startMission",0,true];
	//[(localize "STR_TRGM2_attemptendmission_Ending")] call TRGM_GLOBAL_fnc_notify;
	//[] spawn TRGM_SERVER_fnc_endMission;
};

true;