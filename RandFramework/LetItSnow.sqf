#include "../setUnitGlobalVars.sqf";	

if (bIsSnow) then {

	iChanceSnow = ("OUT_par_LetItSnow" call BIS_fnc_getParamValue);  // i.e. weather type (need to rename variable)

	if (iChanceSnow == 1) then {
		if bBlackWhiteIfSnow then {
				"colorCorrections" ppEffectEnable true; "colorCorrections" ppEffectAdjust [0.5,0.5,0,[0,0,0,0],[0.85,1,1,0.4],[1,1,1,1]]; "colorCorrections" ppEffectCommit 0.5; 
		};
		
		//0 setFog 0.6;
		//setWind [10, 10, true];
		0 setRain 0;
		0 setOvercast 0;

		[] execVM "RandFramework\goon_snowstorm.sqf";
	};
	if (iChanceSnow == 2) then {
		
		{
			if ((side _x) == EnemySide) then {
				//_x setSkill ["general",1];
				_x setSkill ["aimingAccuracy",0.1];
				_x setSkill ["aimingShake",0.2];
				_x setSkill ["aimingSpeed",0.4];
				_x setSkill ["endurance",0.1];
				_x setSkill ["spotDistance",0.1];
				_x setSkill ["spotTime",0.1];
				_x setSkill ["courage",1];
				_x setSkill ["reloadspeed",0.1];
				_x setSkill ["commanding",0.5];
			};
		} forEach allUnits;
		
		null = [340,86400,false,false,false] execvm "AL_dust_storm\al_duststorm.sqf";
		0 setOvercast 1;
		0 setLightnings 0;
		forceWeatherChange;
		0=[] spawn {while {true} do {1 setRain 0;0 setLightnings 0;sleep 1}}; 
	};
	if (iChanceSnow == 3) then { //Blizzard
		if bBlackWhiteIfSnow then {
				"colorCorrections" ppEffectEnable true; "colorCorrections" ppEffectAdjust [0.5,0.5,0,[0,0,0,0],[0.85,1,1,0.4],[1,1,1,1]]; "colorCorrections" ppEffectCommit 0.5; 
		};
		
		
		0 setFog [0.7, 0, 0];
		0 setOverCast 1;
		0 setRain 0;
		setWind [-1,-1];
		forceWeatherChange;


		[] execVM "RandFramework\goon_snowstorm.sqf";

		// start audio
		if (true) then {
			[] spawn {
				private "_cnt";
				playSound "MKY_Blizzard";
				//player say ["MKY_Blizzard",5];
				_cnt = 0;
				while {true} do {
					_cnt = 0;
					while {true} do  {
						
						0 setFog [0.7, 0, 0];
						0 setOverCast 1;
						0 setRain 0;
						setWind [-1,-1];

						if bBlackWhiteIfSnow then {
							"colorCorrections" ppEffectEnable true; "colorCorrections" ppEffectAdjust [0.5,0.5,0,[0,0,0,0],[0.85,1,1,0.4],[1,1,1,1]]; "colorCorrections" ppEffectCommit 0.5; 
						};
						_cnt = _cnt + 1;
						if (_cnt >= 205) then {
							playSound "MKY_Blizzard";
							//player say ["MKY_Blizzard",5];
							_cnt = 0;
						};
						sleep 1;
					};
					sleep 1;
				};
			};
		};


	};

};