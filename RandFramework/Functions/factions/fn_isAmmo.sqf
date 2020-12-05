params[["_className", "", [objNull, ""]]];

switch (typeName _className) do {
    case ("OBJECT") : {_className = typeOf _className};
};

getNumber(configFile >> "CfgVehicles" >> _className >> "transportAmmo") > 0;