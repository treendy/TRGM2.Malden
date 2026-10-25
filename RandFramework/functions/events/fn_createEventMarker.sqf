//creates the map marker for an event: in training always shows _trainingText, otherwise a 1 in _distressOdds chance (0 = never) of a "Distress Signal" marker; returns the marker name or ""
params ["_pos", "_trainingText", ["_distressOdds", 4]];

private _markerText = "";
if (!(isNil "IsTraining")) then {
	_markerText = _trainingText;
}
else {
	if (_distressOdds > 0 && {floor (random _distressOdds) == 0}) then {
		_markerText = "Distress Signal";
	};
};

private _marker = "";
if (_markerText != "") then {
	_marker = createMarker [format["_markerEventMedi%1",(call TRGM_fnc_nextMarkerId)], _pos];
	_marker setMarkerShape "ICON";
	_marker setMarkerType "hd_dot";
	_marker setMarkerText _markerText;
};

_marker
