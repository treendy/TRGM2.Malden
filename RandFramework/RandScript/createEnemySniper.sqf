/*
player addaction ["testsniper","RandFramework\RandScript\createEnemySniper.sqf"];  
player addaction ["tele","RandFramework\tele.sqf"];  
player allowDamage false;
*/

//player setCaptive true;

_targetPos = _this select 0;
//_targetPos = getPosASL player;


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
		//hint str(_i);
		TestTestTargetPos = str(_targetPos);
		//_pos = [_targetPos, _maxRange, 200, _minHeight, _targetPos] execVM "RandFramework\RandScript\findOverwatchOverride.sqf";
		_pos = [_targetPos, _maxRange, 200, _minHeight, _targetPos] call compile preprocessFileLineNumbers "RandFramework\RandScript\findOverwatchOverride.sqf";
		//_pos = [_targetPos, _maxRange, 200, _minHeight, _targetPos] call BIS_fnc_findOverwatch;
		_spawnedUnit setPos _pos;
		_direction = [getpos _spawnedUnit, _targetPos] call BIS_fnc_DirTo;
		//hint str(_direction);
		_spawnedUnit setDir _direction;
		_spawnedUnit setFormDir _direction;
		_spawnedUnit setUnitPos selectRandom ["MIDDLE","DOWN"];
		
		//_lodPos = [_targetPos select 0, _targetPos select 1, (_targetPos select 2) + 20];
		//Sign_Arrow_Large_Green_F
		//_defi = "Sign_Arrow_Large_Green_F" createVehicle _lodPos;
		_cansee = [objNull, "VIEW"] checkVisibility [eyePos _spawnedUnit, eyePos _spawnedTempTarget];
		_direction2 = [getpos player, getpos _spawnedUnit] call BIS_fnc_DirTo;
		//player setpos _pos;
		//player setDir _direction2;
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
			//[format["mrkSniper%1", time, str(getpos _spawnedUnit select 0)],  position _spawnedUnit, "ICON", "ColorGreen", [0.5,0.5], "SNIPER"] call AIS_Core_fnc_createLocalMarker;
			SniperCount = SniperCount + 1;
		}
		else {
			//[format["mrkSniper%1", time, str(getpos _spawnedUnit select 0)],  position _spawnedUnit, "ICON", "ColorRed", [0.5,0.5], "SNIPER"] call AIS_Core_fnc_createLocalMarker;
			SniperAttemptCount = SniperAttemptCount + 1;
			if (_i < 11) then {
				_minHeight = _minHeight - 1;
				_maxRange = _maxRange - 10;
				_minRange = _minRange - 45;
				//hint str( _minRange);
			};
			//deleteVehicle _spawnedUnit;
			//deleteVehicle _spawnedTempTarget
		};
	};
	//hint str(_cansee);
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



