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

_pos = [_dest, 1000, random 360] call BIS_fnc_relPos;
_dir = [_pos, _dest] call BIS_fnc_dirTo;

_transport = [_pos,0,"UK3CB_TKM_O_2b14_82mm",EAST] call BIS_fnc_spawnVehicle;
_transportGrp = (_transport select 2);
_transport = _transport select 0





