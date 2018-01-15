DefaultEnemyFactionArray = [1,2,3];
DefaultEnemyFactionArrayText = ["CSAT and FIA as militia","CSAT only","FIA only"];
DefaultEnemyFactionIndex = 0;

_prevSetup = profileNamespace getVariable [worldname + ":PreviousSettings",[]];

if ((isClass(configFile >> "CfgPatches" >> "rhs_main")) && (isClass(configFile >> "CfgPatches" >> "rhsusf_main")) && (isClass(configFile >> "CfgPatches" >> "rhsgref_main"))) then {
	//IF RHSAFRF, RHSUSAF, RHSGREF are active
	DefaultEnemyFactionArray = DefaultEnemyFactionArray + [4];
	DefaultEnemyFactionArrayText = DefaultEnemyFactionArrayText + ["RHS - Russia MSV"]
};

publicVariable "DefaultEnemyFactionArray";
publicVariable "DefaultEnemyFactionArrayText";
publicVariable "DefaultEnemyFactionIndex";



call compile preprocessFileLineNumbers  "RandFramework\General\TRGMSetUnitGlobalVars.sqf";

sFriendlyNVClassName = "NVGoggles";	
sEnemyNVClassName = "NVGoggles_tna_F";  //"NVGoggles_OPFOR"	
FriendlySide = West;
EnemySide = East;
FriendlySideString = "West";
EnemySideString = "East";
sArmaGroup = "TCF"; //use this to customise code for specific group requiments


bNoVNChance = [false];

ReinforceStartPos1 = [200,200,0];
ReinforceStartPos2 = [100,100,0];

SideMissionMinDistFromBase = 3000;
KilledZoneRadius = 1500;
KilledZoneInnerRadius = 1450;
SaveZoneRadius = 1000; //if 0 will be no safezone

//to set these in mission local globalVars file, in editor, double click ammobox, att the required items (not virtual) then save and search in mission.sqf for the items (should be box1, or one of class names)
//InitialBoxItems=[[[["hgun_P07_F","hgun_P07_khk_F","hgun_P07_snds_F"],[20,20,20]],[["APERSBoundingMine_Range_Mag","APERSTripMine_Wire_Mag","ATMine_Range_Mag","DemoCharge_Remote_Mag","SatchelCharge_Remote_Mag","10Rnd_338_Mag","130Rnd_338_Mag","10Rnd_127x54_Mag","","","","","","200Rnd_556x45_Box_Tracer_F","20Rnd_650x39_Cased_Mag_F","100Rnd_65x39_caseless_mag","100Rnd_65x39_caseless_mag_Tracer","200Rnd_65x39_cased_Box","200Rnd_65x39_cased_Box_Tracer","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag_Tracer","150Rnd_762x54_Box_Tracer","10Rnd_762x54_Mag","150Rnd_762x54_Box","20Rnd_762x51_Mag","10Rnd_9x21_Mag","16Rnd_9x21_green_Mag","10Rnd_93x64_DMR_05_Mag","150Rnd_93x64_Mag","16Rnd_9x21_Mag","30Rnd_9x21_Mag","RPG7_F","RPG32_HE_F","RPG32_F","Titan_AA","Titan_AP","Titan_AT"],[]],[["ItemCompass","ItemMap","ItemWatch","optic_Hamr","optic_Hamr_khk_F"],[]],[[],[]]],true];
//InitialBoxItemsWithAce=[[[["ACE_VMH3","ACE_VMM3","hgun_P07_F","hgun_P07_khk_F","hgun_P07_snds_F"],[]],[["APERSBoundingMine_Range_Mag","APERSTripMine_Wire_Mag","ATMine_Range_Mag","DemoCharge_Remote_Mag","SatchelCharge_Remote_Mag","ACE_10Rnd_338_300gr_HPBT_Mag","ACE_10Rnd_338_API526_Mag","10Rnd_338_Mag","130Rnd_338_Mag","10Rnd_127x54_Mag","150Rnd_556x45_Drum_Mag_F","150Rnd_556x45_Drum_Mag_Tracer_F","200Rnd_556x45_Box_Red_F","200Rnd_556x45_Box_F","200Rnd_556x45_Box_Tracer_Red_F","200Rnd_556x45_Box_Tracer_F","20Rnd_650x39_Cased_Mag_F","100Rnd_65x39_caseless_mag","ACE_100Rnd_65x39_caseless_mag_Tracer_Dim","100Rnd_65x39_caseless_mag_Tracer","200Rnd_65x39_cased_Box","200Rnd_65x39_cased_Box_Tracer","ACE_200Rnd_65x39_cased_Box_Tracer_Dim","30Rnd_65x39_caseless_mag","ACE_30Rnd_65x39_caseless_mag_Tracer_Dim","30Rnd_65x39_caseless_mag_Tracer","ACE_20Rnd_65_Creedmor_mag","ACE_20Rnd_65x47_Scenar_mag","150Rnd_762x54_Box_Tracer","10Rnd_762x54_Mag","150Rnd_762x54_Box","20Rnd_762x51_Mag","ACE_20Rnd_762x67_Berger_Hybrid_OTM_Mag","ACE_20Rnd_762x51_M118LR_Mag","ACE_20Rnd_762x51_M993_AP_Mag","ACE_20Rnd_762x67_Mk248_Mod_0_Mag","ACE_20Rnd_762x67_Mk248_Mod_1_Mag","ACE_20Rnd_762x51_Mk316_Mod_0_Mag","ACE_20Rnd_762x51_Mk319_Mod_0_Mag","ACE_20Rnd_762x51_Mag_SD","ACE_20Rnd_762x51_Mag_Tracer_Dim","ACE_20Rnd_762x51_Mag_Tracer","ACE_10Rnd_762x54_Tracer_mag","10Rnd_9x21_Mag","16Rnd_9x21_green_Mag","10Rnd_93x64_DMR_05_Mag","150Rnd_93x64_Mag","16Rnd_9x21_Mag","30Rnd_9x21_Mag","RPG7_F","RPG32_HE_F","RPG32_F","Titan_AA","Titan_AP","Titan_AT"],[]],[["ACE_RangeTable_82mm","ACE_adenosine","ACE_ATragMX","ACE_atropine","ACE_Banana","ACE_fieldDressing","ACE_elasticBandage","ACE_quikclot","ACE_bloodIV","ACE_bloodIV_250","ACE_bloodIV_500","ACE_bodyBag","ACE_CableTie","ItemCompass","ACE_DAGR","ACE_DefusalKit","ACE_EarPlugs","ACE_EntrenchingTool","ACE_epinephrine","ACE_Flashlight_MX991","ACE_Kestrel4500","ACE_Flashlight_KSF1","ACE_M26_Clacker","ACE_Clacker","ACE_Flashlight_XL50","ItemMap","ACE_MapTools","ACE_microDAGR","ACE_morphine","ACE_packingBandage","ACE_personalAidKit","ACE_plasmaIV","ACE_plasmaIV_250","ACE_plasmaIV_500","ACE_RangeCard","ACE_salineIV","ACE_salineIV_250","ACE_salineIV_500","ACE_Sandbag_empty","ACE_Tripod","ACE_surgicalKit","ACE_tourniquet","ACE_VectorDay","ItemWatch","ACE_wirecutter","optic_Hamr","ACE_optic_Hamr_2D","optic_Hamr_khk_F","ACE_optic_Hamr_PIP","tf_anprc152","tf_anprc154"],[]],[["tf_rt1523g","tf_rt1523g_big"],[]]],true];

InitialBoxItems=[[[["hgun_P07_F","hgun_P07_khk_F","hgun_P07_snds_F","arifle_MX_F","arifle_MX_khk_F","arifle_MXC_F","arifle_MXC_Black_F","arifle_MXC_khk_F","arifle_MXM_F","arifle_MXM_Black_F","arifle_MXM_khk_F"],[50,50,50,50,50,50,50,50,50,50,50]],[["APERSBoundingMine_Range_Mag","APERSTripMine_Wire_Mag","ATMine_Range_Mag","DemoCharge_Remote_Mag","SatchelCharge_Remote_Mag","10Rnd_338_Mag","130Rnd_338_Mag","10Rnd_127x54_Mag","200Rnd_556x45_Box_Tracer_F","20Rnd_650x39_Cased_Mag_F","100Rnd_65x39_caseless_mag","100Rnd_65x39_caseless_mag_Tracer","200Rnd_65x39_cased_Box","200Rnd_65x39_cased_Box_Tracer","30Rnd_65x39_caseless_mag","30Rnd_65x39_caseless_mag_Tracer","150Rnd_762x54_Box_Tracer","10Rnd_762x54_Mag","150Rnd_762x54_Box","20Rnd_762x51_Mag","10Rnd_9x21_Mag","16Rnd_9x21_green_Mag","10Rnd_93x64_DMR_05_Mag","150Rnd_93x64_Mag","16Rnd_9x21_Mag","30Rnd_9x21_Mag","RPG7_F","RPG32_HE_F","RPG32_F","Titan_AA","Titan_AP","Titan_AT"],[50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50]],[["ItemCompass","ItemMap","ItemWatch","optic_Hamr","optic_Hamr_khk_F"],[50,50,50,50,50]],[[],[]]],false];
InitialBoxItemsWithAce=[[[["ACE_VMH3","ACE_VMM3","hgun_P07_F","hgun_P07_khk_F","hgun_P07_snds_F","arifle_MX_F","arifle_MX_khk_F","arifle_MXC_F","arifle_MXC_Black_F","arifle_MXC_khk_F","arifle_MXM_F","arifle_MXM_Black_F","arifle_MXM_khk_F"],[50,50,50,50,50,50,50,50,50,50,50,50,50]],[["APERSBoundingMine_Range_Mag","APERSTripMine_Wire_Mag","ATMine_Range_Mag","DemoCharge_Remote_Mag","SatchelCharge_Remote_Mag","ACE_10Rnd_338_300gr_HPBT_Mag","ACE_10Rnd_338_API526_Mag","10Rnd_338_Mag","130Rnd_338_Mag","10Rnd_127x54_Mag","150Rnd_556x45_Drum_Mag_F","150Rnd_556x45_Drum_Mag_Tracer_F","200Rnd_556x45_Box_Red_F","200Rnd_556x45_Box_F","200Rnd_556x45_Box_Tracer_Red_F","200Rnd_556x45_Box_Tracer_F","20Rnd_650x39_Cased_Mag_F","100Rnd_65x39_caseless_mag","ACE_100Rnd_65x39_caseless_mag_Tracer_Dim","100Rnd_65x39_caseless_mag_Tracer","200Rnd_65x39_cased_Box","200Rnd_65x39_cased_Box_Tracer","ACE_200Rnd_65x39_cased_Box_Tracer_Dim","30Rnd_65x39_caseless_mag","ACE_30Rnd_65x39_caseless_mag_Tracer_Dim","30Rnd_65x39_caseless_mag_Tracer","ACE_20Rnd_65_Creedmor_mag","ACE_20Rnd_65x47_Scenar_mag","150Rnd_762x54_Box_Tracer","10Rnd_762x54_Mag","150Rnd_762x54_Box","20Rnd_762x51_Mag","ACE_20Rnd_762x67_Berger_Hybrid_OTM_Mag","ACE_20Rnd_762x51_M118LR_Mag","ACE_20Rnd_762x51_M993_AP_Mag","ACE_20Rnd_762x67_Mk248_Mod_0_Mag","ACE_20Rnd_762x67_Mk248_Mod_1_Mag","ACE_20Rnd_762x51_Mk316_Mod_0_Mag","ACE_20Rnd_762x51_Mk319_Mod_0_Mag","ACE_20Rnd_762x51_Mag_SD","ACE_20Rnd_762x51_Mag_Tracer_Dim","ACE_20Rnd_762x51_Mag_Tracer","ACE_10Rnd_762x54_Tracer_mag","10Rnd_9x21_Mag","16Rnd_9x21_green_Mag","10Rnd_93x64_DMR_05_Mag","150Rnd_93x64_Mag","16Rnd_9x21_Mag","30Rnd_9x21_Mag","RPG7_F","RPG32_HE_F","RPG32_F","Titan_AA","Titan_AP","Titan_AT"],[50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50]],[["ACE_RangeTable_82mm","ACE_adenosine","ACE_ATragMX","ACE_atropine","ACE_Banana","ACE_fieldDressing","ACE_elasticBandage","ACE_quikclot","ACE_bloodIV","ACE_bloodIV_250","ACE_bloodIV_500","ACE_bodyBag","ACE_CableTie","ItemCompass","ACE_DAGR","ACE_DefusalKit","ACE_EarPlugs","ACE_EntrenchingTool","ACE_epinephrine","ACE_Flashlight_MX991","ACE_Kestrel4500","ACE_Flashlight_KSF1","ACE_M26_Clacker","ACE_Clacker","ACE_Flashlight_XL50","ItemMap","ACE_MapTools","ACE_microDAGR","ACE_morphine","ACE_packingBandage","ACE_personalAidKit","ACE_plasmaIV","ACE_plasmaIV_250","ACE_plasmaIV_500","ACE_RangeCard","ACE_salineIV","ACE_salineIV_250","ACE_salineIV_500","ACE_Sandbag_empty","ACE_Tripod","ACE_surgicalKit","ACE_tourniquet","ACE_VectorDay","ItemWatch","ACE_wirecutter","optic_Hamr","ACE_optic_Hamr_2D","optic_Hamr_khk_F","ACE_optic_Hamr_PIP","tf_anprc152","tf_anprc154"],[50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50]],[["tf_rt1523g","tf_rt1523g_big"],[50,50]]],false];

CampaignRecruitUnitRifleman = "B_Soldier_F";
CampaignRecruitUnitAT = "B_soldier_AT_F";
CampaignRecruitUnitAA = "B_soldier_AA_F";
CampaignRecruitUnitExplosiveSpecialist = "B_soldier_exp_F";
CampaignRecruitUnitMedic = "B_medic_F";
CampaignRecruitUnitEngineer = "B_engineer_F";
CampaignRecruitUnitAuto = "B_soldier_AR_F";
CampaignRecruitUnitSniper = "B_sniper_F";
CampaignRecruitUnitSpotter = "B_spotter_F";
CampaignRecruitUnitUAV = "B_soldier_UAV_F";

GraveYardPos = [799.305,12129.2,1.90735e-006];
GraveYardDirection = 90;

FriendlyFastResponseVehicles = ["B_T_MRAP_01_F"];
FriendlyFastResponseDingy = ["B_Boat_Transport_01_F"];

SmallTransportVehicle = ["B_Quadbike_01_F"]; //used for AO camp, just incase no vehicles near, or too built up in jungle for cars