format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;
if (TREND_iAllowNVG isEqualTo 0) then {
	player addPrimaryWeaponItem "acc_flashlight";
	player enableGunLights "forceOn";
	{player unassignItem _x; player removeItem _x;} forEach TREND_aNVClassNames;
};