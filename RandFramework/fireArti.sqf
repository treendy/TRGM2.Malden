params ["_targetX","_targetY","_Ammo"];

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
	closedialog 0;
	AIArti1 setVehicleAmmo 1;
	_artiETA = AIArti1 getArtilleryETA [[parseNumber _targetX - GridXOffSet, parseNumber _targetY - GridYOffSet], _Ammo];
	hint format[localize "STR_TRGM2_fireArti_ArtiRequested",_targetX,_targetY,_artiETA];

	_artiCommandParameters = [AIArti1, [[parseNumber _targetX - GridXOffSet, parseNumber _targetY - GridYOffSet], _Ammo, 1]];
	_artiCommandParameters remoteExec ["commandArtilleryFire",2,false];
};