
class Params
{

		class TREND_par_MissionType // 4
        {
			title = $STR_TRGM2_TRGMdescription_MissionType;
			values[] = {1,13,14,11,12,0,2,3,4,5,6,7,8,9,10};
			default = 1;
			texts[] = {
				$STR_TRGM2_TRGMdescription_MissionType1, //1
				$STR_TRGM2_TRGMdescription_MissionType2, //13
				$STR_TRGM2_TRGMdescription_MissionType3, //14
				$STR_TRGM2_TRGMdescription_MissionType4, //11
				$STR_TRGM2_TRGMdescription_MissionType5, //12
				"==========================================================", //0
				$STR_TRGM2_TRGMdescription_MissionType6, //2
				$STR_TRGM2_TRGMdescription_MissionType7, //3
				$STR_TRGM2_TRGMdescription_MissionType8, //4
				$STR_TRGM2_TRGMdescription_MissionType9,  //5
				$STR_TRGM2_TRGMdescription_MissionType10, //6
				$STR_TRGM2_TRGMdescription_MissionType11, //7
				$STR_TRGM2_TRGMdescription_MissionType12, //8
				$STR_TRGM2_TRGMdescription_MissionType13, //9
				$STR_TRGM2_TRGMdescription_MissionType14 //10
			};
		};

        class OUT_par_AllowLargePatrols // 4
        {
			title = $STR_TRGM2_TRGMdescription_Parameter_MaxEnemy;
			values[] = {1, 2, 3};
			default = 1;
			texts[] = {$STR_TRGM2_TRGMdescription_Parameter_MaxEnemy_True, $STR_TRGM2_TRGMdescription_Parameter_False, $STR_TRGM2_TRGMSetUnitGlobalVars_Random};
		};

        class OUT_par_WeatherAndTimeConditions // 10
        {
			title = $STR_TRGM2_TRGMdescription_Parameter_WeatherTime;
			values[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11};
			default = 1;
			texts[] = {$STR_TRGM2_TRGMSetUnitGlobalVars_Random, $STR_TRGM2_TRGMSetUnitGlobalVars_Sunny, $STR_TRGM2_TRGMSetUnitGlobalVars_DaytimeHeavyOvercast, $STR_TRGM2_TRGMSetUnitGlobalVars_DaytimeAverageOvercast, $STR_TRGM2_TRGMSetUnitGlobalVars_DarkNightClear, $STR_TRGM2_TRGMSetUnitGlobalVars_DarkNightHeavyOvercast, $STR_TRGM2_TRGMSetUnitGlobalVars_DarkNightAverageOvercast, $STR_TRGM2_TRGMSetUnitGlobalVars_EarlyMorning, $STR_TRGM2_TRGMSetUnitGlobalVars_MoonNightClear, $STR_TRGM2_TRGMSetUnitGlobalVars_MoonNightAverageOvercast, $STR_TRGM2_TRGMSetUnitGlobalVars_MoonNightHeavyOvercast};
		};


        class OUT_par_AllowGPS // 10
        {
			title = $STR_TRGM2_TRGMdescription_Parameter_GPS;
			values[] = {1, 0};
			default = 1;
			texts[] = {$STR_TRGM2_TRGMdescription_Parameter_True, $STR_TRGM2_TRGMdescription_Parameter_False};
		};
        class OUT_par_AllowNVG // 10
        {
			title = $STR_TRGM2_TRGMdescription_Parameter_NVG;
			values[] = {1, 0, 2};
			default = 2;
			texts[] = {$STR_TRGM2_TRGMSetUnitGlobalVars_NVG_Allow, $STR_TRGM2_TRGMSetUnitGlobalVars_NVG_NoAllow, $STR_TRGM2_TRGMdescription_Parameter_NVG_PoorVis};
		};

        class OUT_par_UseRevive // 10
        {
			title = $STR_TRGM2_TRGMdescription_Parameter_Revive;
			values[] = {0, 1, 2, 3};
			default = 0;
			texts[] = {$STR_TRGM2_TRGMSetUnitGlobalVars_Revive_No, $STR_TRGM2_TRGMSetUnitGlobalVars_Revive_Guarantee, $STR_TRGM2_TRGMSetUnitGlobalVars_Revive_Real1, $STR_TRGM2_TRGMSetUnitGlobalVars_Revive_Real2};
		};

        class OUT_par_AllowAIInsExtr // 10
        {
			title = $STR_TRGM2_TRGMdescription_Parameter_AI;
			values[] = {1, 0};
			default = 1;
			texts[] = {$STR_TRGM2_TRGMdescription_Parameter_True, $STR_TRGM2_TRGMdescription_Parameter_False};
		};


};

class CfgDebriefing
{
	class End1
	{
		title = $STR_TRGM2_Description_Debriefing_End_Success;
		subtitle = "";
		description = $STR_TRGM2_Description_Debriefing_End1_Description;
		pictureBackground = "";
		picture = "b_inf";
		pictureColor[] = {0.0,0.3,0.6,1};
	};
	class End2
	{
		title = $STR_TRGM2_Description_Debriefing_End_Fail;
		subtitle = "";
		description = $STR_TRGM2_Description_Debriefing_End2_Description;
		pictureBackground = "";
		picture = "b_inf";
		pictureColor[] = {0.6,0.1,0.2,1};
	};
};



//class CfgSounds
//{
//	sounds[] = {};
//
//	class MKY_Blizzard
//	{
//		name = "";
//		sound[] = {"\RandFramework\MKY\sounds\m0nkey_blizzard.ogg", db+10, 1.0};
//		titles[] = {0,""};
//	};
//
//};


class CfgMusic
{
  	tracks[]=
  	{
      		spotted, takiIntro, end
  	};

	class spotted
  	{
      		name = "spotted";
      		sound[] = {"sound\spotted.ogg", db+8, 1.0};
  	};
    	class takiIntro
  	{
      		name = "takiIntro";
      		sound[] = {"sound\takiIntro.OGG", db+8, 1.0};
  	};
    	class end
  	{
      		name = "end";
      		sound[] = {"sound\end.OGG", db+8, 1.0};
  	};

};



class CfgSounds
{
	class uragan_1
	{
		name = "uragan_1";
		sound[] = {"\sound\uragan_1.ogg", db+10, 1};
		titles[] = {1, ""};
	};
	class uragan_end
	{
		name = "uragan_end";
		sound[] = {"\sound\uragan_end.ogg", db+10, 1};
		titles[] = {1, ""};
	};
	class bcg_wind
	{
		name = "bcg_wind";
		sound[] = {"\sound\bcg_wind.ogg", db+5, 1};
		titles[] = {1, ""};
	};
	class rafala_1
	{
		name = "rafala_1";
		sound[] = {"\sound\rafala_1.ogg", db+10, 1};
		titles[] = {1, ""};
	};
	class rafala_2
	{
		name = "rafala_2";
		sound[] = {"\sound\rafala_2.ogg", db+5, 1};
		titles[] = {1, ""};
	};
	class rafala_4_dr
	{
		name = "rafala_4_dr";
		sound[] = {"\sound\rafala_4_dr.ogg", db+10, 1};
		titles[] = {1, ""};
	};
	class rafala_5_st
	{
		name = "rafala_5_st";
		sound[] = {"\sound\rafala_5_st.ogg", db+10, 1};
		titles[] = {1, ""};
	};
	class rafala_6
	{
		name = "rafala_6";
		sound[] = {"\sound\rafala_6.ogg", db+15, 1};
		titles[] = {1, ""};
	};
	class rafala_7
	{
		name = "rafala_7";
		sound[] = {"\sound\rafala_7.ogg", db+10, 1};
		titles[] = {1, ""};
	};
	class rafala_8
	{
		name = "rafala_8";
		sound[] = {"\sound\rafala_8.ogg", db+15, 1};
		titles[] = {1, ""};
	};
	class rafala_9
	{
		name = "rafala_9";
		sound[] = {"\sound\rafala_9.ogg", db+10, 1};
		titles[] = {1, ""};
	};
	class sandstorm
	{
		name = "sandstorm";
		sound[] = {"\sound\sandstorm.ogg", db+10, 1};
		titles[] = {1, ""};
	};
};


class CfgRadio
{
	sounds[] =
	{chopperspotted, FastMoverSpotted, EnemyCommsDown, EnemyBaseIntel};

	class chopperspotted
	{
		name = "chopperspotted";
		sound[] = {"\RandFramework\Sounds\chopperspotted.ogg", db+0,1.0};
		title = $STR_TRGM2_Description_RadioSubtitle_chopperspotted;
	};
	class FastMoverSpotted
	{
		name = "FastMoverSpotted";
		sound[] = {"\RandFramework\Sounds\FastMoverSpotted.ogg", db+0,1.0};
		title = $STR_TRGM2_Description_RadioSubtitle_FastMoverSpotted;
	};
	class EnemyCommsDown
	{
		name = "EnemyCommsDown";
		sound[] = {"\RandFramework\Sounds\EnemyCommsDown.ogg", db+0,1.0};
		title = $STR_TRGM2_Description_RadioSubtitle_EnemyCommsDown;
	};
	class EnemyBaseIntel
	{
		name = "EnemyBaseIntel";
		sound[] = {"\RandFramework\Sounds\EnemyBaseIntel.ogg", db+0,1.0};
		title = $STR_TRGM2_Description_RadioSubtitle_EnemyBaseIntel;
	};
	class LocationFound
	{
		name = "LocationFound";
		sound[] = {"\RandFramework\Sounds\LocationFound.ogg", db+0,1.0};
		title = $STR_TRGM2_Description_RadioSubtitle_LocationFound;
	};


}

//--------------------------------------------------------------
//------------------------AIS INJURY----------------------------
//--------------------------------------------------------------
class RscTitles {
	#include "ais_injury\dialogs\rscTitlesAIS.hpp"
};
class CfgFunctions {
	#include "ais_injury\cfgFunctionsAIS.hpp"
};
//---------
