params ["_killed","_killer"];


if (side _killer == west && _killed != _killer) then {
	

	[0.2,format["Paramedic Killed by %1", name _killer]] execVM "RandFramework\AdjustBadPoints.sqf";
};
