
_useCustomMission = false;
if (_useCustomMission || (["CustomMission", 0] call BIS_fnc_getParamValue) isEqualTo 1) then {
	TREND_ForceMissionSetup = true; //will mean the main player will not see an mission setup dialog, and will force the settings you have selected below.
	TREND_MainMissionTitle = "The Mission of DOOOOM";
};

if (isServer && {_useCustomMission || (["CustomMission", 0] call BIS_fnc_getParamValue) isEqualTo 1}) then {

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
		10=Heavy Mission, hidden location and type
		5=Campaign
	*/
	TREND_iMissionParamType = 3;


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
	14 = defuse bomb
	15 = Search and destroy (three targets)
	16 = Destroy Cache
	99999 = meeting assasination
	*/
	TREND_iMissionParamObjective = 3;
	//TREND_iMissionParamObjective2 = 13;
	//TREND_iMissionParamObjective3 = 7;

	TREND_iStartLocation = 1;	//0=StartAtHQ 1=StartNearAO
	TREND_AOCampOnlyAmmoBox = true; //If true, then if players start at camp near AO, then there will only be an ammo box at the position (you may want to set this to true if you have designed your own camp)
	TREND_AOCampLocation = [1674.52,1846.55,0]; //ignored if start location is HQ

	TREND_Mission1Loc = [2079.68,3054.64,0];
	//TREND_Mission2Loc = [3153.53,3491.27,0];
	//TREND_Mission3Loc = [2375.46,302.959,0];

	//These are only used if your mission has a sub task (e.g. speak with bomb informant)
	//However, if you have selected heavy with intel required above (i.e. iMissionParamType = 1), then just select the TREND_Mission2Loc to a pos where the informat will be
	//TREND_Mission1SubLoc = [2079.68,3054.64,0];
	//TREND_Mission2SubLoc = [3153.53,3491.27,0];
	//TREND_Mission3SubLoc = [2375.46,302.959,0];

	TREND_Mission1Title = "Blow dem trucks up!";
	TREND_Mission1Desc = "these trucks need to be blown up man.  They are bad and we need rid!";

	TREND_ForceWarZoneLoc = [3021,18451.7,0]; //nil  << set to nil if not wanted!

	TREND_UseEditorWeather = true; //set this to true, and the weather options will be ignored and will just use what was set in editor
	TREND_DateTimeWeather = [/*YEAR*/2055,/*MONTH*/12,/*DAY*/16,/*HOUR*/09,/*MIN*/17,/*OVERCAST*/1,/*FOG*/[0,0,0]];
	//FOG ARRAY:
	/*
		fogValue: Number - value for fog at base level. Range (0...1)
		fogDecay: Number - decay of fog density with altitude. Range (-1...1)
		fogBase: Number - base altitude of fog (in meters). Range (-5000...5000)
	*/

	TREND_iAllowNVG = 1;	//0=NotAllowed, 1=Allowed, 2=Realistic
	TREND_iMissionParamRepOption =  0;	//1=FailMissionIfRepLow 0=JustFailTaskIfRepLow
	TREND_iUseRevive = 0;	//0=NoRevive 1=GuaranteeRevive 2=CriticalHitsWillKill 3=As2ButOnlyMedicsCanRevive  4=As3ButMedicsNeedToBeNearMedicalVehicle  5=As3ButMedicsNeedToBeAtHQ

	//TREND_NewMissionMusic = "LeadTrack02_F_Jets";
	//TREND_PatrolType = 0; //0=random  1=smaller size, but more patrols spread around the AO
	//TREND_AllowAOFires = false;
	TREND_HideAoMarker = true; //just incase you want to add your own markers!

	TREND_CustomAdvancedSettings =
	[
		1, 					//Allow virtual arsenal
		"Tactical Test 2", 	//Group Name
		0, 					//Allow Support Options
		1, 					//Respawn ticket count (set to 1 for no respawn)
		1, 					//Allow map drawing in direct channel only (Setting to zero will all map drawing in all channels)
		10, 				//Respawn timer
		"OPF_F", 			//EnemyFaction | Vanilla Examples: OPF_F=CSAT,  OPF_T_F=CSAT (Pacific),  OPF_G_F=FIA | RHS Examples: rhs_faction_msv=Russia (MSV), rhs_faction_vdv=Russia (VDV)
		"IND_G_F", 			//MilitiaFaction | Vanilla Examples: IND_F=AAF,  IND_G_F=FIA,  3=FIA | RHS Examples: rhsgref_faction_cdf_ground=CDF Ground Forces
		"BLU_F", 			//FriendlyFaction | Vanilla Examples: BLU_F=NATO, BLU_T_F=NATO (Pacific), BLU_G_F=FIA | RHS Examples: rhs_faction_usarmy_d=US Army D, rhs_faction_usmc_wd=USMC WD
		2, 					//Sandstorm option (0=Random, 1=Always, 2=Never, 3=NonStop)
		0, 					//Enable Group Manager
		0, 					//allow to select AO position (pointless if ForceMissionSetup is set to false above)
		0, 					//allow to select AO camp position (pointless if ForceMissionSetup is set to false above)
		0, 					//enemy have flashlights (0=random, 1=yes, 2=no),
		0, 					//Make tasks mini missions
		0, 					//Compact Target/Ied Missions
		0, 					//Harder mission (beta)
		0, 					//Large patrols
		0 					// Vehicle spawning requires rep points
	];

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Do not change anything under here!
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	publicVariable "TREND_ForceMissionSetup";
	publicVariable "TREND_MainMissionTitle";
	publicVariable "TREND_iMissionParamType";
	publicVariable "TREND_iMissionParamObjective";
	publicVariable "TREND_iMissionParamObjective2";
	publicVariable "TREND_iMissionParamObjective3";
	publicVariable "TREND_iStartLocation";
	publicVariable "TREND_AOCampOnlyAmmoBox";
	publicVariable "TREND_AOCampLocation";
	publicVariable "TREND_Mission1Loc";
	publicVariable "TREND_Mission2Loc";
	publicVariable "TREND_Mission3Loc";
	publicVariable "TREND_Mission1SubLoc";
	publicVariable "TREND_Mission2SubLoc";
	publicVariable "TREND_Mission3SubLoc";
	publicVariable "TREND_Mission1Title";
	publicVariable "TREND_Mission1Desc";
	publicVariable "TREND_ForceWarZoneLoc";
	publicVariable "TREND_UseEditorWeather";
	publicVariable "TREND_DateTimeWeather";
	publicVariable "TREND_iAllowNVG";
	publicVariable "TREND_iMissionParamRepOption";
	publicVariable "TREND_iUseRevive";
	publicVariable "TREND_NewMissionMusic";
	publicVariable "TREND_PatrolType";
	publicVariable "TREND_AllowAOFires";
	publicVariable "TREND_HideAoMarker";

	// Convert string to index:
	TREND_AdvancedSettings = [];
	{
		switch (_forEachIndex) do {
			case 6: { //TREND_ADVSET_ENEMY_FACTIONS_IDX
				for "_i" from 0 to (count TREND_EastFactionData - 1) do {
					(TREND_EastFactionData select _i) params ["_className", "_displayName"];
					if (_className == _x) then {
						TREND_AdvancedSettings pushBack _i;
					};
				};
			};
			case 7: { //TREND_ADVSET_MILITIA_FACTIONS_IDX
				for "_i" from 0 to (count TREND_GuerFactionData - 1) do {
					(TREND_GuerFactionData select _i) params ["_className", "_displayName"];
					if (_className == _x) then {
						TREND_AdvancedSettings pushBack _i;
					};
				};
			};
			case 8: { //TREND_ADVSET_FRIENDLY_FACTIONS_IDX
				for "_i" from 0 to (count TREND_WestFactionData - 1) do {
					(TREND_WestFactionData select _i) params ["_className", "_displayName"];
					if (_className == _x) then {
						TREND_AdvancedSettings pushBack _i;
					};
				};
			};
			default { TREND_AdvancedSettings pushBack _x;};
		};
	} forEach TREND_CustomAdvancedSettings;
	publicVariable "TREND_AdvancedSettings";
};