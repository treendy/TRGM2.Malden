if (TRGM_VAR_OverrideMissionSetup) then {
    TRGM_VAR_ForceMissionSetup = false; // a value of 'true' means the main player will not see an mission setup dialog, and will force the settings you have selected below.
    TRGM_VAR_UseCustomMission = false; // a value of 'true' enables the use of the Custom Mission (value 99999) below.
    TRGM_VAR_MainMissionTitle = "The Mission of DOOOOM";
};

if (isServer && {TRGM_VAR_OverrideMissionSetup}) then {

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
    TRGM_VAR_iMissionParamType = 3;


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
    99999 = Custom Mission - MUST BE ENABLED VIA 'Enable Custom Mission' parameter in lobby OR 'TRGM_VAR_UseCustomMission' must be set to TRUE above!
    */
    TRGM_VAR_iMissionParamObjective = 3;
    //TRGM_VAR_iMissionParamObjective2 = 13;
    //TRGM_VAR_iMissionParamObjective3 = 7;

    TRGM_VAR_iStartLocation = 1;    //0=StartAtHQ 1=StartNearAO
    TRGM_VAR_AOCampOnlyAmmoBox = true; //If true, then if players start at camp near AO, then there will only be an ammo box at the position (you may want to set this to true if you have designed your own camp)
    TRGM_VAR_AOCampLocation = [1674.52,1846.55,0]; //ignored if start location is HQ

    TRGM_VAR_Mission1Loc = [2079.68,3054.64,0];
    //TRGM_VAR_Mission2Loc = [3153.53,3491.27,0];
    //TRGM_VAR_Mission3Loc = [2375.46,302.959,0];

    //These are only used if your mission has a sub task (e.g. speak with bomb informant)
    //However, if you have selected heavy with intel required above (i.e. iMissionParamType = 1), then just select the TRGM_VAR_Mission2Loc to a pos where the informat will be
    //TRGM_VAR_Mission1SubLoc = [2079.68,3054.64,0];
    //TRGM_VAR_Mission2SubLoc = [3153.53,3491.27,0];
    //TRGM_VAR_Mission3SubLoc = [2375.46,302.959,0];

    TRGM_VAR_Mission1Title = "Blow dem trucks up!";
    TRGM_VAR_Mission1Desc = "these trucks need to be blown up man.  They are bad and we need rid!";

    TRGM_VAR_ForceWarZoneLoc = [3021,18451.7,0]; //nil  << set to nil if not wanted!

    TRGM_VAR_UseEditorWeather = true; //set this to true, and the weather options will be ignored and will just use what was set in editor
    TRGM_VAR_DateTimeWeather = [/*YEAR*/2055,/*MONTH*/12,/*DAY*/16,/*HOUR*/09,/*MIN*/17,/*OVERCAST*/1,/*FOG*/[0,0,0]];
    //FOG ARRAY:
    /*
        fogValue: Number - value for fog at base level. Range (0...1)
        fogDecay: Number - decay of fog density with altitude. Range (-1...1)
        fogBase: Number - base altitude of fog (in meters). Range (-5000...5000)
    */

    TRGM_VAR_iAllowNVG = 1;    //0=NotAllowed, 1=Allowed, 2=Realistic
    TRGM_VAR_iMissionParamRepOption =  0;    //1=FailMissionIfRepLow 0=JustFailTaskIfRepLow
    TRGM_VAR_iUseRevive = 0;    //0=NoRevive 1=GuaranteeRevive 2=CriticalHitsWillKill 3=As2ButOnlyMedicsCanRevive  4=As3ButMedicsNeedToBeNearMedicalVehicle  5=As3ButMedicsNeedToBeAtHQ

    //TRGM_VAR_NewMissionMusic = "LeadTrack02_F_Jets";
    //TRGM_VAR_PatrolType = 0; //0=random  1=smaller size, but more patrols spread around the AO
    //TRGM_VAR_AllowAOFires = false;
    TRGM_VAR_HideAoMarker = true; //just incase you want to add your own markers!

    TRGM_VAR_CustomAdvancedSettings =
    [
        1,                     //Allow virtual arsenal
        "Tactical Test 2",     //Group Name
        0,                     //Allow Support Options
        1,                     //Respawn ticket count (set to 1 for no respawn)
        1,                     //Allow map drawing in direct channel only (Setting to zero will all map drawing in all channels)
        10,                    //Respawn timer
        "OPF_F",               //EnemyFaction | Vanilla Examples: OPF_F=CSAT,  OPF_T_F=CSAT (Pacific),  OPF_G_F=FIA | RHS Examples: rhs_faction_msv=Russia (MSV), rhs_faction_vdv=Russia (VDV)
        "IND_G_F",             //MilitiaFaction | Vanilla Examples: IND_F=AAF,  IND_G_F=FIA,  3=FIA | RHS Examples: rhsgref_faction_cdf_ground=CDF Ground Forces
        "BLU_F",               //FriendlyFaction | Vanilla Examples: BLU_F=NATO, BLU_T_F=NATO (Pacific), BLU_G_F=FIA | RHS Examples: rhs_faction_usarmy_d=US Army D, rhs_faction_usmc_wd=USMC WD
        2,                     //Sandstorm option (0=Random, 1=Always, 2=Never, 3=NonStop)
        0,                     //Enable Group Manager
        0,                     //allow to select AO position (pointless if ForceMissionSetup is set to false above)
        0,                     //allow to select AO camp position (pointless if ForceMissionSetup is set to false above)
        0,                     //enemy have flashlights (0=random, 1=yes, 2=no),
        0,                     //Make tasks mini missions
        0,                     //Compact Target/Ied Missions
        0,                     //Harder mission (beta)
        0,                     //Large patrols
        0                      // Vehicle spawning requires rep points
    ];

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Do not change anything under here!
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    publicVariable "TRGM_VAR_ForceMissionSetup";
    publicVariable "TRGM_VAR_UseCustomMission";
    publicVariable "TRGM_VAR_MainMissionTitle";
    publicVariable "TRGM_VAR_iMissionParamType";
    publicVariable "TRGM_VAR_iMissionParamObjective";
    publicVariable "TRGM_VAR_iMissionParamObjective2";
    publicVariable "TRGM_VAR_iMissionParamObjective3";
    publicVariable "TRGM_VAR_iStartLocation";
    publicVariable "TRGM_VAR_AOCampOnlyAmmoBox";
    publicVariable "TRGM_VAR_AOCampLocation";
    publicVariable "TRGM_VAR_Mission1Loc";
    publicVariable "TRGM_VAR_Mission2Loc";
    publicVariable "TRGM_VAR_Mission3Loc";
    publicVariable "TRGM_VAR_Mission1SubLoc";
    publicVariable "TRGM_VAR_Mission2SubLoc";
    publicVariable "TRGM_VAR_Mission3SubLoc";
    publicVariable "TRGM_VAR_Mission1Title";
    publicVariable "TRGM_VAR_Mission1Desc";
    publicVariable "TRGM_VAR_ForceWarZoneLoc";
    publicVariable "TRGM_VAR_UseEditorWeather";
    publicVariable "TRGM_VAR_DateTimeWeather";
    publicVariable "TRGM_VAR_iAllowNVG";
    publicVariable "TRGM_VAR_iMissionParamRepOption";
    publicVariable "TRGM_VAR_iUseRevive";
    publicVariable "TRGM_VAR_NewMissionMusic";
    publicVariable "TRGM_VAR_PatrolType";
    publicVariable "TRGM_VAR_AllowAOFires";
    publicVariable "TRGM_VAR_HideAoMarker";

    // Convert string to index:
    TRGM_VAR_AdvancedSettings = [];
    {
        switch (_forEachIndex) do {
            case 6: { //TRGM_VAR_ADVSET_ENEMY_FACTIONS_IDX
                for "_i" from 0 to (count TRGM_VAR_AllFactionData - 1) do {
                    (TRGM_VAR_AllFactionData select _i) params ["_className", "_displayName"];
                    if (_className == _x) then {
                        TRGM_VAR_AdvancedSettings pushBack _i;
                    };
                };
            };
            case 7: { //TRGM_VAR_ADVSET_MILITIA_FACTIONS_IDX
                for "_i" from 0 to (count TRGM_VAR_AllFactionData - 1) do {
                    (TRGM_VAR_AllFactionData select _i) params ["_className", "_displayName"];
                    if (_className == _x) then {
                        TRGM_VAR_AdvancedSettings pushBack _i;
                    };
                };
            };
            case 8: { //TRGM_VAR_ADVSET_FRIENDLY_FACTIONS_IDX
                for "_i" from 0 to (count TRGM_VAR_AllFactionData - 1) do {
                    (TRGM_VAR_AllFactionData select _i) params ["_className", "_displayName"];
                    if (_className == _x) then {
                        TRGM_VAR_AdvancedSettings pushBack _i;
                    };
                };
            };
            default { TRGM_VAR_AdvancedSettings pushBack _x;};
        };
    } forEach TRGM_VAR_CustomAdvancedSettings;
    publicVariable "TRGM_VAR_AdvancedSettings";
};