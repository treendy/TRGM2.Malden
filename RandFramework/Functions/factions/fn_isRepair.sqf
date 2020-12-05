params[["_className", "", [objNull, ""]]];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;

switch (typeName _className) do {
    case ("OBJECT") : {_className = typeOf _className};
};

if !(isClass (configFile >> "CfgVehicles" >> _className)) exitWith {false};

getNumber(configFile >> "CfgVehicles" >> _className >> "transportRepair") > 0;