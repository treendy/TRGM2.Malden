if (isServer) then {
	//defaults (only kept for reference of empty values, as the adjusted values below the defaults will be removed after testing!!!)
	/*
	MissionOneLoc = nil; //[0,0,0]
	MainMissionTitle = ""; //"String"
	*/

	MainMissionTitle = "The Mission of DOOOOM";

	MissionMode = 8;
	/*
		0=Heavy Mission (with two optional sides)
		6=Heavy Mission (two hidden optional sides)
		8=Heavy Mission (two objectives at AO, chance of side)
		1=Heavy Mission (Intel required for AO Location)
		2=Heavy Mission Only
		3=Single Mission
		9=Single Mission (two objectives at AO, chance of side)
		4=Three Missions
		7=Three Hidden Missions
		5=Campaign
	*/

	Mission1Loc = [3364.39,19215,0];
	Mission2Loc = nil; //[5868.06,3522.33,0];
	Mission3Loc = nil; //[6235.78,2866.49,0];

	//see startInfMission.sqf from line 284
	Mission1Type = 99999;
	Mission2Type = 13;
	Mission2Type = 13; //7;

	ForceWarZoneLoc = [3021,18451.7,0];

	DateTimeWeather = [/*YEAR*/2055,/*MONTH*/12,/*DAY*/16,/*HOUR*/06,/*MIN*/17,/*OVERCAST*/1,/*FOG*/[0,0,0]];
	//FOG ARRAY:
	/*
		fogValue: Number - value for fog at base level. Range (0...1)
		fogDecay: Number - decay of fog density with altitude. Range (-1...1)
		fogBase: Number - base altitude of fog (in meters). Range (-5000...5000)
	*/	


	iMissionParamType = SavedData select 0;
	publicVariable "iMissionParamType";
	iMissionParamObjective = SavedData select 1;
	publicVariable "iMissionParamObjective";
	iAllowNVG = SavedData select 2;
	publicVariable "iAllowNVG";
	iMissionParamRepOption =  SavedData select 3;
	publicVariable "iMissionParamRepOption";
	iWeather = SavedData select 4;
	publicVariable "iWeather";
	iUseRevive = SavedData select 5;
	publicVariable "iUseRevive";
	iStartLocation = SavedData select 6;
	publicVariable "iStartLocation";

	AdvancedSettings = [0,"Tactical Cannon Fodder",1,1,1,10,DefaultEnemyFactionValue select 0,DefaultFriendlyFactionValue select 0,DefaultSandStormOption,0];
	
}