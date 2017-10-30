// by psycho
private ["_unit","_points","_bloodPoint","_bodyPos"];
_unit = _this select 0;

[_unit] call tcb_fnc_resetBleeding;	// prevent duplicate

if ((random 100) < (damage _unit * 100)) then {
	_points = ["Pelvis", "aimpoint", "RightShoulder"];
	_bloodPoint = _points select (floor (random (count _points)));

	_bodyPos = [0,0,0];
	switch (_bloodPoint) do {
		case "aimpoint": {					// Brust
			_ran_x = (0.2 - random 0.3);
			_bodyPos = [_ran_x,0,0.1];
		};
		case "Pelvis": {					// Hüfte
			_bodyPos = [0,0,0.2];
		};
		case "RightShoulder": {				// Schulter rechts
			_bodyPos = [0,0,0.1];
		};
		/*case "neck": {						// Nacken
			_bodyPos = [0,0.1,.04];
		};*/
	};
	
	tcb_ais_areBleeding set [count tcb_ais_areBleeding, [_unit,true,_bodyPos,_bloodPoint]];
	publicVariable "tcb_ais_areBleeding";
};