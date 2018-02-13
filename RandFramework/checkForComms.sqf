
_posA = getPos(_this select 0);
_posB = CommsTowerPos;
if (_posA distance _posB < 5) then {
	hint (localize "STR_TRGM2_checkForComms_GotEnemySignal");
}
else {
	hint (localize "STR_TRGM2_checkForComms_NoEnemySignal");
};
