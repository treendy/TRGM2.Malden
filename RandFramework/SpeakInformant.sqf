params ["_thisCiv","_thisPlayer","_id","_params"];
_params params ["_iSelected","_bCreateTask"];

if (side player == FriendlySide) then {

	//task fails if he is dead
	[_thisCiv, _iSelected, _bCreateTask, ["failed","succeeded"] select (alive _thisCiv)] call TRGM_fnc_completeIntelAction;

	if (_bCreateTask) then {
		if (!alive _thisCiv) then {
			hint "He is dead you muppet!";
		};
	}
	else {
		hint "You start to talk to the informant...";

		_thisCiv disableAI "move";
		sleep 3;
		_thisCiv enableAI "move";

		if (alive _thisCiv) then {
			if (!([] call TRGM_fnc_revealMainObjective)) then {
				[IntelShownType,"SpeakInform"] spawn TRGM_fnc_showIntel;
				sleep 5;
				[IntelShownType,"SpeakInform"] spawn TRGM_fnc_showIntel;
			};
		}
		else {
			hint "He is dead you muppet!";
		};
	};
};
