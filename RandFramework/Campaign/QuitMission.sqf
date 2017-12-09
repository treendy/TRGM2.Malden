#include "..\..\setUnitGlobalVars.sqf";

//'if mission is successs... then do nothing with it
//'otherwise fail the mission'

//{removeAllActions endMissionBoard;} remoteExec ["bis_fnc_call", 0];

//run this as a string?? use CALL command???
[InfSide%1, "failed"] remoteExec [FHQ_TT_setTaskState, 0]   ,   iCampaignDay