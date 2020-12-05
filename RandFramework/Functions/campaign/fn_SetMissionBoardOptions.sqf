
_option = _this select 0;


//all players will have this run, need to make sure only show for commander
_dCurrentRep = [TREND_MaxBadPoints - TREND_BadPoints,1] call BIS_fnc_cutDecimals;

{
	// Current missionboard is saved in variable _x
	//These two lines do the same... just here for my reference
	//{removeAllActions endMissionBoard;} remoteExec ["call", 0];
	_x remoteExec ["removeAllActions"];
	[_x, [localize "STR_TRGM2_SetMissionBoardOptions_ShowRep",{[] spawn TREND_fnc_ShowRepReport;}]] remoteExec ["addAction", 0];
} forEach [endMissionBoard, endMissionBoard2];

switch (_option) do {
    case "INIT": {
		{
			[_x, [localize "STR_TRGM2_SetMissionBoardOptions_StartMission",{[false] spawn TREND_fnc_StartMissionPreCheck;}]] remoteExec ["addAction", 0];
		} forEach [endMissionBoard, endMissionBoard2];
	};
    case "NEW_MISSION": {
		{
			[_x, [localize "STR_TRGM2_SetMissionBoardOptions_TurnInMission",{[] spawn TREND_fnc_TurnInMission;}]] remoteExec ["addAction", 0];
		} forEach [endMissionBoard, endMissionBoard2];
    };
    case "MISSION_COMPLETE": {
    	{
			if (_dCurrentRep >= 10) then {
				[_x, [localize "STR_TRGM2_SetMissionBoardOptions_RequestFinal",{[true] spawn TREND_fnc_StartMissionPreCheck;}]] remoteExec ["addAction", 0];
			} else {
				[_x, [localize "STR_TRGM2_SetMissionBoardOptions_RequestNext",{[false] spawn TREND_fnc_StartMissionPreCheck;}]] remoteExec ["addAction", 0];
			};
		} forEach [endMissionBoard, endMissionBoard2];
		if (isMultiplayer) then {
			[endMissionBoard, [localize "STR_TRGM2_SetMissionBoardOptions_EndMission",{_this spawn TREND_fnc_attemptEndMission;}]] remoteExec ["addAction", 0];
		};
	};
	case "CAMPAIGN_END": {
		[endMissionBoard, [localize "STR_TRGM2_SetMissionBoardOptions_EndMission",{_this spawn TREND_fnc_attemptEndMission;}]] remoteExec ["addAction", 0];
	};
};

// The following code is redundant with the new recruit system:
// if (_option != "CAMPAIGN_END") then {
// 	{
// 		[_x, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitRifleman",{_this spawn TREND_fnc_RecruiteInf;},[TREND_CampaignRecruitUnitRifleman,"Rifleman"]]] remoteExec ["addAction", 0];
// 		[_x, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitAT",{_this spawn TREND_fnc_RecruiteInf;},[TREND_CampaignRecruitUnitAT,"ATSpecialist"]]] remoteExec ["addAction", 0];
// 		[_x, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitAA",{_this spawn TREND_fnc_RecruiteInf;},[TREND_CampaignRecruitUnitAA,"AASpecialist"]]] remoteExec ["addAction", 0];
// 		[_x, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitEngineer",{_this spawn TREND_fnc_RecruiteInf;},[TREND_CampaignRecruitUnitEngineer,"Engineer"]]] remoteExec ["addAction", 0];
// 		[_x, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitExplosive",{_this spawn TREND_fnc_RecruiteInf;},[TREND_CampaignRecruitUnitExplosiveSpecialist,"ExplosiveSpecialist"]]] remoteExec ["addAction", 0];
// 		[_x, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitMedic",{_this spawn TREND_fnc_RecruiteInf;},[TREND_CampaignRecruitUnitMedic,"Medic"]]] remoteExec ["addAction", 0];
// 		if (_dCurrentRep == 3) then {
// 			[_x, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitAutomaticRiflemanS",{_this spawn TREND_fnc_RecruiteInf;},[TREND_CampaignRecruitUnitAuto,"Autorifleman"]]] remoteExec ["addAction", 0];
// 		};
// 		if (_dCurrentRep > 3) then {
// 			[_x, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitAutomaticRifleman",{_this spawn TREND_fnc_RecruiteInf;},[TREND_CampaignRecruitUnitAuto,"Autorifleman"]]] remoteExec ["addAction", 0];
// 		};
// 		if (_dCurrentRep == 5) then {
// 			[_x, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitSniperS",{_this spawn TREND_fnc_RecruiteInf;},[TREND_CampaignRecruitUnitSniper,"Sniper"]]] remoteExec ["addAction", 0];
// 			[_x, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitSpotterS",{_this spawn TREND_fnc_RecruiteInf;},[TREND_CampaignRecruitUnitSpotter,"Spotter"]]] remoteExec ["addAction", 0];
// 		};

// 		if (_dCurrentRep > 5) then {
// 			[_x, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitSniper",{_this spawn TREND_fnc_RecruiteInf;},[TREND_CampaignRecruitUnitSniper,"Sniper"]]] remoteExec ["addAction", 0];
// 			[_x, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitSpotter",{_this spawn TREND_fnc_RecruiteInf;},[TREND_CampaignRecruitUnitSpotter,"Spotter"]]] remoteExec ["addAction", 0];
// 		};
// 		if (_dCurrentRep == 7) then {
// 			[_x, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitUAVS",{_this spawn TREND_fnc_RecruiteInf;},[TREND_CampaignRecruitUnitUAV,"UAVOperator"]]] remoteExec ["addAction", 0];
// 		};
// 		if (_dCurrentRep > 7) then {
// 			[_x, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitUAV",{_this spawn TREND_fnc_RecruiteInf;},[TREND_CampaignRecruitUnitUAV,"UAVOperator"]]] remoteExec ["addAction", 0];
// 		};
// 	} forEach [endMissionBoard, endMissionBoard2];
// };

if (!isMultiplayer) then {
	endMissionBoard addAction [localize "STR_TRGM2_SetMissionBoardOptions_Save", {saveGame}];
	endMissionBoard2 addAction [localize "STR_TRGM2_SetMissionBoardOptions_Save", {saveGame}];
};

true;