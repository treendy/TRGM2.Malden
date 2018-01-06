_bAllowEnd = true;

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
		hint "The Kilo-1 teamleader needs to select this";
		_bAllowEnd = false;
	};

	if (!_bSLAlive && _bK1_1Alive && str(player) != "k2_1") then {
		hint "The Kilo-2 teamleader needs to select this";
		_bAllowEnd = false;
	};
	if (!_bSLAlive && !_bK1_1Alive && (leader (group player))!=player) then {
			hint "The Kilo-1 teamleader needs to select this";
			_bAllowEnd = false;
	};


	if (_bAllowEnd) then {
			hint "Mission Ending..."; 
			execVM "RandFramework\endMission.sqf";
	};
};