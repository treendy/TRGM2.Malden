//creates a unit attached to _patient playing the "treating wounded" animation, with a small light on it for every client; returns the medic
params ["_group", "_unitType", "_pos", "_patient"];

private _medic = _group createUnit [_unitType,_pos,[],0,"CAN_COLLIDE"];
_medic playmove "Acts_TreatingWounded02";
_medic disableAI "anim";
_medic attachTo [_patient, [0.5,-0.3,-0.1]];
_medic setDir 270;
_medic addEventHandler ["killed", {_this spawn TRGM_fnc_ParamedicKilled;}];

[_medic] remoteExec ["TRGM_fnc_medicalParamedicLight", 0, true];

_medic
