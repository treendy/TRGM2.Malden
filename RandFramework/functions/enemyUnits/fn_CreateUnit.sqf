params ["_sUnitType","_spawnPos", "_group"];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;

_unit = _group createUnit [_sUnitType,_spawnPos, [], 5, "NONE"];
//HERE, check if EnemyRifleman exists
if (!isNil "EnemyRifleman") then {
	_unit setUnitLoadout (getUnitLoadout EnemyRifleman);
	_unit setFace selectRandom["AsianHead_A3_03", "AsianHead_A3_05"];
	_unit setSpeaker selectRandom["Male01CHI","Male02CHI","Male03CHI"];
};

_unit;

