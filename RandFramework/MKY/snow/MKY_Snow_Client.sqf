
///////////////////////////////// m0nkey snow client /////////////////////////////////////
/*
	_this:
	0 - array 		- fog data 											-- ie. [.3,.5,200] -- use 0 to ignore (can omit)
	1 - integer 	- overcast  										-- use "" to ignore (can omit)
	2 - boolean 	- use ppEffects (default is false)					-- (can omit)
	3 - boolean 	- allow rain (default is false) 					-- (can omit)
	4 - boolean		- enforce wind dir/strength (default is true) 		-- (can omit)
	5 - boolean 	- vary fog effect (default is true)					-- (can omit)
	6 - boolean		- use wind audio file (default is true)				-- (can omit)
	NOTE: omitting a value means you can stop there and not have to list the remaining parameters (defaults will be applied)

	EXAMPLES:
	0 = [[0.23,0.021,100],"",true] execVM "script.sqf"; // fog, no overcast change, use ppeffects, (no rain)
	0 = [0,.3,false,true] execVM "script.sqf"; // no fog, .3 overcast, do not use ppeffects, allow rain
	0 = [0,"",false,true,false] execVM "script.sqf"; // no fog, no overcast change, do not use ppeffects, allow rain, do not enforce wind
	0 = [] execVM "script.sqf"; // no fog, no overcast change, do not use ppeffects, no rain, enforced wind (direction & strength)

	NOTES:
	fog array values [overall fog density, amount of dissipation with altitude, altitude]
	using [0.25,0,5] will create a thick, low fog that does not dissipate - same from top to bottom
	using [0.25,1,5] will create a thick on bottom and hazy on top fog
	these values [0.23,0.021,60] will give a nice thick distance fog while allowing a few hundred yards of some visibility
	when allowed to vary the fog effect, this script will try to maintain the altitude of fog that you gave
	this means if you gave [.2,.1,10] that you would not see the fog most likely at 50m altitude (a hilltop)
	the snow effect is enhanced with some fog, so vary fog means to periodically reset its altitude to match the players


*/
/* - TO DO
create sound vehicle that allows flurry/light snow to use low level of wind audio while blizzard gets howling wind
*/

////////////////////////// FUNCTIONS //////////////////////////
MKY_fnc_ppEffect_On = {
	if !(isNil "effsnow") exitWith {true;};
	effsnow = ppEffectCreate ["colorCorrections", 1501];
	effsnow ppEffectEnable true;
	effsnow ppEffectAdjust [1,1.0,0.0,[.55,.55,.52,.2],[.88,.88,.93,.75],[1,.1,.4,0.03]];
	effsnow ppEffectCommit 0; // can also fade colorization in slowly if not using black in /black out
	(true);
};
MKY_fnc_ppEffect_Off = {
	if (isNil "effsnow") exitWith {true;};
	0 = [] spawn {
		effsnow ppEffectAdjust [1,1.0,0.0,[.55,.55,.52,0],[.88,.88,.93,1],[1,.1,.4,0.03]];
		effsnow ppEffectCommit 30;  // fade colorization out slowly
		sleep 35;
		ppEffectDestroy effsnow;
		effsnow = nil;
	};
	(true);
};
MKY_fnc_Exit_Snow = {
	{
		{deleteVehicle _x;_x = nil;} forEach _x;
	} forEach [arFlurry_Emitters,arLight_Emitters,arModerate_Emitters,arHeavy_Emitters,arBlizzard_Emitters,arWhiteout_Emitters];
	deleteVehicle objEmitterHost;
	objEmitterHost = nil;
	(true);
};
MKY_fnc_set_Drop_Intervals = {
	// _this: 0 - "type of snow"
	private ["_arEmitters","_arDropMax","_intStart"];

	switch (_this select 0) do {
		case "flurry": {_arEmitters = arFlurry_Emitters;_arDropMax = arFlurry_Drop_Max;};
		case "light": {_arEmitters = arLight_Emitters;_arDropMax = arLight_Drop_Max;};
		case "blizzard": {_arEmitters = arBlizzard_Emitters;_arDropMax = arBlizzard_Drop_Max;};
		case "whiteout": {_arEmitters = arWhiteout_Emitters;_arDropMax = arWhiteout_Drop_Max;};
	};
hint format ["changing snow -- %1 -- %2",(_this select 0),random(99)];
	if !(arCurrent_Emitters isEqualTo _arEmitters) then {
		{
			_x setDropInterval (_arDropMax select _forEachIndex);
		} forEach _arEmitters;
		sleep 3;
		// stop the current (old) effect
		{_x setDropInterval 0.0;sleep 1;} forEach arCurrent_Emitters;
		// set the global variable to the new current emitters
		arCurrent_Emitters = _arEmitters;
	};
	(true);
};
MKY_fnc_set_Wind_Velocity = {
	// _this: 0 - "type of snow"
	private ["_intV","_rnd"];
	_intV = 0;
	_rnd = random(1);
	switch (_this select 0) do {
		case "blizzard": {_intV = 5;};
		case "whiteout": {_intV = 5;};
	};

	if (isNil "varSnowData") then {
		arCurrent_Wind = [0.4,-0.4,true];
	} else {
		arCurrent_Wind = [((_rnd + _intV) * ((varSnowData select 1) select 0)),((_rnd + _intV) * ((varSnowData select 1) select 1)),true];
	};
	// set the global with new wind values
	setWind arCurrent_Wind;
	(true);
};
MKY_fnc_create_Emitter_Host = {
	objEmitterHost = "Land_Bucket_F" createVehicleLocal (position player);
	objEmitterHost attachTo [player,[0,0,0]];
	objEmitterHost hideObject true;
	objEmitterHost allowDamage false;
	objEmitterHost enableSimulation false;
	(true);
};
MKY_fnc_set_Object_Direction = {
	// spawn a thread that sets attached object to the bearing variable
	0 = [] spawn {
		// wait for dummy object to exist
		waitUntil {sleep 0.25;!(isNil "objEmitterHost")};
		while {true} do {
			sleep 0.25;
			if (bDoSetDirection) then {
				/*
					x = 360 - direction player is facing
					set object direction to (x + bearing variable)
				*/
				objEmitterHost setDir ((360 - (getDir player)) + (varSnowData select 0));
			};
		};
	};
	(true);
};
MKY_fnc_flurry_Init = {
	private ["_pos","_color","_obj"];
	_pos = position objEmitterHost;
	_obj = objEmitterHost;
	_color = [[1,1,1,0],[1,1,1,1]];
	flurry_parent = "#particleSource" createVehicleLocal _pos;
	flurry_parent setParticleParams [["a3\data_f\ParticleEffects\Universal\Universal.p3d",16,13,10,0],"","Billboard",1,10,[0,0,8],[0,0,-8],(.7),.1375,.10,0.4,[.03],_color,[1000],.7,.3,"","",_obj];
	flurry_parent setParticleCircle [0,[0,0,0]];
	flurry_parent setParticleRandom [0,[15,15,.5],[0,0,1],0,0.55,[0,0,0,.5],0,0];

	flurry_front = "#particleSource" createVehicleLocal _pos;
	flurry_front setParticleParams [["a3\data_f\ParticleEffects\Universal\Universal.p3d",16,13,10,0],"","Billboard",1,10,[0,30,12],[0,0,-8],(.7),.1375,.10,0.4,[.03],_color,[1000],.7,.3,"","",_obj];
	flurry_front setParticleCircle [0,[0,0,0]];
	flurry_front setParticleRandom [0,[20,20,.5],[0,0,1],0,0.55,[0,0,0,.5],0,0];

	flurry_rear = "#particleSource" createVehicleLocal _pos;
	flurry_rear setParticleParams [["a3\data_f\ParticleEffects\Universal\Universal.p3d",16,13,10,0],"","Billboard",1,10,[0,-25,12],[0,0,-8],(.7),.1375,.10,0.4,[.03],_color,[1000],.7,.3,"","",_obj];
	flurry_rear setParticleCircle [0,[0,0,0]];
	flurry_rear setParticleRandom [0,[15,15,.5],[0,0,1],0,0.55,[0,0,0,.5],0,0];

	flurry_right = "#particleSource" createVehicleLocal _pos;
	flurry_right setParticleParams [["a3\data_f\ParticleEffects\Universal\Universal.p3d",16,13,10,0],"","Billboard",1,10,[25,0,12],[0,0,-8],(.7),.1375,.10,0.4,[.03],_color,[1000],.7,.3,"","",_obj];
	flurry_right setParticleCircle [0,[0,0,0]];
	flurry_right setParticleRandom [0,[20,20,.5],[0,0,1],0,0.55,[0,0,0,.5],0,0];

	flurry_left = "#particleSource" createVehicleLocal _pos;
	flurry_left setParticleParams [["a3\data_f\ParticleEffects\Universal\Universal.p3d",16,13,10,0],"","Billboard",1,10,[-15,0,12],[0,0,-8],(.7),.1375,.10,0.4,[.03],_color,[1000],.7,.3,"","",_obj];
	flurry_left setParticleCircle [0,[0,0,0]];
	flurry_left setParticleRandom [0,[20,20,.5],[0,0,1],0,0.55,[0,0,0,.5],0,0];

	arFlurry_Emitters = [flurry_parent,flurry_front,flurry_rear,flurry_right,flurry_left];
	arFlurry_Drop_Max = [0.004,0.003,0.006,0.005,0.005];
	intFlurry_Drop_Start = 9;
	(true);
};
MKY_fnc_light_Init = {
	private ["_pos","_obj"];
	_pos = position objEmitterHost;
	_obj = objEmitterHost;
	light_parent = "#particleSource" createVehicleLocal (position player);
	light_parent setParticleParams [["a3\data_f\ParticleEffects\Universal\Universal.p3d",16,13,10,0],"","Billboard",1,8,[0,0,8],[0,0,-8],(.7),1.69,1,2,[.05],[[1,1,1,0],[1,1,1,.99]],[1000],.7,.3,"","",player];
	light_parent setParticleCircle [0,[0,0,0]];
	light_parent setParticleRandom [0,[15,15,.5],[0,0,0],0,0.55,[0,0,0,.5],0,0];

	light_front = "#particlesource" createVehicleLocal (position player);
	light_front setParticleParams [["a3\data_f\ParticleEffects\Universal\Universal.p3d",16,14,2,0],"","Billboard",1,10,[0,30,12],[0,0,-8],1,1.59,1,2,[1.75],[[1,1,1,0.2],[1,1,1,0.4]],[1000],0.5,0.15,"","",player];
	light_front setParticleCircle [0,[0,0,0]];
	light_front setParticleRandom [0,[20,20,.5],[0,0,0],0,0,[0,0,0,0.03],0,0];

	light_rear = "#particleSource" createVehicleLocal (position player);
	light_rear setParticleParams [["a3\data_f\ParticleEffects\Universal\Universal.p3d",16,13,6,0],"","Billboard",1,14,[0,0,18],[0,0,-8],(.7),1.69,1,2,[5],[[1,1,1,0],[1,1,1,.29]],[1000],.7,.2,"","",player];
	light_rear setParticleCircle [0,[0,0,0]];
	light_rear setParticleRandom [0,[40,40,.5],[0,0,0],0,0,[0,0,0,0],0,0];

	light_right = "#particlesource" createVehicleLocal (position player);
	light_right setParticleParams [["a3\data_f\ParticleEffects\Universal\Universal.p3d",16,14,2,0],"","Billboard",1,10,[0,10,12],[0,0,-8],1,1.59,1,2,[1.75],[[1,1,1,0.2],[1,1,1,0.4]],[1000],0.5,0.15,"","",player];
	light_right setParticleCircle [0,[0,0,0]];
	light_right setParticleRandom [0,[15,20,.5],[0,0,0],0,0,[0,0,0,0.03],0,0];

	light_left = "#particleSource" createVehicleLocal (position player);
	light_left setParticleParams [["a3\data_f\ParticleEffects\Universal\Universal.p3d",16,13,6,0],"","Billboard",1,8,[0,0,8],[0,0,-8],0,1.69,1,2,[5],[[1,1,1,0],[1,1,1,.29]],[1000],.7,.2,"","",player];
	light_left setParticleCircle [0,[0,0,0]];
	light_left setParticleRandom [0,[40,40,.5],[0,0,0],0,0,[0,0,0,0],0,0];

	arLight_Emitters = [light_parent,light_front,light_rear,light_right,light_left];
	arLight_Drop_Max = [0.003,0.004,0.009,0.000,0.009];
	intLight_Drop_Start = 9;
	(true);
};
MKY_fnc_blizzard_Init = {
	private ["_pos","_obj"];
	_pos = position objEmitterHost;
	_obj = objEmitterHost;

	blizzard_front = "#particleSource" createVehicleLocal _pos;
	blizzard_front setParticleParams [["a3\data_f\ParticleEffects\Universal\Universal.p3d",16,13,6,0],"","Billboard",1,8,[0,30,8],[0,0,0],(0),1.59,1,1.5,[3],[[1,1,1,.15],[1,1,1,0.25]],[1000],0, 0,"","",_obj];
	blizzard_front setParticleCircle [0,[0,0,0]];
	blizzard_front setParticleRandom [0, [30,0, 8], [0, 0, 0], 0, .5, [0,0,0,0.03], 0, 0];

	blizzard_parent = "#particleSource" createVehicleLocal _pos;
	blizzard_parent setParticleParams [["a3\data_f\ParticleEffects\Universal\Universal.p3d",16,13,6,0],"","Billboard",1,5,[0,15,8],[0,0,0],(0),1.59,1,1.5,[3],[[1,1,1,.15],[1,1,1,0.15]],[1000],0, 0,"","",_obj];
	blizzard_parent setParticleCircle [0,[0,0,0]];
	blizzard_parent setParticleRandom [0, [25,0,8], [0, 0, 0], 0, .5, [0,0,0,0.03], 0, 0];

	blizzard_rear = "#particleSource" createVehicleLocal _pos;
	blizzard_rear setParticleParams [["a3\data_f\ParticleEffects\Universal\Universal.p3d",16,13,6,0],"","Billboard",1,5,[0,-10,6],[0,0,0],(0),1.59,1,1.5,[3],[[1,1,1,0],[1,1,1,0.15]],[1000],0, 0,"","",_obj]; // pos was -5, try -10
	blizzard_rear setParticleCircle [0,[0,0,0]];
	blizzard_rear setParticleRandom [0, [15,12, 6], [0, 0, 0], 0, .5, [0,0,0,0.03], 0, 0];

	blizzard_right = "#particleSource" createVehicleLocal _pos;
	blizzard_right setParticleParams [["a3\data_f\ParticleEffects\Universal\Universal.p3d",16,13,6,0],"","Billboard",1,5,[20,0,6],[0,0,0],(0),1.59,1,1.5,[3],[[1,1,1,0],[1,1,1,0.25]],[1000],0, 0,"","",_obj];
	blizzard_right setParticleCircle [0,[0,0,0]];
	blizzard_right setParticleRandom [0, [20,15, 4], [0, 0, 0], 0, .5, [0,0,0,0.03], 0, 0];

	blizzard_left = "#particleSource" createVehicleLocal _pos;
	blizzard_left setParticleParams [["a3\data_f\ParticleEffects\Universal\Universal.p3d",16,13,6,0],"","Billboard",1,5,[-20,0,6],[0,0,0],(0),1.59,1,1.5,[3],[[1,1,1,0],[1,1,1,0.25]],[1000],0, 0,"","",_obj];
	blizzard_left setParticleCircle [0,[0,0,0]];
	blizzard_left setParticleRandom [0, [20,15, 4], [0, 0, 0], 0, .5, [0,0,0,0.03], 0, 0];

	arBlizzard_Emitters = [blizzard_parent,blizzard_front,blizzard_rear,blizzard_right,blizzard_left];
	arBlizzard_Drop_Max = [0.001,0.001,0.001,0.001,0.001];
	intBlizzard_Drop_Start = 7;
	(true);
};
MKY_fnc_whiteout_Init = {
	private ["_pos","_obj"];
	_pos = position objEmitterHost;
	_obj = objEmitterHost;

	whiteout_front = "#particleSource" createVehicleLocal _pos;
	whiteout_front setParticleParams [["a3\data_f\ParticleEffects\Universal\Universal.p3d",16,13,6,0],"","Billboard",1,8,[0,30,8],[0,0,0],(0),1.59,1,1.5,[3],[[1,1,1,.55],[1,1,1,0.65]],[1000],0, 0,"","",_obj];
	whiteout_front setParticleCircle [0,[0,0,0]];
	whiteout_front setParticleRandom [0, [30,0, 8], [0, 0, 0], 0, .5, [0,0,0,0.03], 0, 0];

	whiteout_parent = "#particleSource" createVehicleLocal _pos;
	whiteout_parent setParticleParams [["a3\data_f\ParticleEffects\Universal\Universal.p3d",16,13,6,0],"","Billboard",1,5,[0,15,8],[0,0,0],(0),1.59,1,1.5,[3],[[1,1,1,.55],[1,1,1,0.65]],[1000],0, 0,"","",_obj];
	whiteout_parent setParticleCircle [0,[0,0,0]];
	whiteout_parent setParticleRandom [0, [25,0,8], [0, 0, 0], 0, .5, [0,0,0,0.03], 0, 0];

	whiteout_rear = "#particleSource" createVehicleLocal _pos;
	whiteout_rear setParticleParams [["a3\data_f\ParticleEffects\Universal\Universal.p3d",16,13,6,0],"","Billboard",1,5,[0,-10,6],[0,0,0],(0),1.59,1,1.5,[3],[[1,1,1,.45],[1,1,1,0.55]],[1000],0, 0,"","",_obj]; // pos was -5, try -10
	whiteout_rear setParticleCircle [0,[0,0,0]];
	whiteout_rear setParticleRandom [0, [15,12, 6], [0, 0, 0], 0, .5, [0,0,0,0.03], 0, 0];

	whiteout_right = "#particleSource" createVehicleLocal _pos;
	whiteout_right setParticleParams [["a3\data_f\ParticleEffects\Universal\Universal.p3d",16,13,6,0],"","Billboard",1,5,[20,0,6],[0,0,0],(0),1.59,1,1.5,[3],[[1,1,1,.45],[1,1,1,0.55]],[1000],0, 0,"","",_obj];
	whiteout_right setParticleCircle [0,[0,0,0]];
	whiteout_right setParticleRandom [0, [20,15, 4], [0, 0, 0], 0, .5, [0,0,0,0.03], 0, 0];

	whiteout_left = "#particleSource" createVehicleLocal _pos;
	whiteout_left setParticleParams [["a3\data_f\ParticleEffects\Universal\Universal.p3d",16,13,6,0],"","Billboard",1,5,[-20,0,6],[0,0,0],(0),1.59,1,1.5,[3],[[1,1,1,.45],[1,1,1,0.55]],[1000],0, 0,"","",_obj];
	whiteout_left setParticleCircle [0,[0,0,0]];
	whiteout_left setParticleRandom [0, [20,15, 4], [0, 0, 0], 0, .5, [0,0,0,0.03], 0, 0];

	arWhiteout_Emitters = [whiteout_parent,whiteout_front,whiteout_rear,whiteout_right,whiteout_left];
	arWhiteout_Drop_Max = [0.001,0.001,0.001,0.001,0.001];
	intWhiteout_Drop_Start = 7;
	(true);
};
f_handle_Respawn = {
// simple event handler would sometimes fail to reattach the objEmitterHost
// calling a function like this appears to work every time
	private ["_unit","_body"];
	_unit = (_this select 0);
	_body = (_this select 1);
	// detach from dead body
	detach objEmitterHost;
	// attach to new body
	objEmitterHost attachTo [player,[0,0,0]];
	(true);
};
///////////////////////////////////////////////////////////////

private ["_arFog_org","_arFog","_intOvercast_org","_intOvercast","_intIndex"];

arCurrent_Emitters = []; 			// global array - holds current emitters
arCurrent_Wind = [0,-0.4,true]; 	// global array - holds current wind values for setWind
bAllowRain = false; 				// global boolean - default stop rain during snow
bDoSetDirection = false; 			// global boolean - used to toggle setting direction of objEmitterHost
bEnforceWind = true; 				// global boolean - used to continually set wind values to this scripts values
bVaryFog = true; 					// global boolean - used to vary the amount of fog and reset the elevation
bUseAudio = true;					// global boolean - used to enable/disable playing of audio file

// varEnableSnow = false; 			// needed for testing only

// create an object that hosts the particle emitters
0 = [] call MKY_fnc_create_Emitter_Host;
// add event handler to always reattach the emitter host to new player vehicle
// nul = player addEventHandler ["Respawn",{objEmitterHost attachTo [player,[0,0,0]];}];
nul = player addEventHandler ["Respawn",f_handle_Respawn];

// allow rain during snow
if ((count _this) > 3) then {if (typeName (_this select 3) == "BOOL") then {_bAllowRain = (_this select 3);};};
// enforce winds
if ((count _this) > 4) then {if (typeName (_this select 4) == "BOOL") then {bEnforceWind = (_this select 4);};};
// allow fog variation
if ((count _this) > 5) then {if (typeName (_this select 5) == "BOOL") then {bVaryFog = (_this select 5);};};
// use wind audio if allowed
if ((count _this) > 6) then {if (typeName (_this select 6) == "BOOL") then {bUseAudio = (_this select 6);};};

// start audio
if (bUseAudio) then {
	[] spawn {
		private "_cnt";
		playMusic "MKY_Blizzard";
		_cnt = 0;
		while {true} do {
			_cnt = 0;
			while {varEnableSnow} do  {
				_cnt = _cnt + 1;
				if (_cnt >= 205) then {
					playMusic "MKY_Blizzard";
					_cnt = 0;
				};
				sleep 1;
			};
			sleep 1;
		};
	};
};

// prepare fog
_arFog_org = fogParams;
if ((count _this) > 0) then {
	if (typeName (_this select 0) == "ARRAY") then {
		0 setFog (_this select 0); // can use a delay if needed, its at 0 for black out / black in
		if (bVaryFog) then {
			// create variance in fog values
			[((_this select 0) select 0),((_this select 0) select 1),((_this select 0) select 2)] spawn {
				sleep 20; // give initial setFog time to change
				while {true} do {
					while {varEnableSnow} do {
						sleep 30;
						20 setFog [(_this select 0),(_this select 1),((getPosASL player) select 2) + ([-15,15] call BIS_fnc_randomInt)];;
					};
					sleep 5;
				};
			};
		};
	};
};

// continually set wind and rain values
[] spawn {
	while {true} do {
		while {varEnableSnow} do {
			sleep 8;
			if (bEnforceWind) then {setWind arCurrent_Wind;};
			if !(bAllowRain) then {0 setRain 0;};
		};
		sleep 1;
	};
};

while {true} do {

	if (varEnableSnow) then {

		// prepare overcast
		_intOvercast_org = overcast;
		if ((count _this) > 1) then {
			if (typeName (_this select 1) == "SCALAR") then {
				skipTime -24;
				86400 setOvercast (_this select 1);
				skipTime 24;
				0 = [] spawn {
					sleep 0.1;
					simulWeatherSync;
				};
			};
		};
		sleep 1;
		// prepare ppEffect
		if ((count _this) > 2) then {
			if (typeName (_this select 2) == "BOOL") then {
				if (_this select 2) then {
					0 = [] call MKY_fnc_ppEffect_On;
				};
			};
		};

		// create the emitters
		0 = [] call MKY_fnc_flurry_Init;
		0 = [] call MKY_fnc_light_Init;
		0 = [] call MKY_fnc_blizzard_Init;
		0 = [] call MKY_fnc_whiteout_Init;

		// always start with flurries
		setWind arCurrent_Wind;

		/*
			this was a good spot to blackin because the weather and fog changing is done
			you can comment it out if not using blackout/in or move it somewhere else
		*/
		titleText ["","BLACK IN",4];

		{
			_intNUM = _x;
			{
				_intVAL = parseNumber (format ["0.00%1",_intNUM]);
				if (_intVAL > (arFlurry_Drop_Max select _forEachIndex)) then {
					_x setDropInterval _intVAL;
				};
			} forEach arFlurry_Emitters;
			sleep 1;
		} forEach [9,8,7,6,5,4,3,2,1];

		arCurrent_Emitters = arFlurry_Emitters;

		// wait for varSnowData to be publicized
		waitUntil {sleep 1;!(isNil "varSnowData")};
		// spawn thread that continually sets direction of emitter host
		0 = [] call MKY_fnc_set_Object_Direction;
		// wait until server publicizes which array of effects is current
		waitUntil {sleep 1;!(isNil "varSnowIndex")};
		_intIndex = "SCALAR";
		// create the while loop here, until varEnableSnow is false
		while {varEnableSnow} do {
			if !(_intIndex isEqualTo varSnowIndex) then {
				_intIndex = varSnowIndex; // server states which effect is current
				_strEffect = (((varSnowData select 2) select varSnowIndex) select 0);

				// blizzards should always start upwind
				if (_strEffect == "blizzard" || _strEffect == "whiteout") then {
					bDoSetDirection = true
				} else {
					bDoSetDirection = false;
				};
				sleep 1;
				0 = [_strEffect] call MKY_fnc_set_Wind_Velocity;
				sleep 1;
				0 = [_strEffect] call MKY_fnc_set_Drop_Intervals;

				sleep (((varSnowData select 2) select varSnowIndex) select 1);
			};
			sleep 1;
		};
		// remove effects and exit
		0 = [] call MKY_fnc_ppEffect_Off;
		if ((count _this) > 0) then {if (typeName (_this select 0) == "ARRAY") then {60 setFog _arFog_org;};};
		// leave overcast as it is
		0 = [] call MKY_fnc_Exit_Snow;
	};
	sleep 1;
};








