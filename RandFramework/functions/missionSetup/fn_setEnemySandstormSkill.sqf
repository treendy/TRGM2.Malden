//lowers (storm active) or restores the skill of all east units for a sandstorm (server)
params ["_bStormActive"];

private _skills = [[0.15,0.1,0.2,0.5,0.5], [0.01,0.01,0.01,0.01,0.01]] select _bStormActive;
{
	if (side _x == East) then {
		private _unit = _x;
		{
			_unit setSkill [_x, _skills select _forEachIndex];
		} forEach ["aimingAccuracy","aimingShake","aimingSpeed","spotDistance","spotTime"];
	};
} forEach allUnits;
