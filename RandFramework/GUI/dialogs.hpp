//shared look of the mission setup dialogs: flat dark panel with a light header (replaces the tablet picture)
class TRGM_RscPanel: RscText
{
	colorBackground[] = {0.09,0.09,0.08,0.94};
};
class TRGM_RscPanelHeader: RscText
{
	colorBackground[] = {0.87,0.85,0.79,1};
};
class TRGM_RscPanelBox: RscText
{
	colorBackground[] = {0.15,0.15,0.13,1};
};
class TRGM_RscAccent: RscText
{
	colorBackground[] = {0.85,0.65,0.13,1};
};
class TRGM_RscDivider: RscText
{
	colorBackground[] = {1,1,1,0.12};
};
class TRGM_RscLogo: RscPicture
{
	style = ST_PICTURE + ST_KEEP_ASPECT_RATIO;
	text = "RandFramework\Media\TRGM7.paa";
};
class TRGM_RscTitle: RscText
{
	style = ST_VCENTER;
	colorText[] = {0.12,0.12,0.11,1};
	shadow = 0;
	font = "PuristaMedium";
	sizeEx = "0.0315 * safezoneH";
};
class TRGM_RscSection: RscText
{
	colorText[] = {0.68,0.66,0.6,1};
	shadow = 0;
	font = "PuristaMedium";
	sizeEx = "0.0139 * safezoneH";
};
class TRGM_RscLabel: RscText
{
	colorText[] = {0.9,0.88,0.82,1};
	shadow = 0;
	sizeEx = "0.0185 * safezoneH";
};
class TRGM_RscHint: RscText
{
	colorText[] = {0.6,0.58,0.53,1};
	shadow = 0;
	sizeEx = "0.0148 * safezoneH";
};
class TRGM_RscButton: RscButton
{
	colorText[] = {0.9,0.88,0.82,1};
	colorBackground[] = {0.2,0.2,0.18,1};
	colorBackgroundActive[] = {0.3,0.3,0.27,1};
	colorFocused[] = {0.2,0.2,0.18,1};
	shadow = 0;
	sizeEx = "0.0194 * safezoneH";
};
class TRGM_RscButtonGold: TRGM_RscButton
{
	colorText[] = {0.08,0.08,0.07,1};
	colorBackground[] = {0.85,0.65,0.13,1};
	colorBackgroundActive[] = {0.95,0.75,0.2,1};
	colorFocused[] = {0.85,0.65,0.13,1};
	font = "PuristaMedium";
	sizeEx = "0.0296 * safezoneH";
};
//font sizes are a share of the screen height (like the positions), so the layout looks the same at every interface size
class TRGM_RscCombo: RscCombo
{
	sizeEx = "0.0176 * safezoneH";
	wholeHeight = "0.3 * safezoneH";
};
class TRGM_RscEdit: RscEdit
{
	sizeEx = "0.0176 * safezoneH";
};
class TRGM_RscStructuredText: RscStructuredText
{
	size = "0.0148 * safezoneH";
};
class TRGM_RscScrollGroup: RscControlsGroup
{
	class VScrollbar: VScrollbar
	{
		color[] = {0.85,0.65,0.13,0.8};
		width = 0.012;
		autoScrollEnabled = 0;
	};
};
class TRGM_RscToolbox: RscToolbox
{
	sizeEx = "0.0185 * safezoneH";
	onToolBoxSelChanged = "[] call TRGM_fnc_missionSetupUpdate; false";
};

class Trend_DialogSetupParams
{
	idd = 5000;
	movingEnabled = false;

	class controls {
		class PanelBack: TRGM_RscPanel
		{
			idc = -1;
			x = 0.2500 * safezoneW + safezoneX;
			y = 0.2185 * safezoneH + safezoneY;
			w = 0.5000 * safezoneW;
			h = 0.6426 * safezoneH;
		};
		class PanelHeader: TRGM_RscPanelHeader
		{
			idc = -1;
			x = 0.2500 * safezoneW + safezoneX;
			y = 0.1389 * safezoneH + safezoneY;
			w = 0.5000 * safezoneW;
			h = 0.0796 * safezoneH;
		};
		class Logo: TRGM_RscLogo
		{
			idc = 5201;
			x = 0.2552 * safezoneW + safezoneX;
			y = 0.1000 * safezoneH + safezoneY;
			w = 0.1042 * safezoneW;
			h = 0.1574 * safezoneH;
		};
		class Title: TRGM_RscTitle
		{
			idc = -1;
			x = 0.3490 * safezoneW + safezoneX;
			y = 0.1574 * safezoneH + safezoneY;
			w = 0.2188 * safezoneW;
			h = 0.0426 * safezoneH;
			text = $STR_TRGM2_Setup_Title;
		};
		class tbMode: TRGM_RscToolbox
		{
			idc = 5910;
			x = 0.5823 * safezoneW + safezoneX;
			y = 0.1574 * safezoneH + safezoneY;
			w = 0.1594 * safezoneW;
			h = 0.0426 * safezoneH;
			strings[] = {$STR_TRGM2_Setup_QuickOp,$STR_TRGM2_Setup_Campaign};
			colorBackground[] = {0.75,0.73,0.67,1};
			colorText[] = {0.12,0.12,0.11,1};
			colorSelectedBg[] = {0.12,0.12,0.11,1};
			colorTextSelect[] = {0.85,0.65,0.13,1};
			colorSelect[] = {0.85,0.65,0.13,1};
			font = "PuristaMedium";
		};
		class lblOperation: TRGM_RscSection
		{
			idc = 5920;
			x = 0.2656 * safezoneW + safezoneX;
			y = 0.2389 * safezoneH + safezoneY;
			w = 0.2135 * safezoneW;
			h = 0.0204 * safezoneH;
			text = $STR_TRGM2_Setup_Operation;
		};
		class tbOperation: TRGM_RscToolbox
		{
			idc = 5911;
			x = 0.2656 * safezoneW + safezoneX;
			y = 0.2630 * safezoneH + safezoneY;
			w = 0.2135 * safezoneW;
			h = 0.0370 * safezoneH;
			strings[] = {$STR_TRGM2_Setup_Assault,$STR_TRGM2_Setup_Patrol};
		};
		class lblSideOps: TRGM_RscSection
		{
			idc = 5921;
			x = 0.2656 * safezoneW + safezoneX;
			y = 0.3148 * safezoneH + safezoneY;
			w = 0.2135 * safezoneW;
			h = 0.0204 * safezoneH;
			text = $STR_TRGM2_Setup_SideOps;
		};
		class tbAssaultSideOps: TRGM_RscToolbox
		{
			idc = 5912;
			x = 0.2656 * safezoneW + safezoneX;
			y = 0.3389 * safezoneH + safezoneY;
			w = 0.2135 * safezoneW;
			h = 0.0370 * safezoneH;
			strings[] = {$STR_TRGM2_Setup_None,$STR_TRGM2_Setup_Two};
		};
		class tbPatrolObjectives: TRGM_RscToolbox
		{
			idc = 5913;
			x = 0.2656 * safezoneW + safezoneX;
			y = 0.3389 * safezoneH + safezoneY;
			w = 0.2135 * safezoneW;
			h = 0.0370 * safezoneH;
			strings[] = {$STR_TRGM2_Setup_One,$STR_TRGM2_Setup_Three};
		};
		class lblIntel: TRGM_RscSection
		{
			idc = 5922;
			x = 0.2656 * safezoneW + safezoneX;
			y = 0.3907 * safezoneH + safezoneY;
			w = 0.2135 * safezoneW;
			h = 0.0204 * safezoneH;
			text = $STR_TRGM2_Setup_Intel;
		};
		class tbAssaultIntel: TRGM_RscToolbox
		{
			idc = 5914;
			x = 0.2656 * safezoneW + safezoneX;
			y = 0.4148 * safezoneH + safezoneY;
			w = 0.2135 * safezoneW;
			h = 0.0778 * safezoneH;
			rows = 2;
			columns = 2;
			strings[] = {$STR_TRGM2_Setup_AllMarked,$STR_TRGM2_Setup_SideOpsHidden,$STR_TRGM2_Setup_FindAO,$STR_TRGM2_Setup_FullMap};
		};
		class tbPatrolIntel: TRGM_RscToolbox
		{
			idc = 5915;
			x = 0.2656 * safezoneW + safezoneX;
			y = 0.4148 * safezoneH + safezoneY;
			w = 0.2135 * safezoneW;
			h = 0.0370 * safezoneH;
			strings[] = {$STR_TRGM2_Setup_AllMarked,$STR_TRGM2_Setup_Hidden};
		};
		class cbTwoObjectives: RscCheckBox
		{
			idc = 5916;
			x = 0.2656 * safezoneW + safezoneX;
			y = 0.5074 * safezoneH + safezoneY;
			w = 0.0135 * safezoneW;
			h = 0.0241 * safezoneH;
			onCheckedChanged = "[] call TRGM_fnc_missionSetupUpdate; false";
		};
		class lblTwoObjectives: TRGM_RscLabel
		{
			idc = 5917;
			x = 0.2833 * safezoneW + safezoneX;
			y = 0.5074 * safezoneH + safezoneY;
			w = 0.1958 * safezoneW;
			h = 0.0241 * safezoneH;
			text = $STR_TRGM2_Setup_TwoObjectives;
		};
		class lblObjective: TRGM_RscSection
		{
			idc = 5002;
			x = 0.2656 * safezoneW + safezoneX;
			y = 0.5463 * safezoneH + safezoneY;
			w = 0.2135 * safezoneW;
			h = 0.0204 * safezoneH;
			text = $STR_TRGM2_dialogs_Objective;
		};
		class cbObjective1: TRGM_RscCombo
		{
			idc = 5104;
			x = 0.2656 * safezoneW + safezoneX;
			y = 0.5704 * safezoneH + safezoneY;
			w = 0.2135 * safezoneW;
			h = 0.0278 * safezoneH;
		};
		class cbObjective2: TRGM_RscCombo
		{
			idc = 7001;
			x = 0.2656 * safezoneW + safezoneX;
			y = 0.5704 * safezoneH + safezoneY;
			w = 0.2135 * safezoneW;
			h = 0.0278 * safezoneH;
		};
		class cbObjective3: TRGM_RscCombo
		{
			idc = 7002;
			x = 0.2656 * safezoneW + safezoneX;
			y = 0.5704 * safezoneH + safezoneY;
			w = 0.2135 * safezoneW;
			h = 0.0278 * safezoneH;
		};
		class BriefingBack: TRGM_RscPanelBox
		{
			idc = -1;
			x = 0.4948 * safezoneW + safezoneX;
			y = 0.2389 * safezoneH + safezoneY;
			w = 0.2396 * safezoneW;
			h = 0.3593 * safezoneH;
		};
		class BriefingAccent: TRGM_RscAccent
		{
			idc = -1;
			x = 0.4948 * safezoneW + safezoneX;
			y = 0.2389 * safezoneH + safezoneY;
			w = 0.0021 * safezoneW;
			h = 0.3593 * safezoneH;
		};
		class lblBriefing: TRGM_RscSection
		{
			idc = -1;
			x = 0.5073 * safezoneW + safezoneX;
			y = 0.2537 * safezoneH + safezoneY;
			w = 0.2146 * safezoneW;
			h = 0.0204 * safezoneH;
			text = $STR_TRGM2_Setup_Briefing;
		};
		class txtBriefingTitle: TRGM_RscTitle
		{
			idc = 5932;
			x = 0.5073 * safezoneW + safezoneX;
			y = 0.2778 * safezoneH + safezoneY;
			w = 0.2146 * safezoneW;
			h = 0.0593 * safezoneH;
			style = ST_MULTI;
			lineSpacing = 1;
			colorText[] = {0.95,0.93,0.87,1};
			sizeEx = "0.0241 * safezoneH";
		};
		class grpBriefing: TRGM_RscScrollGroup
		{
			idc = 5935;
			x = 0.5073 * safezoneW + safezoneX;
			y = 0.3444 * safezoneH + safezoneY;
			w = 0.2146 * safezoneW;
			h = 0.2426 * safezoneH;
			class controls
			{
				class txtBriefing: TRGM_RscLabel
				{
					idc = 5001;
					x = 0;
					y = 0;
					w = "0.2146 * safezoneW - 0.02";
					h = "0.2426 * safezoneH";
					style = ST_MULTI;
					lineSpacing = 1;
					colorText[] = {0.8,0.78,0.72,1};
					sizeEx = "0.0167 * safezoneH";
				};
			};
		};
		class Divider: TRGM_RscDivider
		{
			idc = -1;
			x = 0.2656 * safezoneW + safezoneX;
			y = 0.6148 * safezoneH + safezoneY;
			w = 0.4688 * safezoneW;
			h = 0.0019 * safezoneH;
		};
		class lblConditions: TRGM_RscSection
		{
			idc = -1;
			x = 0.2656 * safezoneW + safezoneX;
			y = 0.6259 * safezoneH + safezoneY;
			w = 0.2083 * safezoneW;
			h = 0.0204 * safezoneH;
			text = $STR_TRGM2_Setup_Conditions;
		};
		class lblCondition0: TRGM_RscHint
		{
			idc = 5005;
			x = 0.2656 * safezoneW + safezoneX;
			y = 0.6500 * safezoneH + safezoneY;
			w = 0.0885 * safezoneW;
			h = 0.0204 * safezoneH;
			text = $STR_TRGM2_dialogs_Weather;
		};
		class cbCondition0: TRGM_RscCombo
		{
			idc = 5101;
			x = 0.2656 * safezoneW + safezoneX;
			y = 0.6722 * safezoneH + safezoneY;
			w = 0.0885 * safezoneW;
			h = 0.0278 * safezoneH;
		};
		class lblCondition1: TRGM_RscHint
		{
			idc = 5006;
			x = 0.3604 * safezoneW + safezoneX;
			y = 0.6500 * safezoneH + safezoneY;
			w = 0.0885 * safezoneW;
			h = 0.0204 * safezoneH;
			text = $STR_TRGM2_dialogs_NVG;
		};
		class cbCondition1: TRGM_RscCombo
		{
			idc = 5102;
			x = 0.3604 * safezoneW + safezoneX;
			y = 0.6722 * safezoneH + safezoneY;
			w = 0.0885 * safezoneW;
			h = 0.0278 * safezoneH;
		};
		class lblCondition2: TRGM_RscHint
		{
			idc = 5007;
			x = 0.4552 * safezoneW + safezoneX;
			y = 0.6500 * safezoneH + safezoneY;
			w = 0.0885 * safezoneW;
			h = 0.0204 * safezoneH;
			text = $STR_TRGM2_dialogs_Revive;
		};
		class cbCondition2: TRGM_RscCombo
		{
			idc = 5103;
			x = 0.4552 * safezoneW + safezoneX;
			y = 0.6722 * safezoneH + safezoneY;
			w = 0.0885 * safezoneW;
			h = 0.0278 * safezoneH;
		};
		class lblCondition3: TRGM_RscHint
		{
			idc = 1012;
			x = 0.5500 * safezoneW + safezoneX;
			y = 0.6500 * safezoneH + safezoneY;
			w = 0.0885 * safezoneW;
			h = 0.0204 * safezoneH;
			text = $STR_TRGM2_dialogs_StartLocation;
			tooltip = $STR_TRGM2_dialogs_StartLocation_HelpText;
		};
		class cbCondition3: TRGM_RscCombo
		{
			idc = 2105;
			x = 0.5500 * safezoneW + safezoneX;
			y = 0.6722 * safezoneH + safezoneY;
			w = 0.0885 * safezoneW;
			h = 0.0278 * safezoneH;
			tooltip = $STR_TRGM2_dialogs_StartLocation_HelpText;
		};
		class lblCondition4: TRGM_RscHint
		{
			idc = 5004;
			x = 0.6448 * safezoneW + safezoneX;
			y = 0.6500 * safezoneH + safezoneY;
			w = 0.0885 * safezoneW;
			h = 0.0204 * safezoneH;
			text = $STR_TRGM2_dialogs_HardcoreReputation;
			tooltip = $STR_TRGM2_dialogs_HardcoreReputation_HelpText;
		};
		class cbCondition4: TRGM_RscCombo
		{
			idc = 5100;
			x = 0.6448 * safezoneW + safezoneX;
			y = 0.6722 * safezoneH + safezoneY;
			w = 0.0885 * safezoneW;
			h = 0.0278 * safezoneH;
			tooltip = $STR_TRGM2_dialogs_HardcoreReputation_HelpText;
		};
		class btnAdvanced: TRGM_RscButton
		{
			idc = 1603;
			x = 0.2656 * safezoneW + safezoneX;
			y = 0.7685 * safezoneH + safezoneY;
			w = 0.1198 * safezoneW;
			h = 0.0519 * safezoneH;
			text = $STR_TRGM2_Setup_MoreSettings;
			action = "[] execVM 'RandFramework\GUI\openDialogAdvancedMissionSettings.sqf'; false";
		};
		class btnLoadLocalSave: TRGM_RscButton
		{
			idc = 1601;
			x = 0.3958 * safezoneW + safezoneX;
			y = 0.7685 * safezoneH + safezoneY;
			w = 0.1146 * safezoneW;
			h = 0.0241 * safezoneH;
			text = $STR_TRGM2_dialogs_LoadLocal;
			tooltip = $STR_TRGM2_dialogs_LoadLocal_HelpText;
			action = "[_this,1] execVM 'RandFramework\GUI\SetParamsAndBegin.sqf'; false";
		};
		class btnLoadglobalSave: TRGM_RscButton
		{
			idc = 1602;
			x = 0.3958 * safezoneW + safezoneX;
			y = 0.7963 * safezoneH + safezoneY;
			w = 0.1146 * safezoneW;
			h = 0.0241 * safezoneH;
			text = $STR_TRGM2_dialogs_LoadGlobal;
			tooltip = $STR_TRGM2_dialogs_LoadGlobal_HelpText;
			action = "[_this,2] execVM 'RandFramework\GUI\SetParamsAndBegin.sqf'; false";
		};
		class txtWebsite: TRGM_RscStructuredText
		{
			idc = 7003;
			x = 0.3958 * safezoneW + safezoneX;
			y = 0.8259 * safezoneH + safezoneY;
			w = 0.2083 * safezoneW;
			h = 0.0241 * safezoneH;
			text = "<t color='#99958a'><a href='http://www.trgm2.com'>trgm2.com</a> - help, features and donations</t>";
		};
		class btnBegin: TRGM_RscButtonGold
		{
			idc = 5600;
			x = 0.6094 * safezoneW + safezoneX;
			y = 0.7685 * safezoneH + safezoneY;
			w = 0.1250 * safezoneW;
			h = 0.0648 * safezoneH;
			text = $STR_TRGM2_dialogs_Begin;
			action = "[_this] execVM 'RandFramework\GUI\SetParamsAndBegin.sqf'; false";
		};
	};
};


class Trend_DialogSetupParamsAdvanced
{
	idd = 6000;
	movingEnabled = false;

	class controls {
		class PanelBack: TRGM_RscPanel
		{
			idc = -1;
			x = 0.2500 * safezoneW + safezoneX;
			y = 0.2185 * safezoneH + safezoneY;
			w = 0.5000 * safezoneW;
			h = 0.6426 * safezoneH;
		};
		class PanelHeader: TRGM_RscPanelHeader
		{
			idc = -1;
			x = 0.2500 * safezoneW + safezoneX;
			y = 0.1389 * safezoneH + safezoneY;
			w = 0.5000 * safezoneW;
			h = 0.0796 * safezoneH;
		};
		class Logo: TRGM_RscLogo
		{
			idc = 5201;
			x = 0.2552 * safezoneW + safezoneX;
			y = 0.1000 * safezoneH + safezoneY;
			w = 0.1042 * safezoneW;
			h = 0.1574 * safezoneH;
		};
		class Title: TRGM_RscTitle
		{
			idc = -1;
			x = 0.3490 * safezoneW + safezoneX;
			y = 0.1574 * safezoneH + safezoneY;
			w = 0.2188 * safezoneW;
			h = 0.0426 * safezoneH;
			text = $STR_TRGM2_Setup_MoreTitle;
		};
		class btnCustomEnemy: TRGM_RscButton
		{
			idc = 6998;
			x = 0.5417 * safezoneW + safezoneX;
			y = 0.1574 * safezoneH + safezoneY;
			w = 0.0990 * safezoneW;
			h = 0.0426 * safezoneH;
			text = $STR_TRGM2_openDialogAdvancedMissionSettings_CustomEnemy;
			action = "[] call TRGM_fnc_readAdvancedSettings; [] execVM 'RandFramework\GUI\openDialogEnemyFaction.sqf'; false";
		};
		class btnCustomLoadouts: TRGM_RscButton
		{
			idc = 6997;
			x = 0.6427 * safezoneW + safezoneX;
			y = 0.1574 * safezoneH + safezoneY;
			w = 0.0990 * safezoneW;
			h = 0.0426 * safezoneH;
			text = $STR_TRGM2_openDialogAdvancedMissionSettings_CustomLoadouts;
			action = "[] call TRGM_fnc_readAdvancedSettings; [] execVM 'RandFramework\GUI\openDialogTeamLoadouts.sqf'; false";
		};
		class lblGroupFactions: TRGM_RscSection
		{
			idc = -1;
			x = 0.2656 * safezoneW + safezoneX;
			y = 0.2389 * safezoneH + safezoneY;
			w = 0.2188 * safezoneW;
			h = 0.0204 * safezoneH;
			text = $STR_TRGM2_Setup_GroupFactions;
		};
		class lblGroupRespawn: TRGM_RscSection
		{
			idc = -1;
			x = 0.5052 * safezoneW + safezoneX;
			y = 0.2389 * safezoneH + safezoneY;
			w = 0.2188 * safezoneW;
			h = 0.0204 * safezoneH;
			text = $STR_TRGM2_Setup_GroupRespawn;
		};
		class lblGroupSupport: TRGM_RscSection
		{
			idc = -1;
			x = 0.2656 * safezoneW + safezoneX;
			y = 0.4889 * safezoneH + safezoneY;
			w = 0.2188 * safezoneW;
			h = 0.0204 * safezoneH;
			text = $STR_TRGM2_Setup_GroupSupport;
		};
		class lblGroupWorld: TRGM_RscSection
		{
			idc = -1;
			x = 0.5052 * safezoneW + safezoneX;
			y = 0.4889 * safezoneH + safezoneY;
			w = 0.2188 * safezoneW;
			h = 0.0204 * safezoneH;
			text = $STR_TRGM2_Setup_GroupWorld;
		};
		class btnBack: TRGM_RscButton
		{
			idc = 6903;
			x = 0.2656 * safezoneW + safezoneX;
			y = 0.7685 * safezoneH + safezoneY;
			w = 0.1198 * safezoneW;
			h = 0.0519 * safezoneH;
			text = $STR_TRGM2_dialogs_Back;
			action = "[] execVM 'RandFramework\GUI\openDialogMissionSelection.sqf'; false";
		};
		class lblHoverHelp: TRGM_RscHint
		{
			idc = -1;
			x = 0.3958 * safezoneW + safezoneX;
			y = 0.7824 * safezoneH + safezoneY;
			w = 0.1979 * safezoneW;
			h = 0.0241 * safezoneH;
			text = $STR_TRGM2_Setup_HoverHelp;
		};
		class btnBegin: TRGM_RscButtonGold
		{
			idc = 6904;
			x = 0.6094 * safezoneW + safezoneX;
			y = 0.7685 * safezoneH + safezoneY;
			w = 0.1250 * safezoneW;
			h = 0.0648 * safezoneH;
			text = $STR_TRGM2_dialogs_Begin;
			action = "[] call TRGM_fnc_readAdvancedSettings; [_this] execVM 'RandFramework\GUI\SetParamsAndBegin.sqf'; false";
		};
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

		class PanelBack: TRGM_RscPanel
		{
			idc = 7901;
			x = 0.2500 * safezoneW + safezoneX;
			y = 0.2185 * safezoneH + safezoneY;
			w = 0.5000 * safezoneW;
			h = 0.6426 * safezoneH;
		};
		class PanelHeader: TRGM_RscPanelHeader
		{
			idc = -1;
			x = 0.2500 * safezoneW + safezoneX;
			y = 0.1389 * safezoneH + safezoneY;
			w = 0.5000 * safezoneW;
			h = 0.0796 * safezoneH;
		};
		class Logo: TRGM_RscLogo
		{
			idc = -1;
			x = 0.2552 * safezoneW + safezoneX;
			y = 0.1000 * safezoneH + safezoneY;
			w = 0.1042 * safezoneW;
			h = 0.1574 * safezoneH;
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