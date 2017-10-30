// by Alwarren
_unit = _this;
/* 
 * Re-Add first aid and Medikits
 * To prevent duplicates, this function uses some sort of Mutex/Semaphore on the
 * unit
 */
if (!local _unit) exitWith {};
if (!isNil {_unit getVariable "AIS_Mutex"}) exitWith {}; // Someone already takes care of it
if (_unit getVariable "AIS_Mutex") exitWith {}; // Likewise
_unit setVariable ["AIS_Mutex", true, true]; // Make sure this is global

_items = _unit getVariable "AIS_MedicalStore";
if (!isNil "_items") then {
	_unit setVariable ["AIS_MedicalStore", nil, true]; // Delete this variable

	_numFakUniform = _items select 0;
	_numFakVest = _items select 1;
	_numFakBackpack = _items select 2;
	_numMedi = _items select 3;

	for "_i" from 1 to _numFakUniform do {
		_unit addItemToUniform "FirstAidKit";
	};

	for "_i" from 1 to _numFakVest do {
		_unit addItemToVest "FirstAidKit";
	};	
	
	for "_i" from 1 to _numFakBackpack do {
		_unit addItemTobackpack "FirstAidKit";
	};
	
	for "_i" from 1 to _numMedi do {
		_unit addItem "Medikit";
	};
};

// Reset the mutex
_unit setVariable ["AIS_Mutex", nil, true];