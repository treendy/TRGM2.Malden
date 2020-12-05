params [["_box", objNull, [objNull]], ["_units", []]];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;

if (isNil "_box") exitWith {};

if (count _units <= 0) then {
	_units = (if (isMultiplayer) then {playableUnits} else {switchableUnits});
};

_initBoxItems = [TREND_InitialBoxItems, TREND_InitialBoxItemsWithAce] select (call TREND_fnc_isAceLoaded);
_initBoxItems params [
	["_input",[],[[]]],
	["_isVirtual",[],[true]]
];
//--- Weapons
_list = _input select 0;
_classes = _list select 0;
_values = _list select 1;
{_box addweaponcargoglobal [_x,_values select _foreachindex];} foreach _classes;

//--- Magazines
_list = _input select 1;
_classes = _list select 0;
_values = _list select 1;
{_box addmagazinecargoglobal [_x,_values select _foreachindex];} foreach _classes;

//--- Items
_list = _input select 2;
_classes = _list select 0;
_values = _list select 1;
{_box additemcargoglobal [_x,_values select _foreachindex];} foreach _classes;

//--- Backpacks
_list = _input select 3;
_classes = _list select 0;
_values = _list select 1;
{_box addbackpackcargoglobal [_x,_values select _foreachindex];} foreach _classes;

{
	if (count (primaryWeaponMagazine _x) > 0) then {
		_box addWeaponCargoGlobal [primaryWeapon _x, 1];
		{_box addMagazineCargoGlobal [_x, 2];} forEach primaryWeaponMagazine _x;
	} else {
		if (primaryWeapon _x != "") then {
			_box addWeaponCargoGlobal [primaryWeapon _x, 1];
			_box addMagazineCargoGlobal [getText(configfile >> "CfgVehicles" >> (primaryWeapon _x) >> "TransportMagazines"), 2];
		};
	};

	if (count (secondaryWeaponMagazine _x) > 0) then {
		_box addWeaponCargoGlobal [secondaryWeapon _x, 1];
		{_box addMagazineCargoGlobal [_x, 2];} forEach secondaryWeaponMagazine _x;
	} else {
		if (secondaryWeapon _x != "") then {
			_box addWeaponCargoGlobal [secondaryWeapon _x, 1];
			_box addMagazineCargoGlobal [getText(configfile >> "CfgVehicles" >> (secondaryWeapon _x) >> "TransportMagazines"), 2];
		};
	};

	if (count (handgunMagazine _x) > 0) then {
		_box addWeaponCargoGlobal [secondaryWeapon _x, 1];
		{_box addMagazineCargoGlobal [_x, 2];} forEach handgunMagazine _x;
	} else {
		if (handgunWeapon _x != "") then {
			_box addWeaponCargoGlobal [handgunWeapon _x, 1];
			_box addMagazineCargoGlobal [getText(configfile >> "CfgVehicles" >> (handgunWeapon _x) >> "TransportMagazines"), 2];
		};
	};

	{
		_box addItemCargoGlobal  [_x, 1];
	} forEach items _x;

	// Scope == 2 excludes protected backpacks that act strange when in an inventory (can't remove, infinite items, etc...)
	if (typeof(unitBackpack _x) != "" && isClass(configfile >> "CfgVehicles" >> typeof(unitBackpack _x)) && getNumber(configfile >> "CfgVehicles" >> typeof(unitBackpack _x) >> "scope") == 2) then {
		_box addBackpackCargoGlobal [typeof(unitBackpack _x), 1];
	};

} forEach _units;