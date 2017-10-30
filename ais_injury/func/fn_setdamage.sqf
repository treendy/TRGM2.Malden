//  by psycho
private ["_unit","_return","_fac"];
_unit = _this select 0;

_return = (((_unit getHit "head") * 0.7) + ((_unit getHit "body") * 0.5) + ((_unit getHit "legs") * 0.3) + ((_unit getHit "hands") * 0.15) / tcb_ais_rambofactor);

if (_return > 0.99) then {
	_return = if (tcb_ais_realistic_mode) then {_return} else {0.85 + (random 0.08)};
};

_return