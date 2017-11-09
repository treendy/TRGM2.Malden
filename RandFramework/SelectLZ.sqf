titleText["Select Map Position outside the AO areas", "PLAIN"];


onMapSingleClick {
	[_pos] execVM "RandFramework\FlyToLZ.sqf"; 
	onMapSingleClick '';
	true;
};
_color = "ColorRed";


{
	_mrkPos = createMarker [format["mrkTempA%1",str(_forEachIndex)], _x]; 
	_mrkPos setMarkerShape "ELLIPSE";
	_mrkPos setMarkerSize [900,900];
	_mrkPos setMarkerColor _color;
	_mrkPos setMarkerAlpha 0.5;
} forEach ObjectivePossitions;


