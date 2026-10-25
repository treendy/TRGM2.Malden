//returns true if the local player may start/turn in missions: in MP only the K1 lead (sl), or the K2 lead (k2_1) if sl is dead, or any group leader if both are dead; hints the reason if not
if (!isMultiplayer) exitWith {true};

private _bSLAlive = false;
private _bK2LeadAlive = false;
if (!isNil "sl") then { //sl is leader of K1 - k2_1 is leader of K2
	_bSLAlive = alive sl;
};
if (!isNil "k2_1") then {
	_bK2LeadAlive = alive k2_1;
};

private _bAllow = true;
if (_bSLAlive && str(player) != "sl") then {
	hint (localize "STR_TRGM2_attemptendmission_Kilo1");
	_bAllow = false;
};
if (!_bSLAlive && _bK2LeadAlive && str(player) != "k2_1") then {
	hint (localize "STR_TRGM2_attemptendmission_Kilo2");
	_bAllow = false;
};
if (!_bSLAlive && !_bK2LeadAlive && (leader (group player)) != player) then {
	hint (localize "STR_TRGM2_attemptendmission_Kilo1");
	_bAllow = false;
};
_bAllow
