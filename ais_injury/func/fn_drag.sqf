// by Bon_Inf*
params ["_injuredperson","_dragger"];

if (!isNull(_injuredperson getVariable "healer") || {!isNull(_injuredperson getVariable "dragger")} || {!isNull(_injuredperson getVariable "helper")}) exitWith {[format ["%1 is already being attended to.", name _injuredperson],0, 0.035 * safezoneH + safezoneY,5,0.3] spawn BIS_fnc_dynamicText};
if (_injuredperson distance _dragger > 2.5) exitWith {[format ["%1 is out of range to be dragged." call tcb_ais_font, name _injuredperson],0, 0.035 * safezoneH + safezoneY,5,0.3] spawn BIS_fnc_dynamicText};
if (!alive _injuredperson) exitWith {[format ["R.I.P. %1" call tcb_ais_font, name _injuredperson],0, 0.035 * safezoneH + safezoneY,5,0.3] spawn BIS_fnc_dynamicText};

_injuredperson setVariable ["dragger",_dragger,true];
_injuredperson attachTo [_dragger, [0, 1, 0.08]];
_injuredperson setDir 180;

_injuredperson switchMove "AinjPpneMrunSnonWnonDb";
_dragger playAction "grabDrag";
sleep 1;

tcb_ais_dropAction = _dragger addAction [format["<t color='#FC9512'>Drop %1</t>",name _injuredperson], {_this spawn tcb_fnc_drop},_injuredperson, 0, false, true];
tcb_ais_carryAction = _dragger addAction [format["<t color='#FC9512'>Carry %1</t>",name _injuredperson], {_this spawn tcb_fnc_carry},_injuredperson, 0, false, true];
_dragger setVariable ["drop_action", tcb_ais_dropAction];
_dragger setVariable ["carry_action", tcb_ais_carryAction];