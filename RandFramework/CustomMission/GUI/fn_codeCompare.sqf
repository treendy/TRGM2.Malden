//Parameters
params ["_inputCode"];

_thisBomb = player getVariable ["missionBomb",nil];
_code = _thisBomb getVariable ["missionBombCODE","NONE"];

_compare = [_code, _inputCode] call BIS_fnc_areEqual;
_isWireCut = _thisBomb getVariable ["_wireCut",false];

if (_compare && _isWireCut) then {
	cutText [localize "STR_TRGM2_BombCodeEntered", "PLAIN DOWN"];
	//DEFUSED = true;
	playSound "button_close";
	_thisBomb setVariable ["_codeEntered",true,true];
	_thisBomb setVariable ["isDefused",true,true];
	[_thisBomb] remoteExec ["removeAllActions", 0, true];
	closeDialog 0;
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
