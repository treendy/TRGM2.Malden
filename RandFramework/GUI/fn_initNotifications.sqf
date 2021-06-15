if (isDedicated || !hasInterface) exitWith {};
disableSerialization;

if (isNil {uiNamespace getVariable "TRGM_VAR_notifications_disp"}) then {uiNamespace setVariable ["TRGM_VAR_notifications_disp", displayNull];};

("Layer_TRGM_VAR_notifications" call BIS_fnc_rscLayer) cutRsc ["TRGM_VAR_notifications", "PLAIN", 0.01, false];
waitUntil {!isNull (uiNamespace getVariable ["TRGM_VAR_notifications_disp", displayNull]);};

private _display = uiNamespace getVariable ["TRGM_VAR_notifications_disp", displayNull];

uiNamespace setVariable ["TRGM_VAR_notifications_active", scriptNull];
uiNamespace setVariable ["TRGM_VAR_notifications_list", []];

!isNull _display;