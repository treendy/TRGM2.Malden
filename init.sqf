#include "setUnitGlobalVars.sqf";

if (isServer) then {
	FirstSpottedHasHappend = false;
	publicVariable "FirstSpottedHasHappend";
};

if (bUseRevive) then {
	//by psycho
	["%1 --- Executing TcB AIS init.sqf",diag_ticktime] call BIS_fnc_logFormat;
	enableSaving [false,false];
	enableTeamswitch false;
};

call compile preprocessFileLineNumbers "fhqtt2.sqf"; 

tf_give_personal_radio_to_regular_soldier = true; 
publicVariable "tf_give_personal_radio_to_regular_soldier";
 
tf_no_auto_long_range_radio = true;
publicVariable "tf_no_auto_long_range_radio";


[     
		west,        
		["Altis Regain Engine", sAltisRegainEngine],
		{true},  
		["Mission", sBreifing],        		        
		["Credits", "Scripts used", sScriptsUsed]
] call FHQ_TT_addBriefing;


if (bUseRevive) then {
	// TcB AIS Wounding System --------------------------------------------------------------------------
	if (!isDedicated) then {
		TCB_AIS_PATH = "ais_injury\";
		{[_x] call compile preprocessFile (TCB_AIS_PATH+"init_ais.sqf")} forEach (if (isMultiplayer) then {playableUnits} else {switchableUnits});		// execute for every playable unit
		
		//{[_x] call compile preprocessFile (TCB_AIS_PATH+"init_ais.sqf")} forEach (units group player);													// only own group - you cant help strange group members
		
		//{[_x] call compile preprocessFile (TCB_AIS_PATH+"init_ais.sqf")} forEach [p1,p2,p3,p4,p5];														// only some defined units
	};
	// --------------------------------------------------------------------------------------------------------------
};




execVM "RandFramework\mainInit.sqf";



if (!isServer) then {
	waitUntil {!isNull player};
	waitUntil {player == player};
	
	

};

//test
