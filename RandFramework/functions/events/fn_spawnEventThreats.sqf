//randomly spawns a waiting ambush (optionally with a suicide bomber), a suicide bomber and a sniper near an event; each chance is "1 in N" (0 = never); returns true if an ambush was spawned
params ["_pos", ["_ambushOdds", 0], ["_ambushBomberOdds", 0], ["_bomberOdds", 0], ["_sniperOdds", 0]];

private _fnc_roll = {
	params ["_odds"];
	_odds > 0 && {floor (random _odds) == 0}
};

private _ambushSpawned = false;
if ([_ambushOdds] call _fnc_roll) then {
	[_pos] spawn TRGM_fnc_createWaitingAmbush;
	_ambushSpawned = true;
	if ([_ambushBomberOdds] call _fnc_roll) then {
		[_pos] spawn TRGM_fnc_createWaitingSuicideBomber;
	};
};
if ([_bomberOdds] call _fnc_roll) then {
	[_pos] spawn TRGM_fnc_createWaitingSuicideBomber;
};
if ([_sniperOdds] call _fnc_roll) then {
	[_pos] spawn TRGM_fnc_createEnemySniper;
};

_ambushSpawned
