params ["_target", "_caller", "_id", "_args"];

_flatPos = nil;
_flatPos = [getPos _target, 5, 10, 5, 2, 0.5, 0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
if (str(_flatPos) == "[0,0,0]") then {
	_flatPos = [getPos _target, 5, 8, 5, 0, 0.5, 0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
	if (str(_flatPos) == "[0,0,0]") then {
		hint (localize "STR_TRGM2_UnloadDingy_NoArea");
	}
	else {
		_dingy = selectRandom TREND_FriendlyFastResponseDingy createVehicle _flatPos;
		[_dingy, [format [localize "STR_TRGM2_UnloadDingy_push", getText (configFile >> "CfgVehicles" >> (typeOf _dingy) >> "displayName")],{[_this select 0, _this select 1, _this select 2, _this select 3] spawn TREND_fnc_PushObject;}, [], -99, false, false, "", "_this == player"]] remoteExec ["addAction", 0];
		hint (localize "STR_TRGM2_UnloadDingy_DingyUnloaded");
		_target removeAction _id;
	};

}
else {
	_dingy = selectRandom TREND_FriendlyFastResponseDingy createVehicle _flatPos;
	[_dingy, [format [localize "STR_TRGM2_UnloadDingy_push", getText (configFile >> "CfgVehicles" >> (typeOf _dingy) >> "displayName")],{[_this select 0, _this select 1, _this select 2, _this select 3] spawn TREND_fnc_PushObject;}, [], -99, false, false, "", "_this == player"]] remoteExec ["addAction", 0];
	hint (localize "STR_TRGM2_UnloadDingy_DingyUnloadedWater");
	_target removeAction _id;
};

//hint str(_flatPos);

