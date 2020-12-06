params[["_className", "", [objNull, ""]]];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;

switch (typeName _className) do {
    case ("OBJECT") : {_className = typeOf _className};
};

if !(isClass (configFile >> "CfgVehicles" >> _className)) exitWith {false};

getNumber(configFile >> "CfgVehicles" >> _className >> "transportSoldier") >= 8; // 8 Is a weapons squad, so anything that can hold a whole squad can be considered a transport.