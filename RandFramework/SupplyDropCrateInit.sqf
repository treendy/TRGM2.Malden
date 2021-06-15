// This is a legacy script to allow use with older versions of TRGM that still have execVM functions in the mission.sqm
// Any edits should be done in the main function.
params ["_thisBox"];
[_thisBox] spawn TRGM_CLIENT_fnc_supplyDropCrateInit;