
class Trend_DialogSetupParams
	{
	idd = 5000;
	movingEnabled = false;

	class controls {

		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by treendy, v1.063, #Nazety)
		////////////////////////////////////////////////////////

		class RscPicture_1201: RscPicture
		{
			idc = 1201;
			text = "RandFramework\Media\table1.paa";
			x = 0.226718 * safezoneW + safezoneX;
			y = 0.0446 * safezoneH + safezoneY;
			w = 0.531094 * safezoneW;
			h = 0.935 * safezoneH;
		};

		//class IGUIBack_2200: IGUIBack
		//{
		//	idc = 5200;
		//	x = 0.29375 * safezoneW + safezoneX;
		//	y = 0.225 * safezoneH + safezoneY;
		//	w = 0.4125 * safezoneW;
		//	h = 0.55 * safezoneH;
		//};
		class RscText_1001: RscText
		{
			idc = 5001;
			style = ST_MULTI;
			lineSpacing = 1;
			text = "Details about it here"; //--- ToDo: Localize;
			x = 0.489686 * safezoneW + safezoneX;
			y = 0.317436 * safezoneH + safezoneY;
			w = 0.211441 * safezoneW;
			h = 0.241947 * safezoneH;
		};
		class RscCombo_2100: RscCombo
		{
			idc = 5100;
			text = "Weather"; //--- ToDo: Localize;
			x = 0.381406 * safezoneW + safezoneX;
			y = 0.59681 * safezoneH + safezoneY;
			w = 0.154713 * safezoneW;
			h = 0.0219952 * safezoneH;	
		};
		class RscText_1004: RscText
		{
			idc = 5004;
			text = "Reputation System"; //--- ToDo: Localize;
			x = 0.302 * safezoneW + safezoneX;
			y = 0.596807 * safezoneH + safezoneY;
			w = 0.0773437 * safezoneW;
			h = 0.022 * safezoneH;
			colorText[] = {0,1,0,1};
		};
		class RscText_1005: RscText
		{
			idc = 5005;
			text = "Weather"; //--- ToDo: Localize;
			x = 0.302 * safezoneW + safezoneX;
			y = 0.627606 * safezoneH + safezoneY;
			w = 0.0773437 * safezoneW;
			h = 0.022 * safezoneH;
			colorText[] = {0,1,0,1};
		};
		class RscCombo_2101: RscCombo
		{
			idc = 5101;
			text = "Weather"; //--- ToDo: Localize;
			x = 0.381406 * safezoneW + safezoneX;
			y = 0.62981 * safezoneH + safezoneY;
			w = 0.154713 * safezoneW;
			h = 0.0219952 * safezoneH;
		};
		class RscCombo_2102: RscCombo
		{
			idc = 5102;
			text = "Weather"; //--- ToDo: Localize;
			x = 0.381406 * safezoneW + safezoneX;
			y = 0.662803 * safezoneH + safezoneY;
			w = 0.154713 * safezoneW;
			h = 0.0219952 * safezoneH;		
		};
		class RscText_1006: RscText
		{
			idc = 5006;
			text = "NVG"; //--- ToDo: Localize;
			x = 0.302 * safezoneW + safezoneX;
			y = 0.660603 * safezoneH + safezoneY;
			w = 0.0773437 * safezoneW;
			h = 0.022 * safezoneH;
			colorText[] = {0,1,0,1};
		};
		class RscText_1007: RscText
		{
			idc = 5007;
			text = "Revive"; //--- ToDo: Localize;
			x = 0.303031 * safezoneW + safezoneX;
			y = 0.693606 * safezoneH + safezoneY;
			w = 0.0773437 * safezoneW;
			h = 0.022 * safezoneH;
			colorText[] = {0,1,0,1};
		};
		class RscCombo_2103: RscCombo
		{
			idc = 5103;
			text = "Weather"; //--- ToDo: Localize;
			x = 0.381406 * safezoneW + safezoneX;
			y = 0.69581 * safezoneH + safezoneY;
			w = 0.154713 * safezoneW;
			h = 0.0219952 * safezoneH;
		};
		class RscButton_1600: RscButton
		{
			idc = 5600;
			text = "Begin"; //--- ToDo: Localize;
			x = 0.582514 * safezoneW + safezoneX;
			y = 0.642969 * safezoneH + safezoneY;
			w = 0.103142 * safezoneW;
			h = 0.0989783 * safezoneH;
			colorBackground[] = {0,1,0,1};
			colorActive[] = {0,1,0,1};
			action = "[_this] execVM 'RandFramework\GUI\SetParamsAndBegin.sqf'; false";
		};
		class RscListbox_1500: RscListbox
		{
			idc = 5500;
			x = 0.298873 * safezoneW + safezoneX;
			y = 0.315236 * safezoneH + safezoneY;
			w = 0.180498 * safezoneW;
			h = 0.219952 * safezoneH;
			onLBSelChanged = "[_this] execVM 'RandFramework\GUI\MissionTypeSelection.sqf'; false; ";
		};
		class RscText_1000: RscText
		{
			idc = 5033;
			text = "Select your options"; //--- ToDo: Localize;
			x = 0.298824 * safezoneW + safezoneX;
			y = 0.236 * safezoneH + safezoneY;
			w = 0.175341 * safezoneW;
			h = 0.0659856 * safezoneH;
			colorText[] = {0,1,0,1};
		};
		class RscText_1002: RscText
		{
			idc = 5002;
			text = "Objective"; //--- ToDo: Localize;
			x = 0.301968 * safezoneW + safezoneX;
			y = 0.561583 * safezoneH + safezoneY;
			w = 0.0773437 * safezoneW;
			h = 0.022 * safezoneH;
			colorText[] = {0,1,0,1};
		};
		class RscCombo_2104: RscCombo
		{
			idc = 5104;
			text = "Weather"; //--- ToDo: Localize;
			x = 0.381387 * safezoneW + safezoneX;
			y = 0.561583 * safezoneH + safezoneY;
			w = 0.154713 * safezoneW;
			h = 0.0219952 * safezoneH;
		};
		class RscText_1003: RscText
		{
			idc = 5003;
			text = ""; //--- ToDo: Localize;
			x = 0.538171 * safezoneW + safezoneX;
			y = 0.5616 * safezoneH + safezoneY;
			w = 0.0154751 * safezoneW;
			h = 0.022 * safezoneH;
			colorText[] = {1,1,1,1};
		};
		class RscText_1008: RscText
		{
			idc = 5008;
			text = "[?]"; //--- ToDo: Localize;
			x = 0.538171 * safezoneW + safezoneX;
			y = 0.5946 * safezoneH + safezoneY;
			w = 0.0154751 * safezoneW;
			h = 0.022 * safezoneH;
			colorText[] = {1,1,1,1};
			tooltip = "If this is enabled, you will have to keep your Reputation up with high command.\nKilling civs, losing main assets and units, killing friendly rebels or any other mistakes will lower your Reputation.\nIf your Reputation is too low, your mission will be unassigned and you will have to return to base!\n(I introduced this point system to make mistakes more costly, to make you think carefully about your actions\nand to feel any vehicle assets you use are not expendable!"; //--- ToDo: Localize;
		};
		class RscText_1009: RscText
		{
			idc = 5009;
			text = ""; //--- ToDo: Localize;
			x = 0.538171 * safezoneW + safezoneX;
			y = 0.6276 * safezoneH + safezoneY;
			w = 0.0154751 * safezoneW;
			h = 0.022 * safezoneH;
			colorText[] = {1,1,1,1};
		};
		class RscText_1010: RscText
		{
			idc = 5010;
			text = ""; //--- ToDo: Localize;
			x = 0.538171 * safezoneW + safezoneX;
			y = 0.6606 * safezoneH + safezoneY;
			w = 0.0154751 * safezoneW;
			h = 0.022 * safezoneH;
			colorText[] = {1,1,1,1};
		};
		class RscText_1011: RscText
		{
			idc = 5011;
			text = ""; //--- ToDo: Localize;
			x = 0.538171 * safezoneW + safezoneX;
			y = 0.6936 * safezoneH + safezoneY;
			w = 0.0154751 * safezoneW;
			h = 0.022 * safezoneH;
			colorText[] = {1,1,1,1};
		};
		class RscPicture_1200: RscPicture
		{
			idc = 5201;
			text = "RandFramework\Media\TRGM7.paa";
			x = 0.536108 * safezoneW + safezoneX;
			y = 0.159 * safezoneH + safezoneY;
			w = 0.165067 * safezoneW;
			h = 0.242 * safezoneH;
		};

		class RscText_1012: RscText
		{
			idc = 1012;
			text = "Start Location"; //--- ToDo: Localize;
			x = 0.304062 * safezoneW + safezoneX;
			y = 0.7266 * safezoneH + safezoneY;
			w = 0.0773437 * safezoneW;
			h = 0.022 * safezoneH;
			colorText[] = {0,1,0,1};
		};
		class RscCombo_2105: RscCombo
		{
			idc = 2105;
			text = "Weather"; //--- ToDo: Localize;
			x = 0.381406 * safezoneW + safezoneX;
			y = 0.7288 * safezoneH + safezoneY;
			w = 0.154713 * safezoneW;
			h = 0.0219952 * safezoneH;
		};
		class RscText_1013: RscText
		{
			idc = 1013;
			text = "[?]"; //--- ToDo: Localize;
			x = 0.538156 * safezoneW + safezoneX;
			y = 0.7288 * safezoneH + safezoneY;
			w = 0.0154751 * safezoneW;
			h = 0.022 * safezoneH;
			colorText[] = {1,1,1,1};
			tooltip = "If you select to start Near AO, this you will start near the AO as a fast response team,\nno need for transport.\n\nYou will be allocated a drivable vehicle. Otherwise will start at the main base\nwith transport chopper to fly you to a choosen LZ"; //--- ToDo: Localize;
		};

		class btnLoadLocalSave: RscButton
		{
			idc = 1601;
			text = "Load Local Campaign"; //--- ToDo: Localize;
			x = 0.5825 * safezoneW + safezoneX;
			y = 0.566 * safezoneH + safezoneY;
			w = 0.103125 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0,1,0,1};
			colorActive[] = {0,1,0,1};
			tooltip = "Will load the last campaign save data for the current map (that was saved by you only... i.e. the current person selecting mission parameters)"; //--- ToDo: Localize;
			action = "[_this,1] execVM 'RandFramework\GUI\SetParamsAndBegin.sqf'; false";
		};
		class btnLoadglobalSave: RscButton
		{
			idc = 1602;
			text = "Load Global Campaign"; //--- ToDo: Localize;
			x = 0.5825 * safezoneW + safezoneX;
			y = 0.599 * safezoneH + safezoneY;
			w = 0.103125 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0,1,0,1};
			colorActive[] = {0,1,0,1};
			tooltip = "Will load any previous campaign global saves for any map running TRGM2 (that was saved by you only... i.e. the current person selecting mission parameters"; //--- ToDo: Localize;
			action = "[_this,2] execVM 'RandFramework\GUI\SetParamsAndBegin.sqf'; false";
		};

		class btnAdvanced: RscButton
		{
			idc = 1603;
			text = "Advanced Options"; //--- ToDo: Localize;
			x = 0.608281 * safezoneW + safezoneX;
			y = 0.7442 * safezoneH + safezoneY;
			w = 0.0773437 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0,1,0,1};
			colorActive[] = {0,1,0,1};
			action = "[] execVM 'RandFramework\GUI\openDialogAdvancedMissionSettings.sqf'; false";
		};


		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////



	};
};



class Trend_DialogSetupParamsAdvanced
	{
	idd = 6000;
	movingEnabled = false;

	class controls {

		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by treendy, v1.063, #Nazety)
		////////////////////////////////////////////////////////

		class RscPicture_6901: RscPicture
		{
			idc = 6901;
			text = "RandFramework\Media\table1.paa";
			x = 0.226718 * safezoneW + safezoneX;
			y = 0.0446 * safezoneH + safezoneY;
			w = 0.531094 * safezoneW;
			h = 0.935 * safezoneH;
		};

			class RscText_6933: RscText
		{
			idc = 6933;
			text = "Advanced Options"; //--- ToDo: Localize;
			x = 0.298 * safezoneW + safezoneX;
			y = 0.236 * safezoneH + safezoneY;
			w = 0.175341 * safezoneW;
			h = 0.0659856 * safezoneH;
			colorText[] = {0,1,0,1};
		};

				
		class btnAdvanced: RscButton
		{
			idc = 6903;
			text = "Back"; //--- ToDo: Localize;
			x = 0.608281 * safezoneW + safezoneX;
			y = 0.7442 * safezoneH + safezoneY;
			w = 0.0773437 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0,1,0,1};
			colorActive[] = {0,1,0,1};
			action = "[] execVM 'RandFramework\GUI\openDialogMissionSelection.sqf'; false";
		};




		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////



	};
};


