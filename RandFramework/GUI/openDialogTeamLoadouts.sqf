#include "..\..\setUnitGlobalVars.sqf";
disableSerialization;


if (!isNull (findDisplay 6000)) then {
	AdvancedSettings = [];
	{
		_CurrentControl = _x;
		_lnpCtrlType = _x select 2;
		_ThisControlOptions = (_x select 4);
		_ThisControlIDX = (_x select 0) + 1;
		_ctrlItem = (findDisplay 6000) displayCtrl _ThisControlIDX;
		debugMessages = debugMessages + "\n\n" + str(lbCurSel _ctrlItem);
		publicVariable "debugMessages";
		_value = nil;
		if (_lnpCtrlType == "RscCombo") then {
			debugMessages = debugMessages + "\n\nHERE:" + str(lbCurSel _ctrlItem);
			_value = _ThisControlOptions select (lbCurSel _ctrlItem);
		};
		if (_lnpCtrlType == "RscEdit") then {
			_value = ctrlText _ThisControlIDX;
		};
		AdvancedSettings pushBack _value;
	} forEach AdvControls;
	publicVariable "AdvancedSettings";

	//_ctrlItem = (findDisplay 6000) displayCtrl 5500;
	//iMissionParamType = MissionParamTypesValues select lbCurSel _ctrlItem;
	//publicVariable "iMissionParamType";
};

//hint "opening 2dialogA";

closedialog 0;

sleep 0.1;

createDialog "Trend_DialogSetupEnemyFaction";
waitUntil {!isNull (findDisplay 7000);};

_display = findDisplay 7000;
_lineHeight = 0.03;

_display ctrlCreate ["RscText", 7999];
_lblctrlTitle = _display displayCtrl 7999;
_lblctrlTitle ctrlSetPosition [0.3 * safezoneW + safezoneX, (0.25 + 0) * safezoneH + safezoneY,1 * safezoneW,0.02 * safezoneH];
ctrlSetText [7999,  localize "STR_TRGM2_openDialogTeamLoadouts_SetLoadout"];
_lblctrlTitle ctrlCommit 0;

_display ctrlCreate ["RscEditMulti", 7998];
_lblctrlData = _display displayCtrl 7998;
_lblctrlData ctrlSetPosition [0.3 * safezoneW + safezoneX, (0.30 + 0) * safezoneH + safezoneY,0.18 * safezoneW,0.40 * safezoneH];
_lblctrlData ctrlCommit 0;
ctrlSetText [7998,  LoadoutData];


_display ctrlCreate ["RscTextMulti", 7996];
_lblctrlMessage = _display displayCtrl 7996;
_lblctrlMessage ctrlSetPosition [0.5 * safezoneW + safezoneX, (0.50 + 0) * safezoneH + safezoneY,0.18 * safezoneW,0.20 * safezoneH];
_lblctrlMessage ctrlCommit 0;
ctrlSetText [7996,  ""];

_display ctrlCreate ["RscTextMulti", 7995];
_lblctrlMessage = _display displayCtrl 7995;
_lblctrlMessage ctrlSetPosition [0.5 * safezoneW + safezoneX, (0.30 + 0) * safezoneH + safezoneY,0.18 * safezoneW,0.40 * safezoneH];
_lblctrlMessage ctrlCommit 0;
ctrlSetText [7995,  localize "STR_TRGM2_openDialogTeamLoadouts_URL"];


_display ctrlCreate ["RscButton", 7997];
_btnSetEnemyFaction = _display displayCtrl 7997;
_btnSetEnemyFaction ctrlSetPosition [0.5 * safezoneW + safezoneX, (0.72 + 0) * safezoneH + safezoneY,0.06 * safezoneW,0.02 * safezoneH];
ctrlSetText [7997,  localize "STR_TRGM2_openDialogEnemyFaction_SaveAndBack"];
_btnSetEnemyFaction ctrlAddEventHandler ["ButtonClick", {
	//LOADENEMYFACTION
	_TempLoadoutData = ctrlText 7998;
	if (_TempLoadoutData != "") then {
		_errorMessage = "";
		_Roles = _TempLoadoutData splitString "#";
		{
			_RoleDetails = _TempLoadoutData splitString ":";
			_roleType = _RoleDetails select 0;
			_loadoutoptions = (_RoleDetails select 1) splitString ";";
			if (count _loadoutoptions == 0) then {
				_errorMessage = localize "STR_TRGM2_openDialogTeamLoadouts_ErrorMsg_SetNotCorrectly";
			};

		} forEach _Roles;
		if (_errorMessage != "") then {
			ctrlSetText [7996,  _errorMessage];
		}
		else {
			LoadoutData = _TempLoadoutData;
			[] execVM 'RandFramework\GUI\openDialogAdvancedMissionSettings.sqf'; false;
		};
	}
	else {
		LoadoutData = "";
		[] execVM 'RandFramework\GUI\openDialogAdvancedMissionSettings.sqf'; false;
	};
}];
_btnSetEnemyFaction ctrlCommit 0;