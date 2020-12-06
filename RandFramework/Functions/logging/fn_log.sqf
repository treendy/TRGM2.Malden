params [["_message", ""], ["_systemChat", false]];

if (isNil "TREND_bDebugMode") then {TREND_bDebugMode = false; publicVariable "TREND_bDebugMode";};

if (TREND_bDebugMode && {!_systemChat}) then {
	[format ["[[TREND - DEBUG]] %1", _message]] remoteExec ["systemChat", 0];
};

if (_systemChat) then {
	[format ["[TRGM] %1", _message]] remoteExec ["systemChat", 0];
};

[format ["[[TREND - DEBUG]] %1", _message]] remoteExec ["diag_log", 0];