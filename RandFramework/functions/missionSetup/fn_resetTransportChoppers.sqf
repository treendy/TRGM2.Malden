//sends the transport chopper back to base, teleports both base choppers to their helipads with engines off and clears the escort chopper's waypoints
params [["_bClearTransportWaypoints", false]];

if (_bClearTransportWaypoints) then {
	private _transportPilot = driver chopper1;
	{
		deleteWaypoint _x
	} forEach waypoints group _transportPilot;
};
chopper1 setVariable ["baseLZ", getPos heliPad1, true];
[chopper1] spawn TRGM_fnc_flyToBase;
chopper1 setPos getPos heliPad1;
chopper2 setPos getPos airSupportHeliPad;
"transportChopper" setMarkerPos getPos chopper1;
chopper1 engineOn false;
chopper2 engineOn false;
private _escortPilot = driver chopper2;
{
	deleteWaypoint _x
} forEach waypoints group _escortPilot;
