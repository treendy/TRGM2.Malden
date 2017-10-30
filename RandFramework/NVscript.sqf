// Night Vision Script Made by BroDouYouEvenBro/Turboswaggg/Tripod27 (I use too many different names) with the help of Killzone Kid (his blog is awesome) and PabstMirror from the ArmaDev subreddit

// Just put this file in the libraries > documents > arma 3/ arma 3 - other profiles > profile you saved the mission on > missions/MPMissions (put it in the folder of every version of your mission you find to be safe)

// Then either add the words    [] execVM "NVscript.sqf";    to your init.sqf file in that same mission that you put this file in or make an init.sqf file in that same mission that you put this file in (make a notepad.txt file then rename the file to init.sqf) and put the words    [] execVM "NVscript.sqf";    in it and save

// This script does seem to slow down if other scripts are being used, sometimes delaying the effects for a noticeable amount of time depending on how big the other scripts you added to your mission are

// If you make any improvments to this script try to tell me! I know there are things you can improve since I just started scripting 4 days before I finished this and if you manage to make a better version I wanna use it


if (isDedicated) exitWith {};
if (player != player) then {waitUntil {player == player};};

// Figures out how zoomed in you are (KillzoneKid is Awesome)
KK_fnc_getZoom = {
    (
        [0.5,0.5] 
        distance 
        worldToScreen 
        positionCameraToWorld 
        [0,1.05,1]
    ) * (
        getResolution 
        select 
        5
    )
};

    while {true} do {
    waitUntil {

    // Adds Effects When NV Enabled
    ((vehicle player) == player) && ((currentVisionMode player) == 1)};

    // Effects below. If you wanna know what this stuff means so you can change the effects, go to https://community.bistudio.com/wiki/Post_process_effects
    // Effect modifiers that change based on range like overall blur and film grain size are further down

    // Dynamic Blur
    ppBlur = ppEffectCreate ["dynamicBlur", 500]; 
    ppBlur ppEffectEnable true;    
    500 ppEffectForceInNVG true;


    // Edge Blur
    ppRim = ppEffectCreate ["RadialBlur", 250]; 
    ppRim ppEffectEnable true;   
    ppRim ppEffectAdjust [0.015, 0.015, 0.22, 0.3];
    ppRim ppEffectCommit 0;  
    501 ppEffectForceInNVG true;


    // Color and Contrast
    ppColor = ppEffectCreate ["ColorCorrections", 1500];  ppColor ppEffectEnable true;
    ppColor ppEffectAdjust [0.6, 1.4, -0.02, [1, 1, 1, 0], [1, 1, 1, 1], [0, 0, 0, 0]]; 
    ppColor ppEffectCommit 0;
    ppColor ppEffectForceInNVG true;


    // Film Grain
    ppFilm = ppEffectCreate ["FilmGrain", 2501]; 
    ppFilm ppEffectEnable true;   
    2501 ppEffectForceInNVG true;

    waitUntil {
    // Scaling effects during Zooming

    _zoomintensity = (call kk_fnc_getZoom * 10) /30;

    
    ppBlur ppEffectAdjust [0.25 + (_zoomIntensity * 0.35)]; 
    ppBlur ppEffectCommit 0; 

    
    ppFilm ppEffectAdjust [0.22, 1, _zoomIntensity, 0.4, 0.2, false];
    ppFilm ppEffectCommit 0;  
    
    //Removes Effects When NV Disabled
    ((vehicle player) != player) || ((currentVisionMode player) != 1)   
    };

    ppEffectDestroy ppBlur; 
    ppEffectDestroy ppRim; 
    ppEffectDestroy ppColor;
    ppEffectDestroy ppFilm;
    };
