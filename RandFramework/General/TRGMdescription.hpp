
class Params
{
        
		class TREND_par_MissionType // 4
        {
			title = "Mission Type:";
			values[] = {1,13,14,11,12,0,2,3,4,5,6,7,8,9,10};
			default = 1;
			texts[] = {
				"Single random side mission", //1
				"Double side: Random", //13
				"Main Mission: Random objective, no intel needed", //14
				"Main Mission: Random Objective, intel required for main AO", //11
				"Training", //12
				"==========================================================", //0
				"single side: Hack Data", //2 
				"Single side: Speak with Informant", //3
				"Single side: Interrogate Officer", //4
				"Single side: Bug Radio",  //5
				"Double side: Get code, enter code (coming soon)", //6
				"Gather Intel(random) for Main location : Random", //7
				"Gather Intel(random) for Main location : Interrogate Officer", //8
				"Gather Intel(random) for Main location : Nuke (coming soon)", //9
				"Gather Intel(Radio) for Main location : Interrogate Officer" //10
				
			};
		};

        class OUT_par_AllowLargePatrols // 4
        {
			title = "Maximum Enemies:";
			values[] = {1, 2, 3};
			default = 1;
			texts[] = {"True (WARNING ! this will mean some patrols will have around 9 units", "False", "Random"};
		};
       
        class OUT_par_WeatherAndTimeConditions // 10
        {
			title = "Weather and Time:";
			values[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11};
			default = 1;
			texts[] = {"Random", "Sunny Clear", "Daytime Heavy Overcast", "Day average Overcast", "Dark Night Clear", "Dark Night Heavy Overcast", "Dark Night Average overcast", "Early Morning", "Moon Night Clear", "Moon Night slight overcast", "Moon Night heavy overcast"};
		};


        class OUT_par_AllowGPS // 10
        {
			title = "Allow GPS:";
			values[] = {1, 0};
			default = 1;
			texts[] = {"True", "False"};
		};
        class OUT_par_AllowNVG // 10
        {
			title = "NVG:";
			values[] = {1, 0, 2};
			default = 2;
			texts[] = {"Allowed", "No NVG", "NVG with poor visibility"};
		};

        class OUT_par_UseRevive // 10
        {
			title = "Revive options:";
			values[] = {0, 1, 2, 3};
			default = 0;
			texts[] = {"No revive", "Guarantee revive", "Realistic revive (critical hits will kill you instantly)", "Realistic revive (only medics can revive with a medkit)"};
		};

        class OUT_par_AllowAIInsExtr // 10
        {
			title = "Allow AI insertion and extraction:";
			values[] = {1, 0};
			default = 1;
			texts[] = {"True", "False"};
		};


};

class CfgDebriefing
{  
	class End1
	{
		title = "Success";
		subtitle = "";
		description = "Well done, Mission success!";
		pictureBackground = "";
		picture = "b_inf";
		pictureColor[] = {0.0,0.3,0.6,1};
	};
	class End2
	{
		title = "Fail";
		subtitle = "";
		description = "Your team killed too many civilians.  The officer in charge of this mission and the units who killed any civilians will need to attend a court hearing regarding these deaths!.";
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
		title = "All teams, this is HQ, We are seeing something moveing into your location, possible enemy chopper. out.";
	};
	class FastMoverSpotted
	{
		name = "FastMoverSpotted";
		sound[] = {"\RandFramework\Sounds\FastMoverSpotted.ogg", db+0,1.0};
		title = "All teams, this is HQ, We have picked up a fast mover on our radar, moving into the area. out.";
	};
	class EnemyCommsDown
	{
		name = "EnemyCommsDown";
		sound[] = {"\RandFramework\Sounds\EnemyCommsDown.ogg", db+0,1.0};
		title = "All team.  This is HQ, good work taking down the enemy comms tower.  We have intel confirming the enemy are trying to figure out how to fix this issue! Out.";
	};
	class EnemyBaseIntel
	{
		name = "EnemyBaseIntel";
		sound[] = {"\RandFramework\Sounds\EnemyBaseIntel.ogg", db+0,1.0};
		title = "This is HQ.  We have gathered the intel found at the enemy base and have managed to locate the exact position of your targets.  Check your map for the red dots for the target locations.";
	};
	class LocationFound
	{
		name = "LocationFound";
		sound[] = {"\RandFramework\Sounds\LocationFound.ogg", db+0,1.0};
		title = "This is HQ.  We have just had intel of the exact location of one of the objectives, check your map for the red marker near the suspected location.  Out.";
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
