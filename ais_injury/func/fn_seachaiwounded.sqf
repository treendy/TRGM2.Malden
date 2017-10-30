// by psycho
private ["_playerdown","_healer"];
_healer = _this select 0;
_playerdown = _this select 1;

While {alive _playerdown && {_playerdown getVariable "tcb_ais_agony"} && {_healer distance _playerdown > 3} && {alive _healer} && {!(_healer getVariable "tcb_ais_agony")}} do {
	_healer Stop false; _healer doMove position _playerdown;
	sleep 5;
};

if (alive _playerdown && {_playerdown getVariable "tcb_ais_agony"}) then {
	if (_healer != _playerdown && {!(_healer getVariable "tcb_ais_agony")}) then {
		[_playerdown, _healer] spawn tcb_fnc_firstAid;
	};
};