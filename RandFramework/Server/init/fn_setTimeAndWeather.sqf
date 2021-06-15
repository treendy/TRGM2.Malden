
params[["_isIntro", false]];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;

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


if (!TRGM_VAR_UseEditorWeather && isServer) then {
    if (!isNil "TRGM_VAR_DateTimeWeather") then {
        TRGM_VAR_DateTimeWeather params ["_year", "_month", "_day", "_hour", "_min", "_overcast", "_fog"];
        setDate [_year, _month, _day, _hour, _min];
        0 setOvercast (_overcast);
        0 setFog (_fog);
    }
    else {
        _BrightestNightDate = [2033, 2, 12]; //This date is a night with the moon phase isEqualTo 1 (i.e. super moon), note that it is different than real life.
        _BrightestNightDate params ["_year", "_month", "_day"];
        TRGM_VAR_arrayTime params ["_hour", "_min"];
        [[_year, _month, _day, _hour, _min], {params ["_year", "_month", "_day", "_hour", "_min"]; setDate [_year, _month, _day, _hour, _min]}] remoteExec ["call",0,true];

        private _WeatherOption = call TRGM_GETTER_fnc_aWeatherOption;

        if (_isIntro) then {_WeatherOption = selectRandom [1,2,3]};

        switch (_WeatherOption) do {
            case 1: { //Clear
                0 setOvercast 0;
            };
            case 2: { //Heavy Overcast
                0 setOvercast 1;
            };
            case 3: { //Average overcast
                0 setOvercast 0.5;
            };
            case 4: { //Realistic
                // These are really just guestimates, but it basically is saying "it's clear at night, foggy in the morning, cloudy during the day, chance of rain in the evening, clears up by midnight.
                // I'm not a Meteorologist though ¯\_(ツ)_/¯
                _timeBasedOvercast = [0, 0, (1/16), (1/8), (1/4), (1/2), (3/4), 1, (3/4), (1/2), (1/4), (1/8), (1/16), (1/8), (1/4), (1/2), (3/4), 1, (1/2), (1/4), (1/8), (1/16), 0, 0] select _hour;
                0 setOvercast (_timeBasedOvercast);
            };
            case 31: { //Monsoon
                0 setOvercast 1;
                _direction_monsoon    = 200; // direction of rain
                _duration_monsoon    = 18030; //5 hrs
                _effect_on_objects    = false; // no flying objs
                _debris_branches    = false; // no flying debris
                _rain_fog            = true; // ground fog
                _rain_drop            = true; // rain drop effect on ground
                _thunder_steroids    = true; // enable AL thunder effects
                _delay_thunder        = 90; //every 1.5 min
                [[_direction_monsoon,_duration_monsoon,_effect_on_objects,_debris_branches,_rain_fog,_rain_drop,_thunder_steroids,_delay_thunder],"RandFramework\Alias\AL_monsoon\al_monsoon.sqf"] remoteExec ["execVM",0,true];
            };
            case 41: { //Blizzard
                0 setOvercast 1;
                _snowfall            = true; // snow particles
                _duration_storm        = 18030; // 5 hrs
                _ambient_sounds        = 60; // ambient sounds
                _breath_vapors        = false; // no breath (bad for a lot of units)
                _snow_burst            = 90; // frequency of snow bursts
                _effect_on_objects    = false; // snow burst blows debris
                _vanilla_fog        = true; // script controls fog levels
                _local_fog            = true; // use script's local fog
                _intensifywind        = true; // wind has force
                _unitsneeze            = true; // units will randomly sneeze/cough during snow bursts
                [[_snowfall,_duration_storm,_ambient_sounds,_breath_vapors,_snow_burst,_effect_on_objects,_vanilla_fog,_local_fog,_intensifywind,_unitsneeze],"RandFramework\Alias\AL_snowstorm\al_snow.sqf"] remoteExec ["execVM",0,true];
            };
            case 99: {
                // Using editor weather, this should never get here but just in-case...
            };
            default {// (Default) Sunny Clear
                0 setOvercast 0;
            };
        };
    };
    forceWeatherChange;
};

true;