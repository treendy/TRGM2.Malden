params ["_thisCiv","_thisPlayer","_unused","_params"];
_params params ["_iSelected","_bCreateTask"];

if (side player == FriendlySide) then {
	//the action is only removed when this is a task (otherwise any player can still confirm the ID)
	[_thisCiv, _iSelected, _bCreateTask, "succeeded", _bCreateTask] call TRGM_fnc_completeIntelAction;

	if (!_bCreateTask) then {
		hint (localize "STR_TRGM2_IdentifyHVT_Confirmed");
	};
};
