// by psycho - dont edit!
private "_ais_exit";
if (isDedicated && {isPlayer _unit}) exitWith {};				// no player unit controlled on a dedicated server
if (!isDedicated && {!hasInterface}) exitWith {};				// no headless client
_unit = _this select 0;

// checking for failed player init
_ais_exit = false;
if (isMultiplayer && !isServer) then {	// only players on dedicated environment
	true spawn {
		private "_puid";
		waitUntil {player == player && local player};
		_puid = getPlayerUID player;
		if (isNil "_puid") exitWith {diag_log "AIS: UID is Nil - AIS init abborted"; _ais_exit = true;};
		if (_puid == "") exitWith {diag_log "AIS: UID is empty - AIS init abborted"; _ais_exit = true;};
	};
};
if (_ais_exit) exitWith {};
if (isNil "_unit") exitWith {diag_log "AIS: unit is Nil - AIS init abborted"};
if (!isNil {_unit getVariable "tcb_ais_aisInit"}) exitWith {};	// prevent that a unit run the init twice
_unit setVariable ["tcb_ais_aisInit",true];
#include "ais_setup.sqf"

"tcb_ais_in_agony" addPublicVariableEventHandler {
	private ["_unit","_in_agony","_side","_fa_action","_drag_action"];
	_unit = (_this select 1) select 0;
	_in_agony = (_this select 1) select 1;
	_side = _unit getVariable "tcb_ais_side";
	if (playerSide == _side) then {
		if (_in_agony) then {
			_unit playActionNow "agonyStart";
			if (local player) then {[side _unit,"HQ"] sideChat format ["%1 is down and needs help at %2!",name _unit, mapGridPosition _unit]};
			
			if (isNil {_unit getVariable ["fa_action", Nil]}) then {
				_fa_action = _unit addAction [format["<t color='#F00000'>First Aid to %1</t>",name _unit],{_this spawn tcb_fnc_firstAid},_unit,100,false,true,"",
					"{not isNull (_target getVariable _x)} count ['healer','dragger'] == 0 && {alive _target} && {vehicle _target == _target}
				"];
				_unit setVariable ["fa_action", _fa_action];
			};
			if (isNil {_unit getVariable ["drag_action", Nil]}) then {
				_drag_action = _unit addAction [format["<t color='#FC9512'>Drag %1</t>",name _unit],{_this spawn tcb_fnc_drag},_unit,99,false,true,"",
					"{not isNull (_target getVariable _x)} count ['healer','dragger','helper'] == 0 && {alive _target} && {vehicle _target == _target}
				"];
				_unit setVariable ["drag_action", _drag_action];
			};
			if (tcb_ais_medical_education >= 1) then {
				if (isNil {_unit getVariable ["help_action", Nil]}) then {
					_help_action = _unit addAction [format["<t color='#FC9512'>Press on the wound</t>",name _unit],{_this spawn tcb_fnc_help},_unit,98,false,true,"",
						"{not isNull (_target getVariable _x)} count ['healer','dragger','helper'] == 0 && {alive _target} && {vehicle _target == _target}
					"];
					_unit setVariable ["help_action", _help_action];
				};
			};
			[_unit] execFSM (TCB_AIS_PATH+"fsm\ais_marker.fsm");
		} else {
			if (tcb_ais_bloodParticle) then {[_unit] call tcb_fnc_resetBleeding};
			_unit playActionNow "agonyStop";
			
			_unit removeAction (_unit getVariable "fa_action");
			_unit removeAction (_unit getVariable "drag_action");
			_unit removeAction (_unit getVariable "carry_action");
			_unit removeAction (_unit getVariable "help_action");
			_unit setVariable ["fa_action",nil];
			_unit setVariable ["drag_action",nil];
			_unit setVariable ["carry_action",nil];
			_unit setVariable ["help_action",nil];

			if (!isNil {_unit getVariable "drag_action"}) then {
				_unit removeAction (_unit getVariable "drop_action");
				_unit setVariable ["drop_action",nil];
			};
			if (!isNil {_unit getVariable "carry_action"}) then {
				_unit removeAction (_unit getVariable "carry_action");
				_unit setVariable ["carry_action",nil];
			};
			if (!isNil {_unit getVariable "fa_action"}) then {
				_unit removeAction (_unit getVariable "fa_action");
				_unit setVariable ["fa_action",nil];
			};
			if (tcb_ais_medical_education >= 1) then {
				if (!isNil {_unit getVariable "help_action"}) then {
					_unit removeAction (_unit getVariable "help_action");
					_unit setVariable ["help_action",nil];
				};
			};
		};
	};
};

"tcb_ais_score" addPublicVariableEventHandler {
	_unit = (_this select 1) select 0;
	_score = (_this select 1) select 1;
	if (isServer) then {_unit addScore _score};
};

tcb_ais_score_delay = false;
tcb_healerStopped = false;
tcb_ais_selftreathing = false;
_unit setVariable ["unit_is_unconscious", false];
_unit setVariable ["tcb_ais_damageStore", 0];
_unit setVariable ["tcb_ais_unit_died", false];
_unit setVariable ["tcb_ais_leader", false];
_unit setVariable ["tcb_ais_fall_in_agony_time_delay", 999999];
tcb_ais_medequip_array = [];
tcb_ais_areBleeding = [];
_unit setVariable ["callHelpDelay", 0];

tcb_ais_font = {"<t color='#fDCDBF6' font='PuristaMedium'>" + _this + "</t>"};
tcb_ais_iconUnits = if (isMultiplayer) then {playableUnits} else {switchableUnits};

if (tcb_ais_show_3d_icons) then {
	if (_unit == player) then {
		_icons = addMissionEventHandler ["Draw3D", {
			{
				if (_x getVariable ["tcb_ais_agony", false] && {_x distance player < 30}) then {
					drawIcon3D ["\A3\ui_f\data\map\mapcontrol\Hospital_CA.paa", [0.6,0.15,0,0.8], _x, 0.5, 0.5, 0, format ["%1 (%2m)", name _x, ceil (player distance _x)], 0, 0.02];
				};
			} forEach tcb_ais_iconUnits;
		}];
	};
};

if (tcb_ais_delTime > 0) then {
	_unit AddEventHandler ["killed",{[_this select 0, tcb_ais_delTime] spawn tcb_fnc_delbody}];
};

if (tcb_ais_showDiaryInfo && {_unit == player}) then {call tcb_fnc_diary};

[_unit] spawn {
	_unit = _this select 0;
	_timeend = time + 1.213;
	waitUntil {!isNil {_unit getVariable "BIS_fnc_feedback_hitArrayHandler"} || {time > _timeend}};	// work around to ensure this EH is the last one that was added
	["%1 --- adding wounding handleDamage eventhandler first time",diag_ticktime] call BIS_fnc_logFormat;
	_unit addEventHandler ["HandleDamage", {_this call tcb_fnc_handleDamage2}];
};

[_unit] execFSM (TCB_AIS_PATH+"fsm\ais.fsm");
//[_unit] execFSM (TCB_AIS_PATH+"fsm\healReset.fsm");

if (tcb_ais_bloodParticle) then {
	execFSM (TCB_AIS_PATH+"fsm\pulse.fsm");
};

if (isPlayer _unit) then {
	waitUntil {!isNull (findDisplay 46)};
	(findDisplay 46) displayAddEventHandler ["KeyDown", {_this call tcb_fnc_keyUnbind}];
};


if (_unit == leader group _unit) then {
	_unit setVariable ["tcb_ais_leader", true];
} else {
	_unit setVariable ["tcb_ais_leader", false];
};

if (tcb_ais_dead_dialog) then {
	if (isNil "respawndelay") then {
		_num = getNumber (missionConfigFile/"respawndelay");
		if (_num != 0) then {
			missionNamespace setVariable ["tcb_ais_respawndelay", _num];
		};
	} else {
		missionNamespace setVariable ["tcb_ais_respawndelay", 999];
	};

	tcb_ais_killcam_quotes = [
		[(localize "STR_QUOTE_1"),(localize "STR_AUTHOR_1")],
		[(localize "STR_QUOTE_2"),(localize "STR_AUTHOR_2")],
		[(localize "STR_QUOTE_3"),(localize "STR_AUTHOR_3")],
		[(localize "STR_QUOTE_4"),(localize "STR_AUTHOR_4")],
		[(localize "STR_QUOTE_5"),(localize "STR_AUTHOR_5")],
		[(localize "STR_QUOTE_6"),(localize "STR_AUTHOR_6")],
		[(localize "STR_QUOTE_7"),(localize "STR_AUTHOR_7")],
		[(localize "STR_QUOTE_8"),(localize "STR_AUTHOR_8")],
		[(localize "STR_QUOTE_9"),(localize "STR_AUTHOR_9")],
		[(localize "STR_QUOTE_10"),(localize "STR_AUTHOR_10")],
		[(localize "STR_QUOTE_11"),(localize "STR_AUTHOR_11")],
		[(localize "STR_QUOTE_12"),(localize "STR_AUTHOR_12")],
		[(localize "STR_QUOTE_13"),(localize "STR_AUTHOR_13")],
		[(localize "STR_QUOTE_14"),(localize "STR_AUTHOR_14")],
		[(localize "STR_QUOTE_15"),(localize "STR_AUTHOR_15")],
		[(localize "STR_QUOTE_16"),(localize "STR_AUTHOR_16")],
		[(localize "STR_QUOTE_17"),(localize "STR_AUTHOR_17")],
		[(localize "STR_QUOTE_18"),(localize "STR_AUTHOR_18")],
		[(localize "STR_QUOTE_19"),(localize "STR_AUTHOR_19")],
		[(localize "STR_QUOTE_20"),(localize "STR_AUTHOR_20")],
		[(localize "STR_QUOTE_21"),(localize "STR_AUTHOR_21")],
		[(localize "STR_QUOTE_22"),(localize "STR_AUTHOR_22")],
		[(localize "STR_QUOTE_23"),(localize "STR_AUTHOR_23")],
		[(localize "STR_QUOTE_24"),(localize "STR_AUTHOR_24")],
		[(localize "STR_QUOTE_25"),(localize "STR_AUTHOR_25")],
		[(localize "STR_QUOTE_26"),(localize "STR_AUTHOR_26")],
		[(localize "STR_QUOTE_27"),(localize "STR_AUTHOR_27")],
		[(localize "STR_QUOTE_28"),(localize "STR_AUTHOR_28")],
		[(localize "STR_QUOTE_29"),(localize "STR_AUTHOR_29")],
		[(localize "STR_QUOTE_30"),(localize "STR_AUTHOR_30")],
		[(localize "STR_QUOTE_31"),(localize "STR_AUTHOR_31")],
		[(localize "STR_QUOTE_32"),(localize "STR_AUTHOR_32")],
		[(localize "STR_QUOTE_33"),(localize "STR_AUTHOR_33")],
		[(localize "STR_QUOTE_34"),(localize "STR_AUTHOR_34")],
		[(localize "STR_QUOTE_35"),(localize "STR_AUTHOR_35")],
		[(localize "STR_QUOTE_36"),(localize "STR_AUTHOR_36")],
		[(localize "STR_QUOTE_37"),(localize "STR_AUTHOR_37")],
		[(localize "STR_QUOTE_38"),(localize "STR_AUTHOR_38")],
		[(localize "STR_QUOTE_39"),(localize "STR_AUTHOR_39")],
		[(localize "STR_QUOTE_40"),(localize "STR_AUTHOR_40")],
		[(localize "STR_QUOTE_41"),(localize "STR_AUTHOR_41")],
		[(localize "STR_QUOTE_42"),(localize "STR_AUTHOR_42")],
		[(localize "STR_QUOTE_LAST"),(localize "STR_AUTHOR_LAST")]
	];

	if (_unit == player) then {
		_unit AddEventHandler ["killed",{_this spawn tcb_fnc_deadcam}];
	};
};