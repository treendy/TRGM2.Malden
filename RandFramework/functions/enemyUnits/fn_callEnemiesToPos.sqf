//Orders every enemy group whose leader is within _radius of _pos to move to _pos (server only)
params ["_pos",["_radius",1500]];

{
	private _group = _x;
	if (side _group == east) then {
		private _groupLeader = leader _group;
		if ((getPos _groupLeader) distance _pos < _radius) then {
			{
				private _unit = _x;
				_unit setCombatMode "RED";
				_unit setBehaviour "AWARE";
				_unit setUnitPos "AUTO";
				_unit forceSpeed -1;
				_unit doMove _pos;
			} forEach units _group;
		};
	};
} forEach allGroups;
