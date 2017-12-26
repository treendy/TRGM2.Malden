params ["_vehicle"];

_actions = [
	[
		"Custom LZ",
		TRGM_fnc_selectLZ,
		nil,
		-20, //priority
		false,
		true,
		"",
		"_this in (crew _target) && (isTouchingGround _target)",
		-1,
		false,
		""
	],
	[
		"Divert to different LZ",
		TRGM_fnc_selectLZ,
		nil,
		-20, //priority
		false,
		true,
		"",
		"_this in (crew _target) && !(isTouchingGround _target)",
		-1,
		false,
		""
	]
];


_target = [0, -2] select isMultiplayer;
{
	if (isServer) then {
		[_vehicle, _x] remoteExec ["addAction",_target,true];
	} else {
		_vehicle addAction _x;
	}
}	foreach _actions;
