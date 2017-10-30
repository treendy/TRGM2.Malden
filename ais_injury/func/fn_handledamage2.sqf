// by BonInf*
// changed by Psycho and Alwarren
private ['_agony','_return','_revive_factor','_newDamage','_dead','_overall_damage'];
params ["_unit","_bodypart","_damage","_source"];

if (isNull _source && {_unit getVariable "tcb_ais_agony"}) exitWith {_unit getVariable "tcb_ais_damageStore"};	//<-- exclude NullSource break down some other game features!!!
if (_bodypart in ["face_hub","neck","pelvis","spine1","spine2","spine3","body"]) exitWith {/*_unit getVariable ["tcb_ais_damageStore", 0]*/0};

/* Attempt at correcting the damage values */
if (_bodypart == "") then {
	_damage = _damage - (getDammage _unit);
} else {
	_dmg = _unit getHit _bodypart;
	_damage = _damage - _dmg;
};
// Since fire starts to "damage" with minimal damage at a large radio, reduce anything that is less than 1e-7 to zero */
_damage = if (_damage < 1e-7) then {0} else {_damage};

if (_damage > 0) then {
	if (tcb_ais_impactEffects) then {
		[_unit, _damage] call tcb_fnc_impactEffect;
	};
};


_return = _damage / tcb_ais_rambofactor;			// damage scaler to make unit more or less tough
_revive_factor = (tcb_ais_rambofactor max 1) * 1.5;	// only needed if realistic mode is enabled - calculate chance to die instantly (headshoot or heavy explos)
_agony = false;
_dead = false;


//diag_log format ["before ----  part: %1 --- damage: %2 --- return: %3",_bodypart, _damage, _return];

if (!(_unit getVariable "tcb_ais_agony") && {alive _unit}) then {

	switch (toLower _bodypart) do {
		case "": {
			_newDamage = (damage vehicle _unit) + _return;
			if(_newDamage > 0.94) then {
				_agony = true;
				if (tcb_ais_realistic_mode) then {
					if (_newDamage > _revive_factor) then {
						_dead = true;
					};
				};
				_newDamage = 0.98;
			};
			_unit setHit ["body",_newDamage];
		};
		
		case "body": {	// die till 1.0, no overall damage
			_newDamage = (_unit getHit "body") + _return;
			if(_newDamage > 0.99) then {
				_agony = true;
				_newDamage = 0.99;
			};
			_unit setHit ["body",_newDamage];
		};

		case "head": {	// die till 1.0, no overall damage
			if (_damage > 20) exitWith {};	// ghost-dead-bug
			_newDamage = (_unit getHit "head") + _return;
			if(_newDamage > 0.99) then {
				_agony = true;
				if (tcb_ais_realistic_mode) then {
					if (_newDamage > _revive_factor) then {					// evtl. upscaling nötig
						_dead = true;
					};
				};
				_newDamage = 0.99;
			};
			_unit setHit ["head",_newDamage];
		};

		case "legs": {	// cant die, no overall damage
			_newDamage = (_unit getHit "legs") + _return;
			if(_newDamage > 1.8) then {
				_agony = true;
			};
			_newDamage = if (tcb_ais_allways_walk && {_newDamage > 0.49}) then {0.45} else {_newDamage};
			_unit setHit ["legs",_newDamage];
		};
		
		case "hands": {	// cant die, no overall damage
			_newDamage = (_unit getHit "hands") + _return;
			if(_newDamage > 3) then {
				_agony = true;
			};
			_unit setHit ["hands",_newDamage];
		};
		default {};
	};

	
	//_overall_damage = [_unit] call tcb_fnc_setDamage;
	_overall_damage = ((_unit getHit "head") * 0.7) + ((_unit getHit "body") * 0.5) + ((_unit getHit "legs") * 0.3) + ((_unit getHit "hands") * 0.15);
	//_overall_damage = _overall_damage / tcb_ais_rambofactor;

	if (_overall_damage > 0.99) then {
		_overall_damage = if (tcb_ais_realistic_mode) then {_overall_damage} else {0.85 + (random 0.08)};
	};
	
	if (_agony && {!(_unit getVariable "tcb_ais_agony")} && {!_dead} && {_overall_damage <= 0.99}) then {
		_unit setVariable ["tcb_ais_agony", true, true];
		_delay = time + 6;										// invulnerable for time x after fall in agony
		_unit setVariable ["tcb_ais_fall_in_agony_time_delay", _delay];
		
		[_unit, _source] spawn {								// spawn == next Frame...
			if (tcb_ais_score_delay) exitWith {};
			tcb_ais_score_delay = true;
			params ["_unit","_source"];
			if (_unit != _source) then {
				if (side _unit == side _source) then {
					tcb_ais_score = [_source,-1];
				} else {
					tcb_ais_score = [_source,1];
				};
				if (isServer) then {_source addScore (tcb_ais_score select 1)} else {publicVariableServer "tcb_ais_score"};
			};
			sleep 0.3;
			tcb_ais_score_delay = false;
		};
	};
/*	
	if (_overall_damage < 0.4) then {							// ensure blood
		_overall_damage = 0.38;
	};
*/
	if (_dead/* || _overall_damage > 0.99*/) then {					// real death
		_overall_damage = 1;
	};

	//diag_log format ["real ----  part: %1 --- all damage: %2 --- hitpart: %3",_bodypart, _overall_damage, _newDamage];
	
} else {

	_overall_damage = switch (true) do {
		case (!alive _unit) : {0.5};
		case (tcb_ais_pvpMode) : {_unit getVariable ["tcb_ais_damageStore", 1]};
		case (time > (_unit getVariable "tcb_ais_fall_in_agony_time_delay")) : {1};
		default {_unit getVariable ["tcb_ais_damageStore", 1]};
	};
	diag_log format ["real dead ----  part: %1 --- all damage: %2 --- hitpart: %3",_bodypart, _overall_damage, _newDamage];
};

BIS_hitArray = _this; BIS_wasHit = true;
_unit setVariable ["tcb_ais_damageStore", _overall_damage];


_overall_damage