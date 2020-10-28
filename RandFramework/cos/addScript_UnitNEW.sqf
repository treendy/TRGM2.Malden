/*
Add Script to individual units spawned by COS.
_unit = unit. Refer to Unit as _unit.
*/

_unit =(_this select 0);

_mainAOPos = ObjectivePossitions select 0;
_distanceFromAO = "FAR"; //4000+=FAR; 1500-3999=MED, 500-1499=CLOSE; 0-499=VERYCLOSE
_AODirection = [_unit, _mainAOPos] call BIS_fnc_DirTo;
_AODistance = _unit distance _mainAOPos;
_chanceOfBad = [false,false,false,false,false,false,false,false,false,true];

if (_AODistance<4000) then {
	_distanceFromAO = "MED";
	_chanceOfBad = [false,false,false,false,false,false,false,true];
};
if (_AODistance<1500) then {
	_distanceFromAO = "CLOSE";
	_chanceOfBad = [false,false,false,false,false,true];
};
if (_AODistance<500) then {
	_distanceFromAO = "VERYCLOSE";
	_chanceOfBad = [false,false,false,false,true];
};

_isBad = selectRandom _chanceOfBad;

//add this in once tested against brads EOS version
//if (!_isBad) then {
//	_unit addEventHandler ["killed", {_this execVM "RandFramework\CivKilled.sqf";}];
//};

if (isserver) then {
	_unit execVM "scripts\badciv.sqf";
};
