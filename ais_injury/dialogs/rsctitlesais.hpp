class RscDeadQuote {
	onload = "uinamespace setvariable ['tcb_ais_title',_this select 0];";
	idd = 1792;
	movingEnable = false;
	moving = false;
	duration=10e10;
	enableSimulation = true;
	controlsBackground[] = {};
	objects[] = {};
	controls[] = {QuoteStructuredText,HeaderDeath};

	class HeaderDeath {
		idc = -1;
		type = 13;
		style = 0x00;
		colorBackground[] = {1, 1, 1, 0};
		colorText[] = {1, 0.0, 0.0, 1};
		x = safezoneX + 0.3 * safezoneW;
		y = safezoneY + 0.045 * safezoneW;
		w = 1;
		h = 0.6;
		size = 0.08;
		text = "You are dead.";
		class Attributes {
			font = "PuristaMedium";
			color = "#CC0000";
			align = "center";
			valign = "middle";
			shadow = false;
			shadowColor = "#ff0000";
			size = "1.6";
		};
	};
	class QuoteStructuredText {
		idc = 1793;
		type = 13;
		style = 0x00;
		colorBackground[] = { 1, 1, 1, 0 };
		colorText[] = {1,1,1,1};
		x = safezoneX + 0.3 * safezoneW;
		y = safezoneY + 0.67 * safezoneW;
		w = 1;
		h = 0.6;
		size = 0.02;
		text = "";
		class Attributes {
			font = "PuristaMedium";
			color = "#000000";
			align = "center";
			valign = "middle";
			shadow = false;
			shadowColor = "#ff0000";
			size = "1.6";
		};
	};
};
	
class ais_ProgressBar {
	idd = -1;
	movingEnable = 0;
	objects[] = {};
	duration = 1e+011;
	name = "ais_ProgressBar";
	onload = "_this call tcb_fnc_progressBarInit;";

	class controlsBackground {
		class mpsf_progressbar_background {
			idc = 0;
			x = "0.298906 * safezoneW + safezoneX";
			y = "0.082 * safezoneH + safezoneY";
			w = "0.407344 * safezoneW";
			h = "0.011 * safezoneH";
			type = 0;
			style = 0;
			shadow = 0;
			colorShadow[] = {0,0,0,0.5};
			font = "PuristaMedium";
			SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			text = "";
			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0.7};
			linespacing = 1;
		};
	};
	class controls {
		class mpsf_progressbar_foreground {
			idc = 1;
			x = "0.298906 * safezoneW + safezoneX";
			y = "0.082 * safezoneH + safezoneY";
			w = "0.001 * safezoneW";
			h = "0.011 * safezoneH";
			type = 0;
			style = 0;
			shadow = 0;
			colorShadow[] = {0,0,0,0.5};
			font = "PuristaMedium";
			SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			text = "";
			colorText[] = {1,1,1,1};
			colorBackground[] = {0.6784, 0.7490, 0.5137, 0.7};
			linespacing = 1;
		};
		class mpsf_progressbar_text {
			idc = 2;
			type = 13;
			style = 0x00;
			colorBackground[] = {0,0,0,0};
			x = "0.298906 * safezoneW + safezoneX";
			y = "0.093 * safezoneH + safezoneY";
			w = "0.407344 * safezoneW";
			h = "0.022 * safezoneH";	
			text = "";
			size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			colorText[] = {0, 0, 0, 1};
			class Attributes {
				font = "EtelkaMonospaceProBold";
				color = "#FFFFFF";
				align = "left";
				valign = "middle";
				shadow = 1;
				shadowColor = "#000000";
				//size = "2.25";
			};
		};
	};
};