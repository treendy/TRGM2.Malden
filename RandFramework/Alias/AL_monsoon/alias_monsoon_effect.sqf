// by ALIAS
// Tutorial: https://www.youtube.com/user/aliascartoons

private ["_debris_branches","_rain_fog","_leaves_p","_alias_local_fog","_leaves_p_drop","_leaves_p_drop"];

if (!hasInterface) exitWith {};

_debris_branches = _this select 0;
_rain_fog		 = _this select 1;

while {al_monsoon_om} do {
	effect_screen = ppEffectCreate ["FilmGrain", 2000]; 
	effect_screen ppEffectEnable true;
	effect_screen ppEffectAdjust [0.1,0.1,0.5,0.1,0.1,true];
	effect_screen ppEffectCommit 0;

	if (_debris_branches) then {
	_leaves_p  = "#particlesource" createVehicleLocal (getposasl vehicle player);
	if (vehicle player != player) then {_leaves_p attachto [vehicle player];} else {_leaves_p attachto [player];};
	_leaves_p setParticleCircle [100,[0,0,0]];
	_leaves_p setParticleRandom [25,[50,50,10],[4,4,0],2,1,[0,0,0,0.5],1,0];
	_leaves_p setParticleParams [["\A3\data_f\ParticleEffects\Hit_Leaves\Sticks_Green", 1, 1, 1], "", "SpaceObject", 1,30,[0,0,0],[50,50,0],2,10,1,0.1,[0.1+random 3],[[0.68,0.68,0.68,1]],[1.5,1],1,0,"","",vehicle player,0,true,1,[[0,0,0,0]]];
	};
	
	if (_rain_fog) then {
	_alias_local_fog = "#particlesource" createVehicleLocal (getposasl vehicle player); 
	if (vehicle player != player) then {_alias_local_fog attachto [vehicle player];} else {_alias_local_fog attachto [player];};
	_alias_local_fog setParticleCircle [50, [3, 3, 0]];
	_alias_local_fog setParticleRandom [5,[20,20,0],[1,1,0],1,1,[0,0,0,0.1],1,0];
	_alias_local_fog setParticleParams [["\A3\data_f\cl_basic", 1, 0, 1], "", "Billboard", 1,10,[0,0,0],[-1,-1,0],3,10,7.9,0.1,[10,20,50],[[1,1,1,0],[1,1,1,0.03],[1,1,1,0]],[0.08],1, 0, "", "", vehicle player];
	};
	
	if (_debris_branches) then {_leaves_p_drop = 5+random 10; _leaves_p setDropInterval _leaves_p_drop};
	if (_rain_fog) then {_alias_drop_fog_factor	= 0.01+random 0.05;_alias_local_fog setDropInterval _alias_drop_fog_factor};
	
	sleep 5 + random 10;
	if (_debris_branches) then {deletevehicle _leaves_p};
	if (_rain_fog) then {deletevehicle _alias_local_fog};
};

effect_screen ppEffectEnable false;
ppEffectDestroy effect_screen;
enableCamShake false;