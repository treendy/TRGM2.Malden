params[["_className", "", [objNull, ""]]];

switch (typeName _className) do {
    case ("OBJECT") : {_className = typeOf _className};
};

getNumber(configFile >> "CfgVehicles" >> _className >> "attendant") > 0;