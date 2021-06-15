/*
 * Author: TheAce0296
 * Adds initial items to inventory, if array of units are
 * provided, also adds ammo for those units.
 *
 * Arguments:
 * 0: Object whose inventory should recieve items <OBJECT>
 * 1: Units to get list of ammo/weapons from <ARRAY>
 *
 * Return Value:
 * true <BOOL>
 *
 * Example:
 * [box1, units group player] call TRGM_GLOBAL_fnc_initAmmoBox
 */

params [["_box", objNull, [objNull]], ["_units", []]];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;

if (isNil "_box") exitWith {};

_initBoxItems = [TRGM_VAR_InitialBoxItems, TRGM_VAR_InitialBoxItemsWithAce] select (call TRGM_GLOBAL_fnc_isAceLoaded);
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

if (count _units > 0) then {
    {
        TRGM_LOCAL_fnc_isWeaponValid = {
            (isClass(configFile >> "CfgWeapons" >> _this) && {getNumber(configFile >> "CfgWeapons" >> _this >> "scope") isEqualTo 2});
        };
        TRGM_LOCAL_fnc_isMagazineValid = {
            (isClass(configFile >> "CfgMagazines" >> _this) && {getNumber(configFile >> "CfgMagazines" >> _this >> "scope") isEqualTo 2});
        };
        _weapons = [[primaryWeapon _x, primaryWeaponMagazine _x], [secondaryWeapon _x, secondaryWeaponMagazine _x], [handgunWeapon _x, handgunMagazine _x], ["", magazines _x]];
        {
            _x params ["_weapon", "_mags"];
            if (_weapon != "" && {_weapon call TRGM_LOCAL_fnc_isWeaponValid}) then {
                _box addWeaponCargoGlobal [_weapon, 1];
                format["Weapon: %2 added to %1", str _box, _weapon] call TRGM_GLOBAL_fnc_log;
                if ({_x call TRGM_LOCAL_fnc_isMagazineValid} count _mags isEqualTo 0) then {
                    _mags = getArray(configfile >> "CfgWeapons" >> _weapon >> "magazines");
                };
                {
                    _box addMagazineCargoGlobal [_x, 2];
                    format["Mags: %2 added to %1", str _box, _x] call TRGM_GLOBAL_fnc_log;
                } forEach (_mags select {_x call TRGM_LOCAL_fnc_isMagazineValid});
            };
            if (_weapon isEqualTo "" && {{_x call TRGM_LOCAL_fnc_isMagazineValid} count _mags > 0}) then {
                {
                    _box addMagazineCargoGlobal [_x, 2];
                    format["Mags: %2 added to %1", str _box, _x] call TRGM_GLOBAL_fnc_log;
                } forEach (_mags select {_x call TRGM_LOCAL_fnc_isMagazineValid});
            };
        } forEach _weapons;

        {
            _box addItemCargoGlobal  [_x, 1];
            format["Item: %2 added to %1", str _box, _x] call TRGM_GLOBAL_fnc_log;
        } forEach items _x;

        // Scope isEqualTo 2 excludes protected backpacks that act strange when in an inventory (can't remove, infinite items, etc...)
        if (typeof(unitBackpack _x) != "" && isClass(configfile >> "CfgVehicles" >> typeof(unitBackpack _x)) && getNumber(configfile >> "CfgVehicles" >> typeof(unitBackpack _x) >> "scope") isEqualTo 2) then {
            _box addBackpackCargoGlobal [typeof(unitBackpack _x), 1];
            format["Backpack: %2 added to %1", str _box, typeof(unitBackpack _x)] call TRGM_GLOBAL_fnc_log;
        };

    } forEach _units;
};

true;