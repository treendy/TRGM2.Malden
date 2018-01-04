#include "..\setUnitGlobalVars.sqf";

params["_isIntro"];
if (isNil "_isIntro") then {_isIntro = false};

if (isServer) then {
	    _year = 2035;
	    _month = 1;
	    _day = 1;
	    _hour = 12;
	    _min = 0;
	    
	    _WeatherOption = selectRandom WeatherOptions;
	    if (_isIntro) then {_WeatherOption = selectRandom [2,8,9,10,11]};
	    
	    if (_WeatherOption == 1) then { //Sunny Clear
			0 setOvercast 0;
	    	setDate Sunny;    
	 	};
	 	if (_WeatherOption == 2) then {  //Daytime Heavy Overcast
			0 setOvercast 1;
	    	setDate Sunny;    
	 	};
	 	if (_WeatherOption == 3) then { //Day average Overcast
			0 setOvercast 0.5;
	    	setDate Sunny;    
	 	};
		if (_WeatherOption == 4) then {   //Dark Night Clear
			0 setOvercast 0;
	    	setDate DarkNight;    
	 	};
	 	if (_WeatherOption == 5) then {  //Dark Night Heavy Overcast
			0 setOvercast 1;
	    	setDate DarkNight;    
	 	};
	 	if (_WeatherOption == 6) then {  //Dark Night Average overcast
			0 setOvercast 0.5;
	    	setDate DarkNight;   
	 	};
	 	if (_WeatherOption == 7) then {   //EarlyMorning
			0 setOvercast 0.6;
	    	setDate EarlyMorning;    
	 	};
		if (_WeatherOption == 8) then {   //moon Night Clear
			0 setOvercast 0;
	    	setDate MoonNight;    
	 	};
	 	if (_WeatherOption == 9) then {  //moon Night slight overcast
			0 setOvercast 0.4;
	    	setDate MoonNight;    
	 	};	    
	   	if (_WeatherOption == 10) then {  //moon Night heavy overcast
			0 setOvercast 1;
	    	setDate MoonNight;    
	 	};
	   	if (_WeatherOption == 11) then {  //Moon Night slight overcast
			0 setOvercast 1;
	    		setDate MoonNight;    
	 	};
		if (_WeatherOption == 12) then {  //Monsoon (Day)
			0 setOvercast 1;
			setDate Sunny;   
			null = [220,5000,false] execvm "AL_storm\al_monsoon.sqf";   
	 	};			



	forceWeatherChange;
	    
};    