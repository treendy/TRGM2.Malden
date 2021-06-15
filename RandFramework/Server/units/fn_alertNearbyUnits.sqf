/*
 * Author: TheAce0296
 * Alerts nearby enemy units to converge onto a positon.
 *
 * Arguments:
 * 0: A condition that must be true for the units to be/stay alerted. <CODE> or <BOOL>
 * 1: A central position units should converge towards. <POSITION>
 * 2: Radius from the center position to apply alertness to. <NUMBER>
 * 3: Whether to repeat the function if the condition was true. <BOOL>
 *    TRY NOT TO USE CYCLE MODE IF THE CONDITION IS NOT OF <CODE> TYPE!
 *    A safer alternative is to use a trigger, or a while loop to call TRGM_SERVER_fnc_alertNearbyUnits.
 *
 * Return Value:
 * true <BOOL>
 *
 * Example:
 * [alive player, position player, 1500, false] spawn TRGM_SERVER_fnc_alertNearbyUnits
 */
params[
	["_condition", {true}, [{},true]],
	["_centerPos", []],
	["_radius", 1500],
	["_cycleMode", false]
];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;

if (isNil "_condition" || isNil "_centerPos") exitWith {};

_groupsAlerted = [];

if (_condition isEqualType {}) then {
	_condition = call _condition;
};

if (_condition) then {
	{
		_group = _x;
		if (!(_group in _groupsAlerted) && {(side _group isEqualTo east || side _group isEqualTo independent)}) then {
			_groupLeader = leader _group;
			if (!((vehicle _groupLeader) isKindOf "Air") && {(getPos _groupLeader) distance _centerPos < _radius}) then {
				{
					_unit = _x;
					_unit enableAI "ALL";
					_unit setCombatMode "RED";
					_unit setBehaviour "AWARE";
					_unit forceSpeed -1;
					_unit doMove _centerPos;
					_unit setDestination [_centerPos, "FORMATION PLANNED", false];
					_unit setSuppression 0;
					_unit setUnitPosWeak "UP";
				} forEach units _group;
			};
		};
		_groupsAlerted pushBack _group;
	} forEach allGroups;
	sleep 60;
	if (_cycleMode) then {
		[_condition, _centerPos, _radius, _cycleMode] spawn TRGM_SERVER_fnc_alertNearbyUnits;
	};
};

true;