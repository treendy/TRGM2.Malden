private ["_unit","_nextTime", "_source", "_mylogic", "_blood", "_bodyPos", "_allowBleeding"];

{
	if (typeName _x == "ARRAY") then {
		_unit = _x select 0;
		_allowBleeding = _x select 1;
		_bodyPos = _x select 2;
		_wound = _x select 3;
				
		if(alive _unit && _allowBleeding) then {
			_nextTime = _unit getVariable ["PulseTime", -1];
			if(_nextTime == -1) then {
				_unit setVariable ["PulseTime", diag_tickTime + (1+random 2)];
				_source = "logic" createVehicleLocal (getpos _unit);
				_unit setVariable ["bloodParticleLogic", _source];
				if (vehicle _unit == _unit) then {_source attachto [_unit, _bodyPos, _wound]} else {_allowBleeding = false};
				_unit setVariable ["bloodParticleSource", nil];
			};
			_myParticleSource = _unit getVariable ["bloodParticleSource", nil];
			if (diag_tickTime >= _nextTime && {_allowBleeding} && {isNull (_unit getVariable ["dragger",objNull])} && {isNull (_unit getVariable ["healer",objNull])} && {isNull (_unit getVariable ["helper",objNull])}) then {
				if (isNil "_myParticleSource") then {
					_unit setVariable ["PulseTime", diag_tickTime + 0.5];
					_mylogic = _unit getVariable "bloodParticleLogic";
					_blood = "#particlesource" createVehicleLocal (getpos _mylogic);
					_blood setParticleParams [
						["\a3\Data_f\ParticleEffects\Universal\Universal", 16, 13, 1],
						"",
						"Billboard",
						0.5,
						0.1,																// lifetime
						[0,0,0],
						[(0.3 - (random 0.6)),(0.3 - (random 0.6)),(0.2 + (random 0.3))],	// velocity
						1,0.32,0.2,0.05,													//rotationVel,weight,volume,rubbing
						[0.05,0.25],
						[[0.2,0.01,0.01,1],[0.2,0.01,0.01,0]],								// color
						[0.1],
						1,																	// ran dir
						0.04,																//ran intesnity
						"",
						"",
						_mylogic
					];
					_blood setParticleRandom [2, [0, 0, 0], [0.0, 0.0, 0.0], 0, 0.5, [0, 0, 0, 0.1], 0, 0, 10];
					_blood setDropInterval 0.02;
					_unit setVariable ["bloodParticleSource", _blood];
				} else {
					_unit setVariable ["PulseTime", diag_tickTime + (1.5+random(2))];
					deletevehicle (_unit getVariable ["bloodParticleSource",objNull]);
					_unit setVariable ["bloodParticleSource", nil];
				};
			};
		} else {
			_unit setVariable ["PulseTime", -1]; 
			deletevehicle (_unit getVariable ["bloodParticleLogic",objNull]);
			deletevehicle (_unit getVariable ["bloodParticleSource",objNull]);
			tcb_ais_areBleeding set [_forEachIndex, -1];
		};
	} else {
		_unit setVariable ["PulseTime", -1]; 
		deletevehicle (_unit getVariable ["bloodParticleLogic",objNull]);
		deletevehicle (_unit getVariable ["bloodParticleSource",objNull]);
		tcb_ais_areBleeding set [_forEachIndex, -1];
	};
} forEach tcb_ais_areBleeding;

//["breath", {call my_breath_func}, 0.1] call tcb_fnc_addPerFrame;