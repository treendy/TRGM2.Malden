/*
Add Script to vehicles spawned by COS.
_veh = Vehicle. Refer to vehicle as _veh.
*/

_veh =(_this select 0);

_bIsTrap = selectRandom[true,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false];
_IEDType = "CAR";

[_veh, ["Tell driver to get out",{
	params ["_veh"];
	if (alive driver _veh) then {
		[_veh] call TRGM_fnc_orderDriverOut;
	}
	else {
		hint "are actually trying to talk to a ghost?"
	};
},[_veh]]] remoteExec ["addAction", 0, true];



[_veh, _bIsTrap, _IEDType] call TRGM_fnc_addIEDSearchAction;