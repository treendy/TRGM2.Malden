if (isServer) then 
{
_victim = _this select 0;
_spawnpos = _this select 1;
_distance = _this select 2;
_mode = _this select 3;
_counter = 0;
_woundcount = 0;

	_victim disableai "move";
	if (_mode == 1) then {_woundcount = 1 + round random 1;};
	if (_mode == 2) then {_woundcount = 1 + round random 4;};
	
	if (_mode <3) then 
	{
		while {_counter <= _woundcount} do
		{
			_bodypart = ["head", "body", "hand_l", "hand_l", "hand_r", "leg_l", "leg_r"] call BIS_fnc_selectRandom;
			_Size = 0.2 + random 0.6;
			//_amount = 1 + round random 4;
			_WoundType = ["bullet", "grenade", "explosive", "shell", "vehiclecrash", "backblast", "stab", "punch", "falling", "unknown"] call BIS_fnc_selectRandom;	
			[_victim, _Size, _bodypart, _WoundType] call ace_medical_fnc_addDamageToUnit;
			
			_counter = _counter + 1;	
		};
	
	} else
		{
			[_victim] call ace_medical_fnc_setCardiacArrest;
		};
	
	waituntil {(_victim distance _spawnpos > _distance || !alive _victim)};	
	
	waituntil {(getPos _victim select 2 <= 0.3 && speed (vehicle _victim)  == 0)};
	
	sleep 5;
	deletevehicle _victim;

};


