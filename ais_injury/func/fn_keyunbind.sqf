// by psycho
// unbind some key functions while the player is unconcious (caused by stupid 3.0)
private ["_key","_return"];
_key = _this select 1;
_return = false;

if ((player getVariable ['unit_is_unconscious',false]) && {_key in [35]}) then {[player] call tcb_fnc_callHelp};	// key "H" --> call for Help
_return = if ((player getVariable ['unit_is_unconscious',false]) && {_key in [23,34]}) then {true} else {false};		// "I"/"G"  ---> throw grenade

{
	if ((player getVariable ['unit_is_unconscious',false]) && {_key in (actionKeys _x)}) then {
		_return = (_key == (actionKeys _x) select 0);
	};
} forEach ['ReloadMagazine','Gear','SwitchWeapon','Diary'];

if (tcb_ais_noChat) then {
	if (player getVariable ['unit_is_unconscious',false] && {_key in (actionKeys 'Chat')}) then {
		_return = (_key == (actionKeys 'Chat') select 0);
		["<t size='0.8' shadow='1' color='#ffffff' font='PuristaMedium'>Chat disabled.", (safeZoneX - 0.2), (safeZoneY + 0.3), 3, 1, 0, 1] spawn BIS_fnc_dynamicText;
	};
};

_return