params ["_tower"];

if (getPos _tower distance CommsTowerPos < 5) then {
	[IntelShownType,"CommsTower"] spawn TRGM_fnc_showIntel;
}
else {
	hint (localize "STR_TRGM2_checkForComms_NoEnemySignal");
};
