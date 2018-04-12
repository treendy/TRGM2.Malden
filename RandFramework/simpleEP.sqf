


sepa = [localize "STR_TRGM2_simpleEP_PutOn",{
	_u = _this select 1;
	_i = _this select 2;
	if (soundVolume == 1) then {
		1 fadeSound 0.3;
		_u setUserActionText [_i,localize "STR_TRGM2_simpleEP_TakeOff"]
	} else {
		1 fadeSound 1;
		_u setUserActionText [_i,localize "STR_TRGM2_simpleEP_PutOn"]
	}
},[],-90,false,true,"","_target == vehicle player"];
_this addAction sepa;
_this addEventHandler ["Respawn",{
	1 fadeSound 1;
	(_this select 0) addAction sepa;
}];