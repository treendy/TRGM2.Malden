//if a player (on foot or driving a car/helicopter) is within _radius, _unit stops what it is doing, moves (to _moveToPos, or 6m towards the player when empty) and waves at them for _waveDuration seconds; returns true if a player was found (must be called from scheduled code)
params ["_unit", "_group", ["_radius", 100], ["_waveDuration", 15], ["_moveToPos", []]];

private _waved = false;
private _nearUnits = nearestObjects [(getPos _unit), ["Man","Car","Helicopter"], _radius];
{
	if ((driver _x) in switchableUnits || (driver _x) in playableUnits) exitWith {
		_waved = true;
		private _target = _x;

		//AI commands run here (the server owns the unit), only the animation reset needs to be broadcast
		_unit enableAI "anim";
		[_unit, ""] remoteExec ["switchMove", 0];
		_unit setBehaviour "CARELESS";
		_group setSpeedMode "FULL";
		_unit setUnitPos "UP";

		private _doWave = false;
		private _waveDir = 0;
		if (_moveToPos isEqualTo []) then {
			sleep 0.5;
			if (alive _unit) then {
				_waveDir = [_unit, _target] call BIS_fnc_DirTo;
				_unit doMove (_unit getPos [6,_waveDir]);
				sleep 3;
				_doWave = true;
			};
		}
		else {
			_unit doMove _moveToPos;
			sleep 3;
			if (alive _unit) then {
				_waveDir = [_unit, _target] call BIS_fnc_DirTo;
				_doWave = true;
			};
		};

		if (_doWave) then {
			_unit setDir _waveDir;
			[_unit, ""] remoteExec ["switchMove", 0];
			sleep 0.1;
			[_unit, "Acts_JetsShooterNavigate_loop"] remoteExec ["switchMove", 0];
			_unit disableAI "anim";
			[_unit] spawn {
				params ["_unit"];
				waitUntil {sleep 1; !alive(_unit)};
				[_unit, ""] remoteExec ["switchMove", 0];
			};
			sleep _waveDuration;
			_unit enableAI "anim";
			_unit switchMove "";
		};
	};
} forEach _nearUnits;

_waved
