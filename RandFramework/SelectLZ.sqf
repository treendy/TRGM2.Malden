titleText["Select Map Position outside the AO areas", "PLAIN"];
onMapSingleClick {
	_bDistanceOK = true;
	{
		_distance1 = _x distance _pos;
		if (_distance1 < 900) then {_bDistanceOK = false};
	} forEach ObjectivePossitions;

	if (!_bDistanceOK) then {
		hint "Please choose another location, you have selected a location too close to the AO\n\nTo abort press ESC";
		false;
	} else {
		onMapSingleClick ""; // unregister click listener
		[_pos,chopper1] execVM "RandFramework\FlyToLZ.sqf"; 
		true;
	}
};

{
	_mrkPos = createMarker [format["mrkTempA%1",str(_forEachIndex)], _x]; 
	_mrkPos setMarkerShape "ELLIPSE";
	_mrkPos setMarkerSize [900,900];
	_mrkPos setMarkerColor "ColorRed";
	_mrkPos setMarkerAlpha 0.5;
} forEach ObjectivePossitions;

openMap true;
