if (isDedicated || !hasInterface) exitWith {};
disableSerialization;

if (isNil {uiNamespace getVariable "TREND_notifications_disp"}) then {uiNamespace setVariable ["TREND_notifications_disp", displayNull];};

("Layer_TREND_notifications" call BIS_fnc_rscLayer) cutRsc ["TREND_notifications", "PLAIN", 0.01, false];
waitUntil {!isNull (uiNamespace getVariable ["TREND_notifications_disp", displayNull]);};

private _display = uiNamespace getVariable ["TREND_notifications_disp", displayNull];

uiNamespace setVariable ["TREND_notifications_active", scriptNull];
uiNamespace setVariable ["TREND_notifications_list", []];

!isNull _display;