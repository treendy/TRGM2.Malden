params ["_car","_caller","_id"];

_flatPos = nil;
_flatPos = [getPos _car , 5, 10, 5, 2, 0.5, 0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
if (str(_flatPos) == "[0,0,0]") then {
	_flatPos = [getPos _car , 5, 8, 5, 0, 0.5, 0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
	if (str(_flatPos) == "[0,0,0]") then {
		hint (localize "STR_TRGM2_UnloadDingy_NoArea");
	}
	else {
		_dingy = selectRandom FriendlyFastResponseDingy createVehicle _flatPos;
		_dingy addAction [localize "STR_TRGM2_UnloadDingy_push","RandFramework\PushObject.sqf"];
		hint (localize "STR_TRGM2_UnloadDingy_DingyUnloaded");
	};

}
else {
	_dingy = selectRandom FriendlyFastResponseDingy createVehicle _flatPos;
	_dingy addAction [localize "STR_TRGM2_UnloadDingy_push","RandFramework\PushObject.sqf"];
	hint (localize "STR_TRGM2_UnloadDingy_DingyUnloadedWater");
};

//hint str(_flatPos);

