
params ["_object","_caller","_id","_params"];
_params params ["_unitClass","_unitRole"];

format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;

//TRGM_VAR_CampaignRecruitUnitRifleman createUnit [getPos player, group player];

//YEAH_fnc_whatever = call TRGM_GLOBAL_fnc_countSpentPoints;
//_currentSpentPoints = call YEAH_fnc_whatever;
_currentSpentPoints = call TRGM_GLOBAL_fnc_countSpentPoints;

//plus 1 is an initial allowance
if (_currentSpentPoints < (TRGM_VAR_MaxBadPoints - TRGM_VAR_BadPoints + 1)) then {

	_SpawnedUnit = (group player createUnit [_unitClass, getPos player, [], 10, "NONE"]);
	addSwitchableUnit _SpawnedUnit;
	player doFollow player; //seemed because player has no units to start, when you add one, the player has "Stop" under his name and no units follow him
	_SpawnedUnit setVariable ["RepCost", 0.5, true];
	_SpawnedUnit setVariable ["IsFRT", true, true];
	_SpawnedUnit setVariable ["UnitRole",_unitRole];
	[_SpawnedUnit] spawn TRGM_GLOBAL_fnc_setLoadout;
	//script_handler = [_SpawnedUnit] spawn TRGM_GLOBAL_fnc_setLoadout;
	//waitUntil { script_handler };
	sleep 0.5;

	[box1, [_SpawnedUnit]] call TRGM_GLOBAL_fnc_initAmmoBox;

	_SpawnedUnit addEventHandler ["killed",
		{
			_tombStone = selectRandom TRGM_VAR_TombStones createVehicle TRGM_VAR_GraveYardPos;
			_tombStone setDir TRGM_VAR_GraveYardDirection;
			_tombStone setVariable ["Message", format[localize "STR_TRGM2_RecruiteInf_KIA",name (_this select 0)],true];
			_tombStone addAction [localize "STR_TRGM2_RecruiteInf_Read",{[format["%1",(_this select 0) getVariable "Message"]] call TRGM_GLOBAL_fnc_notify}];
			[0.2, format[localize "STR_TRGM2_RecruiteInf_KIA",name (_this select 0)]] spawn TRGM_GLOBAL_fnc_adjustBadPoints;
		}];
	//spawn tombstone with name on it
	[format[localize "STR_TRGM2_RecruiteInf_UnitAdd", name _SpawnedUnit,_currentSpentPoints+0.5,TRGM_VAR_MaxBadPoints - TRGM_VAR_BadPoints + 1]] call TRGM_GLOBAL_fnc_notify;

	if (TRGM_VAR_bUseRevive || !isNil "AIS_MOD_ENABLED") then {
		[_SpawnedUnit] call AIS_System_fnc_loadAIS;
	};
}
else {
	[(localize "STR_TRGM2_RecruiteInf_MoreReputation")] call TRGM_GLOBAL_fnc_notify;
};

true;