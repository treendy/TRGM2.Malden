params ["_car","_caller","_id"];

_flatPos = nil;
_flatPos = [getPos _car , 5, 10, 5, 2, 0.5, 0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
if (str(_flatPos) == "[0,0,0]") then {
	_flatPos = [getPos _car , 5, 8, 5, 0, 0.5, 0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
	if (str(_flatPos) == "[0,0,0]") then {
		hint "Not enough room near vehicle to unload!";
	}
	else {
		_dingy = selectRandom FriendlyFastResponseDingy createVehicle _flatPos;
		_dingy addAction ["push","RandFramework\PushObject.sqf"];
		hint "Dingy unloaded!";
	};
	
}
else {
	_dingy = selectRandom FriendlyFastResponseDingy createVehicle _flatPos;
	_dingy addAction ["push","RandFramework\PushObject.sqf"];
	hint "Dingy unloaded to nearest water!";
};

//hint str(_flatPos);

