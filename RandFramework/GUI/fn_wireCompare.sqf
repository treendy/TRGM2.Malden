/*
 * Author: Trendy
 * Takes an input wire color for the mission bomb and compares
 * it with the input from a player, if they are the same
 * the bomb is ready to take a code input, otherwise it blows up.
 *
 * Arguments:
 * 0: The color of the wire that was cut <STRING>
 *
 * Return Value:
 * true <BOOL>
 *
 * Example:
 * ['BLUE'] spawn TRGM_GUI_fnc_wireCompare
 */

params ["_cutWire"];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;

_thisBomb = player getVariable ["missionBomb",nil];
_wire = _thisBomb getVariable ["missionBombWire","NONE"];
//compare wires
_compare = [_wire, _cutWire] call BIS_fnc_areEqual;

if (_compare) then {
	cutText ["Wire cut", "PLAIN DOWN"];
	//DEFUSED = true;
	playSound "button_close";
	_thisBomb setVariable ["_wireCut",true,true];
	["Timer activated"] call TRGM_GLOBAL_fnc_notify;
	sleep 1;
	_countDown = 10;
	while {_countDown > 0 && !(_thisBomb getVariable ["isDefused",false])} do {
		[format[localize "STR_TRGM2_BombCountdown",_countDown]] call TRGM_GLOBAL_fnc_notify;
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

true;