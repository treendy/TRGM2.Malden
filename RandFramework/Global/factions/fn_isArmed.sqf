params[["_className", "", [objNull, ""]]];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;

switch (typeName _className) do {
    case ("OBJECT") : {_className = typeOf _className};
};

if !(isClass (configFile >> "CfgVehicles" >> _className)) exitWith {false};

_configPath = (configFile >> "CfgVehicles" >> _className);

_isArmed = false;

if (_className isKindOf "CAManBase") then {
    _isArmed = count ((getArray(_configPath >> "weapons")) - ["Throw","Put","FakeWeapon"]) > 0;
} else {
    if (_className isKindOf "AllVehicles") then {
        _isArmed = count (getArray(_configPath >> "Turrets" >> "MainTurret" >> "Magazines")) > 0 || count (getArray(_configPath >> "Turrets" >> "M2_Turret" >> "Magazines")) > 0 || count (_configPath >> "Components" >> "TransportPylonsComponent" >> "pylons") > 0 || count (_configPath >> "Components" >> "TransportPylonsComponent" >> "pylons") > 0|| count (getArray(_configPath >> "Weapons") - ["Laserdesignator_mounted", "CMFlareLauncher","Laserdesignator_pilotCamera"]) > 0; // more than just flare/chaff launcher

        if (_className isKindOf "Plane") then {
            if (!_isArmed) then {
                // Check for any turrets with weapons
                {
                    _isArmed = count (getArray(_configPath >> "Turrets" >> _x >> "weapons") - ["Laserdesignator_mounted", "CMFlareLauncher","Laserdesignator_pilotCamera"]) > 0;
                    if (_isArmed) exitWith {};
                } foreach (getArray(_configPath >> "Turrets"));
            };

            if (!_isArmed) then {
                _isArmed = count (_configPath >> "Components" >> "TransportPylonsComponent" >> "pylons") > 0;
            };

        };
    };
};

_isArmed;