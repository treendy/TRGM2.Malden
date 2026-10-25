//Reveals the hidden main objective marker on the map. Returns true if it was hidden (and is now shown), false if it was already visible
params [["_hintText", localize "STR_TRGM2_bugRadio1_MapUpdated"]];

private _markerName = "mrkMainObjective0"; //NOTE: hard coded zero as only one main task will exist (currently!)
if (getMarkerType _markerName == "empty") exitWith {
	_markerName setMarkerType "mil_unknown";
	hint _hintText;
	true
};
false
