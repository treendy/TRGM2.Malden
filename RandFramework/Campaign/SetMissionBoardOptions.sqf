#include "..\..\setUnitGlobalVars.sqf"; //this can be replayed for joining players before init.sqf has run, so make sure the globals exist (guarded, only runs once)
//Runs on every client (remoteExec'd with JIP id "TRGM_missionBoardOptions", so only the latest state is replayed for JIP players)
//and sets up the actions on the two mission boards locally
if (!hasInterface) exitWith {};

params ["_option"];

_dCurrentRep = [MaxBadPoints - BadPoints,1] call BIS_fnc_cutDecimals;

_boards = [endMissionBoard, endMissionBoard2];
{removeAllActions _x;} forEach _boards;

_fnc_addBoardAction = {
	params ["_title","_script",["_args",[]],["_bothBoards",true]];
	endMissionBoard addAction [_title,_script,_args];
	if (_bothBoards) then {
		endMissionBoard2 addAction [_title,_script,_args];
	};
};

_fnc_addRecruitAction = {
	params ["_titleKey","_unitClass","_unitRole"];
	[localize _titleKey,"RandFramework\Campaign\RecruiteInf.sqf",[_unitClass,_unitRole]] call _fnc_addBoardAction;
};

//recruits that unlock with rep: [rep needed, title key when exactly on that rep, title key when above, unit class, role]
_fnc_addRecruitActions = {
	[localize "STR_TRGM2_SetMissionBoardOptions_ShowRep","RandFramework\Campaign\ShowRepReport.sqf"] call _fnc_addBoardAction;

	["STR_TRGM2_SetMissionBoardOptions_RecruitRifleman",CampaignRecruitUnitRifleman,"Rifleman"] call _fnc_addRecruitAction;
	["STR_TRGM2_SetMissionBoardOptions_RecruitAT",CampaignRecruitUnitAT,"ATSpecialist"] call _fnc_addRecruitAction;
	["STR_TRGM2_SetMissionBoardOptions_RecruitAA",CampaignRecruitUnitAA,"AASpecialist"] call _fnc_addRecruitAction;
	["STR_TRGM2_SetMissionBoardOptions_RecruitEngineer",CampaignRecruitUnitEngineer,"Engineer"] call _fnc_addRecruitAction;
	["STR_TRGM2_SetMissionBoardOptions_RecruitExplosive",CampaignRecruitUnitExplosiveSpecialist,"ExplosiveSpecialist"] call _fnc_addRecruitAction;
	["STR_TRGM2_SetMissionBoardOptions_RecruitMedic",CampaignRecruitUnitMedic,"Medic"] call _fnc_addRecruitAction;

	{
		_x params ["_repNeeded","_titleKeyOnRep","_titleKeyAboveRep","_unitClass","_unitRole"];
		if (_dCurrentRep == _repNeeded) then {
			[_titleKeyOnRep,_unitClass,_unitRole] call _fnc_addRecruitAction;
		};
		if (_dCurrentRep > _repNeeded) then {
			[_titleKeyAboveRep,_unitClass,_unitRole] call _fnc_addRecruitAction;
		};
	} forEach [
		[3,"STR_TRGM2_SetMissionBoardOptions_RecruitAutomaticRiflemanS","STR_TRGM2_SetMissionBoardOptions_RecruitAutomaticRifleman",CampaignRecruitUnitAuto,"Autorifleman"],
		[5,"STR_TRGM2_SetMissionBoardOptions_RecruitSniperS","STR_TRGM2_SetMissionBoardOptions_RecruitSniper",CampaignRecruitUnitSniper,"Sniper"],
		[5,"STR_TRGM2_SetMissionBoardOptions_RecruitSpotterS","STR_TRGM2_SetMissionBoardOptions_RecruitSpotter",CampaignRecruitUnitSpotter,"Spotter"],
		[7,"STR_TRGM2_SetMissionBoardOptions_RecruitUAVS","STR_TRGM2_SetMissionBoardOptions_RecruitUAV",CampaignRecruitUnitUAV,"UAVOperator"]
	];
};

switch (_option) do {
	case "INIT": {
		[localize "STR_TRGM2_SetMissionBoardOptions_ShowRep","RandFramework\Campaign\ShowRepReport.sqf"] call _fnc_addBoardAction;
		[localize "STR_TRGM2_SetMissionBoardOptions_StartMission",{[false] ExecVM "RandFramework\Campaign\StartMissionPreCheck.sqf"}] call _fnc_addBoardAction;

		["STR_TRGM2_SetMissionBoardOptions_RecruitRifleman",CampaignRecruitUnitRifleman,"Rifleman"] call _fnc_addRecruitAction;
		["STR_TRGM2_SetMissionBoardOptions_RecruitAT",CampaignRecruitUnitAT,"ATSpecialist"] call _fnc_addRecruitAction;
		["STR_TRGM2_SetMissionBoardOptions_RecruitAA",CampaignRecruitUnitAA,"AASpecialist"] call _fnc_addRecruitAction;
		["STR_TRGM2_SetMissionBoardOptions_RecruitEngineer",CampaignRecruitUnitEngineer,"Engineer"] call _fnc_addRecruitAction;
		["STR_TRGM2_SetMissionBoardOptions_RecruitExplosive",CampaignRecruitUnitExplosiveSpecialist,"ExplosiveSpecialist"] call _fnc_addRecruitAction;
		["STR_TRGM2_SetMissionBoardOptions_RecruitMedic",CampaignRecruitUnitMedic,"Medic"] call _fnc_addRecruitAction;
	};
	case "NEW_MISSION": {
		[localize "STR_TRGM2_SetMissionBoardOptions_TurnInMission",{[] ExecVM "RandFramework\Campaign\TurnInMission.sqf";}] call _fnc_addBoardAction;
		[] call _fnc_addRecruitActions;
	};
	case "MISSION_COMPLETE": {
		if (_dCurrentRep >= 10) then {
			[localize "STR_TRGM2_SetMissionBoardOptions_RequestFinal",{[true] ExecVM "RandFramework\Campaign\StartMissionPreCheck.sqf";}] call _fnc_addBoardAction;
		} else {
			[localize "STR_TRGM2_SetMissionBoardOptions_RequestNext",{[false] ExecVM "RandFramework\Campaign\StartMissionPreCheck.sqf";}] call _fnc_addBoardAction;
		};
		[] call _fnc_addRecruitActions;
		if (isMultiplayer) then {
			[localize "STR_TRGM2_SetMissionBoardOptions_EndMission","RandFramework\attemptendmission.sqf",[],false] call _fnc_addBoardAction;
		};
	};
	case "CAMPAIGN_END": {
		[localize "STR_TRGM2_SetMissionBoardOptions_ShowRep","RandFramework\Campaign\ShowRepReport.sqf"] call _fnc_addBoardAction;
		[localize "STR_TRGM2_SetMissionBoardOptions_EndMission","RandFramework\attemptendmission.sqf",[],false] call _fnc_addBoardAction;
	};
};
if (!isMultiplayer) then {
	[localize "STR_TRGM2_SetMissionBoardOptions_Save", {saveGame}] call _fnc_addBoardAction;
};

//full reputation report (was added once in initPlayerLocal, but every board refresh removes all actions)
endMissionBoard addAction [localize "STR_TRGM2_SetMissionBoardOptions_ShowRepLong", {_justPlayers = allPlayers - entities "HeadlessClient_F";_iPlayerCount = count _justPlayers;_iPointsToAdd = 3 / ((_iPlayerCount / 3) * 1.8);_iPointsToAdd = [_iPointsToAdd,1] call BIS_fnc_cutDecimals;hint parseText format[localize "STR_TRGM2_TRGMInitPlayerLocal_FullReputationReport",_iPointsToAdd,BadPoints, MaxBadPoints, MaxBadPoints - BadPoints, BadPointsReason]}];

