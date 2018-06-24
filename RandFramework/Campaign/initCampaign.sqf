//call script to start campaign if campaign picked
//show noticboard to player
//	- Current Reputation Points and report
//	- a random mission will have started, when RTB, welldone message and tell to go to board for next assignment (when picked, fade out and in with new weather/time settings)
//			- show label on screen as fade in "Day 2 : 18:46 PM - Destroy Cache near XXX"
//	- option to request asset or recrute unit
//	- if 10 rep, then the mission to load will be a main mission, with 2 optional sides for intel only!  (may have to be negative 10??? instead of rewritig the rep stuff)
	

//try to run it all on server (the two below need to run on server!)
//call compile preprocessFileLineNumbers  "RandFramework\SetTimeAndWeather.sqf";
//call compile preprocessFileLineNumbers  "RandFramework\startInfMission.sqf";






if (SaveType == 0) then {
	[["INIT"],"RandFramework\Campaign\SetMissionBoardOptions.sqf"] remoteExec ["BIS_fnc_execVM",0,true];
	MaxBadPoints = 1;
	publicVariable "MaxBadPoints";
}
else {
	[["MISSION_COMPLETE"],"RandFramework\Campaign\SetMissionBoardOptions.sqf"] remoteExec ["BIS_fnc_execVM",0,true];
};


if (!isnil "k1_2") then {if (!isPlayer k1_2) then {deleteVehicle k1_2;}};
if (!isnil "k1_3") then {if (!isPlayer k1_3) then {deleteVehicle k1_3;}};
if (!isnil "k1_4") then {if (!isPlayer k1_4) then {deleteVehicle k1_4;}};
if (!isnil "k1_5") then {if (!isPlayer k1_5) then {deleteVehicle k1_5;}};	
if (!isnil "k1_6") then {if (!isPlayer k1_6) then {deleteVehicle k1_6;}};		
if (!isnil "k1_7") then {if (!isPlayer k1_7) then {deleteVehicle k1_7;}};	

CampaignInitiated = true;
publicVariable "CampaignInitiated";


//hint "go to the board to get started"



