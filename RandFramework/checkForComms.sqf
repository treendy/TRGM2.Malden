
_posA = getPos(_this select 0);
_posB = CommsTowerPos;
if (_posA distance _posB < 5) then {
	hint "You are picking up enemy comms from this tower!";
}
else {
	hint "Nothing of interest from this tower";
};
