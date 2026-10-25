//Fires a white flare 400m above a position, the light effect runs on every machine
params ["_Pos"];

private _flare1 = "F_40mm_white" createvehicle [_Pos select 0, _Pos select 1, 400];
_flare1 setVelocity [0,0,-10];
private _al_flare_light = "#lightpoint" createVehicle getPosATL _flare1;

[_al_flare_light, _flare1] remoteExec ["TRGM_fnc_animateFlareLight", 0];
