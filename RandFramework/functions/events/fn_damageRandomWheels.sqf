//breaks each of the four steering wheels of a vehicle with a 50% chance; if _ensureOne is true at least one wheel ends up broken
params ["_veh", ["_ensureOne", true]];

private _wheels = ["wheel_1_1_steering","wheel_1_2_steering","wheel_2_1_steering","wheel_2_2_steering"];
{
	if (selectRandom[true,false]) then {_veh setHit [_x,1];};
} forEach _wheels;

if (_ensureOne && {({(_veh getHit _x) < 0.5} count _wheels) == count _wheels}) then {
	_veh setHit ["wheel_1_1_steering",1];
};
