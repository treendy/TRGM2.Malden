
_useCustomMission = false;
if (isServer && _useCustomMission) then {

	ForceMissionSetup = true;

	MainMissionTitle = "The Mission of DOOOOM";

	iMissionParamType = 3;
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

	

	/*
	1 = Hack Data
	2 = Steal data from research vehicle
	3 = Destroy Ammo Trucks
	4 = Speak with informant
	5 = interrogate officer
	6 = Transmit Enemy Comms to HQ
	7 = Eliminate Officer   -   gain 1 point if side, if main, need to id him before complete
	8 = Assasinate weapon dealer   -   gain 1 point if side, no intel from him... if main need to id him before complete
	9 = Destroy AAA vehicles
	10 = Destroy Artillery vehicles
	11 = Rescue POW
	12 = Rescue Reporter
	13 = defuse 3 IEDs
	13 = defuse bomb
	99999 = meeting assasination
	*/
	iMissionParamObjective = 3;
	//iMissionParamObjective2 = 13;
	//iMissionParamObjective3 = 7;

	AOCampOnlyAmmoBox = true; //If true, then if players start at camp near AO, then there will only be an ammo box at the position (you may want to set this to true if you have designed your own camp)

	AOCampLocation = [1674.52,1846.55,0]; //ignored if start location is HQ
	Mission1Loc = [2079.68,3054.64,0];
	//Mission2Loc = [3153.53,3491.27,0]; 
	//Mission3Loc = [2375.46,302.959,0];
	ForceWarZoneLoc = [3021,18451.7,0]; //nil  << set to nil if not wanted!

	DateTimeWeather = [/*YEAR*/2055,/*MONTH*/12,/*DAY*/16,/*HOUR*/09,/*MIN*/17,/*OVERCAST*/1,/*FOG*/[0,0,0]];
	//FOG ARRAY:
	/*
		fogValue: Number - value for fog at base level. Range (0...1)
		fogDecay: Number - decay of fog density with altitude. Range (-1...1)
		fogBase: Number - base altitude of fog (in meters). Range (-5000...5000)
	*/	

	iAllowNVG = 1;	//0=NotAllowed, 1=Allowed, 2=Realistic
	iMissionParamRepOption =  1;	//1=FailMissionIfRepLow 0=JustFailTaskIfRepLow
	iUseRevive = 0;	//0=NoRevive 1=GuaranteeRevive 2=CriticalHitsWillKill 3=As2ButOnlyMedicsCanRevive  4=As3ButMedicsNeedToBeNearMedicalVehicle  5=As3ButMedicsNeedToBeAtHQ
	iStartLocation = 1;	//0=StartAtHQ 1=StartNearAO
	AdvancedSettings = 
	[
		1, //Allow virtual arsenal
		"Tactical Test 2", //Group Name
		0, //Allow Support Options
		1, //Respawn ticket count (set to 1 for no respawn)
		1, //Allow map drawing in direct channel only (Setting to zero will all map drawing in all channels)
		10, //Respawn timer
		1, //EnemyFaction
		1, //FriendlyFaction
		3, //Sandstorm option (0=Random, 1=Always, 2=Never, 3=NonStop)
		0 //Enable Group Manager
	];
	

	//Do not change anything under here!
	publicVariable "iAllowNVG";
	publicVariable "iMissionParamRepOption";
	publicVariable "iUseRevive";	
	publicVariable "iStartLocation";
	publicVariable "iMissionParamType";
	publicVariable "iMissionParamObjective";
	publicVariable "iMissionParamObjective2";
	publicVariable "iMissionParamObjective3";
}