// by BonInf*
// changed by Psycho
#define __includedMates (units group _playerdown - [_playerdown])
private ["_playerdown","_closestsquadmate","_min_distance","_distance","_callout"];
_playerdown = _this select 0;
_closestsquadmate = if (count _this > 1) then {_this select 1} else {nil};
_callout = if (count _this > 2) then {_this select 2} else {false};

_delay = if (_callout) then {3 + (random 2)} else {15 + (random 40)};
sleep _delay;

if (count _this > 1) then {
	if (isNull _closestsquadmate || {_closestsquadmate getVariable "tcb_ais_agony"} || {!alive _closestsquadmate}) then {
		_closestsquadmate = Nil;
	};
};
if (isNil "_closestsquadmate") then {
	{if (_x call tcb_fnc_isMedic && {!(_x getVariable "tcb_ais_agony")} && {!isPlayer _x}) exitWith {_closestsquadmate = _x}} forEach __includedMates;

	if (isNil "_closestsquadmate") then {
		_closestsquadmate = _playerdown;
		_min_distance = 100000;
		{
			_distance = _playerdown distance _x;
			if ((_distance < _min_distance) && {!isPlayer _x} && {!(_x getVariable "tcb_ais_agony")}) then {
				_min_distance = _distance;
				_closestsquadmate = _x;
			};
		} foreach __includedMates;
	};
};

if (isNull _closestsquadmate || {_closestsquadmate == _playerdown}) exitWith {[_playerdown] spawn tcb_fnc_sendaihealer};

/*
Hint format ["healer %1 is running",_closestsquadmate];
diag_log format ["healer %1 is running",_closestsquadmate];
*/

While {alive _playerdown && {_playerdown getVariable "tcb_ais_agony"} && {_closestsquadmate distance _playerdown > 4} && {alive _closestsquadmate} && {!(_closestsquadmate getVariable "tcb_ais_agony")}} do {
	_delay = time + 10;
	_closestsquadmate setBehaviour "AWARE";
	if (currentCommand _closestsquadmate != "MOVE") then {_closestsquadmate Stop false; _closestsquadmate doMove (position _playerdown)};
	waitUntil {(_closestsquadmate distance _playerdown <= 4) || {time > _delay}};
};

if (!alive _closestsquadmate || {_closestsquadmate getVariable "tcb_ais_agony"} || {isNull _closestsquadmate}) then {
	[_playerdown] spawn tcb_fnc_sendaihealer;
};

if (alive _playerdown && {_playerdown getVariable "tcb_ais_agony"}) then {
	[_playerdown, _closestsquadmate] spawn tcb_fnc_firstAid;
};