
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

		if (_isIntro) then {_WeatherOption = selectRandom [2,8,9,10,11]};

		switch (_WeatherOption) do {
			case 1: { //Sunny Clear
				0 setOvercast 0;
				setDate TREND_Sunny;
			};
			case 2: { //Daytime Heavy Overcast
				0 setOvercast 1;
				setDate TREND_Sunny;
			};
			case 3: { //Day average Overcast
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
			case 8: { //moon Night Clear
				0 setOvercast 0;
				setDate TREND_MoonNight;
			};
			case 9: { //moon Night slight overcast
				0 setOvercast 0.4;
				setDate TREND_MoonNight;
			};
			case 10: { //moon Night heavy overcast
				0 setOvercast 1;
				setDate TREND_MoonNight;
			};
			case 11: { //Moon Night slight overcast
				0 setOvercast 1;
				setDate TREND_MoonNight;
			};
			case 12: { //Monsoon (Day)
				0 setOvercast 1;
				setDate TREND_Sunny;
				// null = [220,5000,false] execVM "AL_storm\al_monsoon.sqf"; // File doesn't exists as of 11/24/20
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