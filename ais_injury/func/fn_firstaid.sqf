// by BonInf*
// changed by psycho
private ["_injuredperson","_healer","_behaviour","_timenow","_relpos","_dir","_offset","_time","_damage","_isMedic","_healed","_animChangeEVH","_skill_factor"];
_injuredperson = _this select 0;
_healer = _this select 1;
_behaviour = behaviour _healer;

if (_healer getVariable "tcb_ais_agony") exitWith {};

if (!isPlayer _healer && {_healer distance _injuredperson > 6}) then {
	_healer setBehaviour "AWARE";
	_healer doMove (position _injuredperson);
	_timenow = time;
	WaitUntil {
		_healer distance _injuredperson <= 4		 		||
		{!alive _injuredperson}			 					||
		{!(_injuredperson getVariable "tcb_ais_agony")} 	||
		{!alive _healer}				 					||
		{_healer getVariable "tcb_ais_agony"}		 		||
		{_timenow + 120 < time}
	};
};

if (isPlayer _healer) then {
	if (_healer distance _injuredperson > 2.5) exitWith {
		if (isPlayer _healer) then {[format ["%1 is too far away to be healed." call tcb_ais_font, name _injuredperson],0, 0.035 * safezoneH + safezoneY,5,0.3] spawn BIS_fnc_dynamicText};
	};
};
_rtn = call tcb_fnc_isHealable;
if (!_rtn) exitWith {};


_ableToHeal = [_healer] call tcb_fnc_allowToHeal;
if (!_ableToHeal) exitWith {
	if (tcb_ais_medical_education >= 2) then {
		if (isPlayer _healer) then {[format ["Only medics are trained for this procedure!" call tcb_ais_font],0, 0.035 * safezoneH + safezoneY,5,0.3] spawn BIS_fnc_dynamicText};
	} else {
		if (isPlayer _healer) then {[format ["You need medical equipment for this action!" call tcb_ais_font],0, 0.035 * safezoneH + safezoneY,5,0.3] spawn BIS_fnc_dynamicText};
	};
	if (!isPlayer _healer) then {
		_healer stop false;
		_healer enableAI "MOVE";
		_healer enableAI "TARGET";
		_healer enableAI "AUTOTARGET";
		_healer enableAI "ANIM";
	};
};

_injuredperson setVariable ["healer", _healer, true];
tcb_healerStopped = false;

_healer selectWeapon primaryWeapon _healer;
sleep 1;
_healer playAction "medicStart";
tcb_animDelay = time + 2;

if (!isPlayer _healer) then {
	_healer stop true;
	_healer disableAI "MOVE";
	_healer disableAI "TARGET";
	_healer disableAI "AUTOTARGET";
	_healer disableAI "ANIM";
};

if (isPlayer _healer) then {
	_animChangeEVH = _healer addEventhandler ["AnimChanged", {
		private ["_anim","_healer"];
		_healer = _this select 0;
		_anim = _this select 1;
		if (primaryWeapon _healer != "") then {
			if (time >= tcb_animDelay) then {tcb_healerStopped = true};
		} else {
			if (_anim in ["amovpknlmstpsnonwnondnon","amovpknlmstpsraswlnrdnon"]) then {
				_healer playAction "medicStart";
			} else {
				if (!(_anim in ["ainvpknlmstpsnonwnondnon_medic0s","ainvpknlmstpsnonwnondnon_medic"])) then {
					if (time >= tcb_animDelay) then {tcb_healerStopped = true};
				};
			};
		};	
	}];
};

_offset = [0,0,0]; _dir = 0;
_relpos = _healer worldToModel position _injuredperson;
if((_relpos select 0) < 0) then{_offset=[-0.2,0.7,0]; _dir=90} else{_offset=[0.2,0.7,0]; _dir=270};

if (isPlayer _healer) then {
	[_healer, _injuredperson] call tcb_fnc_medicEquipment;
};

_injuredperson attachTo [_healer,_offset];
_injuredperson setDir _dir;
_time = time;

_skill_factor = if (_healer call tcb_fnc_isMedic) then {40+(random 10)} else {70+(random 10)};
_damage = (damage _injuredperson * _skill_factor);
if (_damage < 5) then {_damage = 5};
sleep 1;
while {
	time - _time < _damage
	&& {alive _healer}
	&& {alive _injuredperson}
	&& {(_healer distance _injuredperson) < 2}
	&& {!(_healer getVariable "tcb_ais_agony")}
	&& {!tcb_healerStopped}
} do {
	sleep 0.5;
	if (isPlayer _healer) then {["Applying First Aid.",((time - _time) / (_damage)) min 1] spawn tcb_fnc_progressbar};
};

if (isPlayer _healer) then {_healer removeEventHandler ["AnimChanged", _animChangeEVH]};
detach _healer;
detach _injuredperson;

if (!isPlayer _healer) then {
	_healer stop false;
	_healer enableAI "MOVE";
	_healer enableAI "TARGET";
	_healer enableAI "AUTOTARGET";
	_healer enableAI "ANIM";
};

if (alive _healer && {!(_healer getVariable "tcb_ais_agony")}) then {
	_healer playAction "medicStop";
	_healer setBehaviour _behaviour;
};
if (!alive _injuredperson) exitWith {["He is not with us anymore." call tcb_ais_font,0, 0.035 * safezoneH + safezoneY,5,0.3] spawn BIS_fnc_dynamicText};
if (!alive _healer) exitWith {};
_injuredperson setVariable ["healer",ObjNull,true];

call tcb_fnc_garbage;

_old_damage = damage _injuredperson;

if (!tcb_healerStopped) then {
	_isMedic = _healer call tcb_fnc_isMedic;
	_healed = switch (true) do {
		case (_isMedic && {(items _healer) find "Medikit" > -1}) : {0.15};
		case (_isMedic && {(items _healer) find "FirstAidKit" >= 0}) : {_healer removeItem "FirstAidKit"; 0.25};
		case (!_isMedic && {(items _healer) find "FirstAidKit" >= 0}) : {_healer removeItem "FirstAidKit"; 0.4};
		default {0.6};
	};

	if (time - _time > _damage) then {
		if (_healed > _old_damage) then {
			_injuredperson setDamage _old_damage;
		} else {
			_injuredperson setDamage _healed;
		};
		//_injuredperson setVariable ["tcb_ais_damageStore", 0];		// wrong location
		_injuredperson setVariable ["tcb_ais_agony", false, true];
	};
} else {
	["You interrupted the healing process." call tcb_ais_font,0, 0.035 * safezoneH + safezoneY,5,0.3] spawn BIS_fnc_dynamicText;
};