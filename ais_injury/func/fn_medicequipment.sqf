// by psycho
private ["_healer","_injured"];
_healer = _this select 0;
_injured = _this select 1;
if (!local _healer) exitWith {};

if (_healer call tcb_fnc_isMedic) then {
	_defi_pos = _healer modelToWorld [-0.5,0.2,0];
	_defi = "Land_Defibrillator_F" createVehicle _defi_pos;
	_defi setPos _defi_pos;
	_defi setDir (getDir _healer - 180);
	[tcb_ais_medequip_array, [[1,_defi]]] call tcb_fnc_arrayPushStack;
	
	if (damage _injured >= 0.5 && {(random 2) >= 1}) then {
		_bb_pos = _healer modelToWorld [0.4,(0.2 - (random 0.5)),0];
		_bb = "Land_BloodBag_F" createVehicle _bb_pos;
		_bb setPos _bb_pos;
		_bb setDir (random 359);
		[tcb_ais_medequip_array, [[0,_bb]]] call tcb_fnc_arrayPushStack;
	};
};

for "_i" from 1 to (1 + (round random 3)) do {
	_band_pos = _healer modelToWorld [(random 1.3),(0.8 + (random 0.6)),0];
	_band = "Land_Bandage_F" createVehicle _band_pos;
	_band setPos _band_pos;
	_band setDir (random 359);
	if (_i > 1) then {
		[tcb_ais_medequip_array, [[0,_band]]] call tcb_fnc_arrayPushStack;
	} else {
		[tcb_ais_medequip_array, [[1,_band]]] call tcb_fnc_arrayPushStack;
	};
};
if (random 2 >= 1) then {
	_ab_pos = _healer modelToWorld [-0.8,(0.6 - (random 0.4)),0];
	_ab = "Land_Antibiotic_F" createVehicle _ab_pos;
	_ab setPos _ab_pos;
	_ab setDir (random 359);
	[tcb_ais_medequip_array, [[0,_ab]]] call tcb_fnc_arrayPushStack;
};

true