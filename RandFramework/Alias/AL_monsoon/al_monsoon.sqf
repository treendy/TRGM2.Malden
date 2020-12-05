// by ALIAS
// Monsoon SCRIPT
// Tutorial: https://www.youtube.com/user/aliascartoons

if (!isServer) exitWith {};

_direction_monsoon	= _this select 0;
_duration_monsoon	= _this select 1;
_effect_on_objects	= _this select 2;
_debris_branches	= _this select 3;
_rain_fog			= _this select 4;
_rain_drop			= _this select 5;
_thunder_steroids	= _this select 6;
delay_thunder		= _this select 7;
publicVariable "delay_thunder";

al_monsoon_om = true;
publicVariable "al_monsoon_om";

thunder_far_alias = ["01_far","02_far","03_far","04_far","05_far","06_far","07_far","08_far","09_far","10_far","11_far","12_far","13_far","14_far","16_far","17_far","18_far","19_far","20_far","21_far","22_far","23_far","24_far","25_far","26_far","27_far"];
publicVariable "thunder_far_alias";

// - memoreaza parametri actuali

al_foglevel		= fog;
al_rainlevel	= rain;
al_thundlevel	= lightnings;
al_windlevel	= wind;
publicVariable "al_foglevel";
publicVariable "al_rainlevel";
publicVariable "al_thundlevel";
publicVariable "al_windlevel";

sleep 0.1;

[_duration_monsoon] spawn {
	x_duration_monsoon = _this select 0;
	sleep x_duration_monsoon;

	al_monsoon_om = false;
	publicVariable "al_monsoon_om";

// restaureaza parametri vreme
	60 setFog al_foglevel;
	60 setRain al_rainlevel;
	60 setLightnings al_thundlevel;
	setWind [al_windlevel select 0, al_windlevel select 1, true];
};

[] spawn {
	while {al_monsoon_om} do {
		["bcg_wind"] remoteExec ["playSound"];
		sleep 60;
	};
};

// seteaza conditii vreme
0 setLightnings 1;

[] spawn {
	_irain=0;
	while {_irain <1} do {
		_irain=_irain+0.01;0 setrain _irain; sleep 0.1;
	};
};

[] spawn {
	_ifog=0;
	while {_ifog <0.5} do {
		_ifog=_ifog+0.001; 0 setFog _ifog; sleep 0.01;
	};
};


// seteaza wind storm functie de directie

raport = 360/_direction_monsoon;
raport = round (raport * (10 ^ 2)) / (10 ^ 2);
//hint str raport;

if (raport >= 4) then {fctx = 1; fcty = 1}
	else {if (raport >= 2) then {fctx = 1; fcty = -1}
						else { if (raport >=1.33) then {fctx = -1; fcty = -1}
												else {fctx = -1; fcty = 1};
						};
	};
if ((raport <= 2) and (raport >= 1.33)) then {fctx = -1; fcty = -1};
//hint str fcty;sleep 2;hint str fctx;

_unx	= ((_direction_monsoon - floor (_direction_monsoon/90)*90))*fctx;
//hint str _unx;
//_uny	= 90-_unx;

vx = floor (_unx * 0.6);
vy = (54 - vx)*fcty;

// mareste incremental vantul

inx = 0;
iny = 0;

incr = true;
incrx = false;
incry = false;

while {incr} do {
	sleep 0.01;
	if (inx < abs vx) then {inx = inx+0.1;} else {incrx = true};
	if (iny < abs vy) then {iny = iny+0.1} else {incry = true};
	if (incrx and incry) then {incr=false};
	winx = floor ((inx*fctx)/2);
	winy = floor ((iny*fcty)/2);
	setWind [winx,winy,true];
};

[[_debris_branches,_rain_fog],"RandFramework\Alias\AL_monsoon\alias_monsoon_effect.sqf"] remoteExec ["execVM",0,true];
if(_rain_drop) then {[[],"RandFramework\Alias\AL_monsoon\rain_drop.sqf"] remoteExec ["execVM",0,true]};
if(_thunder_steroids) then {
		_rand_pl = [] execVM "RandFramework\Alias\AL_monsoon\alias_hunt.sqf";
		waitUntil {scriptDone _rand_pl};
[] spawn {
	_storm_clouds = true;
	while {al_monsoon_om} do
	{
		//_delayth2 = linearConversion [0.3,1,overcast,30+(random 120),0.1 + (random _delay2),true];
		_delayth2 = delay_thunder + random 10;
		waitUntil {!isNil "hunt_alias"};
		poz_f_1 = [hunt_alias,700+random 1300, random 360] call BIS_fnc_relPos;
		publicVariable "poz_f_1";
		_tip_tunet = ["lumina","sunet","lumina","sunet_lumina","lumina","lumina"] call BIS_fnc_selectRandom;
		_numar_sclipiri = floor (1+random 3);
		_sound_tunet = thunder_far_alias call BIS_fnc_selectRandom;
		[[poz_f_1,_tip_tunet,_numar_sclipiri,_sound_tunet,_storm_clouds],"RandFramework\Alias\AL_monsoon\thunder_storm.sqf"] remoteExec ["execVM"];
		sleep _delayth2;
	};
};
};

if (_effect_on_objects) then {

	while {al_monsoon_om} do {
		_rand_pl = [] execVM "RandFramework\Alias\AL_monsoon\alias_hunt.sqf";
		waitUntil {scriptDone _rand_pl};

	// interval object blow
		sleep 60+random 120;

		al_nearobjects = nearestObjects [hunt_alias,[],50];
		ar_obj_eligibl = [];

		{if((_x isKindOf "LandVehicle") or (_x isKindOf "Man") or (_x isKindOf "Air") or (_x isKindOf "Wreck")) then
			{ar_obj_eligibl pushBack _x;};
		} foreach al_nearobjects;

		sleep 1;

		// alege obiect
		_blowobj= ar_obj_eligibl call BIS_fnc_selectRandom;

		//durata_rafala = 1+random 5;	sleep 30+random 120;
		sleep 1;
		[] spawn {
			_rafale = ["rafala_1","rafala_2","rafala_4_dr","rafala_5_st","rafala_6","rafala_7","rafala_8","rafala_9"] call BIS_fnc_selectRandom;
			[_rafale] remoteExec ["playSound"];
			["RandFramework\Alias\AL_monsoon\camera_shake.sqf"] remoteExec ["execVM"];
		};

		if (!isNull _blowobj) then {
			_xblow	= 0.1+random 5;
			_yblow	= 0.1+random 5;

			// creste viteza incremental
			_xx=0;
			_yy=0;

			while {(_xx< _xblow) or (_yy< _yblow)} do {
				_blowobj setvelocity [_xx*fctx,_yy*fcty,random -1];
				_xx = _xx + 0.01;
				_yy = _yy + 0.01;
				sleep 0.01; //0.0001 + random 0.01;
			};

		};
	};

};