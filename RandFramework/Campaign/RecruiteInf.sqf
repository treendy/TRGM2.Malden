
params ["_object","_caller","_id","_params"];
_params params ["_unitClass","_unitRole"];


_currentSpentPoints = [] call TRGM_fnc_CountSpentPoints;

//plus 1 is an initial allowance
if (_currentSpentPoints < (MaxBadPoints - BadPoints + 1)) then {

	_SpawnedUnit = (group player createUnit [_unitClass, getPos player, [], 10, "NONE"]);
	addSwitchableUnit _SpawnedUnit;
	player doFollow player; //seemed because player has no units to start, when you add one, the player has "Stop" under his name and no units follow him
	_SpawnedUnit setVariable ["RepCost", 0.5, true];
	_SpawnedUnit setVariable ["IsFRT", true, true];
	_SpawnedUnit setVariable ["UnitRole",_unitRole];
	[_SpawnedUnit] spawn TRGM_fnc_setLoadout;
	sleep 0.5;

	{
		box1 addMagazineCargoGlobal [_x, 3];
	} forEach magazines _SpawnedUnit + primaryWeaponMagazine _SpawnedUnit + secondaryWeaponMagazine _SpawnedUnit;
	{
		box1 addItemCargoGlobal  [_x, 1];
	} forEach items _SpawnedUnit;
	if (typeof(unitBackpack _SpawnedUnit) != "") then {
		box1 addBackpackCargoGlobal [typeof(unitBackpack _SpawnedUnit), 1];
	};

	_SpawnedUnit addEventHandler ["killed",
		{
			_tombStone = selectRandom TombStones createVehicle GraveYardPos;
			_tombStone setDir GraveYardDirection;
			_tombStone setVariable ["Message", format[localize "STR_TRGM2_RecruiteInf_KIA",name (_this select 0)],true];
			[_tombStone, [localize "STR_TRGM2_RecruiteInf_Read",{hint format["%1",(_this select 0) getVariable "Message"]}]] remoteExec ["addAction", 0, true];
			[0.2, format[localize "STR_TRGM2_RecruiteInf_KIA",name (_this select 0)]] call TRGM_fnc_adjustBadPoints;
		}];
	//spawn tombstone with name on it
	hint format[localize "STR_TRGM2_RecruiteInf_UnitAdd", name _SpawnedUnit,_currentSpentPoints+0.5,MaxBadPoints - BadPoints + 1];

	if (iUseRevive != 0) then {
				[_SpawnedUnit] call AIS_System_fnc_loadAIS;
	};
}
else {
	hint (localize "STR_TRGM2_RecruiteInf_MoreReputation");
};
