params["_vehicle","_redZonePositions","_vehiclePositon","_baseLZPos","_radius","_minimumDistance","_markers","_baseRadius","_baseReturnAllowed","_isPickup"];
scopeName "onMapClickedHandler";

_resetMapState = {
	onMapSingleClick ""; // unregister click listener
	//delete markers
	{ deleteMarkerLocal _X; } forEach _markers;
};

if (_baseReturnAllowed && _pos distance2D _baseLZPos <= _baseRadius) then {
	// click on base area
	[_vehicle,localize "STR_TRGM2_transport_fnselectLzOnMapClick_RTB"] spawn TRGM_fnc_commsPilotToVehicle;
	[_vehicle] spawn TRGM_fnc_flyToBase;

	call _resetMapState;
} else {
	if (!_baseReturnAllowed && _pos distance2D _baseLZPos <= _baseRadius) then {
		hint (localize "STR_TRGM2_transport_fnselectLzOnMapClick_TooCloseBase");
		breakOut "onMapClickedHandler"; // no need to check more
	};

	{
		if ((_x distance2D _pos) < _radius) then {
			hint (localize "STR_TRGM2_transport_fnselectLzOnMapClick_TooCloseAO");
			breakOut "onMapClickedHandler"; // no need to check more
		};
	} forEach _redZonePositions;

	if (!(objNull isEqualTo _vehiclePositon) && (_vehiclePositon distance2D _pos < _minimumDistance)) then {
		hint (localize "STR_TRGM2_transport_fnselectLzOnMapClick_TooCloseWalk");
		breakOut "onMapClickedHandler"; // no need to check more
	};

	/* Find a save landing Position */

	_safeLandingZonePosition = nil;
	_safeLandingZonePosition = [_pos , 0, 50, 20, 0, 0.3, 0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;

	//if no zone found within 50 meters of selected pos, then search wider
	if (_safeLandingZonePosition select 0 == 0) then { // no safe zone found
		_safeLandingZonePosition = [_pos , 0, 200, 20, 0, 0.3, 0,[],[[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
	};

	if (_safeLandingZonePosition select 0 == 0) then { // no safe zone found
		hint (localize "STR_TRGM2_transport_fnselectLzOnMapClick_LessBuildUp");
	} else {
		call _resetMapState;
		[_safeLandingZonePosition, _vehicle, _isPickup] spawn TRGM_fnc_flyToLZ;
		//openMap false; //better leave it open ?
	};

};
