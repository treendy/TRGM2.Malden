//Returns the friendly side unit that killed _killed (ACE's last damage source when there is one), or objNull if it was not a friendly kill or was a suicide
params ["_killed", "_killer"];

private _aceSource = _killed getVariable ["ace_medical_lastDamageSource", objNull];
if (!isNull _aceSource) then {
	_killer = _aceSource;
};

if (side _killer == FriendlySide && {_killed != _killer}) exitWith {_killer};
objNull
