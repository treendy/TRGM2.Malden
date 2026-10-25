//creates an injured unit lying in a pool of blood that keeps moaning while alive; returns the unit
params ["_group", "_unitType", "_pos"];

private _bloodPools = ["BloodPool_01_Large_New_F","BloodSplatter_01_Large_New_F"];

private _downedCiv = _group createUnit [_unitType,_pos,[],0,"NONE"];
_downedCiv setDamage 0.8;
[_downedCiv, "Acts_CivilInjuredGeneral_1"] remoteExec ["switchMove", 0];
_downedCiv disableAI "anim";
_downedCiv setDir (floor(random 360));
_downedCiv addEventHandler ["killed", {_this spawn TRGM_fnc_CivKilled;}];

private _bloodPool1 = createVehicle [selectRandom _bloodPools, getpos _downedCiv, [], 0, "CAN_COLLIDE"];
_bloodPool1 setDir (floor(random 360));
private _trialDir = (floor(random 360));
private _trialPos = (getPos _bloodPool1) getPos [3,_trialDir];
private _bloodTrail1 = createVehicle ["BloodTrail_01_New_F", _trialPos, [], 0, "CAN_COLLIDE"];
_bloodTrail1 setDir _trialDir;

//each client runs its own moaning loop (JIP id is the unit, so the queue entry goes when the unit is deleted)
[_downedCiv] remoteExec ["TRGM_fnc_woundedSoundLoop", 0, _downedCiv];

_downedCiv
