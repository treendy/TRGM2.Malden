params ["_radio","_caller","_id","_params"];
_params params ["_iSelected","_bCreateTask"];

if (side player == FriendlySide) then {

	[_radio, _iSelected, _bCreateTask, "succeeded", true, false, true] call TRGM_fnc_completeIntelAction;

	if (!_bCreateTask) then {
		hint "HQ are listening in, stand by...";
		sleep 10;
		if (!([] call TRGM_fnc_revealMainObjective)) then {
			[IntelShownType,"BugRadio"] spawn TRGM_fnc_showIntel;
		};
	};
};
