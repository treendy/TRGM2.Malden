
_posA = getPos(_this select 0);
_posB = CommsTowerPos;
if (_posA distance _posB < 5) then {
	[IntelShownType,"CommsTower"] execVM "RandFramework\showIntel.sqf";	
}
else {
	hint "Nothing of interest from this tower";
};
