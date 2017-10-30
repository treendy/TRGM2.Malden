// by psycho
private["_injuredperson","_helper"];
_injuredperson = _this select 0;
_helper = _this select 1;

if (_helper getVariable "tcb_ais_agony") exitWith {};

if (!isNull(_injuredperson getVariable "healer") || {!isNull(_injuredperson getVariable "dragger")}) exitWith {[format ["%1 is being attended to." call tcb_ais_font, name _injuredperson],0, 0.035 * safezoneH + safezoneY,5,0.3] spawn BIS_fnc_dynamicText};
if (_injuredperson distance _helper > 2.5) exitWith {[format ["%1 is too far away to press on the wound." call tcb_ais_font, name _injuredperson],0, 0.035 * safezoneH + safezoneY,5,0.3] spawn BIS_fnc_dynamicText};
if (!alive _injuredperson) exitWith {[format ["R.I.P. %1" call tcb_ais_font, name _injuredperson],0, 0.035 * safezoneH + safezoneY,5,0.3] spawn BIS_fnc_dynamicText};

_injuredperson setVariable ["helper", _helper, true];
tcb_helperStopped = false;
_helper selectWeapon primaryWeapon _helper;
sleep 1;
_helper playMove "AinvPknlMstpSlayWrflDnon_1";	

tcb_animDelay = time + 2;

_animChangeEVH = _helper addEventhandler ["AnimChanged", {
	private ["_anim","_helper"];
	_helper = _this select 0;
	_anim = _this select 1;
	if (primaryWeapon _helper != "") then {
		if (time >= tcb_animDelay) then {tcb_helperStopped = true; /*Hint "has stopped cause weapon rised";*/};
	} else {
		if (!(_anim in ["AinvPknlMstpSlayWrflDnon_1"])) then {
			if (time >= tcb_animDelay) then {tcb_helperStopped = true};
			//Hint "has stopped";
		};
	};	
}];

_offset = [0,0,0]; _dir = 0;
_relpos = _helper worldToModel position _injuredperson;
if((_relpos select 0) < 0) then{_offset=[-0.2,0.7,0]; _dir=90} else{_offset=[0.2,0.7,0]; _dir=270};
_injuredperson attachTo [_helper,_offset];
_injuredperson setDir _dir;

waitUntil {
	!alive _helper
	|| {!alive _injuredperson}
	|| {(_helper distance _injuredperson) > 2}
	|| {_helper getVariable "tcb_ais_agony"}
	|| {tcb_helperStopped}
	|| {!isNull(_injuredperson getVariable "healer")}
};

_helper removeEventHandler ["AnimChanged", _animChangeEVH];
detach _helper;
detach _injuredperson;

if (alive _helper && {!(_helper getVariable "tcb_ais_agony")}) then {
	_helper playMove "AinvPknlMstpSlayWrflDnon_AmovPknlMstpSrasWrflDnon";
};

if (!alive _injuredperson) exitWith {["He was killed in action." call tcb_ais_font,0, 0.035 * safezoneH + safezoneY,5,0.3] spawn BIS_fnc_dynamicText};
if (!alive _helper) exitWith {};
_injuredperson setVariable ["helper", ObjNull, true];
