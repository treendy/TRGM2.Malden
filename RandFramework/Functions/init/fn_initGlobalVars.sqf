/////// Debug Mode ///////
TREND_bDebugMode = [false, true] select ((["DebugMode", 0] call BIS_fnc_getParamValue) isEqualTo 1);
publicVariable "TREND_bDebugMode";
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;

if (isNil "TREND_debugMessages") then {TREND_debugMessages = ""; publicVariable "TREND_debugMessages";};

if (isNil "TREND_NeededObjectsAvailable") then { TREND_NeededObjectsAvailable = false; publicVariable "TREND_NeededObjectsAvailable"; };
if (isNil "TREND_playerIsChoosingHQpos")  then { TREND_playerIsChoosingHQpos  = false; publicVariable "TREND_playerIsChoosingHQpos"; };
if (isNil "TREND_HQPosFound")             then { TREND_HQPosFound             = false; publicVariable "TREND_HQPosFound"; };
if (!isNil "laptop1")                     then { TREND_NeededObjectsAvailable = true;  publicVariable "TREND_NeededObjectsAvailable"; };

//// These must be declared BEFORE either initUnitVars or TRGMSetDefaultMissionSetupVars!!!
TREND_WestFactionData =  [WEST] call TREND_fnc_getFactionDataBySide; publicVariable "TREND_WestFactionData";
TREND_EastFactionData =  [EAST] call TREND_fnc_getFactionDataBySide; publicVariable "TREND_EastFactionData";
TREND_GuerFactionData =  [INDEPENDENT] call TREND_fnc_getFactionDataBySide; publicVariable "TREND_GuerFactionData";
TREND_AllFactionData = TREND_WestFactionData + TREND_EastFactionData + TREND_GuerFactionData; publicVariable "TREND_AllFactionData";

if ((["CustomMission", 0] call BIS_fnc_getParamValue) isEqualTo 1) then {
	call compile preprocessFileLineNumbers "CustomMission\TRGMSetDefaultMissionSetupVars.sqf";
};

// if (isNil "TREND_TopLeftPos") then { TREND_TopLeftPos = [25.4257,8173.69,0]; publicVariable "TREND_TopLeftPos"; };
// if (isNil "TREND_BotRightPos") then { TREND_BotRightPos = [8188.86,9.91748,0]; publicVariable "TREND_BotRightPos"; };

call TREND_fnc_initUnitVars;

if (isNil "TREND_aNVClassNames")      then { TREND_aNVClassNames = ["NVGoggles","NVGoggles_tna_F"]; publicVariable "TREND_aNVClassNames"; };
if (isNil "TREND_FriendlySide")       then { TREND_FriendlySide = West;                             publicVariable "TREND_FriendlySide"; };
if (isNil "TREND_EnemySide")          then { TREND_EnemySide = East;                                publicVariable "TREND_EnemySide"; };
if (isNil "TREND_FriendlySideString") then { TREND_FriendlySideString = "West";                     publicVariable "TREND_FriendlySideString"; };
if (isNil "TREND_EnemySideString")    then { TREND_EnemySideString = "East";                        publicVariable "TREND_EnemySideString"; };
if (isNil "TREND_sArmaGroup")         then { TREND_sArmaGroup = "TCF";                              publicVariable "TREND_sArmaGroup"; }; //use this to customise code for specific group requiments
if (isNil "TREND_bNoVNChance")        then { TREND_bNoVNChance = [false];                           publicVariable "TREND_bNoVNChance"; };

TREND_GetReinforceStartPos = { [random 500, random 500, 0]; }; publicVariable "TREND_GetReinforceStartPos";

if (isNil "TREND_SideMissionMinDistFromBase") then { TREND_SideMissionMinDistFromBase = 3000; publicVariable "TREND_SideMissionMinDistFromBase"; }; //for min distached to have AO from base... TREND_BaseAreaRange is more for patrols and events (thees need to be seperate variables, because if we had main HQ on an island and an AO spawned on the small island away from main land... hen will cause issues spawning in everything else)
if (isNil "TREND_BaseAreaRange")              then { TREND_BaseAreaRange = 1500;              publicVariable "TREND_BaseAreaRange"; }; //used to make sure enemy events, patrols etc... doesnt spawn too close to base
if (isNil "TREND_KilledZoneRadius")           then { TREND_KilledZoneRadius = 1500;           publicVariable "TREND_KilledZoneRadius"; };
if (isNil "TREND_KilledZoneInnerRadius")      then { TREND_KilledZoneInnerRadius = 1450;      publicVariable "TREND_KilledZoneInnerRadius"; };
if (isNil "TREND_SaveZoneRadius")             then { TREND_SaveZoneRadius = 1000;             publicVariable "TREND_SaveZoneRadius"; }; //if 0 will be no safezone

//remove radios etc... for nam mission or other era
if (isNil "TREND_InitialBoxItems")        then { TREND_InitialBoxItems = [[[[],[]],[["SmokeShellBlue","SmokeShellGreen","SmokeShellOrange","SmokeShellRed","SmokeShell"],[20,20,20,20,20]],[["ItemCompass","ItemMap","ItemWatch"],[5,5,5]],[[],[]]],false]; publicVariable "TREND_InitialBoxItems"; };
if (isNil "TREND_InitialBoxItemsWithAce") then { TREND_InitialBoxItemsWithAce = [[[["ACE_VMH3","ACE_VMM3"],[5,5]],[["DemoCharge_Remote_Mag","SatchelCharge_Remote_Mag","SmokeShellGreen","SmokeShellOrange","SmokeShellRed","SmokeShell"],[5,5,20,20,20,20,20]],[["ACE_RangeTable_82mm","ACE_adenosine","ACE_ATragMX","ACE_atropine","ACE_Banana","ACE_fieldDressing","ACE_elasticBandage","ACE_quikclot","ACE_bloodIV","ACE_bloodIV_250","ACE_bloodIV_500","ACE_bodyBag","ACE_CableTie","ItemCompass","ACE_DAGR","ACE_DefusalKit","ACE_EarPlugs","ACE_EntrenchingTool","ACE_epinephrine","ACE_Flashlight_MX991","ACE_Kestrel4500","ACE_Flashlight_KSF1","ACE_M26_Clacker","ACE_Clacker","ACE_Flashlight_XL50","ItemMap","ACE_MapTools","ACE_microDAGR","ACE_morphine","ACE_packingBandage","ACE_personalAidKit","ACE_plasmaIV","ACE_plasmaIV_250","ACE_plasmaIV_500","ACE_RangeCard","ACE_salineIV","ACE_salineIV_250","ACE_salineIV_500","ACE_Sandbag_empty","ACE_Tripod","ACE_surgicalKit","ACE_tourniquet","ACE_VectorDay","ItemWatch","ACE_wirecutter","tf_anprc152","tf_anprc154"],[50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50]],[["tf_rt1523g","tf_rt1523g_big"],[3,3]]],false]; publicVariable "TREND_InitialBoxItemsWithAce"; };


if (isNil "TREND_CampaignRecruitUnitRifleman")            then { TREND_CampaignRecruitUnitRifleman = "B_Soldier_F";                publicVariable "TREND_CampaignRecruitUnitRifleman"; };
if (isNil "TREND_CampaignRecruitUnitAT")                  then { TREND_CampaignRecruitUnitAT = "B_soldier_AT_F";                   publicVariable "TREND_CampaignRecruitUnitAT"; };
if (isNil "TREND_CampaignRecruitUnitAA")                  then { TREND_CampaignRecruitUnitAA = "B_soldier_AA_F";                   publicVariable "TREND_CampaignRecruitUnitAA"; };
if (isNil "TREND_CampaignRecruitUnitExplosiveSpecialist") then { TREND_CampaignRecruitUnitExplosiveSpecialist = "B_soldier_exp_F"; publicVariable "TREND_CampaignRecruitUnitExplosiveSpecialist"; };
if (isNil "TREND_CampaignRecruitUnitMedic")               then { TREND_CampaignRecruitUnitMedic = "B_medic_F";                     publicVariable "TREND_CampaignRecruitUnitMedic"; };
if (isNil "TREND_CampaignRecruitUnitEngineer")            then { TREND_CampaignRecruitUnitEngineer = "B_engineer_F";               publicVariable "TREND_CampaignRecruitUnitEngineer"; };
if (isNil "TREND_CampaignRecruitUnitAuto")                then { TREND_CampaignRecruitUnitAuto = "B_soldier_AR_F";                 publicVariable "TREND_CampaignRecruitUnitAuto"; };
if (isNil "TREND_CampaignRecruitUnitSniper")              then { TREND_CampaignRecruitUnitSniper = "B_sniper_F";                   publicVariable "TREND_CampaignRecruitUnitSniper"; };
if (isNil "TREND_CampaignRecruitUnitSpotter")             then { TREND_CampaignRecruitUnitSpotter = "B_spotter_F";                 publicVariable "TREND_CampaignRecruitUnitSpotter"; };
if (isNil "TREND_CampaignRecruitUnitUAV")                 then { TREND_CampaignRecruitUnitUAV = "B_soldier_UAV_F";                 publicVariable "TREND_CampaignRecruitUnitUAV"; };

if (isNil "TREND_GraveYardPos")       then { TREND_GraveYardPos = [5028.07,1424.47,0]; publicVariable "TREND_GraveYardPos"; };
if (isNil "TREND_GraveYardDirection") then { TREND_GraveYardDirection = 90;            publicVariable "TREND_GraveYardDirection"; };

if (isNil "TREND_FriendlyFastResponseDingy") then { TREND_FriendlyFastResponseDingy = ["B_Boat_Transport_01_F"]; publicVariable "TREND_FriendlyFastResponseDingy"; };
if (isNil "TREND_SmallTransportVehicle")     then { TREND_SmallTransportVehicle = ["B_Quadbike_01_F"];           publicVariable "TREND_SmallTransportVehicle"; }; //used for AO camp, just incase no vehicles near, or too built up in jungle for cars


if (isNil "TREND_EnemyRadioSounds")    then { TREND_EnemyRadioSounds = ["ambient_radio2","ambient_radio8","ambient_radio10","ambient_radio11","ambient_radio12","ambient_radio13","ambient_radio15","ambient_radio16","ambient_radio18","ambient_radio20","ambient_radio24"]; publicVariable "TREND_EnemyRadioSounds"; };
if (isNil "TREND_FriendlyRadioSounds") then { TREND_FriendlyRadioSounds = ["ambient_radio3","ambient_radio4","ambient_radio5","ambient_radio6","ambient_radio7","ambient_radio9","ambient_radio14","ambient_radio17","ambient_radio19","ambient_radio21","ambient_radio22","ambient_radio23","ambient_radio25","ambient_radio26","ambient_radio27","ambient_radio28","ambient_radio29","ambient_radio30"]; publicVariable "TREND_FriendlyRadioSounds"; };
if (isNil "TREND_IEDClassNames")       then { TREND_IEDClassNames = ["IEDUrbanBig_F","IEDLandBig_F","IEDUrbanSmall_F"]; publicVariable "TREND_IEDClassNames"; };
if (isNil "TREND_IEDFakeClassNames")   then { TREND_IEDFakeClassNames = ["Land_GarbagePallet_F","Land_JunkPile_F"]; publicVariable "TREND_IEDFakeClassNames"; };
if (isNil "TREND_ATMinesClassNames")   then { TREND_ATMinesClassNames = ["ATMine"]; publicVariable "TREND_ATMinesClassNames"; };
if (isNil "TREND_WreckCarClasses")     then { TREND_WreckCarClasses = ["Land_Wreck_Slammer_F","Land_Wreck_Truck_dropside_F","Land_Wreck_Offroad2_F","Land_Wreck_Car3_F","Land_Wreck_Truck_F"]; publicVariable "TREND_WreckCarClasses"; };
if (isNil "TREND_ChopperWrecks")       then { TREND_ChopperWrecks = ["Land_Wreck_Heli_Attack_01_F"]; publicVariable "TREND_ChopperWrecks"; };


if (isNil "TREND_MedicalMessItems") then { TREND_MedicalMessItems = ["MedicalGarbage_01_1x1_v1_F","MedicalGarbage_01_1x1_v2_F","MedicalGarbage_01_1x1_v3_F","MedicalGarbage_01_3x3_v1_F","MedicalGarbage_01_3x3_v2_F","MedicalGarbage_01_5x5_v1_F"]; publicVariable "TREND_MedicalMessItems"; };
if (isNil "TREND_MedicalBoxes")     then { TREND_MedicalBoxes = ["Land_PaperBox_01_small_closed_white_med_F","Land_FirstAidKit_01_open_F"]; publicVariable "TREND_MedicalBoxes"; };
if (isNil "TREND_ConesWithLight")   then { TREND_ConesWithLight = ["RoadCone_L_F"]; publicVariable "TREND_ConesWithLight"; };
if (isNil "TREND_Cones")            then { TREND_Cones = ["RoadCone_F"]; publicVariable "TREND_Cones"; };

if (isNil "TREND_TombStones")        then { TREND_TombStones = ["Land_Tombstone_01_F","Land_Tombstone_03_F","Land_Tombstone_02_F"]; publicVariable "TREND_TombStones"; };
if (isNil "TREND_InformantImage")    then { TREND_InformantImage = "<img image='RandFramework\Media\Informants2.jpg' size='1' />"; publicVariable "TREND_InformantImage"; };
if (isNil "TREND_OfficerImage")      then { TREND_OfficerImage = "<img image='RandFramework\Media\Officer2.jpg' size='1' />"; publicVariable "TREND_OfficerImage"; };
if (isNil "TREND_WeaponDealerImage") then { TREND_WeaponDealerImage = "<img image='RandFramework\Media\WeaponDealers2.jpg' size='1' />"; publicVariable "TREND_WeaponDealerImage"; };


if (isNil "TREND_AllInitScriptsFinished")                  then {TREND_AllInitScriptsFinished = false;                      	publicVariable "TREND_AllInitScriptsFinished";};
if (isNil "TREND_AOCampOnlyAmmoBox")                       then {TREND_AOCampOnlyAmmoBox = false;                           	publicVariable "TREND_AOCampOnlyAmmoBox";};
//TREND_AODetails = [[AOIndex,InfSpottedCount,VehSpottedCount,AirSpottedCount,bScoutCalled,patrolMoveCounter]]
//example TREND_AODetails [[1,0,0,0,False,0],[2,0,0,0,True,0]]
if (isNil "TREND_AODetails")                               then {TREND_AODetails = [];                                      	publicVariable "TREND_AODetails";};
if (isNil "TREND_ATFieldPos")                              then {TREND_ATFieldPos = [];                                     	publicVariable "TREND_ATFieldPos";};
if (isNil "TREND_ActiveTasks")                             then {TREND_ActiveTasks = [];                                    	publicVariable "TREND_ActiveTasks";};
if (isNil "TREND_AdminPlayer")                             then {TREND_AdminPlayer = objNull;                               	publicVariable "TREND_AdminPlayer";};
if (isNil "TREND_AdvancedSettings")                        then {TREND_AdvancedSettings = TREND_DefaultAdvancedSettings;    	publicVariable "TREND_AdvancedSettings";};
if (isNil "TREND_AllowAOFires") 						   then {TREND_AllowAOFires =   true; 									publicVariable "TREND_AllowAOFires";};
if (isNil "TREND_AllowUAVLocateHelp")                      then {TREND_AllowUAVLocateHelp = false;                          	publicVariable "TREND_AllowUAVLocateHelp";};
if (isNil "TREND_BadPoints")                               then {TREND_BadPoints = 0;                                       	publicVariable "TREND_BadPoints";};
if (isNil "TREND_BadPointsReason")                         then {TREND_BadPointsReason = "";                                	publicVariable "TREND_BadPointsReason";};
if (isNil "TREND_CalledAirsupportIndex")                   then {TREND_CalledAirsupportIndex = 1;                           	publicVariable "TREND_CalledAirsupportIndex";};
if (isNil "TREND_CampaignInitiated")                       then {TREND_CampaignInitiated = false;                           	publicVariable "TREND_CampaignInitiated"; };
if (isNil "TREND_CheckPointAreas")                         then {TREND_CheckPointAreas = [];                                	publicVariable "TREND_CheckPointAreas";};
if (isNil "TREND_CivDeathCount")                           then {TREND_CivDeathCount = 0;                                   	publicVariable "TREND_CivDeathCount";};
if (isNil "TREND_ClearedPositions")                        then {TREND_ClearedPositions = [];                               	publicVariable "TREND_ClearedPositions";};
if (isNil "TREND_CommsTowerPos")                           then {TREND_CommsTowerPos = [0,0];                               	publicVariable "TREND_CommsTowerPos";};
if (isNil "TREND_CoreCompleted")    					   then { TREND_CoreCompleted = false; 									publicVariable "TREND_CoreCompleted";};
if (isNil "TREND_CurrentZeroMissionTitle")                 then {TREND_CurrentZeroMissionTitle = "";                        	publicVariable "TREND_CurrentZeroMissionTitle";};
if (isNil "TREND_CustomObjectsSet")                        then {TREND_CustomObjectsSet = false;                            	publicVariable "TREND_CustomObjectsSet";};
if (isNil "TREND_EnemyFactionData")                        then {TREND_EnemyFactionData = "";                               	publicVariable "TREND_EnemyFactionData";};
if (isNil "TREND_EnemyID")                                 then {TREND_EnemyID = 1;                                         	publicVariable "TREND_EnemyID";};
if (isNil "TREND_FinalMissionStarted")                     then {TREND_FinalMissionStarted = false;                         	publicVariable "TREND_FinalMissionStarted";};
if (isNil "TREND_FlareCounter")                            then {TREND_FlareCounter = 15;                                   	publicVariable "TREND_FlareCounter";};
if (isNil "TREND_FireFlares")                              then {TREND_FireFlares = random 1 < .50;                         	publicVariable "TREND_FireFlares";};
if (isNil "TREND_ForceEndSandStorm")                       then {TREND_ForceEndSandStorm = false;                           	publicVariable "TREND_ForceEndSandStorm";};
if (isNil "TREND_ForceMissionSetup")                       then {TREND_ForceMissionSetup = false;                           	publicVariable "TREND_ForceMissionSetup";};
if (isNil "TREND_HiddenPossitions")                        then {TREND_HiddenPossitions = [];                               	publicVariable "TREND_HiddenPossitions";};
if (isNil "TREND_ISUNSUNG")                                then {TREND_ISUNSUNG = false;                                    	publicVariable "TREND_ISUNSUNG";};
if (isNil "TREND_InfTaskCount")                            then {TREND_InfTaskCount = 0;                                    	publicVariable "TREND_InfTaskCount";};
if (isNil "TREND_InfTaskStarted")                          then {TREND_InfTaskStarted = false;                              	publicVariable "TREND_InfTaskStarted";};
if (isNil "TREND_IntelFound")                              then {TREND_IntelFound = [];                                     	publicVariable "TREND_IntelFound";};
if (isNil "TREND_IntroMusic")                              then {TREND_IntroMusic = selectRandom TREND_ThemeAndIntroMusic;  	publicVariable "TREND_IntroMusic";};
if (isNil "TREND_IsFullMap")                               then {TREND_IsFullMap = false;                                   	publicVariable "TREND_IsFullMap";};
if (isNil "TREND_IsSnowMap")                               then {TREND_IsSnowMap = false;                                   	publicVariable "TREND_IsSnowMap";};
if (isNil "TREND_KilledPlayers")                           then {TREND_KilledPlayers = [];                                  	publicVariable "TREND_KilledPlayers";};
if (isNil "TREND_KilledPositions")                         then {TREND_KilledPositions = [];                                	publicVariable "TREND_KilledPositions";};
if (isNil "TREND_LoadoutData")                             then {TREND_LoadoutData = "";                                    	publicVariable "TREND_LoadoutData";};
if (isNil "TREND_LoadoutDataDefault")                      then {TREND_LoadoutDataDefault = "";                             	publicVariable "TREND_LoadoutDataDefault";};
if (isNil "TREND_MainMissionTitle")                        then {TREND_MainMissionTitle = "";                               	publicVariable "TREND_MainMissionTitle";};
if (isNil "TREND_MaxBadPoints")                            then {TREND_MaxBadPoints = 1;                                    	publicVariable "TREND_MaxBadPoints";};
if (isNil "TREND_MissionLoaded")                           then {TREND_MissionLoaded = false;                               	publicVariable "TREND_MissionLoaded";};
if (isNil "TREND_MissionParamsSet")                        then {TREND_MissionParamsSet = false;                            	publicVariable "TREND_MissionParamsSet";};
if (isNil "TREND_NewMissionMusic") 						   then {TREND_NewMissionMusic = selectRandom TREND_ThemeAndIntroMusic; publicVariable "TREND_NewMissionMusic";};
if (isNil "TREND_ObjectivePossitions")                     then {TREND_ObjectivePossitions = [];                            	publicVariable "TREND_ObjectivePossitions";};
if (isNil "TREND_OccupiedHousesPos") 					   then {TREND_OccupiedHousesPos =   []; 								publicVariable "TREND_OccupiedHousesPos"; };
if (isNil "TREND_ParaDropped")                             then {TREND_ParaDropped = false;                                 	publicVariable "TREND_ParaDropped";};
if (isNil "TREND_PatrolType")							   then {TREND_PatrolType =   0; 										publicVariable "TREND_PatrolType";};
if (isNil "TREND_PlayersHaveLeftStartingArea")             then {TREND_PlayersHaveLeftStartingArea = false;                 	publicVariable "TREND_PlayersHaveLeftStartingArea";};
if (isNil "TREND_ReinforcementsCalled")					   then {TREND_ReinforcementsCalled = 0; 								publicVariable "TREND_ReinforcementsCalled";};
if (isNil "TREND_SaveType")                                then {TREND_SaveType = 0;                                        	publicVariable "TREND_SaveType";};
if (isNil "TREND_SentryAreas")                             then {TREND_SentryAreas = [];                                    	publicVariable "TREND_SentryAreas";};
if (isNil "TREND_TimeLastReinforcementsCalled")            then {TREND_TimeLastReinforcementsCalled = time;                 	publicVariable "TREND_TimeLastReinforcementsCalled";};
if (isNil "TREND_TimeSinceAdditionalReinforcementsCalled") then {TREND_TimeSinceAdditionalReinforcementsCalled = time;      	publicVariable "TREND_TimeSinceAdditionalReinforcementsCalled";};
if (isNil "TREND_TimeSinceLastSpottedAction")              then {TREND_TimeSinceLastSpottedAction = time;                   	publicVariable "TREND_TimeSinceLastSpottedAction";};
if (isNil "TREND_ToUseMilitia_Side") 					   then {TREND_ToUseMilitia_Side = false; 								publicVariable "TREND_ToUseMilitia_Side";};
if (isNil "TREND_bAndSoItBegins")                          then {TREND_bAndSoItBegins = false;                              	publicVariable "TREND_bAndSoItBegins";};
if (isNil "TREND_bBaseHasChopper")                         then {TREND_bBaseHasChopper = false;                             	publicVariable "TREND_bBaseHasChopper";};
if (isNil "TREND_bBreifingPrepped")                        then {TREND_bBreifingPrepped = false;                            	publicVariable "TREND_bBreifingPrepped";};
if (isNil "TREND_bCommsBlocked")                           then {TREND_bCommsBlocked = false;                               	publicVariable "TREND_bCommsBlocked";};
if (isNil "TREND_bHasCommsTower")                          then {TREND_bHasCommsTower = false;                              	publicVariable "TREND_bHasCommsTower";};
if (isNil "TREND_bMortarFiring")                           then {TREND_bMortarFiring = false;                               	publicVariable "TREND_bMortarFiring";};
if (isNil "TREND_bOptionsSet")                             then {TREND_bOptionsSet = false;                                 	publicVariable "TREND_bOptionsSet";};
if (isNil "TREND_bOptionsSet")                             then {TREND_bOptionsSet = false;                                 	publicVariable "TREND_bOptionsSet";};
if (isNil "TREND_iAllowNVG")                               then {TREND_iAllowNVG = 2;                                       	publicVariable "TREND_iAllowNVG";};
if (isNil "TREND_iCampaignDay")                            then {TREND_iCampaignDay = 0;                                    	publicVariable "TREND_iCampaignDay";};
if (isNil "TREND_iMissionParamObjective")                  then {TREND_iMissionParamObjective = 0;                          	publicVariable "TREND_iMissionParamObjective";};
if (isNil "TREND_iMissionParamObjective2")                 then {TREND_iMissionParamObjective2 = 0;                         	publicVariable "TREND_iMissionParamObjective2";};
if (isNil "TREND_iMissionParamObjective3")                 then {TREND_iMissionParamObjective3 = 0;                         	publicVariable "TREND_iMissionParamObjective3";};
if (isNil "TREND_iMissionParamRepOption")                  then {TREND_iMissionParamRepOption = 0;                          	publicVariable "TREND_iMissionParamRepOption";};
if (isNil "TREND_iMissionParamType")                       then {TREND_iMissionParamType = 9;                               	publicVariable "TREND_iMissionParamType";};
if (isNil "TREND_iStartLocation")                          then {TREND_iStartLocation = 2;                                  	publicVariable "TREND_iStartLocation";};
if (isNil "TREND_iUseRevive")                              then {TREND_iUseRevive = 0;                                      	publicVariable "TREND_iUseRevive";};
if (isNil "TREND_iWeather")                                then {TREND_iWeather = 1;                                        	publicVariable "TREND_iWeather";};
true;