
_posA = getPos(_this select 0);
_posB = CommsTowerPos;
if (_posA distance _posB < 5) then {

	[IntelShownType,"CommsTower"] spawn TRGM_fnc_showIntel;	

}
else {
	hint (localize "STR_TRGM2_checkForComms_NoEnemySignal");
};
