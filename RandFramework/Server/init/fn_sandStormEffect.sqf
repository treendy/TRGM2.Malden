format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;

// Make sure we're not trying to do monsoon/blizzard and sandstorm at the same time...
_iSandStormOption = [2, call TRGM_GETTER_fnc_sandStormOption] select (call TRGM_GETTER_fnc_aWeatherOption < 11);

if (_iSandStormOption isEqualTo 0 && {random 1 < .20}) then { //Random
    [format["Mission Core: %1", "SandStormEffect"], true] call TRGM_GLOBAL_fnc_log;
    StartWhen = selectRandom [990,1290,1710];
    sleep StartWhen;
    //work out how to deal with JIP if sandstorm already playing
    //Maybe store timer, and how long left... so if player JIP, it will fire off storm script if currently runnig and adjust the time to play to what is left
    SandStormTimer = selectRandom [150,390,630];
    publicVariable SandStormTimer;
    [[SandStormTimer,false], "RandFramework\RikoSandStorm\ROSSandstorm.sqf"] remoteExec ["execVM", 0];
    //Set enemy skill
    {
        if (Side _x isEqualTo East) then {
            _x setskill ["aimingAccuracy",0.01];
            _x setskill ["aimingShake",0.01];
            _x setskill ["aimingSpeed",0.01];
            _x setskill ["spotDistance",0.01];
            _x setskill ["spotTime",0.01];
        };
    } forEach allUnits;
    sleep SandStormTimer;
    //reset enemy skill
    {
        if (Side _x isEqualTo East) then {
            _x setskill ["aimingAccuracy",0.15];
            _x setskill ["aimingShake",0.1];
            _x setskill ["aimingSpeed",0.2];
            _x setskill ["spotDistance",0.5];
            _x setskill ["spotTime",0.5];
        };
    } forEach allUnits;
};
if (_iSandStormOption isEqualTo 1) then { //Always
    [format["Mission Core: %1", "SandStormEffect"], true] call TRGM_GLOBAL_fnc_log;
    StartWhen = selectRandom [990,1290,1710];
    sleep StartWhen;
    //work out how to deal with JIP if sandstorm already playing
    //Maybe store timer, and how long left... so if player JIP, it will fire off storm script if currently runnig and adjust the time to play to what is left
    SandStormTimer = selectRandom [150,390,630];
    publicVariable "SandStormTimer";
    [[SandStormTimer,false], "RandFramework\RikoSandStorm\ROSSandstorm.sqf"] remoteExec ["execVM", 0];
    //Set enemy skill
    {
        if (Side _x isEqualTo East) then {
            _x setskill ["aimingAccuracy",0.01];
            _x setskill ["aimingShake",0.01];
            _x setskill ["aimingSpeed",0.01];
            _x setskill ["spotDistance",0.01];
            _x setskill ["spotTime",0.01];
        };
    } forEach allUnits;
    sleep SandStormTimer;
    //reset enemy skill
    {
        if (Side _x isEqualTo East) then {
            _x setskill ["aimingAccuracy",0.15];
            _x setskill ["aimingShake",0.1];
            _x setskill ["aimingSpeed",0.2];
            _x setskill ["spotDistance",0.5];
            _x setskill ["spotTime",0.5];
        };
    } forEach allUnits;
};
if (_iSandStormOption isEqualTo 3) then { //5 hours non stop
    [format["Mission Core: %1", "SandStormEffect"], true] call TRGM_GLOBAL_fnc_log;
    //ok, if something is true, then in here we will start the sand storm and all clients!
    //work out how to deal with JIP if sandstorm already playing
    //Maybe store timer, and how long left... so if player JIP, it will fire off storm script if currently runnig and adjust the time to play to what is left
    [[18030,false], "RandFramework\RikoSandStorm\ROSSandstorm.sqf"] remoteExec ["execVM", 0];
    //Set enemy skill
    {
        if (Side _x isEqualTo East) then {
            _x setskill ["aimingAccuracy",0.01];
            _x setskill ["aimingShake",0.01];
            _x setskill ["aimingSpeed",0.01];
            _x setskill ["spotDistance",0.01];
            _x setskill ["spotTime",0.01];
        };
    } forEach allUnits;
    sleep 18030;
    //reset enemy skill
    {
        if (Side _x isEqualTo East) then {
            _x setskill ["aimingAccuracy",0.15];
            _x setskill ["aimingShake",0.1];
            _x setskill ["aimingSpeed",0.2];
            _x setskill ["spotDistance",0.5];
            _x setskill ["spotTime",0.5];
        };
    } forEach allUnits;
    //reset enemy skill
};
