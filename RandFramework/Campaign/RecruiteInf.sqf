#include "..\..\setUnitGlobalVars.sqf";

params ["_object","_caller","_id","_params"];
_params params ["_unitClass","_unitRole"];


//CampaignRecruitUnitRifleman createUnit [getPos player, group player];

//YEAH_fnc_whatever = compile preprocessFile "RandFramework\functions\common\fn_CountSpentPoints.sqf";
//_currentSpentPoints = [] call YEAH_fnc_whatever;
_currentSpentPoints = [] call TRGM_fnc_CountSpentPoints;

//plus 1 is an initial allowance
if (_currentSpentPoints < (MaxBadPoints - BadPoints + 1)) then {

	_SpawnedUnit = (group player createUnit [_unitClass, getPos player, [], 10, "NONE"]);
	addSwitchableUnit _SpawnedUnit;
	player doFollow player; //seemed because player has no units to start, when you add one, the player has "Stop" under his name and no units follow him
	_SpawnedUnit setVariable ["RepCost", 0.5, true];
	_SpawnedUnit setVariable ["IsFRT", true, true];
	_SpawnedUnit setVariable ["UnitRole",_unitRole];
	[_SpawnedUnit] execVM "RandFramework\setLoadout.sqf";
	//script_handler = [_SpawnedUnit] execVM "RandFramework\setLoadout.sqf";
	//waitUntil { scriptDone script_handler };
	sleep 0.5;

	{
		box1 addMagazineCargoGlobal [_x, 3];
	} forEach magazines _SpawnedUnit + primaryWeaponMagazine _SpawnedUnit + secondaryWeaponMagazine _SpawnedUnit;
	{
		box1 addItemCargoGlobal  [_x, 1];
	} forEach items _SpawnedUnit;
	box1 addBackpackCargoGlobal [typeof(unitBackpack _SpawnedUnit), 1];

	_SpawnedUnit addEventHandler ["killed",
		{
			//hint format["TEST: %1", CampaignRecruitUnitRifleman];
			_tombStone = selectRandom TombStones createVehicle GraveYardPos;
			_tombStone setDir GraveYardDirection;
			_tombStone setVariable ["Message", format[localize "STR_TRGM2_RecruiteInf_KIA",name (_this select 0)],true];
			_tombStone addAction [localize "STR_TRGM2_RecruiteInf_Read",{hint format["%1",(_this select 0) getVariable "Message"]}];
			[0.2, format[localize "STR_TRGM2_RecruiteInf_KIA",name (_this select 0)]] execVM "RandFramework\AdjustBadPoints.sqf";
		}];
	//spawn tombstone with name on it
	hint format[localize "STR_TRGM2_RecruiteInf_UnitAdd", name _SpawnedUnit,_currentSpentPoints+0.5,MaxBadPoints - BadPoints + 1];

	if (bUseRevive) then {
				[_SpawnedUnit] call AIS_System_fnc_loadAIS;

				//[_SpawnedUnit] call AIS_Core_fnc_aisInitHost;
				//_SpawnedUnit removeAllEventHandlers "HandleHeal";
				//_SpawnedUnit addEventHandler ["HandleHeal", {_this call AIS_System_fnc_handleHeal}];

				//if (_SpawnedUnit getVariable ["ais_unconscious", false]) then {
				//	if (!isNull(_SpawnedUnit getVariable ["ais_DragDrop_Player", objNull])) then {
				//		_SpawnedUnit switchMove "AinjPpneMrunSnonWnonDb";
				//	} else {
				//		_SpawnedUnit playActionNow "agonyStart";
				//	};
				//};


		{
			//{
			//	_x removeAllEventHandlers "HandleHeal";
			//	_x addEventHandler ["HandleHeal", {_this call AIS_System_fnc_handleHeal}];
			//
			//	if (_x getVariable ["ais_unconscious", false]) then {
			//		if (!isNull(_x getVariable ["ais_DragDrop_Player", objNull])) then {
			//			_x switchMove "AinjPpneMrunSnonWnonDb";
			//		} else {
			//			_x playActionNow "agonyStart";
			//		};
			//	};
			//} forEach (if (isMultiplayer) then {playableUnits} else {switchableUnits});

			//by psycho
			//["%1 --- Executing TcB AIS init.sqf",diag_ticktime] call BIS_fnc_logFormat;
			//enableSaving true;
			//enableTeamswitch false;


			// TcB AIS Wounding System --------------------------------------------------------------------------
			//if (!isDedicated) then {
			//	TCB_AIS_PATH = "ais_injury\";
			//	{[_x] call compile preprocessFile (TCB_AIS_PATH+"init_ais.sqf")} forEach (if (isMultiplayer) then {playableUnits} else {switchableUnits});		// execute for every playable unit

				//{[_x] call compile preprocessFile (TCB_AIS_PATH+"init_ais.sqf")} forEach (units group player);													// only own group - you cant help strange group members

				//{[_x] call compile preprocessFile (TCB_AIS_PATH+"init_ais.sqf")} forEach [p1,p2,p3,p4,p5];														// only some defined units
			//};
			// --------------------------------------------------------------------------------------------------------------

		} remoteExec ["bis_fnc_call", 0];
	};
}
else {
	hint (localize "STR_TRGM2_RecruiteInf_MoreReputation");
};

//hint format["test:%1", _currentSpentPoints];