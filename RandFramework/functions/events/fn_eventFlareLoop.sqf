//fires a red flare above an object every 10 minutes while it is alive (must be spawned)
params ["_obj"];

while{ (alive _obj)} do {
	private _flarePos = getPos _obj;
	private _flare1 = "F_40mm_red" createvehicle [(_flarePos select 0)+20,(_flarePos select 1)+20, 250];
	_flare1 setVelocity [0,0,-10];
	sleep 600;
};
