disableSerialization;


[] call TRGM_fnc_readAdvancedSettings;


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