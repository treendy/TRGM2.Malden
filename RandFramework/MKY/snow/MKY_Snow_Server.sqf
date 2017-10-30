

// server creates the variable to hold the "snow data" the clients need
varSnowData = [0,[],[]]; // wind bearing, wind dir, snow FX cycle
// server can send message to start or stop the snow effect
// varEnableSnow = true; // publicize when ready
// server starts tracking snow effects cycle, sending current to all clients
// varSnowIndex = 0;

// server may need to send data to JIP client
"JIP_varSnowData" addPublicVariableEventHandler {
	(owner (_this select 0)) publicVariableClient "varFadeIn";
	sleep 1;
	(owner (_this select 0)) publicVariableClient "varEnableSnow";
	sleep 1;
	(owner (_this select 0)) publicVariableClient "varSnowData";
	sleep 1;
};

// server needs to find a bearing for the wind
MKY_fnc_s_getWind = {
	private ["_arBearing","_arSigns","_intWindIndex"];
	// array of cardinal bearings
	_arBearing = [0,45,90,135,180,225,270,315];
	// array of signed integers for wind (in order of bearings array)
	_arSigns = [[0,-1],[-1,-1],[-1,0],[-1,1],[0,1],[1,1],[1,0],[1,-1]];
	// get a wind index value
	_intWindIndex = floor (random (7));
	// set the global/public bearing variable indices
	varSnowData set [0,(_arBearing select _intWindIndex)];
	varSnowData set [1,(_arSigns select _intWindIndex)];
	(true);
};
// server creates an effects cycle for the clients to run
MKY_fnc_s_setSnowCycle = {
	private ["_arSnowFX","_arCycle"];
	_arSnowFX = ["flurry","light","blizzard","whiteout"];
	_arCycle = [];
	// assume 200 different snow efx will be plenty for any mission
	for "_i" from 1 to 200 do {
		//[effect type, effect lifetime]
		_efx = _arSnowFX call BIS_fnc_selectRandom;
		if (_efx == "blizzard" || _efx == "whiteout") then {
			_arCycle pushBack [_efx,205];
		} else {
			_arCycle pushBack [_efx,(floor(random(90)) + 90)];
			// _arCycle pushBack [_efx,(floor(random(15)) + 35)];	// *** TEMP TEST ***
		};
	};
	// add flurries as last effect
	_arCycle pushBack ["flurry",160];
	varSnowData set [2,_arCycle];
	(true);
};

0 = [] spawn {
	// get wind details
	0 = [] call MKY_fnc_s_getWind;
	// create array of random snow effects
	0 = [] call MKY_fnc_s_setSnowCycle;
	// publicize the variables for clients
	publicVariable "varSnowData";
	sleep 1;
	varEnableSnow = true;
	publicVariable "varEnableSnow";
	sleep 1;
	// sleep while initial clients prepare with flurries first
	sleep 60;
	//sleep 15; // *** TEMP TEST ***

	// step through effects array, pausing for each
	// pass the current index along to clients
	for "_i" from 0 to (count (varSnowData select 2)) - 1 do {
		if !(varEnableSnow) exitWith {true;};
		varSnowIndex = _i;
		publicVariable "varSnowIndex";
		sleep (((varSnowData select 2) select _i) select 1);
		sleep 30; // buffer the server sleep to help clients be "ready" for next effect
	};
	// leave snow enabled, last effect is flurries !!
};















