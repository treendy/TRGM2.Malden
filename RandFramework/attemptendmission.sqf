_bAllowEnd = true;

_bSLAlive = false;
_bK1_1Alive = false;
if (!isnil "sl") then {
	_bSLAlive = alive sl;
};
if (!isnil "k1_1") then {
	_bK1_1Alive = alive k1_1;
};

if (_bSLAlive && str(player) != "sl") then {
	hint "The commanding officer needs to select this";
	_bAllowEnd = false;
};

if (!_bSLAlive && _bK1_1Alive && str(player) != "k1_1") then {
	hint "The Kilo-1 teamleader needs to select this";
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
