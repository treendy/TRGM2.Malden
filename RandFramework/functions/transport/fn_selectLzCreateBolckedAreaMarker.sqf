params ["_position","_radius",["_color","colorOPFOR"]];

_uniqueMarkerName = format["redZone%1",str(_position)];
_redZoneMarker = createMarkerLocal [_uniqueMarkerName, _position]; 
_redZoneMarker setMarkerShape "ELLIPSE";
_redZoneMarker setMarkerSize [_radius, _radius];
_redZoneMarker setMarkerColor _color;
_redZoneMarker setMarkerAlpha 0.5;
// return markerName
_redZoneMarker;