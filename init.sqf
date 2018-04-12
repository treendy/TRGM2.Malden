
#include "setUnitGlobalVars.sqf";


if (isServer) then {
	FirstSpottedHasHappend = false;
	publicVariable "FirstSpottedHasHappend";
};


call compile preprocessFileLineNumbers "fhqtt2.sqf";

tf_give_personal_radio_to_regular_soldier = true;
publicVariable "tf_give_personal_radio_to_regular_soldier";

tf_no_auto_long_range_radio = true;
publicVariable "tf_no_auto_long_range_radio";


[
		west,
		[(localize "STR_TRGM2_Init_TRGM2Engine"), sAltisRegainEngine],
		{true},
		[(localize "STR_TRGM2_Init_Mission"), sBreifing],
		[(localize "STR_TRGM2_Init_Credits"), (localize "STR_TRGM2_Init_ScriptsUsed"), sScriptsUsed]
] call FHQ_TT_addBriefing;


"Marker1" setMarkerTextLocal (localize "STR_TRGM2_Init_MarkerText_HQ"); //Head Quarters marker localize
"transportChopper" setMarkerTextLocal (localize "STR_TRGM2_Init_MarkerText_TransportChopper"); //Transport Chopper marker localize


execVM "RandFramework\mainInit.sqf";
//call compile preprocessFileLineNumbers "RandFramework\mainInit.sqf";
