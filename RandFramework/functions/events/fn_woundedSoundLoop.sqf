//plays random wounded moaning from a unit while it is alive (say3D is local, so this is remoteExec'd to every client with JIP)
params ["_unit"];
if (!hasInterface) exitWith {};

while {alive _unit} do {
	_unit say3D selectRandom WoundedSounds;
	sleep selectRandom [2,2.5,3];
};
