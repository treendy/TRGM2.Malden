if (!isServer) exitWith {};


_fnc_closestPlayer = {
  private ["_o","_s","_p"];
  _o = _this;
  _p = objNull;
  {
    if (alive _x && isplayer _x && !(vehicle _x isKindOf "Air")) then {
      if (_x distance _o < _x distance _p) then {
        _p = _x;
      };
    };
  } foreach (if ismultiplayer then {playableunits} else {switchableunits});
  _p
};

private ["_pos","_dir","_chute","_dest","_transport","_transportGrp","_wp","_grp"];

_dest = _this;
if (typename _dest == typename objNull) then { _dest = getpos _dest; };

_pos = [_dest, 2000, random 360] call BIS_fnc_relPos;
_dir = [_pos, _dest] call BIS_fnc_dirTo;


_transport = [_pos,0,"UK3CB_TKM_O_LR_Open",east] call BIS_fnc_spawnVehicle;
_transportGrp = (_transport select 2);
_transport = _transport select 0;
{_x setBehaviour "COMBAT";} forEach units _transportGrp;


_transportGrp move _dest;


_grp = [_pos, east, (configfile >> "CfgGroups" >> "East" >> "UK3CB_TKM_O" >> "Infantry" >> "UK3CB_TKM_O_AR_Sentry"),[],[],[0.25,0.4]] call BIS_fnc_spawnGroup;
{
_x assignascargo _transport;
_x moveincargo _transport;
  sleep 0.5;
} forEach units _grp;

_dest = getpos (_transport call _fnc_closestPlayer);
while {_dest distance _transport >30} do {
  _dest = getpos (_transport call _fnc_closestPlayer);
  sleep 2;
};
_dest = getpos (_transport call _fnc_closestPlayer);
[_transportGrp, getPos _dest,200] call bis_fnc_taskPatrol;

