params ["_Object","_caller","_id"];

if (count crew _Object > 0) then {
	hint "Vehicle needs to be empty to push";
}	
else {
	_newPos = _Object getPos [3, [_caller, _Object] call BIS_fnc_dirTo];
	_Object setPos _newPos;
};

//hint str(count crew _Object);

