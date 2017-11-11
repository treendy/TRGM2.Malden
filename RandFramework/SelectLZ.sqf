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

_chopper = chopper1;
_redZonePositions = ObjectivePossitions;
_radius = 900;
_minimumDistance = 300;
_markers = [];

// create Markers
{
	_markers pushBack ([_x, _radius] call _createRedZoneMarkerLocal);
} forEach _redZonePositions;
_markers pushBack ([position _chopper,_minimumDistance , "ColorWhite" ] call _createRedZoneMarkerLocal);

[_chopper, _redZonePositions, _radius,_minimumDistance, _markers] onMapSingleClick {
	params["_vehicle","_redZonePositions","_radius","_minimumDistance","_markers"];
	_closeMap = false;

	_bDistanceOK = true;
	{
		scopeName "checkRedZones";
		if ((_x distance _pos) < _radius) then {
			_bDistanceOK = false;
			hint "Please choose another location, you have selected a location too close to the AO\n\nTo abort press ESC";	
			breakOut "checkRedZones"; // no need to check more
		};
	} forEach _redZonePositions;

	if (((position _vehicle) distance _pos) < _minimumDistance) then {
		_bDistanceOK = false;
		hint "You can walk that far soldier!";	
	};

	if (_bDistanceOK) then {
		onMapSingleClick ""; // unregister click listener

		//delete markers	
		{ deleteMarkerLocal _X; } forEach _markers;

		[_pos, _vehicle] execVM "RandFramework\FlyToLZ.sqf";
		//openMap false; //better leave it open ?
	};
};

openMap true;
titleText["Select Map Position outside the AO areas", "PLAIN"];

waitUntil {!visibleMap};
{ deleteMarkerLocal _X; } forEach _markers;
