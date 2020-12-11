params[
	["_condition",{ true }, [{}]],
	["_centerPos", []],
	["_radius", 1500]
];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;

if (isNil "_condition" || isNil "_centerPos") exitWith {};

_groupsAlerted = [];

while {_condition} do {
	{
		_group = _x;
		if (!(_group in _groupsAlerted) && {(side _group == east || side _group == independent)}) then {
			_groupLeader = leader _group;
			if ((getPos _groupLeader) distance _centerPos < _radius) then {
				{
					_unit = _x;
					_unit enableAI "ALL";
					_unit setCombatMode "RED";
					_unit setBehaviour "AWARE";
					_unit setUnitPos "AUTO";
					_unit forceSpeed -1;
					if (!((vehicle _unit) isKindOf "Air")) then {
						_unit doMove _centerPos;
					};
				} forEach units _group;
			};
		};
		_groupsAlerted pushBack _group;
	} forEach allGroups;
};