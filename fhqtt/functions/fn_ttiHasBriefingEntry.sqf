private ["_x", "_res", "_test", "_inArray"];
_res = false;
    
_inArray = [_this, 1, []] call BIS_fnc_param;
_test = [_this, 0, []] call BIS_fnc_param;
     
{
   	if (_x select 0 == _inArray select 0 && ((_x select 1) select 0) == ((_inArray select 1) select 0) 
      && ((_x select 1) select 1) == ((_inArray select 1) select 1)) exitWith {
         _res = true;
    };
} foreach _test;
    
_res; 