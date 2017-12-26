#include "..\..\setUnitGlobalVars.sqf";

_option = _this select 0;


//all players will have this run, need to make sure only show for commander


switch (_option) do {
    case "INIT": {
    	//These two lines do the same... just here for my reference
		//{removeAllActions endMissionBoard;} remoteExec ["bis_fnc_call", 0];
		endMissionBoard remoteExec ["removeAllActions"];
		[endMissionBoard, ["Show Rep Report","RandFramework\Campaign\ShowRepReport.sqf"]] remoteExec ["addAction", 0];
		//[endMissionBoard, ["!!Start Mission!!","RandFramework\Campaign\StartMission.sqf"]] remoteExec ["addAction", 0];
		[endMissionBoard, ["!!Start Mission!!","[[],""RandFramework\Campaign\StartMission.sqf""] remoteExec [""BIS_fnc_execVM"",0,true];"]] remoteExec ["addAction", 0];
		[endMissionBoard, ["Recruit Rifleman","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitRifleman]]] remoteExec ["addAction", 0];
		[endMissionBoard, ["Recruit AT Unit","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitAT]]] remoteExec ["addAction", 0];
		[endMissionBoard, ["Recruit AA Unit","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitAA]]] remoteExec ["addAction", 0];
		[endMissionBoard, ["Recruit Engineer","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitEngineer]]] remoteExec ["addAction", 0];
		[endMissionBoard, ["Recruit Explosive Specialist","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitExplosiveSpecialist]]] remoteExec ["addAction", 0];
		[endMissionBoard, ["Recruit Medic","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitMedic]]] remoteExec ["addAction", 0];	
	};
    case "NEW_MISSION": {
    	endMissionBoard remoteExec ["removeAllActions"];
		[endMissionBoard, ["Show Rep Report","RandFramework\Campaign\ShowRepReport.sqf"]] remoteExec ["addAction", 0];
		//[endMissionBoard, ["Quit Current Mission (will lower your rep)","RandFramework\Campaign\QuitMission.sqf"]] remoteExec ["addAction", 0];
		[endMissionBoard, ["Recruit Rifleman","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitRifleman]]] remoteExec ["addAction", 0];
		[endMissionBoard, ["Recruit AT Unit","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitAT]]] remoteExec ["addAction", 0];
		[endMissionBoard, ["Recruit AA Unit","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitAA]]] remoteExec ["addAction", 0];
		[endMissionBoard, ["Recruit Engineer","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitEngineer]]] remoteExec ["addAction", 0];
		[endMissionBoard, ["Recruit Explosive Specialist","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitExplosiveSpecialist]]] remoteExec ["addAction", 0];
		[endMissionBoard, ["Recruit Medic","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitMedic]]] remoteExec ["addAction", 0];	
		if (MaxBadPoints == 3) then {
			[endMissionBoard, ["**Recruit Automatic Rifleman**","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitAuto]]] remoteExec ["addAction", 0];
		};
		if (MaxBadPoints > 3) then {
			[endMissionBoard, ["Recruit Automatic Rifleman","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitAuto]]] remoteExec ["addAction", 0];
		};	
		if (MaxBadPoints == 5) then {
			[endMissionBoard, ["**Recruit Sniper**","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitSniper]]] remoteExec ["addAction", 0];
			[endMissionBoard, ["**Recruit Spotter**","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitSniper]]] remoteExec ["addAction", 0];
		};
		if (MaxBadPoints > 5) then {
			[endMissionBoard, ["Recruit Sniper","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitSniper]]] remoteExec ["addAction", 0];
			[endMissionBoard, ["Recruit Spotter","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitSniper]]] remoteExec ["addAction", 0];
		};	
		if (MaxBadPoints == 7) then {
			[endMissionBoard, ["**Recruit UAV Operator**","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitUAV]]] remoteExec ["addAction", 0];
		};
		if (MaxBadPoints > 7) then {
			[endMissionBoard, ["Recruit UAV Operator","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitUAV]]] remoteExec ["addAction", 0];
		};	
    };
    case "MISSION_COMPLETE": {
    	endMissionBoard remoteExec ["removeAllActions"];
    	if (MaxBadPoints >= 10) then {
			//[endMissionBoard, ["!!Request Final Assignment!!","RandFramework\Campaign\StartMission.sqf"]] remoteExec ["addAction", 0];
			[endMissionBoard, ["!!Request Final Assignment!!","[[],""RandFramework\Campaign\StartMission.sqf""] remoteExec [""BIS_fnc_execVM"",0,true];"]] remoteExec ["addAction", 0];
		} else {
			//[endMissionBoard, ["!!Request Next Mission!!","RandFramework\Campaign\StartMission.sqf"]] remoteExec ["addAction", 0];
			[endMissionBoard, ["!!Request Next Mission!!","[[],""RandFramework\Campaign\StartMission.sqf""] remoteExec [""BIS_fnc_execVM"",0,true];"]] remoteExec ["addAction", 0];
		};
		[endMissionBoard, ["Show Rep Report","RandFramework\Campaign\ShowRepReport.sqf"]] remoteExec ["addAction", 0];
		[endMissionBoard, ["Recruit Rifleman","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitRifleman]]] remoteExec ["addAction", 0];
		[endMissionBoard, ["Recruit AT Unit","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitAT]]] remoteExec ["addAction", 0];
		[endMissionBoard, ["Recruit AA Unit","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitAA]]] remoteExec ["addAction", 0];
		[endMissionBoard, ["Recruit Engineer","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitEngineer]]] remoteExec ["addAction", 0];
		[endMissionBoard, ["Recruit Explosive Specialist","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitExplosiveSpecialist]]] remoteExec ["addAction", 0];
		[endMissionBoard, ["Recruit Medic","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitMedic]]] remoteExec ["addAction", 0];	
		if (MaxBadPoints == 3) then {
			[endMissionBoard, ["**Recruit Automatic Rifleman**","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitAuto]]] remoteExec ["addAction", 0];
		};
		if (MaxBadPoints > 3) then {
			[endMissionBoard, ["Recruit Automatic Rifleman","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitAuto]]] remoteExec ["addAction", 0];
		};	
		if (MaxBadPoints == 5) then {
			[endMissionBoard, ["**Recruit Sniper**","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitSniper]]] remoteExec ["addAction", 0];
			[endMissionBoard, ["**Recruit Spotter**","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitSniper]]] remoteExec ["addAction", 0];
		};
		if (MaxBadPoints > 5) then {
			[endMissionBoard, ["Recruit Sniper","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitSniper]]] remoteExec ["addAction", 0];
			[endMissionBoard, ["Recruit Spotter","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitSniper]]] remoteExec ["addAction", 0];
		};	
		if (MaxBadPoints == 7) then {
			[endMissionBoard, ["**Recruit UAV Operator**","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitUAV]]] remoteExec ["addAction", 0];
		};
		if (MaxBadPoints > 7) then {
			[endMissionBoard, ["Recruit UAV Operator","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitUAV]]] remoteExec ["addAction", 0];
		};		
		
	};
	case "CAMPAIGN_END": {
		endMissionBoard remoteExec ["removeAllActions"];
		[endMissionBoard, ["Show Rep Report","RandFramework\Campaign\ShowRepReport.sqf"]] remoteExec ["addAction", 0];
		[endMissionBoard, ["End Mission","RandFramework\endMission.sqf"]] remoteExec ["addAction", 0];
	};
};

//iMissionParamType == 5  <<<<< if 5 then campaign
//These two lines do the same... just here for my reference
//{removeAllActions endMissionBoard;} remoteExec ["bis_fnc_call", 0];
//endMissionBoard remoteExec ["removeAllActions"];
//[endMissionBoard, ["View Campaign Options and report",""]] remoteExec ["addAction", 0];
//[endMissionBoard, ["Show Rep Report","RandFramework\Campaign\ShowRepReport.sqf"]] remoteExec ["addAction", 0];
//[endMissionBoard, ["Start Mission","RandFramework\Campaign\StartMission.sqf"]] remoteExec ["addAction", 0];
//[endMissionBoard, ["Quit Current Mission (will lower your rep)","RandFramework\Campaign\QuitMission.sqf"]] remoteExec ["addAction", 0];
//[endMissionBoard, ["Recruit Rifleman","RandFramework\Campaign\RecruiteRifleman.sqf"]] remoteExec ["addAction", 0];
//[endMissionBoard, ["Request Small transport chopper","RandFramework\Campaign\RequestChopper.sqf"]] remoteExec ["addAction", 0];
