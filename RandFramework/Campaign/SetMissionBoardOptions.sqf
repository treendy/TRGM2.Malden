#include "..\..\setUnitGlobalVars.sqf";

_option = _this select 0;


//all players will have this run, need to make sure only show for commander
_dCurrentRep = [MaxBadPoints - BadPoints,1] call BIS_fnc_cutDecimals;

switch (_option) do {
    case "INIT": {
    	//These two lines do the same... just here for my reference
		//{removeAllActions endMissionBoard;} remoteExec ["bis_fnc_call", 0];
		endMissionBoard remoteExec ["removeAllActions"];
		endMissionBoard2 remoteExec ["removeAllActions"];

		[endMissionBoard, [localize "STR_TRGM2_SetMissionBoardOptions_ShowRep","RandFramework\Campaign\ShowRepReport.sqf"]] remoteExec ["addAction", 0];
		[endMissionBoard2, [localize "STR_TRGM2_SetMissionBoardOptions_ShowRep","RandFramework\Campaign\ShowRepReport.sqf"]] remoteExec ["addAction", 0];

		//[endMissionBoard, [localize "STR_TRGM2_SetMissionBoardOptions_StartMission","[[],""RandFramework\Campaign\StartMission.sqf""] remoteExec [""BIS_fnc_execVM"",0,true];"]] remoteExec ["addAction", 0];
		[endMissionBoard, [localize "STR_TRGM2_SetMissionBoardOptions_StartMission",{[false] ExecVM "RandFramework\Campaign\StartMissionPreCheck.sqf"}]] remoteExec ["addAction", 0];
		[endMissionBoard2, [localize "STR_TRGM2_SetMissionBoardOptions_StartMission",{[false] ExecVM "RandFramework\Campaign\StartMissionPreCheck.sqf"}]] remoteExec ["addAction", 0];
		//[endMissionBoard2, ["!!Start Mission!!","[[],""RandFramework\Campaign\StartMission.sqf""] remoteExec [""BIS_fnc_execVM"",0,true];"]] remoteExec ["addAction", 0];

		[endMissionBoard, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitRifleman","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitRifleman,"Rifleman"]]] remoteExec ["addAction", 0];
		[endMissionBoard2, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitRifleman","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitRifleman,"Rifleman"]]] remoteExec ["addAction", 0];

		[endMissionBoard, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitAT","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitAT,"ATSpecialist"]]] remoteExec ["addAction", 0];
		[endMissionBoard2, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitAT","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitAT,"ATSpecialist"]]] remoteExec ["addAction", 0];

		[endMissionBoard, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitAA","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitAA,"AASpecialist"]]] remoteExec ["addAction", 0];
		[endMissionBoard2, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitAA","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitAA,"AASpecialist"]]] remoteExec ["addAction", 0];

		[endMissionBoard, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitEngineer","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitEngineer,"Engineer"]]] remoteExec ["addAction", 0];
		[endMissionBoard2, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitEngineer","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitEngineer,"Engineer"]]] remoteExec ["addAction", 0];

		[endMissionBoard, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitExplosive","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitExplosiveSpecialist,"ExplosiveSpecialist"]]] remoteExec ["addAction", 0];
		[endMissionBoard2, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitExplosive","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitExplosiveSpecialist,"ExplosiveSpecialist"]]] remoteExec ["addAction", 0];

		[endMissionBoard, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitMedic","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitMedic,"Medic"]]] remoteExec ["addAction", 0];
		[endMissionBoard2, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitMedic","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitMedic,"Medic"]]] remoteExec ["addAction", 0];
	};
    case "NEW_MISSION": {
    	endMissionBoard remoteExec ["removeAllActions"];
    	endMissionBoard2 remoteExec ["removeAllActions"];

    	[endMissionBoard, [localize "STR_TRGM2_SetMissionBoardOptions_TurnInMission",{[] ExecVM "RandFramework\Campaign\TurnInMission.sqf";}]] remoteExec ["addAction", 0];
		[endMissionBoard2, [localize "STR_TRGM2_SetMissionBoardOptions_TurnInMission",{[] ExecVM "RandFramework\Campaign\TurnInMission.sqf";}]] remoteExec ["addAction", 0];

		[endMissionBoard, [localize "STR_TRGM2_SetMissionBoardOptions_ShowRep","RandFramework\Campaign\ShowRepReport.sqf"]] remoteExec ["addAction", 0];
		[endMissionBoard2, [localize "STR_TRGM2_SetMissionBoardOptions_ShowRep","RandFramework\Campaign\ShowRepReport.sqf"]] remoteExec ["addAction", 0];

		[endMissionBoard, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitRifleman","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitRifleman,"Rifleman"]]] remoteExec ["addAction", 0];
		[endMissionBoard2, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitRifleman","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitRifleman,"Rifleman"]]] remoteExec ["addAction", 0];

		[endMissionBoard, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitAT","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitAT,"ATSpecialist"]]] remoteExec ["addAction", 0];
		[endMissionBoard2, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitAT","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitAT,"ATSpecialist"]]] remoteExec ["addAction", 0];

		[endMissionBoard, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitAA","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitAA,"AASpecialist"]]] remoteExec ["addAction", 0];
		[endMissionBoard2, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitAA","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitAA,"AASpecialist"]]] remoteExec ["addAction", 0];

		[endMissionBoard, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitEngineer","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitEngineer,"Engineer"]]] remoteExec ["addAction", 0];
		[endMissionBoard2, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitEngineer","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitEngineer,"Engineer"]]] remoteExec ["addAction", 0];

		[endMissionBoard, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitExplosive","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitExplosiveSpecialist,"ExplosiveSpecialist"]]] remoteExec ["addAction", 0];
		[endMissionBoard2, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitExplosive","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitExplosiveSpecialist,"ExplosiveSpecialist"]]] remoteExec ["addAction", 0];

		[endMissionBoard, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitMedic","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitMedic,"Medic"]]] remoteExec ["addAction", 0];
		[endMissionBoard2, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitMedic","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitMedic,"Medic"]]] remoteExec ["addAction", 0];

		if (_dCurrentRep == 3) then {
			[endMissionBoard, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitAutomaticRiflemanS","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitAuto,"Autorifleman"]]] remoteExec ["addAction", 0];
			[endMissionBoard2, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitAutomaticRiflemanS","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitAuto,"Autorifleman"]]] remoteExec ["addAction", 0];
		};
		if (_dCurrentRep > 3) then {
			[endMissionBoard, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitAutomaticRifleman","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitAuto,"Autorifleman"]]] remoteExec ["addAction", 0];
			[endMissionBoard2, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitAutomaticRifleman","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitAuto,"Autorifleman"]]] remoteExec ["addAction", 0];
		};	
		if (_dCurrentRep == 5) then {
			[endMissionBoard, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitSniperS","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitSniper,"Sniper"]]] remoteExec ["addAction", 0];
			[endMissionBoard2, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitSniperS","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitSniper,"Sniper"]]] remoteExec ["addAction", 0];

			[endMissionBoard, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitSpotterS","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitSpotter]]] remoteExec ["addAction", 0];
			[endMissionBoard2, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitSpotterS","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitSpotter]]] remoteExec ["addAction", 0];
		};

		if (_dCurrentRep > 5) then {
			[endMissionBoard, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitSniper","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitSniper,"Sniper"]]] remoteExec ["addAction", 0];
			[endMissionBoard2, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitSniper","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitSniper,"Sniper"]]] remoteExec ["addAction", 0];

			[endMissionBoard, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitSpotter","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitSpotter,"Spotter"]]] remoteExec ["addAction", 0];
			[endMissionBoard2, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitSpotter","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitSpotter,"Spotter"]]] remoteExec ["addAction", 0];
		};	
		if (_dCurrentRep == 7) then {
			[endMissionBoard, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitUAVS","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitUAV,"UAVOperator"]]] remoteExec ["addAction", 0];
			[endMissionBoard2, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitUAVS","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitUAV,"UAVOperator"]]] remoteExec ["addAction", 0];
		};
		if (_dCurrentRep > 7) then {
			[endMissionBoard, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitUAV","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitUAV,"UAVOperator"]]] remoteExec ["addAction", 0];
			[endMissionBoard2, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitUAV","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitUAV,"UAVOperator"]]] remoteExec ["addAction", 0];
		};	
    };
    case "MISSION_COMPLETE": {
    	endMissionBoard remoteExec ["removeAllActions"];
    	endMissionBoard2 remoteExec ["removeAllActions"];

    	if (_dCurrentRep >= 10) then {
			//[endMissionBoard, [localize "STR_TRGM2_SetMissionBoardOptions_RequestFinal","FinalMissionStarted=true;publicVariable ""FinalMissionStarted""; [[],""RandFramework\Campaign\StartMission.sqf""] remoteExec [""BIS_fnc_execVM"",0,true];"]] remoteExec ["addAction", 0];
			[endMissionBoard, [localize "STR_TRGM2_SetMissionBoardOptions_RequestFinal",{[true] ExecVM "RandFramework\Campaign\StartMissionPreCheck.sqf";}]] remoteExec ["addAction", 0];
			[endMissionBoard2, [localize "STR_TRGM2_SetMissionBoardOptions_RequestFinal",{[true] ExecVM "RandFramework\Campaign\StartMissionPreCheck.sqf";}]] remoteExec ["addAction", 0];
			//[endMissionBoard2, ["!!Request Final Assignment!!","[[],""RandFramework\Campaign\StartMission.sqf""] remoteExec [""BIS_fnc_execVM"",0,true];"]] remoteExec ["addAction", 0];
		} else {
			//[endMissionBoard, [localize "STR_TRGM2_SetMissionBoardOptions_RequestNext","[[],""RandFramework\Campaign\StartMission.sqf""] remoteExec [""BIS_fnc_execVM"",0,true];"]] remoteExec ["addAction", 0];
			[endMissionBoard, [localize "STR_TRGM2_SetMissionBoardOptions_RequestNext",{[false] ExecVM "RandFramework\Campaign\StartMissionPreCheck.sqf";}]] remoteExec ["addAction", 0];
			[endMissionBoard2, [localize "STR_TRGM2_SetMissionBoardOptions_RequestNext",{[false] ExecVM "RandFramework\Campaign\StartMissionPreCheck.sqf";}]] remoteExec ["addAction", 0];
			//[endMissionBoard2, ["!!Request Next Mission!!","[[],""RandFramework\Campaign\StartMission.sqf""] remoteExec [""BIS_fnc_execVM"",0,true];"]] remoteExec ["addAction", 0];
		};
		
		[endMissionBoard, [localize "STR_TRGM2_SetMissionBoardOptions_ShowRep","RandFramework\Campaign\ShowRepReport.sqf"]] remoteExec ["addAction", 0];
		[endMissionBoard2, [localize "STR_TRGM2_SetMissionBoardOptions_ShowRep","RandFramework\Campaign\ShowRepReport.sqf"]] remoteExec ["addAction", 0];

		[endMissionBoard, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitRifleman","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitRifleman,"Rifleman"]]] remoteExec ["addAction", 0];
		[endMissionBoard2, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitRifleman","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitRifleman,"Rifleman"]]] remoteExec ["addAction", 0];

		[endMissionBoard, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitAT","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitAT,"ATSpecialist"]]] remoteExec ["addAction", 0];
		[endMissionBoard2, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitAT","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitAT,"ATSpecialist"]]] remoteExec ["addAction", 0];

		[endMissionBoard, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitAA","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitAA,"AASpecialist"]]] remoteExec ["addAction", 0];
		[endMissionBoard2, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitAA","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitAA,"AASpecialist"]]] remoteExec ["addAction", 0];

		[endMissionBoard, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitEngineer","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitEngineer,"Engineer"]]] remoteExec ["addAction", 0];
		[endMissionBoard2, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitEngineer","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitEngineer,"Engineer"]]] remoteExec ["addAction", 0];

		[endMissionBoard, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitExplosive","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitExplosiveSpecialist,"ExplosiveSpecialist"]]] remoteExec ["addAction", 0];
		[endMissionBoard2, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitExplosive","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitExplosiveSpecialist,"ExplosiveSpecialist"]]] remoteExec ["addAction", 0];

		[endMissionBoard, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitMedic","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitMedic,"Medic"]]] remoteExec ["addAction", 0];
		[endMissionBoard2, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitMedic","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitMedic,"Medic"]]] remoteExec ["addAction", 0];

		if (_dCurrentRep == 3) then {
			[endMissionBoard, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitAutomaticRiflemanS","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitAuto,"Autorifleman"]]] remoteExec ["addAction", 0];
			[endMissionBoard2, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitAutomaticRiflemanS","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitAuto,"Autorifleman"]]] remoteExec ["addAction", 0];
		};
		if (_dCurrentRep > 3) then {
			[endMissionBoard, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitAutomaticRifleman","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitAuto,"Autorifleman"]]] remoteExec ["addAction", 0];
			[endMissionBoard2, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitAutomaticRifleman","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitAuto,"Autorifleman"]]] remoteExec ["addAction", 0];
		};	
		if (_dCurrentRep == 5) then {
			[endMissionBoard, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitSniperS","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitSniper,"Sniper"]]] remoteExec ["addAction", 0];
			[endMissionBoard2, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitSniperS","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitSniper,"Sniper"]]] remoteExec ["addAction", 0];


			[endMissionBoard, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitSpotterS","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitSpotter,"Spotter"]]] remoteExec ["addAction", 0];
			[endMissionBoard2, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitSpotterS","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitSpotter,"Spotter"]]] remoteExec ["addAction", 0];
		};

		if (_dCurrentRep > 5) then {
			[endMissionBoard, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitSniper","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitSniper,"Sniper"]]] remoteExec ["addAction", 0];
			[endMissionBoard2, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitSniper","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitSniper,"Sniper"]]] remoteExec ["addAction", 0];

			[endMissionBoard, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitSpotter","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitSpotter,"Spotter"]]] remoteExec ["addAction", 0];
			[endMissionBoard2, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitSpotter","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitSpotter,"Spotter"]]] remoteExec ["addAction", 0];
		};	
		if (_dCurrentRep == 7) then {
			[endMissionBoard, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitUAVS","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitUAV,"UAVOperator"]]] remoteExec ["addAction", 0];
			[endMissionBoard2, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitUAVS","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitUAV,"UAVOperator"]]] remoteExec ["addAction", 0];
		};
		if (_dCurrentRep > 7) then {
			[endMissionBoard, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitUAV","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitUAV,"UAVOperator"]]] remoteExec ["addAction", 0];
			[endMissionBoard2, [localize "STR_TRGM2_SetMissionBoardOptions_RecruitUAV",[CampaignRecruitUnitUAV,"UAVOperator"]]] remoteExec ["addAction", 0];
		};		
		if (isMultiplayer) then {
			[endMissionBoard, [localize "STR_TRGM2_SetMissionBoardOptions_EndMission","RandFramework\attemptEndMission.sqf"]] remoteExec ["addAction", 0];
			//[endMissionBoard2, ["End Mission","RandFramework\attemptEndMission.sqf"]] remoteExec ["addAction", 0];
		};
	};
	case "CAMPAIGN_END": {
		endMissionBoard remoteExec ["removeAllActions"];
		endMissionBoard2 remoteExec ["removeAllActions"];

		[endMissionBoard, [localize "STR_TRGM2_SetMissionBoardOptions_ShowRep","RandFramework\Campaign\ShowRepReport.sqf"]] remoteExec ["addAction", 0];
		[endMissionBoard2, [localize "STR_TRGM2_SetMissionBoardOptions_ShowRep","RandFramework\Campaign\ShowRepReport.sqf"]] remoteExec ["addAction", 0];

		[endMissionBoard, [localize "STR_TRGM2_SetMissionBoardOptions_EndMission","RandFramework\attemptEndMission.sqf"]] remoteExec ["addAction", 0];
		//[endMissionBoard2, ["End Mission","RandFramework\attemptEndMission.sqf"]] remoteExec ["addAction", 0];
		
	};
};
if (!isMultiplayer) then {
	endMissionBoard addAction [localize "STR_TRGM2_SetMissionBoardOptions_Save", {saveGame}];
	endMissionBoard2 addAction [localize "STR_TRGM2_SetMissionBoardOptions_Save", {saveGame}];
};