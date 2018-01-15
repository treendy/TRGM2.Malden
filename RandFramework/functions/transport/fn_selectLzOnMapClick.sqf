params["_vehicle","_redZonePositions","_vehiclePositon","_baseLZPos","_radius","_minimumDistance","_markers","_baseRadius","_baseReturnAllowed","_isPickup"];
scopeName "onMapClickedHandler";

_resetMapState = {
	onMapSingleClick ""; // unregister click listener
	//delete markers	
	{ deleteMarkerLocal _X; } forEach _markers;
};

if (_baseReturnAllowed && _pos distance2D _baseLZPos <= _baseRadius) then {
	// click on base area
	[_vehicle,"Copy that, RTB."] spawn TRGM_fnc_commsPilotToVehicle;
	[_vehicle] spawn TRGM_fnc_flyToBase;
	call _resetMapState;
} else {
	if (!_baseReturnAllowed && _pos distance2D _baseLZPos <= _baseRadius) then {
		hint "Please choose another location, you have selected a location too close to the Base\n\nTo abort press ESC";	
		breakOut "onMapClickedHandler"; // no need to check more
	};

	{
		if ((_x distance2D _pos) < _radius) then {
			hint "Please choose another location, you have selected a location too close to the AO\n\nTo abort press ESC";	
			breakOut "onMapClickedHandler"; // no need to check more
		};
	} forEach _redZonePositions;

	if (!(objNull isEqualTo _vehiclePositon) && (_vehiclePositon distance2D _pos < _minimumDistance)) then {
		hint "You can walk that far soldier!";	
		breakOut "onMapClickedHandler"; // no need to check more
	};

	/* Find a save landing Position */

	_safeLandingZonePosition = nil;
	_safeLandingZonePosition = [_pos , 0, 50, 12, 0, 0.3, 0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;

	//if no zone found within 50 meters of selected pos, then search wider
	if (_safeLandingZonePosition select 0 == 0) then { // no safe zone found
		_safeLandingZonePosition = [_pos , 0, 200, 12, 0, 0.3, 0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
	};
	
	if (_safeLandingZonePosition select 0 == 0) then { // no safe zone found
		hint "Couldnt find a good LZ near your point, please select another.  Try to choose somewhere that is less built up";
	} else {
		call _resetMapState;
		[_safeLandingZonePosition, _vehicle, _isPickup] spawn TRGM_fnc_flyToLZ;
		//openMap false; //better leave it open ?
	};

};
