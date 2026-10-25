//Mission setup dialog (display 5000): turns the operation / side ops / intel / two objectives choices into one of the
//mission types (iMissionParamType) and updates the page to match. Called by every choice's event handler (unscheduled).
//_fromType: set the choices from iMissionParamType first (used when the dialog opens)
params [["_fromType", false]];

disableSerialization;
private _display = findDisplay 5000;
if (isNull _display) exitWith {};
if (!isNil "TRGM_setupUpdating") exitWith {}; //selecting a control below can fire its event handler again
TRGM_setupUpdating = true;

private _ctrlMode = _display displayCtrl 5910;
private _ctrlOperation = _display displayCtrl 5911;
private _ctrlAssaultSideOps = _display displayCtrl 5912;
private _ctrlPatrolObjectives = _display displayCtrl 5913;
private _ctrlAssaultIntel = _display displayCtrl 5914;
private _ctrlPatrolIntel = _display displayCtrl 5915;
private _ctrlTwoObjectives = _display displayCtrl 5916;

//[mode (0 quick op, 1 campaign), operation (0 assault, 1 patrol), assault side ops (0 none, 1 two),
// assault intel (0 all marked, 1 side ops hidden, 2 find AO via intel, 3 full map), patrol objectives (0 one, 1 three),
// patrol intel (0 marked, 1 hidden), two objectives in the AO]
private _state = [];
if (_fromType) then {
	_state = switch (iMissionParamType) do {
		case 0: {[0,0,1,0,0,0,false]};
		case 6: {[0,0,1,1,0,0,false]};
		case 8: {[0,0,1,0,0,0,true]};
		case 1: {[0,0,1,2,0,0,false]};
		case 2: {[0,0,0,0,0,0,false]};
		case 10: {[0,0,0,3,0,0,false]};
		case 3: {[0,1,1,0,0,0,false]};
		case 9: {[0,1,1,0,0,0,true]};
		case 4: {[0,1,1,0,1,0,false]};
		case 7: {[0,1,1,0,1,1,false]};
		case 5: {[1,0,1,0,0,0,false]};
		default {[0,0,1,0,0,0,false]};
	};
}
else {
	private _old = missionNamespace getVariable ["TRGM_setupState", [0,0,1,0,0,0,false]];
	_state = [lbCurSel _ctrlMode, lbCurSel _ctrlOperation, lbCurSel _ctrlAssaultSideOps, lbCurSel _ctrlAssaultIntel, lbCurSel _ctrlPatrolObjectives, lbCurSel _ctrlPatrolIntel, cbChecked _ctrlTwoObjectives];
	{
		if (_x < 0) then {_state set [_forEachIndex, _old select _forEachIndex];};
	} forEach (_state select [0, 6]);

	//the choice the player just made wins, the others are adjusted so the combination is a real mission type
	_state params ["", "_operation", "_assaultSideOps", "_assaultIntel", "_patrolObjectives", "_patrolIntel", "_twoObjectives"];
	private _changed = {!((_state select _this) isEqualTo (_old select _this))};
	if (_operation == 0) then {
		if (2 call _changed) then {
			if (_assaultSideOps == 0 && _assaultIntel in [1,2]) then {_state set [3, 0];}; //hidden side ops / intel from side ops need side ops
			if (_assaultSideOps == 1 && _assaultIntel == 3) then {_state set [3, 0];}; //full map has no side ops
			if (_assaultSideOps == 0) then {_state set [6, false];};
		};
		if (3 call _changed) then {
			if (_assaultIntel in [1,2]) then {_state set [2, 1]; _state set [6, false];};
			if (_assaultIntel == 3) then {_state set [2, 0]; _state set [6, false];};
		};
		if ((6 call _changed) && _twoObjectives) then {_state set [2, 1]; _state set [3, 0];};
	}
	else {
		if (4 call _changed) then {
			if (_patrolObjectives == 0) then {_state set [5, 0];}; //a single objective is always marked
			if (_patrolObjectives == 1) then {_state set [6, false];};
		};
		if ((5 call _changed) && _patrolIntel == 1) then {_state set [4, 1]; _state set [6, false];};
		if ((6 call _changed) && _twoObjectives) then {_state set [4, 0]; _state set [5, 0];};
	};
};
TRGM_setupState = _state;
_state params ["_mode", "_operation", "_assaultSideOps", "_assaultIntel", "_patrolObjectives", "_patrolIntel", "_twoObjectives"];

{
	_x params ["_ctrl", "_index"];
	if (lbCurSel _ctrl != _index) then {_ctrl lbSetCurSel _index;};
} forEach [[_ctrlMode,_mode],[_ctrlOperation,_operation],[_ctrlAssaultSideOps,_assaultSideOps],[_ctrlAssaultIntel,_assaultIntel],[_ctrlPatrolObjectives,_patrolObjectives],[_ctrlPatrolIntel,_patrolIntel]];
if !((cbChecked _ctrlTwoObjectives) isEqualTo _twoObjectives) then {_ctrlTwoObjectives cbSetChecked _twoObjectives;};

//the mission type these choices make
iMissionParamType = call {
	if (_mode == 1) exitWith {5};
	if (_operation == 0) exitWith {
		if (_twoObjectives) exitWith {8};
		[[2,0],[6,6],[1,1],[10,10]] select _assaultIntel select _assaultSideOps
	};
	if (_twoObjectives) exitWith {9};
	[[3,3],[4,7]] select _patrolObjectives select _patrolIntel
};

//only show the rows for the chosen operation (none for a campaign)
private _isQuickOp = _mode == 0;
{_x ctrlShow _isQuickOp;} forEach [_display displayCtrl 5920, _ctrlOperation, _display displayCtrl 5921, _display displayCtrl 5922, _ctrlTwoObjectives, _display displayCtrl 5917];
{_x ctrlShow (_isQuickOp && _operation == 0);} forEach [_ctrlAssaultSideOps, _ctrlAssaultIntel];
{_x ctrlShow (_isQuickOp && _operation == 1);} forEach [_ctrlPatrolObjectives, _ctrlPatrolIntel];
(_display displayCtrl 5921) ctrlSetText localize (["STR_TRGM2_Setup_SideOps", "STR_TRGM2_Setup_Objectives"] select (_operation == 1));
//the patrol intel row is one line shorter, keep the checkbox right under it
{
	(ctrlPosition _x) params ["_cbX", "", "_cbW", "_cbH"];
	_x ctrlSetPosition [_cbX, ([548, 504] select (_operation == 1)) / 1080 * safezoneH + safezoneY, _cbW, _cbH];
	_x ctrlCommit 0;
} forEach [_ctrlTwoObjectives, _display displayCtrl 5917];

//briefing preview
private _typeIndex = MissionParamTypesValues find iMissionParamType;
(_display displayCtrl 5932) ctrlSetText (MissionParamTypes select _typeIndex);
private _ctrlDescription = _display displayCtrl 5001; //inside a scrolling group: make it as tall as its text
_ctrlDescription ctrlSetText (MissionTypeDescriptions select _typeIndex);
(ctrlPosition _ctrlDescription) params ["", "", "_descriptionW"];
_ctrlDescription ctrlSetPosition [0, 0, _descriptionW, (ctrlTextHeight _ctrlDescription) max (0.2426 * safezoneH)];
_ctrlDescription ctrlCommit 0;

//objective combos: side op objectives for assaults with side ops, the other objectives for patrols with more than one
private _objectiveCount = call {
	if (iMissionParamType in [0,6,4,7]) exitWith {3};
	if (iMissionParamType in [8,9]) exitWith {2};
	1
};
private _objectiveCtrls = [_display displayCtrl 5104, _display displayCtrl 7001, _display displayCtrl 7002];
//a campaign has no operation rows, so its objective goes to the top of the column
(ctrlPosition (_objectiveCtrls select 0)) params ["_objX", "", "", "_objH"];
private _objY = ([616, 284] select (_mode == 1)) / 1080 * safezoneH + safezoneY;
private _ctrlObjectiveLabel = _display displayCtrl 5002;
(ctrlPosition _ctrlObjectiveLabel) params ["_lblX", "", "_lblW", "_lblH"];
_ctrlObjectiveLabel ctrlSetPosition [_lblX, ([590, 258] select (_mode == 1)) / 1080 * safezoneH + safezoneY, _lblW, _lblH];
_ctrlObjectiveLabel ctrlCommit 0;
private _objFullW = 0.2135 * safezoneW;
private _objGap = 0.003 * safezoneW;
private _objW = (_objFullW - (_objectiveCount - 1) * _objGap) / _objectiveCount;
{
	_x ctrlShow (_forEachIndex < _objectiveCount);
	_x ctrlSetPosition [_objX + _forEachIndex * (_objW + _objGap), _objY, _objW, _objH];
	_x ctrlCommit 0;
} forEach _objectiveCtrls;
_ctrlObjectiveLabel ctrlSetText (call {
	if (iMissionParamType in [0,6]) exitWith {localize "STR_TRGM2_Setup_ObjectiveMainSides"};
	if (_objectiveCount > 1) exitWith {localize "STR_TRGM2_Setup_ObjectiveList"};
	toUpper localize "STR_TRGM2_dialogs_Objective"
});

//a campaign sets its own reputation and weather, and only uses a chosen objective if the mission allows it
if (isNil "AllowMissionTypeCampaign") then {AllowMissionTypeCampaign = false;};
private _ctrlObjective = _objectiveCtrls select 0;
private _ctrlRep = _display displayCtrl 5100;
private _ctrlWeather = _display displayCtrl 5101;
if (iMissionParamType == 5) then {
	if (!AllowMissionTypeCampaign) then {
		_ctrlObjective ctrlEnable false;
		_ctrlObjective lbSetCurSel 0;
	};
	_ctrlRep ctrlEnable false;
	_ctrlRep lbSetCurSel 1;
	_ctrlWeather ctrlEnable false;
	_ctrlWeather lbSetCurSel 0;
}
else {
	{_x ctrlEnable true;} forEach [_ctrlObjective, _ctrlRep, _ctrlWeather];
};

//campaign saves can only be loaded in multiplayer
{(_display displayCtrl _x) ctrlShow isMultiplayer;} forEach [1601, 1602];

TRGM_setupUpdating = nil;
