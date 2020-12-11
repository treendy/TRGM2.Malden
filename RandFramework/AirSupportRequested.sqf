// This is a legacy script to allow use with older versions of TRGM that still have execVM functions in the mission.sqm
// Any edits should be done in the main function.
params ["_pointsToAdd","_message"];
[_pointsToAdd, _message] spawn TREND_fnc_AirSupportRequested;