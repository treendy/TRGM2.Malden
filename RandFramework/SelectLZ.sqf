titleText["Select Map Position outside the AO areas", "PLAIN"];
onMapSingleClick "[_pos] execVM ""RandFramework\FlyToLZ.sqf""; onMapSingleClick '';true;";
//onMapSingleClick "vehicle player setPos _pos; onMapSingleClick '';true;";


_color = "ColorRed";

_mrkPos = createMarker ["mrkTempAO1", getMarkerPos "mrkFirstLocation"]; 
_mrkPos setMarkerShape "ELLIPSE";
_mrkPos setMarkerSize [900,900];
_mrkPos setMarkerColor _color;
_mrkPos setMarkerAlpha 0.5;

_mrkPos2 = createMarker ["mrkTempAO2", getMarkerPos "mrkSecondLocation"]; 
_mrkPos2 setMarkerShape "ELLIPSE";
_mrkPos2 setMarkerSize [900,900];
_mrkPos2 setMarkerColor _color;
_mrkPos2 setMarkerAlpha 0.5;