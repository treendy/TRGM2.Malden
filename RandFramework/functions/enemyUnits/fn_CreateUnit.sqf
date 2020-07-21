params ["_sUnitType","_spawnPos", "_group"];

_unit = _group createUnit [_sUnitType,_spawnPos, [], 5, "NONE"];
//HERE, check if EnemyRifleman exists
_unit setUnitLoadout (getUnitLoadout EnemyRifleman);
_unit setFace selectRandom["AsianHead_A3_03", "AsianHead_A3_05"];
_unit setSpeaker selectRandom["Male01CHI","Male02CHI","Male03CHI"];
