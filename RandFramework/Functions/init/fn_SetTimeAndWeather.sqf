
params["_isIntro"];
if (isNil "_isIntro") then {_isIntro = false};


if (isNil "TREND_UseEditorWeather") then { TREND_UseEditorWeather =   false; publicVariable "TREND_UseEditorWeather"; };

private _fullMoonDates = {
	private _year = param [0, 2035];
	private ["_date", "_phase", "_fullMoonDate"];
	private _fullMoonPhase = 1;
	private _waxing = false;
	private _fullMoonDates = [];
	for "_i" from dateToNumber [_year, 1, 1, 0, 0] to dateToNumber [_year, 12, 31, 23, 59] step 1 / 365 do
	{
		_date = numberToDate [_year, _i];
		_phase = moonPhase _date;
		call
		{
			if (_phase > _fullMoonPhase) exitWith
			{
				_waxing = true;
				_fullMoonDate = _date;
			};
			if (_waxing) exitWith
			{
				_waxing = false;
				_fullMoonDates pushBack _fullMoonDate;
			};
		};
		_fullMoonPhase = _phase;
	};
	_fullMoonDates
};


if (!TREND_UseEditorWeather && isServer) then {
	if (!isNil "TREND_DateTimeWeather") then {
		TREND_DateTimeWeather params ["_year", "_month", "_day", "_hour", "_min", "_overcast", "_fog"];
		setDate [_year, _month, _day, _hour, _min];
		0 setOvercast (_overcast);
		0 setFog (_fog);
	}
	else {
		[2035, 1, 1, 12, 0] params ["_year", "_month", "_day", "_hour", "_min"];
		private _WeatherOption = selectRandom TREND_WeatherOptions;

		if (_isIntro) then {_WeatherOption = selectRandom [2,8,9,10,7]};

		switch (_WeatherOption) do {
			case 1: { //Sunny Clear
				0 setOvercast 0;
				setDate TREND_Sunny;
			};
			case 2: { //Daytime Heavy Overcast
				0 setOvercast 1;
				setDate TREND_Sunny;
			};
			case 3: { //Day Average overcast
				0 setOvercast 0.5;
				setDate TREND_Sunny;
			};
			case 4: { //Dark Night Clear
				0 setOvercast 0;
				setDate TREND_DarkNight;
			};
			case 5: { //Dark Night Heavy Overcast
				0 setOvercast 1;
				setDate TREND_DarkNight;
			};
			case 6: { //Dark Night Average overcast
				0 setOvercast 0.5;
				setDate TREND_DarkNight;
			};
			case 7: { //EarlyMorning
				0 setOvercast 0.6;
				setDate TREND_EarlyMorning;
			};
			case 8: { //Moon Night Clear
				0 setOvercast 0;
				setDate TREND_MoonNight;
			};
			case 9: { //Moon Night Average overcast
				0 setOvercast 0.4;
				setDate TREND_MoonNight;
			};
			case 10: { //Moon Night Heavy overcast
				0 setOvercast 1;
				setDate TREND_MoonNight;
			};
			case 11: { //Monsoon (Day)
				0 setOvercast 1;
				setDate TREND_EarlyMorning;
				_direction_monsoon	= 200; // direction of rain
				_duration_monsoon	= 18030; //5 hrs
				_effect_on_objects	= false; // no flying objs
				_debris_branches	= false; // no flying debris
				_rain_fog			= true; // ground fog
				_rain_drop			= true; // rain drop effect on ground
				_thunder_steroids	= true; // enable AL thunder effects
				_delay_thunder		= 90; //every 1.5 min
				[[_direction_monsoon,_duration_monsoon,_effect_on_objects,_debris_branches,_rain_fog,_rain_drop,_thunder_steroids,_delay_thunder],"RandFramework\Alias\AL_monsoon\al_monsoon.sqf"] remoteExec ["execVM",0,true];
			};
			case 99: {
				// Using editor weather, this should never get here but just in-case...
			};
			default {// (Default) Sunny Clear
				0 setOvercast 0;
				setDate TREND_Sunny;
			};
		};
	};
	forceWeatherChange;
};

true;