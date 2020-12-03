_thisBox = _this select 0;

if ([] call TREND_fnc_isAceLoaded) then {
	[_thisBox,TREND_InitialBoxItemsWithAce] call BIS_fnc_initAmmoBox;
}
else {
	[_thisBox,TREND_InitialBoxItems] call BIS_fnc_initAmmoBox;
};
{
	{
		_thisBox addMagazineCargoGlobal [_x, 2];
	} forEach magazines _x + primaryWeaponMagazine _x + secondaryWeaponMagazine _x;
	{
		_thisBox addItemCargoGlobal  [_x, 1];
	} forEach items _x;
	if (typeof(unitBackpack _x) != "") then {
		_thisBox addBackpackCargoGlobal [typeof(unitBackpack _x), 1];
	};
}  forEach (if (isMultiplayer) then {playableUnits} else {switchableUnits});