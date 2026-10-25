//Stores the debug text for one Secure Comms Tower AO and publishes all of them as one string (server only).
//In the debug console on any machine:  copyToClipboard TRGM_Mission18Debug
params ["_iTaskIndex","_sText"];

missionNamespace setVariable [format["TRGM_Mission18Debug%1",_iTaskIndex], _sText];

private _sAll = "";
{
	private _sThis = missionNamespace getVariable [format["TRGM_Mission18Debug%1",_x], ""];
	if (_sThis != "") then {
		_sAll = _sAll + format["[AO %1] %2   ||   ",_x,_sThis];
	};
} forEach [0,1,2];

TRGM_Mission18Debug = _sAll;
publicVariable "TRGM_Mission18Debug";
