
params ["_targetX","_targetY","_Ammo"];
_targetX = _this select 0;
_targetY = _this select 1;
_Ammo = _this select 2;

_targetX = _targetX splitString " " joinString "";
_targetY = _targetY splitString " " joinString "";

//hint format ["test1: %1 ", count _targetX];
//sleep 2;

if (count _targetX == 3) then {_targetX = _targetX + "55"};
if (count _targetY == 3) then {_targetY = _targetY + "55"};
if (count _targetX == 4) then {_targetX = _targetX + "5"};
if (count _targetY == 4) then {_targetY = _targetY + "5"};

if (count _targetX < 3 || count _targetX > 5 || count _targetY < 3 || count _targetY > 5) then {
	hint (localize "STR_TRGM2_fireArti_InvalidGrid");
}
else {
	hint format[localize "STR_TRGM2_getArtiETA_ETA",AIArti1 getArtilleryETA [[_targetX, _targetY], _Ammo]];
};