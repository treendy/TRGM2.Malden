// by psycho
private ["_unit"];
_unit = _this select 0;

if (count tcb_ais_areBleeding > 0) then {
	{
		if (_x select 0 == _unit) then {
			tcb_ais_areBleeding set [_forEachIndex, -1];
			_unit setVariable ["PulseTime", -1]; 
			deletevehicle (_unit getVariable ["bloodParticleLogic",objNull]);
			deletevehicle (_unit getVariable ["bloodParticleSource",objNull]);
		};
	} forEach tcb_ais_areBleeding;
};
tcb_ais_areBleeding = tcb_ais_areBleeding - [-1];
//publicVariable "tcb_ais_areBleeding";

true