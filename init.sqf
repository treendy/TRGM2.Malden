
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
		["TRGM2 Engine", sAltisRegainEngine],
		{true},  
		["Mission", sBreifing],        		        
		["Credits", "Scripts used", sScriptsUsed]
] call FHQ_TT_addBriefing;



execVM "RandFramework\mainInit.sqf";

