params ["_killed","_killer"];

if (isNil "CivDeathCount") then {
	//CivDeathCount = 0;
	//publicVariable "CivDeathCount";
};

if (side _killer == west && str(_killed) != str(_killer)) then {
	//bCivKilled = true;
	//publicVariable "bCivKilled";
	
	//CivDeathCount = CivDeathCount + 1;
	//publicVariable "CivDeathCount";

	[0.2,format["Paramedic Killed by %1", name _killer]] execVM "RandFramework\AdjustBadPoints.sqf";
};
