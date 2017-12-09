#include "..\..\setUnitGlobalVars.sqf";

//CampaignRecruitUnitRifleman createUnit [getPos player, group player];

YEAH_fnc_whatever = compile preprocessFile "RandFramework\functions\common\fn_CountSpentPoints.sqf";
_currentSpentPoints = [] call YEAH_fnc_whatever;
//_currentSpentPoints = [] call TRGM_fnc_CountSpentPoints;


if (_currentSpentPoints < (MaxBadPoints - BadPoints)) then {
	_SpawnedUnit = (group player createUnit [CampaignRecruitUnitRifleman, getPos player, [], 10, "NONE"]);
	addSwitchableUnit _SpawnedUnit;
	_SpawnedUnit setVariable ["RepCost", 1]; 	
	_SpawnedUnit addEventHandler ["killed", 
		{
			//hint format["TEST: %1", CampaignRecruitUnitRifleman];
			_tombStone = selectRandom TombStones createVehicle GraveYardPos;
			_tombStone setDir GraveYardDirection;
			_tombStone setVariable ["Message", format["KIA: %1",name (_this select 0)]]; 	
			_tombStone addAction ["Read",{hint format["%1",(_this select 0) getVariable "Message"]}];
			[0.2, format["KIA: %1",name (_this select 0)]] execVM "RandFramework\AdjustBadPoints.sqf";
		}];
	//spawn tombstone with name on it
	hint format["Unit Added: %1", name _SpawnedUnit];
}
else {
	hint "Your reputation needs to be higher to recruit more units";
};

//hint format["test:%1", _currentSpentPoints];