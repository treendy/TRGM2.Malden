params ["_target", "_caller", "_ID", "_arguments"];

_vehicle = chopper1;//_target;
_redZonePositions = ObjectivePossitions;
_radius = 900;
_minimumDistance = 300;
_markers = [];

// create Markers

// Objective Zones
{
	_markers pushBack ([_x, _radius] call TRGM_fnc_selectLzCreateBolckedAreaMarker);
} forEach _redZonePositions;

// Chopper location when on ground
_vehiclePositon = objNull;
if (isTouchingGround _vehicle) then {
	_vehiclePositon = position _vehicle;
	_markers pushBack ([_vehiclePositon,_minimumDistance , "ColorWhite" ] call TRGM_fnc_selectLzCreateBolckedAreaMarker);
};

// Base LZ
_baseLZPos = _vehicle getVariable ["baseLZ",objNull];
if (!(objNull isEqualTo _baseLZPos)) then {
	_markers pushBack ([_baseLZPos ,_minimumDistance , "ColorWhite" ] call TRGM_fnc_selectLzCreateBolckedAreaMarker);
};

[_vehicle, _redZonePositions, _vehiclePositon,_baseLZPos, _radius,_minimumDistance, _markers] onMapSingleClick TRGM_fnc_selectLZOnMapClick;

openMap true;
titleText["Select Map Position outside the AO areas", "PLAIN"];

waitUntil {!visibleMap || !alive player};
onMapSingleClick "";
{ deleteMarkerLocal _X; } forEach _markers;
