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

		[_safeLandingZonePosition, _vehicle] spawn TRGM_fnc_flyToLZ;
		//openMap false; //better leave it open ?
	};
};