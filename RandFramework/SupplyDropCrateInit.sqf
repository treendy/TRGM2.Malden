//hint str(_this);
//sleep 2;

_thisBox = _this select 0;

if ([] call TRGM_fnc_isAceLoaded) then {
	[_thisBox,InitialBoxItemsWithAce] call bis_fnc_initAmmoBox;
}
else {
	[_thisBox,InitialBoxItems] call bis_fnc_initAmmoBox;
};
{
	{
		_thisBox addMagazineCargoGlobal [_x, 2];
	} forEach magazines _x + primaryWeaponMagazine _x + secondaryWeaponMagazine _x;
	{ 
		_thisBox addItemCargoGlobal  [_x, 1]; 
	} forEach items _x; 
	_thisBox addBackpackCargoGlobal [typeof(unitBackpack _x), 1];
}  forEach (if (isMultiplayer) then {playableUnits} else {switchableUnits});