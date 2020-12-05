params ["_message"];

if (isNil "TREND_bDebugMode") then {TREND_bDebugMode = false; publicVariable "TREND_bDebugMode";};

if (TREND_bDebugMode) then {
	[format ["[[TREND - DEBUG]] %1", _message]] remoteExec ["systemChat", 0];
};

[format ["[[TREND - DEBUG]] %1", _message]] remoteExec ["diag_log", 0];