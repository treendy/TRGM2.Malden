params["_vehicle","_redZonePositions","_vehiclePositon","_baseLZPos","_radius","_minimumDistance","_markers","_baseRadius","_baseReturnAllowed","_isPickup"];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;
scopeName "onMapClickedHandler";

_resetMapState = {
    onMapSingleClick ""; // unregister click listener
    //delete markers
    { deleteMarkerLocal _X; } forEach _markers;
};

if (_baseReturnAllowed && _pos distance2D _baseLZPos <= _baseRadius) then {
    // click on base area
    [_vehicle,localize "STR_TRGM2_transport_fnselectLzOnMapClick_RTB"] spawn TRGM_GLOBAL_fnc_commsPilotToVehicle;
    [_vehicle] spawn TRGM_GLOBAL_fnc_flyToBase;

    call _resetMapState;
} else {
    if (!_baseReturnAllowed && _pos distance2D _baseLZPos <= _baseRadius) then {
        [(localize "STR_TRGM2_transport_fnselectLzOnMapClick_TooCloseBase")] call TRGM_GLOBAL_fnc_notify;
        breakOut "onMapClickedHandler"; // no need to check more
    };

    {
        if ((_x distance2D _pos) < _radius) then {
            [(localize "STR_TRGM2_transport_fnselectLzOnMapClick_TooCloseAO")] call TRGM_GLOBAL_fnc_notify;
            breakOut "onMapClickedHandler"; // no need to check more
        };
    } forEach _redZonePositions;

    if (!(objNull isEqualTo _vehiclePositon) && (_vehiclePositon distance2D _pos < _minimumDistance)) then {
        [(localize "STR_TRGM2_transport_fnselectLzOnMapClick_TooCloseWalk")] call TRGM_GLOBAL_fnc_notify;
        breakOut "onMapClickedHandler"; // no need to check more
    };

    /* Find a save landing Position */

    _safeLandingZonePosition = nil;
    _safeLandingZonePosition = [_pos , 0, 50, 20, 0, 0.3, 0,[],[[0,0,0],[0,0,0]],_vehicle] call TRGM_GLOBAL_fnc_findSafePos;

    //if no zone found within 50 meters of selected pos, then search wider
    if (_safeLandingZonePosition select 0 isEqualTo 0) then { // no safe zone found
        _safeLandingZonePosition = [_pos , 0, 200, 20, 0, 0.3, 0,[],[[0,0,0],[0,0,0]],_vehicle] call TRGM_GLOBAL_fnc_findSafePos;
    };

    if (_safeLandingZonePosition select 0 isEqualTo 0) then { // no safe zone found
        [(localize "STR_TRGM2_transport_fnselectLzOnMapClick_LessBuildUp")] call TRGM_GLOBAL_fnc_notify;
    } else {
        call _resetMapState;
        [_safeLandingZonePosition, _vehicle, _isPickup] spawn TRGM_GLOBAL_fnc_flyToLZ;
        //openMap false; //better leave it open ?
    };

};


true;