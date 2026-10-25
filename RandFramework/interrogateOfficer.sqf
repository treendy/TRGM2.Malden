params ["_thisCiv","_thisPlayer","_id","_params"];
_params params ["_iSelected","_bCreateTask"];

if (side player == FriendlySide) then {

	//task fails if he is dead
	[_thisCiv, _iSelected, _bCreateTask, ["failed","succeeded"] select (alive _thisCiv)] call TRGM_fnc_completeIntelAction;

	if (_bCreateTask) then {
		if (alive _thisCiv) then {
			_thisCiv switchMove "Acts_ExecutionVictim_Loop";
		}
		else {
			hint "He is dead you muppet!";
		};
	}
	else {
		hint "Map updated with intel found";

		removeAllActions _thisCiv;

		if (!([] call TRGM_fnc_revealMainObjective)) then {
			if (alive _thisCiv) then {
				[IntelShownType,"IntOfficer"] spawn TRGM_fnc_showIntel;
				sleep 2;
				[IntelShownType,"IntOfficer"] spawn TRGM_fnc_showIntel;
			}
			else {
				hint (localize "STR_TRGM2_interrogateOfficer_DeadGuy")
			};
		};
	};
};
