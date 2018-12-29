//Parameters
params ["_cutWire"];

_thisBomb = player getVariable ["missionBomb",nil];
_wire = _thisBomb getVariable ["missionBombWire","NONE"];
//compare wires
_compare = [_wire, _cutWire] call BIS_fnc_areEqual;

if (_compare) then {
	cutText ["Wire cut", "PLAIN DOWN"];
	//DEFUSED = true;
	playSound "button_close";
	_thisBomb setVariable ["_wireCut",true,true];
	hint "Timer activated";
	sleep 1;
	_countDown = 10;
	while {_countDown > 0 && !(_thisBomb getVariable ["isDefused",false])} do {
		hint format[localize "STR_TRGM2_BombCountdown",_countDown];
		_countDown = _countDown - 1;
		sleep 1;
	};
	if (!(_thisBomb getVariable ["isDefused",false])) then {
		cutText [localize "STR_TRGM2_IEDOhOh", "PLAIN DOWN"];
		//ARMED = true;
		playSound "button_wrong";
		sleep 1;
		_BOOM = "Bomb_03_F" createVehicleLocal (getPos _thisBomb);
		_BOOM setDamage 1;
		deleteVehicle _thisBomb;
		closeDialog 0;
	};

} else {
	cutText [localize "STR_TRGM2_IEDOhOh", "PLAIN DOWN"];
	//ARMED = true;
	playSound "button_wrong";
	sleep 1;
	_BOOM = "Bomb_03_F" createVehicleLocal (getPos _thisBomb);
	_BOOM setDamage 1;
	deleteVehicle _thisBomb;
	closeDialog 0;
};
