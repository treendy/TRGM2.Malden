


sepa = ["<t color='#ffff33'>Put on ear plugs</t>",{
	_u = _this select 1;
	_i = _this select 2;
	if (soundVolume == 1) then {
		1 fadeSound 0.3;
		_u setUserActionText [_i,"<t color='#ffff33'>Take off ear plugs</t>"]
	} else {
		1 fadeSound 1;
		_u setUserActionText [_i,"<t color='#ffff33'>Put on ear plugs</t>"]
	}
},[],-90,false,true,"","_target == vehicle player"];
_this addAction sepa;
_this addEventHandler ["Respawn",{
	1 fadeSound 1;
	(_this select 0) addAction sepa;
}];