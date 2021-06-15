
//'if mission is successs... then do nothing with it
//'otherwise fail the mission'

//{removeAllActions endMissionBoard;} remoteExec ["call", 0];

//run this as a string?? use CALL command???

// This seems to be not called by anything, should it be removed? - TheAce
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;
// [InfSide%1, "failed"] remoteExec [FHQ_fnc_ttSetTaskState, 0], TRGM_VAR_iCampaignDay