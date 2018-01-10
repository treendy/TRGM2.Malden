#include "..\..\setUnitGlobalVars.sqf";

_option = _this select 0;


//all players will have this run, need to make sure only show for commander


switch (_option) do {
    case "INIT": {
    	//These two lines do the same... just here for my reference
		//{removeAllActions endMissionBoard;} remoteExec ["bis_fnc_call", 0];
		endMissionBoard remoteExec ["removeAllActions"];
		endMissionBoard2 remoteExec ["removeAllActions"];

		[endMissionBoard, ["Show Rep Report","RandFramework\Campaign\ShowRepReport.sqf"]] remoteExec ["addAction", 0];
		[endMissionBoard2, ["Show Rep Report","RandFramework\Campaign\ShowRepReport.sqf"]] remoteExec ["addAction", 0];

		[endMissionBoard, ["!!Start Mission!!","[[],""RandFramework\Campaign\StartMission.sqf""] remoteExec [""BIS_fnc_execVM"",0,true];"]] remoteExec ["addAction", 0];
		//[endMissionBoard2, ["!!Start Mission!!","[[],""RandFramework\Campaign\StartMission.sqf""] remoteExec [""BIS_fnc_execVM"",0,true];"]] remoteExec ["addAction", 0];

		[endMissionBoard, ["Recruit Rifleman","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitRifleman]]] remoteExec ["addAction", 0];
		[endMissionBoard2, ["Recruit Rifleman","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitRifleman]]] remoteExec ["addAction", 0];

		[endMissionBoard, ["Recruit AT Unit","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitAT]]] remoteExec ["addAction", 0];
		[endMissionBoard2, ["Recruit AT Unit","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitAT]]] remoteExec ["addAction", 0];

		[endMissionBoard, ["Recruit AA Unit","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitAA]]] remoteExec ["addAction", 0];
		[endMissionBoard2, ["Recruit AA Unit","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitAA]]] remoteExec ["addAction", 0];

		[endMissionBoard, ["Recruit Engineer","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitEngineer]]] remoteExec ["addAction", 0];
		[endMissionBoard2, ["Recruit Engineer","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitEngineer]]] remoteExec ["addAction", 0];

		[endMissionBoard, ["Recruit Explosive Specialist","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitExplosiveSpecialist]]] remoteExec ["addAction", 0];
		[endMissionBoard2, ["Recruit Explosive Specialist","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitExplosiveSpecialist]]] remoteExec ["addAction", 0];

		[endMissionBoard, ["Recruit Medic","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitMedic]]] remoteExec ["addAction", 0];	
		[endMissionBoard2, ["Recruit Medic","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitMedic]]] remoteExec ["addAction", 0];	
	};
    case "NEW_MISSION": {
    	endMissionBoard remoteExec ["removeAllActions"];
    	endMissionBoard2 remoteExec ["removeAllActions"];

		[endMissionBoard, ["Show Rep Report","RandFramework\Campaign\ShowRepReport.sqf"]] remoteExec ["addAction", 0];
		[endMissionBoard2, ["Show Rep Report","RandFramework\Campaign\ShowRepReport.sqf"]] remoteExec ["addAction", 0];

		[endMissionBoard, ["Recruit Rifleman","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitRifleman]]] remoteExec ["addAction", 0];
		[endMissionBoard2, ["Recruit Rifleman","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitRifleman]]] remoteExec ["addAction", 0];

		[endMissionBoard, ["Recruit AT Unit","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitAT]]] remoteExec ["addAction", 0];
		[endMissionBoard2, ["Recruit AT Unit","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitAT]]] remoteExec ["addAction", 0];

		[endMissionBoard, ["Recruit AA Unit","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitAA]]] remoteExec ["addAction", 0];
		[endMissionBoard2, ["Recruit AA Unit","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitAA]]] remoteExec ["addAction", 0];

		[endMissionBoard, ["Recruit Engineer","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitEngineer]]] remoteExec ["addAction", 0];
		[endMissionBoard2, ["Recruit Engineer","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitEngineer]]] remoteExec ["addAction", 0];

		[endMissionBoard, ["Recruit Explosive Specialist","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitExplosiveSpecialist]]] remoteExec ["addAction", 0];
		[endMissionBoard2, ["Recruit Explosive Specialist","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitExplosiveSpecialist]]] remoteExec ["addAction", 0];

		[endMissionBoard, ["Recruit Medic","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitMedic]]] remoteExec ["addAction", 0];	
		[endMissionBoard2, ["Recruit Medic","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitMedic]]] remoteExec ["addAction", 0];	

		if (MaxBadPoints == 3) then {
			[endMissionBoard, ["**Recruit Automatic Rifleman**","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitAuto]]] remoteExec ["addAction", 0];
			[endMissionBoard2, ["**Recruit Automatic Rifleman**","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitAuto]]] remoteExec ["addAction", 0];
		};
		if (MaxBadPoints > 3) then {
			[endMissionBoard, ["Recruit Automatic Rifleman","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitAuto]]] remoteExec ["addAction", 0];
			[endMissionBoard2, ["Recruit Automatic Rifleman","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitAuto]]] remoteExec ["addAction", 0];
		};	
		if (MaxBadPoints == 5) then {
			[endMissionBoard, ["**Recruit Sniper**","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitSniper]]] remoteExec ["addAction", 0];
			[endMissionBoard2, ["**Recruit Sniper**","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitSniper]]] remoteExec ["addAction", 0];

			[endMissionBoard, ["**Recruit Spotter**","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitSniper]]] remoteExec ["addAction", 0];
			[endMissionBoard2, ["**Recruit Spotter**","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitSniper]]] remoteExec ["addAction", 0];
		};
		if (MaxBadPoints > 5) then {
			[endMissionBoard, ["Recruit Sniper","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitSniper]]] remoteExec ["addAction", 0];
			[endMissionBoard2, ["Recruit Sniper","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitSniper]]] remoteExec ["addAction", 0];

			[endMissionBoard, ["Recruit Spotter","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitSniper]]] remoteExec ["addAction", 0];
			[endMissionBoard2, ["Recruit Spotter","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitSniper]]] remoteExec ["addAction", 0];
		};	
		if (MaxBadPoints == 7) then {
			[endMissionBoard, ["**Recruit UAV Operator**","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitUAV]]] remoteExec ["addAction", 0];
			[endMissionBoard2, ["**Recruit UAV Operator**","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitUAV]]] remoteExec ["addAction", 0];
		};
		if (MaxBadPoints > 7) then {
			[endMissionBoard, ["Recruit UAV Operator","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitUAV]]] remoteExec ["addAction", 0];
			[endMissionBoard2, ["Recruit UAV Operator","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitUAV]]] remoteExec ["addAction", 0];
		};	
    };
    case "MISSION_COMPLETE": {
    	endMissionBoard remoteExec ["removeAllActions"];
    	endMissionBoard remoteExec ["removeAllActions"];
    	if (MaxBadPoints >= 10) then {
			[endMissionBoard, ["!!Request Final Assignment!!","[[],""RandFramework\Campaign\StartMission.sqf""] remoteExec [""BIS_fnc_execVM"",0,true];"]] remoteExec ["addAction", 0];
			//[endMissionBoard2, ["!!Request Final Assignment!!","[[],""RandFramework\Campaign\StartMission.sqf""] remoteExec [""BIS_fnc_execVM"",0,true];"]] remoteExec ["addAction", 0];
		} else {
			[endMissionBoard, ["!!Request Next Mission!!","[[],""RandFramework\Campaign\StartMission.sqf""] remoteExec [""BIS_fnc_execVM"",0,true];"]] remoteExec ["addAction", 0];
			//[endMissionBoard2, ["!!Request Next Mission!!","[[],""RandFramework\Campaign\StartMission.sqf""] remoteExec [""BIS_fnc_execVM"",0,true];"]] remoteExec ["addAction", 0];
		};
		[endMissionBoard, ["Show Rep Report","RandFramework\Campaign\ShowRepReport.sqf"]] remoteExec ["addAction", 0];
		[endMissionBoard2, ["Show Rep Report","RandFramework\Campaign\ShowRepReport.sqf"]] remoteExec ["addAction", 0];

		[endMissionBoard, ["Recruit Rifleman","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitRifleman]]] remoteExec ["addAction", 0];
		[endMissionBoard2, ["Recruit Rifleman","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitRifleman]]] remoteExec ["addAction", 0];

		[endMissionBoard, ["Recruit AT Unit","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitAT]]] remoteExec ["addAction", 0];
		[endMissionBoard2, ["Recruit AT Unit","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitAT]]] remoteExec ["addAction", 0];

		[endMissionBoard, ["Recruit AA Unit","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitAA]]] remoteExec ["addAction", 0];
		[endMissionBoard2, ["Recruit AA Unit","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitAA]]] remoteExec ["addAction", 0];

		[endMissionBoard, ["Recruit Engineer","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitEngineer]]] remoteExec ["addAction", 0];
		[endMissionBoard2, ["Recruit Engineer","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitEngineer]]] remoteExec ["addAction", 0];

		[endMissionBoard, ["Recruit Explosive Specialist","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitExplosiveSpecialist]]] remoteExec ["addAction", 0];
		[endMissionBoard2, ["Recruit Explosive Specialist","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitExplosiveSpecialist]]] remoteExec ["addAction", 0];

		[endMissionBoard, ["Recruit Medic","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitMedic]]] remoteExec ["addAction", 0];	
		[endMissionBoard2, ["Recruit Medic","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitMedic]]] remoteExec ["addAction", 0];	

		if (MaxBadPoints == 3) then {
			[endMissionBoard, ["**Recruit Automatic Rifleman**","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitAuto]]] remoteExec ["addAction", 0];
			[endMissionBoard2, ["**Recruit Automatic Rifleman**","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitAuto]]] remoteExec ["addAction", 0];
		};
		if (MaxBadPoints > 3) then {
			[endMissionBoard, ["Recruit Automatic Rifleman","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitAuto]]] remoteExec ["addAction", 0];
			[endMissionBoard2, ["Recruit Automatic Rifleman","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitAuto]]] remoteExec ["addAction", 0];
		};	
		if (MaxBadPoints == 5) then {
			[endMissionBoard, ["**Recruit Sniper**","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitSniper]]] remoteExec ["addAction", 0];
			[endMissionBoard2, ["**Recruit Sniper**","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitSniper]]] remoteExec ["addAction", 0];

			[endMissionBoard, ["**Recruit Spotter**","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitSniper]]] remoteExec ["addAction", 0];
			[endMissionBoard2, ["**Recruit Spotter**","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitSniper]]] remoteExec ["addAction", 0];
		};
		if (MaxBadPoints > 5) then {
			[endMissionBoard, ["Recruit Sniper","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitSniper]]] remoteExec ["addAction", 0];
			[endMissionBoard2, ["Recruit Sniper","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitSniper]]] remoteExec ["addAction", 0];

			[endMissionBoard, ["Recruit Spotter","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitSniper]]] remoteExec ["addAction", 0];
			[endMissionBoard2, ["Recruit Spotter","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitSniper]]] remoteExec ["addAction", 0];
		};	
		if (MaxBadPoints == 7) then {
			[endMissionBoard, ["**Recruit UAV Operator**","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitUAV]]] remoteExec ["addAction", 0];
			[endMissionBoard2, ["**Recruit UAV Operator**","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitUAV]]] remoteExec ["addAction", 0];
		};
		if (MaxBadPoints > 7) then {
			[endMissionBoard, ["Recruit UAV Operator","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitUAV]]] remoteExec ["addAction", 0];
			[endMissionBoard2, ["Recruit UAV Operator","RandFramework\Campaign\RecruiteInf.sqf",[CampaignRecruitUnitUAV]]] remoteExec ["addAction", 0];
		};		
		[endMissionBoard, ["!EXIT MISSON (will save if save active)!","RandFramework\Campaign\exitCampaign.sqf"]] remoteExec ["addAction", 0];
		//[endMissionBoard2, ["!EXIT MISSON (will save if save active)!","RandFramework\Campaign\exitCampaign.sqf"]] remoteExec ["addAction", 0];
		
	};
	case "CAMPAIGN_END": {
		endMissionBoard remoteExec ["removeAllActions"];
		//endMissionBoard2 remoteExec ["removeAllActions"];

		[endMissionBoard, ["Show Rep Report","RandFramework\Campaign\ShowRepReport.sqf"]] remoteExec ["addAction", 0];
		[endMissionBoard2, ["Show Rep Report","RandFramework\Campaign\ShowRepReport.sqf"]] remoteExec ["addAction", 0];

		[endMissionBoard, ["End Mission","RandFramework\attemptEndMission.sqf"]] remoteExec ["addAction", 0];
		//[endMissionBoard2, ["End Mission","RandFramework\attemptEndMission.sqf"]] remoteExec ["addAction", 0];
	};
};
