disableSerialization;

if (!isNull (findDisplay 5000)) then {
	[] call TRGM_fnc_readMainParams;
};


closedialog 0;

sleep 0.1;

createDialog "Trend_DialogSetupParamsAdvanced";
waitUntil {!isNull (findDisplay 6000);};

_display = findDisplay 6000;

//where each setting goes: [label idc, column (0 left, 1 right), group (0 top, 1 bottom), row]
//(top left: factions & loadouts, top right: respawn, bottom left: support & map, bottom right: world & enemy)
_layout = [
	[6013,0,0,0], [6015,0,0,1], [6001,0,0,2], [6003,0,0,3],
	[6007,1,0,0], [6011,1,0,1], [6019,1,0,2],
	[6005,0,1,0], [6009,0,1,1], [6021,0,1,2], [6023,0,1,3],
	[6017,1,1,0], [6025,1,1,1], [6027,1,1,2], [6029,1,1,3]
];
_fnc_x = {(_this / 1920) * safezoneW + safezoneX};
_fnc_y = {(_this / 1080) * safezoneH + safezoneY};

{
	_x params ["_lblCtrlID", "_lblText", "_lnpCtrlType", "_Options", "_Values", "_DefaultSelIndex", "_toolTip"];
	_InpCtrlID = _lblCtrlID + 1;

	_layoutIndex = _layout findIf {(_x select 0) == _lblCtrlID};
	_place = [_lblCtrlID, 1, 0, 3]; //a new setting without a layout entry: free slot under respawn
	if (_layoutIndex >= 0) then {_place = _layout select _layoutIndex;};
	_place params ["", "_column", "_group", "_row"];
	_rowY = ([292, 562] select _group) + _row * 50;
	_labelX = [510, 970] select _column;

	_display ctrlCreate ["TRGM_RscLabel", _lblCtrlID];
	_lblctrl = _display displayCtrl _lblCtrlID;
	_lblctrl ctrlSetPosition [_labelX call _fnc_x, _rowY call _fnc_y, (195 / 1920) * safezoneW, (30 / 1080) * safezoneH];
	_lblctrl ctrlSetText _lblText;
	_lblctrl ctrlSetTooltip _toolTip;
	_lblctrl ctrlCommit 0;

	_display ctrlCreate ["TRGM_" + _lnpCtrlType, _InpCtrlID]; //TRGM_RscCombo / TRGM_RscEdit: same font size as the rest of the page
	_inpctrl = _display displayCtrl _InpCtrlID;
	_inpctrl ctrlSetPosition [(_labelX + 200) call _fnc_x, _rowY call _fnc_y, (220 / 1920) * safezoneW, (30 / 1080) * safezoneH];

	if (_lnpCtrlType == "RscCombo") then {
		{
			_inpctrl lbAdd _x;
		} forEach _Options;
		_inpctrl lbSetCurSel ((_Values find (AdvancedSettings select _forEachIndex)) max 0);
	};
	if (_lnpCtrlType == "RscEdit") then {
		_inpctrl ctrlSetText (AdvancedSettings select _forEachIndex);
	};
	_inpctrl ctrlCommit 0;
	_inpctrl ctrlSetTooltip _toolTip;

} forEach AdvControls;

//custom enemy classnames / team loadouts in use (these replace the faction choices above)
{
	_x params ["_idc", "_inUse", "_textKey", "_rowY"];
	if (_inUse) then {
		_display ctrlCreate ["TRGM_RscLabel", _idc];
		_lblctrlWarn = _display displayCtrl _idc;
		_lblctrlWarn ctrlSetPosition [510 call _fnc_x, _rowY call _fnc_y, (900 / 1920) * safezoneW, (24 / 1080) * safezoneH];
		_lblctrlWarn ctrlSetTextColor [1, 0.35, 0.3, 1];
		_lblctrlWarn ctrlSetText (localize _textKey);
		_lblctrlWarn ctrlCommit 0;
	};
} forEach [
	[6996, EnemyFactionData != "", "STR_TRGM2_openDialogAdvancedMissionSettings_CustomEnemy_Hint", 768],
	[6995, LoadoutData != "", "STR_TRGM2_openDialogAdvancedMissionSettings_CustomFriend_Hint", 794]
];
