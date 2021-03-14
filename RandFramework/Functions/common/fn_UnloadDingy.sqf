params ["_target", "_caller", "_id", "_args"];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;

_dingy = selectRandom TREND_FriendlyFastResponseDingy createVehicle [0,0,0];
_flatPos = nil;
_flatPos = [getPos _target, 5, 10, 5, 2, 0.5, 0,[],[[0,0,0],[0,0,0]], _dingy] call TREND_fnc_findSafePos;
if (str(_flatPos) isEqualTo "[0,0,0]") then {
	_flatPos = [getPos _target, 5, 8, 5, 0, 0.5, 0,[],[[0,0,0],[0,0,0]], _dingy] call TREND_fnc_findSafePos;
	if (str(_flatPos) isEqualTo "[0,0,0]") then {
		[(localize "STR_TRGM2_UnloadDingy_NoArea")] call TREND_fnc_notify;
		deleteVehicle _dingy;
	}
	else {
		_dingy setPos _flatPos;
		[_dingy, [format [localize "STR_TRGM2_UnloadDingy_push", getText (configFile >> "CfgVehicles" >> (typeOf _dingy) >> "displayName")],{_this spawn TREND_fnc_PushObject;}, [], -99, false, false, "", "_this isEqualTo player && count crew _target isEqualTo 0"]] remoteExec ["addAction", 0];
		[(localize "STR_TRGM2_UnloadDingy_DingyUnloaded")] call TREND_fnc_notify;
		_target removeAction _id;
	};

}
else {
	_dingy setPos _flatPos;
	[_dingy, [format [localize "STR_TRGM2_UnloadDingy_push", getText (configFile >> "CfgVehicles" >> (typeOf _dingy) >> "displayName")],{_this spawn TREND_fnc_PushObject;}, [], -99, false, false, "", "_this isEqualTo player && count crew _target isEqualTo 0"]] remoteExec ["addAction", 0];
	[(localize "STR_TRGM2_UnloadDingy_DingyUnloadedWater")] call TREND_fnc_notify;
	_target removeAction _id;
};

//[str(_flatPos)] call TREND_fnc_notify;

