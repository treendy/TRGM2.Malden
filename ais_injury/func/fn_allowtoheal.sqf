// by psycho
private ["_healer","_bool"];
_healer = _this select 0;
_bool = false;

_bool = switch (tcb_ais_medical_education) do {
	case (0) : {true};
	case (1) : {(items _healer) find "FirstAidKit" >= 0 || {(items _healer) find "Medikit" >= 0}};
	case (2) : {_healer call tcb_fnc_isMedic};
	default {true};
};

_bool