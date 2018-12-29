
class Trend_DialogSetupParams
	{
	idd = 5000;
	movingEnabled = false;

	class controls {

		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by treendy, v1.063, #Nazety)
		////////////////////////////////////////////////////////

		//class RscPicture_1201: RscPicture
		//{
		//	idc = 1201;
		//	text = "RandFramework\Media\table1.paa";
		//	x = 0.226718 * safezoneW + safezoneX;
		//	y = 0.0446 * safezoneH + safezoneY;
		//	w = 0.531094 * safezoneW;
		//	h = 0.935 * safezoneH;
		//};

		//class IGUIBack_2200: IGUIBack
		//{
		//	idc = 5200;
		//	x = 0.29375 * safezoneW + safezoneX;
		//	y = 0.225 * safezoneH + safezoneY;
		//	w = 0.4125 * safezoneW;
		//	h = 0.55 * safezoneH;
		//};

		class RscListbox_1500: RscListbox
		{
			idc = 5500;
			x = 0.298873 * safezoneW + safezoneX;
			y = 0.315236 * safezoneH + safezoneY;
			w = 0.180498 * safezoneW;
			h = 0.239952 * safezoneH;
			onLBSelChanged = "[_this] execVM 'RandFramework\GUI\MissionTypeSelection.sqf'; false; ";
		};

		class RscCombo_2100: RscCombo
		{
			idc = 5100;
			text = $STR_TRGM2_dialogs_Weather; //--- ToDo: Localize;
			x = 0.381406 * safezoneW + safezoneX;
			y = 0.59681 * safezoneH + safezoneY;
			w = 0.154713 * safezoneW;
			h = 0.0219952 * safezoneH;
		};
		class RscText_1001: RscText
		{
			idc = 5001;
			style = ST_MULTI;
			lineSpacing = 1;
			text = $STR_TRGM2_dialogs_Details; //--- ToDo: Localize;
			x = 0.489686 * safezoneW + safezoneX;
			y = 0.317436 * safezoneH + safezoneY;
			w = 0.211441 * safezoneW;
			h = 0.241947 * safezoneH;
		};
		class RscText_1004: RscText
		{
			idc = 5004;
			text = $STR_TRGM2_dialogs_HardcoreReputation; //--- ToDo: Localize;
			x = 0.302 * safezoneW + safezoneX;
			y = 0.596807 * safezoneH + safezoneY;
			w = 0.0773437 * safezoneW;
			h = 0.022 * safezoneH;
			colorText[] = {0.85,0.4,0,1};
		};
		class RscText_1005: RscText
		{
			idc = 5005;
			text = $STR_TRGM2_dialogs_Weather; //--- ToDo: Localize;
			x = 0.302 * safezoneW + safezoneX;
			y = 0.627606 * safezoneH + safezoneY;
			w = 0.0773437 * safezoneW;
			h = 0.022 * safezoneH;
			colorText[] = {0.85,0.4,0,1};
		};
		class RscCombo_2101: RscCombo
		{
			idc = 5101;
			text = $STR_TRGM2_dialogs_Weather; //--- ToDo: Localize;
			x = 0.381406 * safezoneW + safezoneX;
			y = 0.62981 * safezoneH + safezoneY;
			w = 0.154713 * safezoneW;
			h = 0.0219952 * safezoneH;
		};
		class RscCombo_2102: RscCombo
		{
			idc = 5102;
			text = $STR_TRGM2_dialogs_Weather; //--- ToDo: Localize;
			x = 0.381406 * safezoneW + safezoneX;
			y = 0.662803 * safezoneH + safezoneY;
			w = 0.154713 * safezoneW;
			h = 0.0219952 * safezoneH;
		};
		class RscText_1006: RscText
		{
			idc = 5006;
			text = $STR_TRGM2_dialogs_NVG; //--- ToDo: Localize;
			x = 0.302 * safezoneW + safezoneX;
			y = 0.660603 * safezoneH + safezoneY;
			w = 0.0773437 * safezoneW;
			h = 0.022 * safezoneH;
			colorText[] = {0.85,0.4,0,1};
		};
		class RscText_1007: RscText
		{
			idc = 5007;
			text = $STR_TRGM2_dialogs_Revive; //--- ToDo: Localize;
			x = 0.303031 * safezoneW + safezoneX;
			y = 0.693606 * safezoneH + safezoneY;
			w = 0.0773437 * safezoneW;
			h = 0.022 * safezoneH;
			colorText[] = {0.85,0.4,0,1};
		};
		class RscCombo_2103: RscCombo
		{
			idc = 5103;
			text = $STR_TRGM2_dialogs_Weather; //--- ToDo: Localize;
			x = 0.381406 * safezoneW + safezoneX;
			y = 0.69581 * safezoneH + safezoneY;
			w = 0.154713 * safezoneW;
			h = 0.0219952 * safezoneH;
		};
		class RscButton_1600: RscButton
		{
			idc = 5600;
			text = $STR_TRGM2_dialogs_Begin; //--- ToDo: Localize;
			x = 0.582514 * safezoneW + safezoneX;
			y = 0.642969 * safezoneH + safezoneY;
			w = 0.103142 * safezoneW;
			h = 0.0989783 * safezoneH;
			colorBackground[] = {0.85,0.4,0,1};
			colorActive[] = {0.85,0.4,0,1};
			action = "[_this] execVM 'RandFramework\GUI\SetParamsAndBegin.sqf'; false";
		};

		class btnAdvanced: RscButton
		{
			idc = 1603;
			text = $STR_TRGM2_dialogs_AdvOpt; //--- ToDo: Localize;
			x = 0.582514 * safezoneW + safezoneX;
			y = 0.7442 * safezoneH + safezoneY;
			w = 0.103142 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0.85,0.4,0,1};
			colorActive[] = {0.85,0.4,0,1};
			action = "[] execVM 'RandFramework\GUI\openDialogAdvancedMissionSettings.sqf'; false";
		};


		//class RscText_1000: RscText
		//{
		//	idc = 5033;
		//	text = "Select your options"; //--- ToDo: Localize;
		//	x = 0.298824 * safezoneW + safezoneX;
		//	y = 0.236 * safezoneH + safezoneY;
		//	w = 0.175341 * safezoneW;
		//	h = 0.0659856 * safezoneH;
		//	colorText[] = {0.85,0.4,0,1};
		//};
		class RscText_1002: RscText
		{
			idc = 5002;
			text = $STR_TRGM2_dialogs_Objective; //--- ToDo: Localize;
			x = 0.301968 * safezoneW + safezoneX;
			y = 0.561583 * safezoneH + safezoneY;
			w = 0.0773437 * safezoneW;
			h = 0.022 * safezoneH;
			colorText[] = {0.85,0.4,0,1};
		};
		class RscCombo_2104: RscCombo
		{
			idc = 5104;
			text = $STR_TRGM2_dialogs_Weather; //--- ToDo: Localize;
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
			tooltip = $STR_TRGM2_dialogs_HardcoreReputation_HelpText; //--- ToDo: Localize;
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
			text = $STR_TRGM2_dialogs_StartLocation; //--- ToDo: Localize;
			x = 0.304062 * safezoneW + safezoneX;
			y = 0.7266 * safezoneH + safezoneY;
			w = 0.0773437 * safezoneW;
			h = 0.022 * safezoneH;
			colorText[] = {0.85,0.4,0,1};
		};
		class RscCombo_2105: RscCombo
		{
			idc = 2105;
			text = $STR_TRGM2_dialogs_Weather; //--- ToDo: Localize;
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
			tooltip = $STR_TRGM2_dialogs_StartLocation_HelpText; //--- ToDo: Localize;
		};

		class btnLoadLocalSave: RscButton
		{
			idc = 1601;
			text = $STR_TRGM2_dialogs_LoadLocal; //--- ToDo: Localize;
			x = 0.5825 * safezoneW + safezoneX;
			y = 0.566 * safezoneH + safezoneY;
			w = 0.103125 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0.85,0.4,0,1};
			colorActive[] = {0.85,0.4,0,1};
			tooltip = $STR_TRGM2_dialogs_LoadLocal_HelpText; //--- ToDo: Localize;
			action = "[_this,1] execVM 'RandFramework\GUI\SetParamsAndBegin.sqf'; false";
		};
		class btnLoadglobalSave: RscButton
		{
			idc = 1602;
			text = $STR_TRGM2_dialogs_LoadGlobal; //--- ToDo: Localize;
			x = 0.5825 * safezoneW + safezoneX;
			y = 0.599 * safezoneH + safezoneY;
			w = 0.103125 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0.85,0.4,0,1};
			colorActive[] = {0.85,0.4,0,1};
			tooltip = $STR_TRGM2_dialogs_LoadGlobal_HelpText; //--- ToDo: Localize;
			action = "[_this,2] execVM 'RandFramework\GUI\SetParamsAndBegin.sqf'; false";
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

		//class RscText_6933: RscText
		//{
		//	idc = 6933;
		//	text = "Advanced Options"; //--- ToDo: Localize;
		//	x = 0.298 * safezoneW + safezoneX;
		//	y = 0.236 * safezoneH + safezoneY;
		//	w = 0.175341 * safezoneW;
		//	h = 0.0659856 * safezoneH;
		//	colorText[] = {0,1,0,1};
		//};


		class btnAdvanced: RscButton
		{
			idc = 6903;
			text = $STR_TRGM2_dialogs_Back; //--- ToDo: Localize;
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



class Trend_DialogSetupEnemyFaction
	{
	idd = 7000;
	movingEnabled = false;

	class controls {

		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by treendy, v1.063, #Nazety)
		////////////////////////////////////////////////////////

		class RscPicture_7901: RscPicture
		{
			idc = 7901;
			text = "RandFramework\Media\table1.paa";
			x = 0.226718 * safezoneW + safezoneX;
			y = 0.0446 * safezoneH + safezoneY;
			w = 0.531094 * safezoneW;
			h = 0.935 * safezoneH;
		};

		//class RscText_6933: RscText
		//{
		//	idc = 6933;
		//	text = "Advanced Options"; //--- ToDo: Localize;
		//	x = 0.298 * safezoneW + safezoneX;
		//	y = 0.236 * safezoneH + safezoneY;
		//	w = 0.175341 * safezoneW;
		//	h = 0.0659856 * safezoneH;
		//	colorText[] = {0,1,0,1};
		//};


		class btnAdvanced: RscButton
		{
			idc = 7903;
			text = $STR_TRGM2_defines_Cancel; //--- ToDo: Localize;
			x = 0.608281 * safezoneW + safezoneX;
			y = 0.7442 * safezoneH + safezoneY;
			w = 0.0773437 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {1,0,0,1};
			colorActive[] = {1,0,0,1};
			action = "[] execVM 'RandFramework\GUI\openDialogAdvancedMissionSettings.sqf'; false";
		};




		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////



	};
};


class KeypadDefuse 
{
	idd = -1;
	movingEnable = 1;
    enableSimulation = 1;
	controlsBackground[] = {};
  	objects[] = {};
	
	class controls 
	{
		class B9: RscButton
		{
			idc = -1;
			x = 0.53197 * safezoneW + safezoneX;
			y = 0.5924 * safezoneH + safezoneY;
			w = 0.0165001 * safezoneW;
			h = 0.022 * safezoneH;
			colorFocused[] = {0.1,0.1,0.1,0.1};
			colorShadow[] = {0,0,0,0};
			colorBorder[] = {0.5,0.5,0.5,0};
			colorBackground[] = {0.7,0.7,0.7,0};
			colorBackgroundActive[] = {0.1,0.1,0.1,0};
			colorDisabled[] = {1,0,0,1};
			colorBackgroundDisabled[] = {0.5,0.5,0.5,0};
			borderSize = 0.015;
			offsetX = 0.005;
			offsetY = 0.005;
			offsetPressedX = 0.002;
			offsetPressedY = 0.002;
			soundClick[] = {"",0,0};
			onMouseButtonDown = "playSound 'button_click'; CODEINPUT set [count CODEINPUT, 9]; ctrlSetText [1099, (ctrlText 1099) + str 9]";
		};
		class B8: RscButton
		{
			idc = -1;
			x = 0.504125 * safezoneW + safezoneX;
			y = 0.5924 * safezoneH + safezoneY;
			w = 0.0165001 * safezoneW;
			h = 0.022 * safezoneH;
			colorFocused[] = {0.1,0.1,0.1,0.1};
			colorShadow[] = {0,0,0,0};
			colorBorder[] = {0.5,0.5,0.5,0};
			colorBackground[] = {0.7,0.7,0.7,0};
			colorBackgroundActive[] = {0.1,0.1,0.1,0};
			colorDisabled[] = {1,0,0,1};
			colorBackgroundDisabled[] = {0.5,0.5,0.5,0};
			borderSize = 0.015;
			offsetX = 0.005;
			offsetY = 0.005;
			offsetPressedX = 0.002;
			offsetPressedY = 0.002;
			soundClick[] = {"",0,0};
			onMouseButtonDown = "playSound 'button_click'; CODEINPUT set [count CODEINPUT, 8]; ctrlSetText [1099, (ctrlText 1099) + str 8]";
		};
		class B7: RscButton
		{
			idc = -1;
			x = 0.476148 * safezoneW + safezoneX;
			y = 0.592356 * safezoneH + safezoneY;
			w = 0.0165001 * safezoneW;
			h = 0.022 * safezoneH;
			colorFocused[] = {0.1,0.1,0.1,0.1};
			colorShadow[] = {0,0,0,0};
			colorBorder[] = {0.5,0.5,0.5,0};
			colorBackground[] = {0.7,0.7,0.7,0};
			colorBackgroundActive[] = {0.1,0.1,0.1,0};
			colorDisabled[] = {1,0,0,1};
			colorBackgroundDisabled[] = {0.5,0.5,0.5,0};
			borderSize = 0.015;
			offsetX = 0.005;
			offsetY = 0.005;
			offsetPressedX = 0.002;
			offsetPressedY = 0.002;
			soundClick[] = {"",0,0};
			onMouseButtonDown = "playSound 'button_click'; CODEINPUT set [count CODEINPUT, 7]; ctrlSetText [1099, (ctrlText 1099) + str 7]";
		};
		class B6: RscButton
		{
			idc = -1;
			x = 0.532441 * safezoneW + safezoneX;
			y = 0.64143 * safezoneH + safezoneY;
			w = 0.0165001 * safezoneW;
			h = 0.022 * safezoneH;
			colorFocused[] = {0.1,0.1,0.1,0.1};
			colorShadow[] = {0,0,0,0};
			colorBorder[] = {0.5,0.5,0.5,0};
			colorBackground[] = {0.7,0.7,0.7,0};
			colorBackgroundActive[] = {0.1,0.1,0.1,0};
			colorDisabled[] = {1,0,0,1};
			colorBackgroundDisabled[] = {0.5,0.5,0.5,0};
			borderSize = 0.015;
			offsetX = 0.005;
			offsetY = 0.005;
			offsetPressedX = 0.002;
			offsetPressedY = 0.002;
			soundClick[] = {"",0,0};
			onMouseButtonDown = "playSound 'button_click'; CODEINPUT set [count CODEINPUT, 6]; ctrlSetText [1099, (ctrlText 1099) + str 6]";
		};
		class B5: RscButton
		{
			idc = -1;
			x = 0.504273 * safezoneW + safezoneX;
			y = 0.643052 * safezoneH + safezoneY;
			w = 0.0165001 * safezoneW;
			h = 0.022 * safezoneH;
			colorFocused[] = {0.1,0.1,0.1,0.1};
			colorShadow[] = {0,0,0,0};
			colorBorder[] = {0.5,0.5,0.5,0};
			colorBackground[] = {0.7,0.7,0.7,0};
			colorBackgroundActive[] = {0.1,0.1,0.1,0};
			colorDisabled[] = {1,0,0,1};
			colorBackgroundDisabled[] = {0.5,0.5,0.5,0};
			borderSize = 0.015;
			offsetX = 0.005;
			offsetY = 0.005;
			offsetPressedX = 0.002;
			offsetPressedY = 0.002;
			soundClick[] = {"",0,0};
			onMouseButtonDown = "playSound 'button_click'; CODEINPUT set [count CODEINPUT, 5]; ctrlSetText [1099, (ctrlText 1099) + str 5]";
		};
		class B4: RscButton
		{
			idc = -1;
			x = 0.47525 * safezoneW + safezoneX;
			y = 0.643 * safezoneH + safezoneY;
			w = 0.0165001 * safezoneW;
			h = 0.022 * safezoneH;
			colorFocused[] = {0.1,0.1,0.1,0.1};
			colorShadow[] = {0,0,0,0};
			colorBorder[] = {0.5,0.5,0.5,0};
			colorBackground[] = {0.7,0.7,0.7,0};
			colorBackgroundActive[] = {0.1,0.1,0.1,0};
			colorDisabled[] = {1,0,0,1};
			colorBackgroundDisabled[] = {0.5,0.5,0.5,0};
			borderSize = 0.015;
			offsetX = 0.005;
			offsetY = 0.005;
			offsetPressedX = 0.002;
			offsetPressedY = 0.002;
			soundClick[] = {"",0,0};
			onMouseButtonDown = "playSound 'button_click'; CODEINPUT set [count CODEINPUT, 4]; ctrlSetText [1099, (ctrlText 1099) + str 4]";
		};
		class B3: RscButton
		{
			idc = -1;
			x = 0.531963 * safezoneW + safezoneX;
			y = 0.691778 * safezoneH + safezoneY;
			w = 0.0165001 * safezoneW;
			h = 0.022 * safezoneH;
			colorFocused[] = {0.1,0.1,0.1,0.1};
			colorShadow[] = {0,0,0,0};
			colorBorder[] = {0.5,0.5,0.5,0};
			colorBackground[] = {0.7,0.7,0.7,0};
			colorBackgroundActive[] = {0.1,0.1,0.1,0};
			colorDisabled[] = {1,0,0,1};
			colorBackgroundDisabled[] = {0.5,0.5,0.5,0};
			borderSize = 0.015;
			offsetX = 0.005;
			offsetY = 0.005;
			offsetPressedX = 0.002;
			offsetPressedY = 0.002;
			soundClick[] = {"",0,0};
			onMouseButtonDown = "playSound 'button_click'; CODEINPUT set [count CODEINPUT, 3]; ctrlSetText [1099, (ctrlText 1099) + str 3]";
		};
		class B2: RscButton
		{
			idc = -1;
			x = 0.504752 * safezoneW + safezoneX;
			y = 0.692704 * safezoneH + safezoneY;
			w = 0.0165001 * safezoneW;
			h = 0.022 * safezoneH;
			colorFocused[] = {0.1,0.1,0.1,0.1};
			colorShadow[] = {0,0,0,0};
			colorBorder[] = {0.5,0.5,0.5,0};
			colorBackground[] = {0.7,0.7,0.7,0};
			colorBackgroundActive[] = {0.1,0.1,0.1,0};
			colorDisabled[] = {1,0,0,1};
			colorBackgroundDisabled[] = {0.5,0.5,0.5,0};
			borderSize = 0.015;
			offsetX = 0.005;
			offsetY = 0.005;
			offsetPressedX = 0.002;
			offsetPressedY = 0.002;
			soundClick[] = {"",0,0};
			onMouseButtonDown = "playSound 'button_click'; CODEINPUT set [count CODEINPUT, 2]; ctrlSetText [1099, (ctrlText 1099) + str 2]";
		};
		class B1: RscButton
		{
			idc = -1;
			x = 0.476095 * safezoneW + safezoneX;
			y = 0.691778 * safezoneH + safezoneY;
			w = 0.0165001 * safezoneW;
			h = 0.022 * safezoneH;
			colorFocused[] = {0.1,0.1,0.1,0.1};
			colorShadow[] = {0,0,0,0};
			colorBorder[] = {0.5,0.5,0.5,0};
			colorBackground[] = {0.7,0.7,0.7,0};
			colorBackgroundActive[] = {0.1,0.1,0.1,0};
			colorDisabled[] = {1,0,0,1};
			colorBackgroundDisabled[] = {0.5,0.5,0.5,0};
			borderSize = 0.015;
			offsetX = 0.005;
			offsetY = 0.005;
			offsetPressedX = 0.002;
			offsetPressedY = 0.002;
			soundClick[] = {"",0,0};
			onMouseButtonDown = "playSound 'button_click'; CODEINPUT set [count CODEINPUT, 1]; ctrlSetText [1099, (ctrlText 1099) + str 1]";
		};
		class B0: RscButton
		{
			idc = -1;
			x = 0.504124 * safezoneW + safezoneX;
			y = 0.742 * safezoneH + safezoneY;
			w = 0.0165001 * safezoneW;
			h = 0.022 * safezoneH;
			colorFocused[] = {0.1,0.1,0.1,0.1};
			colorShadow[] = {0,0,0,0};
			colorBorder[] = {0.5,0.5,0.5,0};
			colorBackground[] = {0.7,0.7,0.7,0};
			colorBackgroundActive[] = {0.1,0.1,0.1,0};
			colorDisabled[] = {1,0,0,1};
			colorBackgroundDisabled[] = {0.5,0.5,0.5,0};
			borderSize = 0.015;
			offsetX = 0.005;
			offsetY = 0.005;
			offsetPressedX = 0.002;
			offsetPressedY = 0.002;
			soundClick[] = {"",0,0};
			onMouseButtonDown = "playSound 'button_click'; CODEINPUT set [count CODEINPUT, 0]; ctrlSetText [1099, (ctrlText 1099) + str 0]";
		};
		class Benter: RscButton
		{
			idc = -1;
			x = 0.532898 * safezoneW + safezoneX;
			y = 0.740504 * safezoneH + safezoneY;
			w = 0.0165001 * safezoneW;
			h = 0.022 * safezoneH;
			colorFocused[] = {0.1,0.1,0.1,0.1};
			colorShadow[] = {0,0,0,0};
			colorBorder[] = {0.5,0.5,0.5,0};
			colorBackground[] = {0.7,0.7,0.7,0};
			colorBackgroundActive[] = {0.1,0.1,0.1,0};
			colorDisabled[] = {1,0,0,1};
			colorBackgroundDisabled[] = {0.5,0.5,0.5,0};
			borderSize = 0.015;
			offsetX = 0.005;
			offsetY = 0.005;
			offsetPressedX = 0.002;
			offsetPressedY = 0.002;
			soundClick[] = {"",0,0};
			onMouseButtonDown = "[CODEINPUT] execVM 'RandFramework\CustomMission\GUI\fn_codeCompare.sqf'; ";
		};
		class Bclear: RscButton
		{
			idc = -1;
			x = 0.477313 * safezoneW + safezoneX;
			y = 0.742 * safezoneH + safezoneY;
			w = 0.0165001 * safezoneW;
			h = 0.022 * safezoneH;
			colorFocused[] = {0.1,0.1,0.1,0.1};
			colorShadow[] = {0,0,0,0};
			colorBorder[] = {0.5,0.5,0.5,0};
			colorBackground[] = {0.7,0.7,0.7,0};
			colorBackgroundActive[] = {0.1,0.1,0.1,0};
			colorDisabled[] = {1,0,0,1};
			colorBackgroundDisabled[] = {0.5,0.5,0.5,0};
			borderSize = 0.015;
			offsetX = 0.005;
			offsetY = 0.005;
			offsetPressedX = 0.002;
			offsetPressedY = 0.002;
			soundClick[] = {"",0,0};
			onMouseButtonDown = "playSound 'button_click'; CODEINPUT = []; ctrlSetText [1099, str CODEINPUT]";
		};
		
		class KeypadImage: RscPicture
		{
			idc = -1;
			moving = 1;
			type = CT_STATIC;
			style = ST_PICTURE;
			x = 0.142156 * safezoneW + safezoneX;
			y = -0.1446 * safezoneH + safezoneY;
			w = 0.721875 * safezoneW;
			h = 1.254 * safezoneH;
			text = "RandFramework\Media\explosive.paa";
		};
		
		class Bblue: RscButton
		{
			idc = -1;
			x = 0.448438 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.020625 * safezoneW;
			h = 0.033 * safezoneH;
			colorBackground[] = {0,0,1,1};
			soundClick[] = {"",0,0};
			onMouseButtonDown = "playSound 'wire_cut'; ['BLUE'] execVM 'RandFramework\CustomMission\GUI\fn_wireCompare.sqf'";
		};
		class Bwhite: RscButton
		{
			idc = -1;
			x = 0.481437 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.020625 * safezoneW;
			h = 0.033 * safezoneH;
			colorBackground[] = {1,1,1,1};
			soundClick[] = {"",0,0};
			onMouseButtonDown = "playSound 'wire_cut'; ['WHITE'] execVM 'RandFramework\CustomMission\GUI\fn_wireCompare.sqf'";
		};
		class Byellow: RscButton
		{
			idc = -1;
			x = 0.521656 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.020625 * safezoneW;
			h = 0.033 * safezoneH;
			colorBackground[] = {1,1,0,1};
			soundClick[] = {"",0,0};
			onMouseButtonDown = "playSound 'wire_cut'; ['YELLOW'] execVM 'RandFramework\CustomMission\GUI\fn_wireCompare.sqf'";
		};
		class Bgreen: RscButton
		{
			idc = -1;
			x = 0.558781 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.020625 * safezoneW;
			h = 0.033 * safezoneH;
			colorBackground[] = {0,1,0,1};
			soundClick[] = {"",0,0};
			onMouseButtonDown = "playSound 'wire_cut'; ['GREEN'] execVM 'RandFramework\CustomMission\GUI\fn_wireCompare.sqf'";
		};
		class NumberDisplay: RscStructuredText
		{
			idc = 1099;
			type = CT_STATIC;
			style = ST_LEFT;
			colorText[] = {0.2,0.4,0,1};
			colorBackground[] = { 1, 1, 1, 0 };
			font = EtelkaNarrowMediumPro;
			sizeEx = 0.072;
			x = 0.474219 * safezoneW + safezoneX;
			y = 0.3258 * safezoneH + safezoneY;
			w = 0.136116 * safezoneW;
			h = 0.1418 * safezoneH;
		};
	};
};