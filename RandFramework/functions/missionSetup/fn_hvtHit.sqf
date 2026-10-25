//handles an informant/officer/HVT being hit (HitPart fires on the shooter's machine, so it sends the hit here to the server where the unit is local)
params ["_thisInformant","_thisShooter","_hitLocation"];

if (!isServer) exitWith {
	_this remoteExec ["TRGM_fnc_hvtHit", 2];
};
if (side (_thisShooter) != West || !alive(_thisInformant)) exitWith {};

private _fnc_woundedLegs = {
	params ["_unit"];
	_unit disableAI "anim";
	[_unit, "Acts_CivilInjuredLegs_1"] remoteExec ["switchMove", 0];
	_unit setHit ['legs',1];
	_unit setCaptive true;
};

_thisInformant allowDamage true;
private _bDone = false;
group _thisInformant setBehaviour "ALERT";
[_thisInformant, ""] remoteExec ["switchMove", 0];
private _ThisTaskType = _thisInformant getVariable ["TaskType",0];
if (!isPlayer _thisShooter && _ThisTaskType == 5) then {
	[_thisInformant] call _fnc_woundedLegs;
}
else {
	if (_hitLocation in ["head","neck","spine1","spine2","spine3","body"]) then {
		_thisInformant setDamage 1;
		_bDone = true;
	};
	if (_hitLocation in ["leftleg","rightleg","rightupleg","leftupleg"]) then {
		if (_ThisTaskType == 5) then {
			[_thisInformant] call _fnc_woundedLegs;
			_thisInformant setVariable ["StopWalkScript", true, true];
			removeAllWeapons _thisInformant;
		}
		else {
			_thisInformant setHit ['legs',1];
		};
		_bDone = true;
	};
	if (!_bDone) then {
		_thisInformant setDamage 0.8;
	};
};
