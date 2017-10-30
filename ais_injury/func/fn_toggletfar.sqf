// by psycho
_canUse = _this select 0;
if (_canUse) then {
	player setVariable ["tf_unable_to_use_radio", false];
} else {
	player setVariable ["tf_unable_to_use_radio", true];
};

true