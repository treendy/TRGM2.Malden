params[["_className", "", [objNull, ""]]];

if ((typeName _className) == "OBJECT") then {
	_className = typeOf _className;
};

if (_className == "") exitWith {false;};

private _isArmed = false;

if (_className isKindOf "CAManBase") then {

    // Checks if default weapons[] is set with weapons
    _isArmed = count ((getArray(configfile >> "CfgVehicles" >> _className >> "weapons")) - ["Throw","Put","FakeWeapon"]) > 0;

} else {

    if (_className isKindOf "AllVehicles" && {!(_className isKindof "Plane")}) then {
        // Checks if magazines are set for the main turrets, tbc: AH9 Pawnee seems to be misconfiged (no magazines)
        _isArmed = count (getArray(configfile >> "CfgVehicles" >> _className >> "Turrets" >> "MainTurret" >> "Magazines")) > 0 || count (getArray(configfile >> "CfgVehicles" >> _className >> "Turrets" >> "M2_Turret" >> "Magazines")) > 0 || count (configfile >> "CfgVehicles" >> _className >> "Components" >> "TransportPylonsComponent" >> "pylons") > 0;
    } else {
	    if (_className isKindOf "Plane") then {

	        // Checks for planez
	        _isArmed = count (getArray(configfile >> "CfgVehicles" >> _className >> "Weapons") - ["Laserdesignator_mounted", "CMFlareLauncher","Laserdesignator_pilotCamera"]) > 0; // more than just flare/chaff launcher

	        if !(_isArmed) then {
	            // Check for any turrets with weapons
	            {
	                _isArmed = count (getArray(configfile >> "CfgVehicles" >> _className >> "Turrets" >> _x >> "weapons") - ["Laserdesignator_mounted", "CMFlareLauncher","Laserdesignator_pilotCamera"]) > 0;
	                if (_isArmed) exitWith {};
	            } foreach (getArray(configfile >> "CfgVehicles" >> _className >> "Turrets"));
	        };

	        // Need to check for new dynamic loadout vehicles too - check pylons
	        if (!_isArmed) then {
	            _isArmed = count (configfile >> "CfgVehicles" >> _className >> "Components" >> "TransportPylonsComponent" >> "pylons") > 0;
	        };

	    };
	};
};

_isArmed;