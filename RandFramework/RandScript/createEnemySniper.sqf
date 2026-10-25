

_targetPos = _this select 0;


_targetPos = [_targetPos select 0, _targetPos select 1, 0]; //round (_targetPos select 2)];

_spawnedUnit = nil;
_foundPlace = false;

_maxRange = 800;
_minRange = 600;
_minHeight = 20;

_spawnedUnit = ((createGroup east) createUnit [sSniper, [-135,-253,0], [], 10, "NONE"]);
_spawnedTempTarget = ((createGroup east) createUnit [sSniper, _targetPos, [], 10, "NONE"]);

for "_i" from 1 to 20 do {
	if (!_foundPlace) then {
		TestTestTargetPos = str(_targetPos);
		_pos = [_targetPos, _maxRange, 200, _minHeight, _targetPos] call compile preprocessFileLineNumbers "RandFramework\RandScript\findOverwatchOverride.sqf";
		_spawnedUnit setPos _pos;
		_direction = [getpos _spawnedUnit, _targetPos] call BIS_fnc_DirTo;
		_spawnedUnit setDir _direction;
		_spawnedUnit setFormDir _direction;
		_spawnedUnit setUnitPos selectRandom ["MIDDLE","DOWN"];
		
		_cansee = [objNull, "VIEW"] checkVisibility [eyePos _spawnedUnit, eyePos _spawnedTempTarget];
		_direction2 = [getpos player, getpos _spawnedUnit] call BIS_fnc_DirTo;
		if (_cansee > 0) then {
			_foundPlace = true;
			_spawnedUnit setskill ["aimingAccuracy",0.8];
			_spawnedUnit setskill ["commanding",1];
			_spawnedUnit setskill ["aimingShake",0.2];
			_spawnedUnit setskill ["aimingSpeed",0.2];
			_spawnedUnit setskill ["spotDistance",1];
			_spawnedUnit setskill ["spotTime",1];
			_spawnedUnit setskill ["endurance",1];
			_spawnedUnit setskill ["general",1];
			group _spawnedUnit setCombatMode "RED";	
			SniperCount = SniperCount + 1;
		}
		else {
			SniperAttemptCount = SniperAttemptCount + 1;
			if (_i < 11) then {
				_minHeight = _minHeight - 1;
				_maxRange = _maxRange - 10;
				_minRange = _minRange - 45;
			};
		};
	};
};
deleteVehicle _spawnedTempTarget;

if (_foundPlace) then {
	while {alive(_spawnedUnit)} do {
		sleep 5;
		_distance = 1000;
		_fov = 90;
		eyeDirection _spawnedUnit params ["_dirX","_dirY"];
		_eyedir = _dirX atan2 _dirY;
		if (_eyedir < 0) then {_eyedir = 360 + _eyedir};
		_distance = _distance ^2;

		_enemies = allUnits select {
			side _x == west AND {_x distancesqr _spawnedUnit < _distance} AND {
			acos ([sin _eyedir, cos _eyedir, 0] vectorCos [sin (_spawnedUnit getDir _x), cos (_spawnedUnit getDir _x), 0]) <= _fov/2}
		};
		_enemies apply {_spawnedUnit reveal [_x,4]};
		SniperRevialTotal = count _enemies;
		//consider loop through _enemies, and confirm sniper has Line of sight, before revealing
	};
}
else {
	deleteVehicle _spawnedUnit;
};


/*
SniperRevialTotal
SniperAttemptCount
SniperCount

*/


