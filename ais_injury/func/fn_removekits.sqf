// by Alwarren
_unit = _this;
/* 
 * Remove first aid and Medikits
 * To prevent duplicates, this function uses some sort of Mutex/Semaphore on the
 * unit
 */
if (!local _unit) exitWith {};
if (!isNil {_unit getVariable "AIS_Mutex"}) exitWith {}; // Someone already takes care of it
if (_unit getVariable "AIS_Mutex") exitWith {}; // Likewise
_unit setVariable ["AIS_Mutex", true, true]; // Make sure this is global

// Count the number of FAK's and Medikits this unit has
_numFakUniform = 0;
_numFaksVest = 0;
_numFaksBackpack = 0;
_numMedi = 0;


// Faks from the uniform
_items = uniformItems _unit;

{
	if (_x == "FirstAidKit") then {
		_numFakUniform = _numFakUniform + 1;
		_unit removeItemFromUniform "FirstAidKit";
	};
} forEach _items;

// Faks from the vest
_items = vestItems _unit;
{
	if (_x == "FirstAidKit") then {
		_numFaksVest = _numFaksVest + 1;
		_unit removeItemFromVest "FirstAidKit";
	};
} forEach _items;


// Faks and Medikits from the backpack. Kits can only be in backpack, so we don't search for them
// anywhere else
_items = backpackItems _unit;

{
	if (_x == "FirstAidKit") then {
		_numFaksBackpack = _numFaksBackpack + 1;
		_unit removeItemFromBackpack "FirstAidKit";
	};

	if (_x == "Medikit") then {
		_numMedi = _numMedi + 1;
		_unit removeItemFromBackpack "Medikit";
	};
} foreach _items;

// Store the result
_unit setVariable ["AIS_MedicalStore", [_numFakUniform, _numFaksVest, _numFaksBackpack, _numMedi], true];

// Reset the mutex
_unit setVariable ["AIS_Mutex", nil, true];