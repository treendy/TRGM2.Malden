// by psycho
private["_injuredperson","_dragger"];
_dragger = _this select 1;
_injuredperson	= _this select 3;

if (_injuredperson distance _dragger > 3) exitWith {[format ["%1 is out of range to be dragged." call tcb_ais_font, name _injuredperson],0, 0.035 * safezoneH + safezoneY,5,0.3] spawn BIS_fnc_dynamicText};
if (!alive _injuredperson) exitWith {[format ["R.I.P. %1" call tcb_ais_font, name _injuredperson],0, 0.035 * safezoneH + safezoneY,5,0.3] spawn BIS_fnc_dynamicText};
if (_dragger call tcb_fnc_checklauncher) exitWith {[format ["You are not able to carry anyone else while carrying a launcher on your back." call tcb_ais_font],0, 0.035 * safezoneH + safezoneY,5,0.3] spawn BIS_fnc_dynamicText};

if (!isNil {_dragger getVariable "carry_action"}) then {
	_dragger removeAction (_dragger getVariable "carry_action");
	_dragger setVariable ["carry_action", nil];
};

detach _dragger;
detach _injuredperson;

_pos = _dragger ModelToWorld [0,1.9,0];
_injuredperson setPos _pos;
_injuredperson playActionNow "grabCarried";
sleep 2;
if (!isPlayer _injuredperson) then {_injuredperson disableAI "ANIM"};
_dragger playAction "grabCarry";

_timenow = time;
waitUntil {!alive _injuredperson || {!alive _dragger} || {_dragger getVariable "tcb_ais_agony"} || {time > _timenow + 16}};
if (!alive _injuredperson || {!alive _dragger} || {(_dragger getVariable "tcb_ais_agony")}) then {
	if (alive _injuredperson) then {
		_injuredperson playActionNow "agonyStart";
	} else {
		if (!isNil {_dragger getVariable "tcb_ais_dropAction"}) then {
			_dragger removeAction (_dragger getVariable "tcb_ais_dropAction");
			_dragger setVariable ["tcb_ais_dropAction",nil];
		};
	};
	if (alive _dragger && {!(_dragger getVariable "tcb_ais_agony")}) then {
		_dragger playMoveNow "amovpknlmstpsraswrfldnon";
	};
} else {
	_injuredperson attachTo [_dragger, [-0.6, 0.28, -0.05]];
};

_dragger = _injuredperson getVariable "dragger";
waitUntil {!alive _injuredperson || {!alive _dragger} || {_dragger getVariable "tcb_ais_agony"} || {isNull _dragger}};
if (isNull _dragger) exitWith {};
if (alive _injuredperson) then {
	_injuredperson playActionNow "agonyStart";
} else {
	if (!isNil {_dragger getVariable "drop_action"}) then {
		_dragger removeAction (_dragger getVariable "drop_action");
		_dragger setVariable ["drop_action",nil];
	};
};
if (alive _dragger && {!(_dragger getVariable "tcb_ais_agony")}) then {
	_dragger playMoveNow "amovpknlmstpsraswrfldnon";
};