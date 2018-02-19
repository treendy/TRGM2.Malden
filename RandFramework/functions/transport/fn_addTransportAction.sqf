params ["_vehicle"];

_actionAdapter = {
	params ["_target", "_caller", "_ID", "_arguments"];
	[_target] spawn TRGM_fnc_selectLZ;
};

_actions = [
	[
		localize "STR_TRGM2_transport_fnaddTransportAction_SelectDest",
		_actionAdapter,
		nil,
		-20, //priority
		false,
		true,
		"",
		"_this in (crew _target) && !([_target] call TRGM_fnc_helicopterIsFlying)",
		-1,
		false,
		""
	],
	[
		localize "STR_TRGM2_transport_fnaddTransportAction_DivertLZ",
		_actionAdapter,
		nil,
		-20, //priority
		false,
		true,
		"",
		"_this in (crew _target) && ([_target] call TRGM_fnc_helicopterIsFlying)",
		-1,
		false,
		""
	]
];


_target = [0, -2] select isMultiplayer;
{
	if (isMultiplayer) then {
		if (isServer) then {
			[_vehicle, _x] remoteExec ["addAction",_target,true];
		};
	} else {
		_vehicle addAction _x;
	}
}	foreach _actions;
