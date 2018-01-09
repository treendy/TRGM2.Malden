

_bAllow = true;
if (isMultiplayer) then {
	_bSLAlive = false;
	_bK1_1Alive = false;
	if (!isnil "sl") then {
		_bSLAlive = alive sl;
	};
	if (!isnil "k2_1") then {
		_bK1_1Alive = alive k2_1;
	};

	if (_bSLAlive && str(player) != "sl") then {
		hint "The Kilo-1 teamleader needs to select this";
		_bAllow = false;
	};

	if (!_bSLAlive && _bK1_1Alive && str(player) != "k2_1") then {
		hint "The Kilo-2 teamleader needs to select this";
		_bAllow = false;
	};
	if (!_bSLAlive && !_bK1_1Alive && (leader (group player))!=player) then {
			hint "The assigned Kilo-1 teamleader needs to select this";
			_bAllow = false;
	};
};


if (_bAllow) then {
	if (SaveType != 0) then {
		[SaveType,false] execVM "RandFramework\Campaign\ServerSave.sqf";
	};	

	if (bAllAtBase) then {
		Hint "Your rep and status has been saved.  Current day is ending";
		["end4", true, 7] remoteExec ["BIS_fnc_endMission"];
		bAttemptedEnd = false; publicVariable "bAttemptedEnd"; 
	}
	else {
		Hint "Campaign details saved, however cant end mission, as all players need to be at base!";
	};
};


