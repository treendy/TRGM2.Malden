params ["_vehicle"];

if (!isServer) exitWith {};


/********************* Add Vehicle Actions ****************/
_actionAdapter = {
	params ["_target", "_caller", "_ID", "_arguments"];
	[_target] spawn TRGM_fnc_selectLZ;
};

// add in vehicle Actions
_actions = [

	// Select Destination when in chopper on ground
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

	// Select Destination when in chopper and flying
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


// add actions on vehicle
{
	//[_vehicle, _x] remoteExec ["addAction",[0, -2] select isMultiplayer,true];
	[_vehicle, _x] remoteExec ["addAction",0,true];
	// TODO: ACE alternative
}	foreach _actions;