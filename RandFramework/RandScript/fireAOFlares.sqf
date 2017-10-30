if (isServer) then {

	

	_Pos = _this select 0;



	_al_color_flare = [1,1,1];
	_flare_brig = al_flare_intensity;

	_flareposX = 0;
	_flareposY = 0;
	_flareposZ = 200;
 	_flareposX = (_Pos select 0) + random 50;
	_flareposY = (_Pos select 1) + random 50;
	//(mrkFirstLocation) ModelToWorld [0,100,200]
	
	_flare1 = "F_40mm_white" createvehicle [_flareposX,_flareposY, 250]; _flare1 setVelocity [0,0,-10];

	sleep 3;

	_al_flare_light = "#lightpoint" createVehicle getPosATL _flare1;  
	_al_flare_light setLightAmbient _al_color_flare;  
	_al_flare_light setLightColor _al_color_flare;
	_al_flare_light setLightIntensity al_flare_intensity;
	_al_flare_light setLightUseFlare true;
	_al_flare_light setLightFlareSize 10;
	_al_flare_light setLightFlareMaxDistance 2000;
	_al_flare_light setLightAttenuation [/*start*/ al_flare_range, /*constant*/1, /*linear*/ 100, /*quadratic*/ 0, /*hardlimitstart*/50,/* hardlimitend*/al_flare_range-10]; 
	_al_flare_light setLightDayLight true;

	// lumina intermitent 23
	
	_inter_flare = 0;
	while {_inter_flare<21} do {
		_int_mic = 0.05 + random 0.1;
		sleep _int_mic;
		_flare_brig = al_flare_intensity+random 10;
		_al_flare_light setLightIntensity _flare_brig;
		_inter_flare = _inter_flare + _int_mic;
		_al_flare_light setpos (getPosATL _flare1);
	};

	_int_mic = 3;

//	hint "scade";

	while {_int_mic>0} do {
		_flare_brig = _flare_brig - 10;
		_al_flare_light setLightIntensity _flare_brig;
		_int_mic = _int_mic-0.03;
		sleep 0.01;
	};
//	hint "DOne";
	deleteVehicle _al_flare_light;
};
