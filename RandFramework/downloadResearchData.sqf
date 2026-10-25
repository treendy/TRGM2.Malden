params ["_thisLaptop" , "_caller", "_ID", "_arguments"];
_arguments params ["_iSelected","_bCreateTask"];

if (side player == FriendlySide) then {

	[_thisLaptop, _iSelected, _bCreateTask, "succeeded", true, true] call TRGM_fnc_completeIntelAction;

	if (!_bCreateTask) then {
		[1, "Downloaded research data"] call TRGM_fnc_adjustMaxBadPoints;
		"Data secured, reputation increased" remoteExecCall	["hint",side _caller];
	};

};
