_createRedZoneMarkerLocal = {
	params ["_position","_radius",["_color","colorOPFOR"]];

	_uniqueMarkerName = format["redZone%1",str(_position)];
	_redZoneMarker = createMarkerLocal [_uniqueMarkerName, _position]; 
	_redZoneMarker setMarkerShape "ELLIPSE";
	_redZoneMarker setMarkerSize [_radius, _radius];
	_redZoneMarker setMarkerColor _color;
	_redZoneMarker setMarkerAlpha 0.5;
	// return markerName
	_redZoneMarker;
};

_fnc_onMapClickSelectLZ = {
	params["_vehicle","_redZonePositions","_vehiclePositon","_baseLZPos","_radius","_minimumDistance","_markers"];
	_closeMap = false;

	_bDistanceOK = true;
	{
		scopeName "checkRedZones";
		if ((_x distance2D _pos) < _radius) then {
			_bDistanceOK = false;
			hint "Please choose another location, you have selected a location too close to the AO\n\nTo abort press ESC";	
			breakOut "checkRedZones"; // no need to check more
		};
	} forEach _redZonePositions;

	if (!(objNull isEqualTo _vehiclePositon) && (_vehiclePositon distance2D _pos < _minimumDistance)) then {
		_bDistanceOK = false;
		hint "You can walk that far soldier!";	
	};
	
	if ((!(objNull isEqualTo _baseLZPos)) && ((_baseLZPos distance2D _pos) < _minimumDistance)) then {
		_bDistanceOK = false;
		hint "This is to close to the Base.";	
	};

	if (_bDistanceOK) then {
		/* Find a save landing Position */

		_safeLandingZonePosition = nil;
		_safeLandingZonePosition = [_pos , 0, 200, 8, 0, 0.5, 0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;

		if (_safeLandingZonePosition select 0 == 0) then { // no safe zone found
			hint "Couldnt find a good LZ near your point, please select another.  Try to choose somewhere that is less built up";
		} else {
			onMapSingleClick ""; // unregister click listener

			//delete markers	
			{ deleteMarkerLocal _X; } forEach _markers;

			[_safeLandingZonePosition, _vehicle] execVM "RandFramework\FlyToLZ.sqf";
			//openMap false; //better leave it open ?
		};
	};
};

_chopper = chopper1;
_redZonePositions = ObjectivePossitions;
_radius = 900;
_minimumDistance = 300;
_markers = [];

// create Markers

// Objective Zones
{
	_markers pushBack ([_x, _radius] call _createRedZoneMarkerLocal);
} forEach _redZonePositions;

// Chopper location when on ground
_vehiclePositon = objNull;
if (isTouchingGround _chopper) then {
	_vehiclePositon = position _chopper;
	_markers pushBack ([_vehiclePositon,_minimumDistance , "ColorWhite" ] call _createRedZoneMarkerLocal);
};

// Base LZ
_baseLZPos = _chopper getVariable ["baseLZ",objNull];
if (!(objNull isEqualTo _baseLZPos)) then {
	_markers pushBack ([_baseLZPos ,_minimumDistance , "ColorWhite" ] call _createRedZoneMarkerLocal);
};


[_chopper, _redZonePositions, _vehiclePositon,_baseLZPos, _radius,_minimumDistance, _markers] onMapSingleClick _fnc_onMapClickSelectLZ;

openMap true;
titleText["Select Map Position outside the AO areas", "PLAIN"];

waitUntil {!visibleMap || !alive player};
onMapSingleClick "";
{ deleteMarkerLocal _X; } forEach _markers;
