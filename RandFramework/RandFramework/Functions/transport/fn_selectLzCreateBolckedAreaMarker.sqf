params ["_position","_radius",["_color","colorOPFOR"]];

_uniqueMarkerName = format["redZone%1",str(_position)];
_redZoneMarker = createMarkerLocal [_uniqueMarkerName, _position]; 
_redZoneMarker setMarkerShapeLocal "ELLIPSE";
_redZoneMarker setMarkerSizeLocal [_radius, _radius];
_redZoneMarker setMarkerColorLocal _color;
_redZoneMarker setMarkerAlphaLocal 0.5;
// return markerName
_redZoneMarker;