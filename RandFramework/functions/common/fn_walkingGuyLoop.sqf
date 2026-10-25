/*
 * Keeps a unit wandering around a position while it is not alerted.
 * Params: [_objManName (missionNamespace var), _thisInitPos, _walkRadius, _exitWhenAlerted (bool, default false), _initialDelay (default 0)]
 * Must be spawned.
 */
params ["_objManName","_thisInitPos",["_walkRadius",35],["_exitWhenAlerted",false],["_initialDelay",0]];
private _objMan = missionNamespace getVariable _objManName;

group _objMan setSpeedMode "LIMITED";
group _objMan setBehaviour "SAFE";
sleep _initialDelay;

while {alive _objMan} do {
	private _bIsShot = _objMan getVariable ["StopWalkScript", false];
	private _bAlerted = behaviour _objMan == "COMBAT" || _bIsShot;
	if (_bAlerted && _exitWhenAlerted) exitWith {};
	if (!_bAlerted) then {
		[_objManName,_thisInitPos,_objMan,_walkRadius] spawn TRGM_fnc_hvtWalkAround;
		sleep 2;
		waitUntil {sleep 1; speed _objMan < 0.5};
		sleep 10;
	} else {
		sleep 5;
	};
};
