// by EightSix
private ["_healer","_isMedic"];
_healer = _this;
_isMedic = if (getNumber (configFile >> "CfgVehicles" >> (typeOf _healer) >> "attendant") == 1) then {true} else {false};

_isMedic