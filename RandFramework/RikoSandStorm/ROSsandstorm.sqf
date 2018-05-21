// ROS Sandstorm V3.0 by RickOShay 2017
// You may use this script as long as I'm creditted and this header text is not removed.
// nul = [duration in secs before fade out] execvm "scripts\ROSSandstorm.sqf";
// nul = [90] execvm "RandFramework\RikoSandStorm\ROSSandstorm.sqf";
// Minimum SS length 90 secs = 30 secs intro + 60 secs loop (x N loops) = 90 secs due to intro + sound loop length x 1.
// Other examples [210] = 30 + (60x3) ie. intro + 3 loops. Or [270] = 30 + (60x4) or [510] = 30 + (60x8). Each of these has a 60 outro excluded from SS length.
// Lengths to use in secs: 90, 150, 210, 270, 330, 390, 450, 510, 570, 630, 690, 750, 810, 870, 930, 990. etc.
// Actual SS length will be 67 secs longer than specified [x] due to Outro fadeout. Outro should be excluded from required SS length.

// JIP - remove if more than one sandstorm in mission = JIP problem - will need multiple variables sandstormdone1 2 etc.
// if (sandstormdone1) exitWith {};

// Debug - disable hint debug
_test = false;

_dur = _this select 0;
_endtime = (time + _dur);
inside = false;

// Reset time multiplier - important
_curtimemultiplier = timeMultiplier;
if (isServer) then {setTimeMultiplier 1};

// Remove ambient life
enableEnvironment [false, true];

if (_test) then {hint format ["Endtime %1", _endtime + 67];};
if (_test) then {sleep 3};
if (_test) then {hint "SS start"};

// Warning length = 11 secs
if (selectRandom [true,false]) then {
    playsound ["sswarning", true];
};

sleep 15;

// Start wind intro = 20 secs ///////////////////////////////////////////////////////////////////////////
if (_test) then {hint "Start Wind intro sound";};
playsound ["sswindintro",false];

// Change wind direction and increase wind 15 secs
    _initwind = wind;
    setwind [0,0,true];
    for "_i" from 1 to 5 do {
        setWind [(wind select 0) + _i, (wind select 1) + _i, true];
        sleep 3;
    };
if (_test) then {hint "Wind speed increased 15/15";};

// Start leaves
    if (_test) then {hint "Start leaves";};
    _leaves_p  = "#particlesource" createVehicleLocal (getpos vehicle player);
    _leaves_p attachto [vehicle player];
    _leaves_p setParticleRandom [0, [10, 10, 7], [4, 4, 5], 2, 0.1, [0, 0, 0, 0.5], 1, 1];
    _leaves_p setParticleCircle [100, [0, 0, 0]];
    _leaves_p setParticleParams [
    ["\A3\data_f\ParticleEffects\Hit_Leaves\Sticks_Green", 1, 1, 1],
    "",
    "SpaceObject",
    1,
    27,
    [0,0,0],
    [40,40,10],
    2,
    0.000001,
    0.0,
    0.1,
    [0.5 + random 0.5],    [[0.68,0.68,0.68,1]],
    [1.5,1],
    13,
    13,
    "",
    "",
    vehicle player,
    0,
    true,
    1,
    [[0,0,0,0]]];
    _leaves_p setDropInterval 0.015;

// Start Wind loop sound
if (_test) then {hint "Start Wind loop";};
[_dur, _endtime, _test] execvm "RandFramework\RikoSandStorm\ROSwindloop.sqf";

// Start Film grain
    if (_test) then {hint "Start filmgrain";};
    _hndlFg = ppEffectCreate ["FilmGrain", 2050];
    _hndlFg ppEffectEnable true;
    _hndlFg ppEffectAdjust [0.08, 1.25, 2.05, 0.75, 1, false];
    _hndlFg ppEffectCommit 45;

// Adjust camshake and sound volume if player in building or vehicle
[_endtime] spawn {
    _endtime = _this select 0;
    While {time < _endtime + 35} do {
 // extra time added due to fadeout time
            _building = nearestObject [player, "HouseBase"];
            _relPos = _building worldToModel (getPosATL player);
            _boundBox = boundingBoxReal _building;
            _min = _boundBox select 0;
            _max = _boundBox select 1;
            _playerX = _relPos select 0;
            _playerY = _relPos select 1;
            _playerZ = _relPos select 2;
            _minX = _min select 0;
            _minY = _min select 1;
            _minZ = _min select 2;
            _maxX = _max select 0;
            _maxY = _max select 1;
            _maxZ = _max select 2;
            _duration = 2 + random 2;
            if ((_playerX > _minX && _playerX < _maxX && _playerY > _minY && _playerY < _maxY && _playerZ > _minZ && _playerZ < _maxZ) or vehicle player != player)
              then {inside = true} else {inside = false};
    // Adjust camshake if player in vehicle or building and reduce sound volume accordingly
            if (inside) then {0.5 fadeSpeech 0.25; enableCamShake false;};
            if (!inside) then {0.5 fadeSpeech 1; enableCamShake true; addCamShake [(0.5 + random 1), _duration, (3 + random 3)]};
    // hint format ["Inside %1", inside];
            sleep 0.2;
    };

    inside = false;
};

/* Testing
[_endtime] spawn {
    _endtime = _this select 0;
    while {time < _endtime} do {
    hint format ["Time: %1 Endtime: %2",time, _endtime];
    sleep 2;
    };
};
*/

// Start fog and synch make sure timemultiplier = 1 (see above) to avoid synch and timing issues
    if (_test) then {hint "Start fog"};
    if (isServer) then {
        60 setFog 0.5;
    };

// Add particle effect

    _particles = "#particlesource" createVehicleLocal (getpos vehicle player);
    _particles attachto [vehicle player];
    _particles setParticleCircle [15, [0, 0, 0]];
    _particles setParticleRandom [10, [0.25, 0.25, 0], [1, 1, 0], 1, 1, [0, 0, 0, 0.1], 0, 0.01];

    _future = time+20;
    _y = 0;

while {time < _future} do {
    _particles setParticleParams
    [["\A3\data_f\cl_basic", 1, 0, 1],
    "", "Billboard",
    1,
    15,
    [0, 0, 0],
    [10, 10, 0],
    1,
    10.15,
    7.9, //HERE was 7.9  lower is 4.9
    0.01,
    [10, 10, 20],
    [[0.7, 0.66, 0.5, _y], [0.7, 0.66, 0.5, _y], [0.7, 0.66, 0.5, _y]],
    [0.08],
    1,
    0,
    "",
    "",
    vehicle player];

// Increase Part circle diam if inside vehicle or building
    if (inside) then {_particles setParticleCircle [20, [1, 1, 0]]} else {_particles setParticleCircle [50, [1, 1, 0]]};
    _particles setDropInterval 0.04;
    sleep 1;
    _y = _y + 0.005; //Here was 0.015 lower is 0.005
};

// Add Color correction
    if (_test) then {hint "Start color correction";};
    _hndl1 = ppEffectCreate ["colorCorrections", 1550];
    _hndl1 ppEffectEnable true;
    _hndl1 ppEffectAdjust [0.5 + (overcast/3), 1, 0, [0.7, 0.66, 0.6, 0.2], [0.7, 0.66, 0.6, 0.2], [0.7, 0.66, 0.6, 0.2]];
    _hndl1 ppEffectCommit 10;

    sleep 15;

// Modify Color correction and dust
    if (_test) then {hint "Start modify CC and alpha";};
    While {time < _endtime} do {
        _hndl1 ppEffectAdjust [0.6 + (overcast/3), 1, 0.05, [0.7, 0.66, 0.6, 0.1 + random 0.4], [0.6 + random 0.1, 0.66, 0.6, 0.1 + random 0.4], [0.6 + random 0.1, 0.66, 0.6, 0.1 + random 0.4]];
        _hndl1 ppEffectCommit 3 + (floor random 2);

        _particles attachto [vehicle player];
        _particles setParticleParams
        [["\A3\data_f\cl_basic", 1, 0, 1],
        "", "Billboard",
        1,
        15,
        [0, 0, 0],
        [10, 10, 0],
        3,
        10.15,
        7.9, //Here was 7.9 lower is 4.9
        0.01,
        [10, 10, 20],
        [[0.7, 0.66, 0.6, 0.1+random 0.4], [0.7, 0.66, 0.6, 0.1+random 0.4], [0.7, 0.66, 0.6, 0.1+random 0.4]], //Here, was random 0.4,random 0.4,random 0.4 lower is random 0.1, random 0.1, random 0.1
        [0.08],
        1,
        0,
        "",
        "",
        vehicle player];
        if (inside) then {_particles setParticleCircle [20, [1, 1, 0]]} else {_particles setParticleCircle [40, [1, 1, 0]]};
        _particles setDropInterval 0.01;

        sleep 5;
    };

// FADE OUT EFFECTS ///////////////////////////////////////////////////////////////////////////////
    if (_test) then {hint "Fade out Sandstorm"; sleep 1;};

// Reset time multiplier to mission init settings
    if (_test) then {hint "Time multiplier reset"};
    if (isServer && _curtimemultiplier > 1) then {
        setTimeMultiplier _curtimemultiplier;
    };

// Fade color correction to normal
    if (_test) then {hint "Colour correction fade to normal"};
    _hndl1 ppEffectAdjust [1, 1, 0,[ 0, 0, 0, 0],[ 1, 1, 1, 1],[ 0, 0, 0, 0]];
    _hndl1 ppEffectCommit 60;

// Remove Fog
    if (_test) then {hint "Remove fog"};
    //force fog to 0
    setTimeMultiplier 2;
    if (isServer) then {35 setFog 0};

    sleep 20;

// Remove _particles
    if (_test) then {hint "Remove particles and fade wind"};
     _particles setParticleCircle [400, [1, 1, 0]];
    sleep 5;
    deleteVehicle _particles;

// Remove leaves
    if (_test) then {hint "Remove leaves"};
    deletevehicle _leaves_p;

    sleep 15;

// Reduce wind
    if (_test) then {hint "Reduce wind"};
    setWind [8, 8, true];
    sleep 7;
    setWind [6, 6, true];

    enableCamShake false;

    sleep 7;

// Reduce film grain and wind
    _hndlFg ppEffectAdjust [0.01, 1.25, 2.05, 0.75, 1, false];
    setWind [4, 4, true];
    sleep 10;
    setWind [3, 3, true];

// Remove Film grain
    if (_test) then {hint "Remove film grain"};
    _hndlFg ppEffectEnable false;
    ppEffectDestroy _hndlFg;

    sleep 10;

// Remove color correction
    if (_test) then {hint "Delete color correction"};
    _hndl1 ppEffectEnable false;
    ppEffectDestroy _hndl1;

// Set wind to original wind setting
    setWind [_initwind select 0, _initwind select 1, true];

// Switch on life
    if (_test) then {hint "Environment on"};
    enableEnvironment [true, true];

// SS END - FADE out ///////////////////////////////////////////////////////////////////////

_endtime = "";

// JIP
//sandstormdone1 = true;
//publicVariable "sandstormdone";

// Remove this - used to extend dawn length - mission specific for sfx
// if (isServer && daytime > 5 && daytime < 8) then {setTimeMultiplier 0.5};

if (_test) then {hint "Sandstorm End"};