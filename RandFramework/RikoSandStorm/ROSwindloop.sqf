// Requires ROSsandstorm.sqf by RickOShay

_dur = _this select 0;
_endtime = (_this select 1) - 30;
_test = _this select 2;

if (_test) then {hint "Start Wind loop";};
// 60 secs per loop
    While {time < _endtime} do {
        playsound ["sswindloop", true];
        sleep 60;
    };
if (_test) then {hint "Start Wind outro sound"; sleep 1;};
//60 secs
playsound ["sswindoutro", true];

