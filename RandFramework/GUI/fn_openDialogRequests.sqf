/*
 * Author: TheAce0296
 * Creates the request units/vehicles dialog.
 *
 * Arguments:
 * 0: The unit opened the dialog (should be player) <OBJECT>
 *
 * Return Value:
 * true <BOOL>
 *
 * Example:
 * player call TREND_fnc_openDialogRequests
 */

disableSerialization;

format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;
params [["_player", objNull, [objNull]]];

if (player != _player) exitWith {};

private _dCurrentRep = [TREND_MaxBadPoints - TREND_BadPoints,1] call BIS_fnc_cutDecimals;
private _unitArray = TREND_WestRiflemen;
_unitArray append TREND_WestATSoldiers;
_unitArray append TREND_WestAASoldiers;
_unitArray append TREND_WestEngineers;
_unitArray append TREND_WestMedics;
_unitArray append TREND_WestExpSpecs;
if (_dCurrentRep >= 3) then {
	_unitArray append TREND_WestAutoriflemen;
	_unitArray append TREND_WestGrenadiers;
};
if (_dCurrentRep >= 5) then {
	_unitArray append TREND_WestSnipers;
};
if (_dCurrentRep >= 7) then {
	_unitArray append TREND_WestUAVOps;
};
TREND_RecruitUnitArray = _unitArray arrayIntersect _unitArray;
publicVariable "TREND_RecruitUnitArray";
TREND_RecruitUnitArrayText = [];
{
	private _dispName = getText(configFile >> "CfgVehicles" >> _x >> "displayName");
	TREND_RecruitUnitArrayText pushBack _dispName;
} forEach TREND_RecruitUnitArray;
publicVariable "TREND_RecruitUnitArrayText";

private _vehArray = TREND_WestUnarmedCars;
_vehArray append TREND_WestUnarmedHelos;
_vehArray append TREND_WestTurrets;
_vehArray append TREND_WestBoats;
if (_dCurrentRep >= 3 || {!(call TREND_VehiclesRequireRep)}) then {
	_vehArray append TREND_WestArmedCars;
	_vehArray append TREND_WestAPCs;
};
if (_dCurrentRep >= 5 || {!(call TREND_VehiclesRequireRep)}) then {
	_vehArray append TREND_WestTanks;
	_vehArray append TREND_WestArmedHelos;
};
if (_dCurrentRep >= 7 || {!(call TREND_VehiclesRequireRep)}) then {
	_vehArray append TREND_WestArtillery;
	_vehArray append TREND_WestAntiAir;
	_vehArray append TREND_WestPlanes;
};
TREND_SpawnVehArray = _vehArray arrayIntersect _vehArray;
TREND_SpawnVehArrayText = [];
{
	private _dispName = getText(configFile >> "CfgVehicles" >> _x >> "displayName");
	TREND_SpawnVehArrayText pushBack _dispName;
} forEach TREND_SpawnVehArray;
publicVariable "TREND_SpawnVehArrayText";

createDialog "Trend_DialogRequests";
waitUntil {!isNull (findDisplay 8000);};


_display = findDisplay 8000;

_display ctrlCreate ["RscCombo", 8007];
_cboSelectUnit = _display displayCtrl 8007;
_cboSelectUnit ctrlSetPosition [0.365954 * safezoneW + safezoneX, 0.412003 * safezoneH + safezoneY, 0.123734 * safezoneW, 0.0329991 * safezoneH];
{
	_cboSelectUnit lbAdd _x;
} forEach TREND_RecruitUnitArrayText;
_cboSelectUnit lbSetCurSel 0;
_cboSelectUnit ctrlCommit 0;
_cboSelectUnit ctrlSetTooltip localize "STR_TRGM2_openDialogRequests_RequestUnitDefault";


_btnSelectUnit = _display displayCtrl 8003;
_btnSelectUnit ctrlAddEventHandler ["ButtonClick", {
	params ["_control"];
	private _index = lbCurSel 8007;
	private _unitClass = TREND_RecruitUnitArray select _index;

	if (player != leader group player) then {
		titleText[localize "STR_TRGM2_openDialogRequests_NotGroupLeader", "PLAIN"];
	} else {
		_currentSpentPoints = call TREND_fnc_CountSpentPoints;
		if (_currentSpentPoints < (TREND_MaxBadPoints - TREND_BadPoints + 1)) then {
			private _SpawnedUnit = (group player createUnit [_unitClass, getPos player, [], 10, "NONE"]);
			addSwitchableUnit _SpawnedUnit;
			player doFollow player;
			_SpawnedUnit setVariable ["RepCost", 0.5, true];
			_SpawnedUnit setVariable ["IsFRT", true, true];

			[box1, [_SpawnedUnit]] call TREND_fnc_initAmmoBox;

			_SpawnedUnit addEventHandler ["killed",
			{
				_tombStone = selectRandom TREND_TombStones createVehicle TREND_GraveYardPos;
				_tombStone setDir TREND_GraveYardDirection;
				_tombStone setVariable ["Message", format[localize "STR_TRGM2_RecruiteInf_KIA",name (_this select 0)],true];
				_tombStone addAction [localize "STR_TRGM2_RecruiteInf_Read",{hint format["%1",(_this select 0) getVariable "Message"]}];
				[0.2, format[localize "STR_TRGM2_RecruiteInf_KIA",name (_this select 0)]] spawn TREND_fnc_AdjustBadPoints;
			}];

			if (TREND_bUseRevive || !isNil "AIS_MOD_ENABLED") then {
				[_SpawnedUnit] call AIS_System_fnc_loadAIS;
			};
			titleText[localize "STR_TRGM2_openDialogRequests_UnitSpawned", "PLAIN"];
		} else {
			titleText [localize "STR_TRGM2_RecruiteInf_MoreReputation", "PLAIN"];
		};
	};
	closedialog 0;
	false;
}];

_display ctrlCreate ["RscCombo", 8009];
_cboSelectVehicle = _display displayCtrl 8009;
_cboSelectVehicle ctrlSetPosition [0.520622 * safezoneW + safezoneX, 0.412003 * safezoneH + safezoneY, 0.123734 * safezoneW, 0.0329991 * safezoneH];
{
	_cboSelectVehicle lbAdd _x;
} forEach TREND_SpawnVehArrayText;
_cboSelectVehicle lbSetCurSel 0;
_cboSelectVehicle ctrlCommit 0;
_cboSelectVehicle ctrlSetTooltip localize "STR_TRGM2_openDialogRequests_RequestVehicleDefault";


_btnSelectVehicle = _display displayCtrl 8005;
_btnSelectVehicle ctrlAddEventHandler ["ButtonClick", {
	params ["_control"];
	private _index = lbCurSel 8009;
	private _vehClass = TREND_SpawnVehArray select _index;
	_currentSpentPoints = call TREND_fnc_CountSpentPoints;
	if (!(call TREND_VehiclesRequireRep) || {_currentSpentPoints < (TREND_MaxBadPoints - TREND_BadPoints + 1)}) then {
		[_vehClass] spawn {
			params ["_classToSpawn"];
			private _safePos = [getPos player, 20,100,25,0,0.15,0,[],[getPos player,getPos player],_classToSpawn] call TREND_fnc_findSafePos; // find a valid pos
			if (_safePos isEqualTo getPos player) then {
				_safePos = [getPos player, 20,150,25,0,0.30,0,[],[getPos player,getPos player],_classToSpawn] call TREND_fnc_findSafePos; // find a valid pos
			};
			if (_safePos isEqualTo getPos player) exitWith {hint "No safe location nearby to create vehicle!"};
			player setPos _safePos;
			private _SpawnedVeh = createVehicle [_classToSpawn, _safePos vectorAdd [0,0,250], [], 0, "NONE"];
			_SpawnedVeh allowdamage false;
			_SpawnedVeh setdamage 0;

			private _largeObjectCorrection = if (((boundingBoxReal _SpawnedVeh select 1 select 1) - (boundingBoxReal _SpawnedVeh select 0 select 1)) != 0 && {
				((boundingBoxReal _SpawnedVeh select 1 select 0) - (boundingBoxReal _SpawnedVeh select 0 select 0)) > 3.2 &&
				((boundingBoxReal _SpawnedVeh select 1 select 0) - (boundingBoxReal _SpawnedVeh select 0 select 0)) / ((boundingBoxReal _SpawnedVeh select 1 select 1) - (boundingBoxReal _SpawnedVeh select 0 select 1)) > 1.25 })
				then { 90; } else { 0; };

			private _attachPos = [
				(boundingCenter _SpawnedVeh select 0) * cos _largeObjectCorrection - (boundingCenter _SpawnedVeh select 1) * sin _largeObjectCorrection,
				((-(boundingBoxReal _SpawnedVeh select 0 select 0) * sin _largeObjectCorrection) max (-(boundingBoxReal _SpawnedVeh select 1 select 0) * sin _largeObjectCorrection)) + ((-(boundingBoxReal _SpawnedVeh select 0 select 1) * cos _largeObjectCorrection) max (-(boundingBoxReal _SpawnedVeh select 1 select 1) * cos _largeObjectCorrection)) + 2 + 0.3 * (((boundingBoxReal _SpawnedVeh select 1 select 1)-(boundingBoxReal _SpawnedVeh select 0 select 1)) * abs sin _largeObjectCorrection + ((boundingBoxReal _SpawnedVeh select 1 select 0)-(boundingBoxReal _SpawnedVeh select 0 select 0)) * abs cos _largeObjectCorrection),
				-(boundingBoxReal _SpawnedVeh select 0 select 2)
			];

			if (!local _SpawnedVeh) then {
				private _makeLocalStartTime = time;
				_SpawnedVeh setOwner (owner player);
				waitUntil {local _SpawnedVeh || time > _makeLocalStartTime + 1.5};
			};

			sleep 0.5;

			_SpawnedVeh setpos _safePos;
			_SpawnedVeh attachTo [player, _attachPos, "head"];

			_actionReleaseObject = player addAction [format [localize "STR_TRGM2_openDialogRequests_VehicleRelease", getText (configFile >> "CfgVehicles" >> _classToSpawn >> "displayName")], {
				params ["_target", "_caller", "_actionId", "_arguments"];
				_arguments params ["_spawnedVeh"];
				detach _spawnedVeh;
				_spawnedVeh setPos [getPos _spawnedVeh select 0, getPos _spawnedVeh select 1];
				_spawnedVeh setVectorUp surfaceNormal position _spawnedVeh;
				_spawnedVeh allowDamage true;
				_target removeAction _actionId;

				// If turret, allow it to be moved by player | TODO: Storage system for statics...
				if ((tolower (getText (configFile >> 'cfgVehicles' >> (typeOf _spawnedVeh) >> 'vehicleClass')) isEqualTo 'static')) then {
					[_spawnedVeh, [format [localize "STR_TRGM2_UnloadDingy_push", getText (configFile >> "CfgVehicles" >> (typeOf _spawnedVeh) >> "displayName")],{_this spawn TREND_fnc_PushObject;}, [], -99, false, false, "", "_this == player && count crew _target isEqualTo 0"]] remoteExec ["addAction", 0];
				} else { // If not a turret, allow an inflatable boat to be unloaded.
					[_spawnedVeh, [localize "STR_TRGM2_startInfMission_UnloadDingy",{_this spawn TREND_fnc_UnloadDingy;}, [], -99, false, false, "", "_this == player && count crew _target isEqualTo 0"]] remoteExec ["addAction", 0];
					[_spawnedVeh, (units group _caller)] call TREND_fnc_initAmmoBox;
				};
				["Open",_spawnedVeh] spawn TREND_fnc_openVehicleCustomizationDialog;
			}, [_SpawnedVeh], 5, true, true];

			if (call TREND_VehiclesRequireRep) then {
				TREND_SpawnedVehicles pushBack _SpawnedVeh; publicVariable "TREND_SpawnedVehicles";
				_SpawnedVeh addEventHandler ["Killed", {
					params ["_unit", "_killer", "_instigator", "_useEffects"];
					[1, format[localize "STR_TRGM2_SpawnVehicles_KIA",name _unit]] spawn TREND_fnc_AdjustBadPoints;
				}];
			};

			titleText[localize "STR_TRGM2_openDialogRequests_VehicleSpawned", "PLAIN"];
		};
	} else {
		titleText [localize "STR_TRGM2_SpawnVehicles_MoreReputation", "PLAIN"];
	};

	closedialog 0;
	false;
}];

true;