params ["_thisLaptop", "_caller", "_id", "_params"];
_params params ["_iSelected","_bCreateTask"];

if (side player == FriendlySide) then {

	[_thisLaptop, _iSelected, _bCreateTask, "succeeded", true, true] call TRGM_fnc_completeIntelAction;

	if (!_bCreateTask) then {
		if (!([] call TRGM_fnc_revealMainObjective)) then {
			[IntelShownType,"HackData"] spawn TRGM_fnc_showIntel;
		};
	};
};
