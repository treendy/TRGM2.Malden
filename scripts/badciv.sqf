_thisCiv = _this; // select 0;

_bFired = false;
_bActivated = false;
_Music = selectRandom ["Music","music2","music1"];
_pissedcivsound = selectRandom ["angryciv","angryciv1","angryciv2","angryciv3","angryciv4","angryciv5","angryciv6","angryciv7","angryciv8","angryciv9"];
_happycivsound = selectRandom ["chat","chat2","chat3","chat4","chat5","chat6","chat7","chat8"];
_civAction = selectRandom ["Acts_Hilltop_Calibration_Pointing_Left","Acts_Hilltop_Calibration_Pointing_Right","Acts_PointingLeftUnarmed","Acts_C_in1_briefing"];
_civAction1 = selectRandom ["Acts_JetsShooterNavigate_loop","Acts_JetsMarshallingClear_loop"];
_civflee = selectRandom ["Acts_JetsMarshallingStop_loop"];
_civflee1 = selectRandom ["ApanPknlMsprSnonWnonDfr"];
_broke = selectRandom ["beep"];
_ambient = selectRandom ["prayer"];
_happycivsound1 = selectRandom ["mister"];

if ((isServer) && (music)) then { 
   _atmos2 = [_thisciv, 250, random 360] call BIS_fnc_relPos; 
   _atmos1 = nearestBuilding _atmos2; 
   musicbox setpos getpos (_atmos1); 
   music = false; 
   publicvariable "music"; 
};
while {alive _thisCiv && !_bFired} do {
   _nearestunits = nearestObjects [getPos _thisCiv,["CamanBase"],15];
   {                
      if ((isPlayer _x) && (!weaponLowered _x)) then {
         if (!_bActivated) then {
            _bActivated = true;
            [_thisCiv,["Check ID","scripts/detain.sqf",[],1,false,true,"","_this distance _target < 8"]] remoteExec ["addAction",0];
            if (selectRandom[true,false]) then {
               unAssignVehicle _thisCiv;
               _thisCiv action ["eject",vehicle _thisCiv];
               [_thisCiv,_pissedcivsound] remoteExecCall ["say3D", 0];
               [[], 'scripts\badintel.sqf'] remoteExec ['BIS_fnc_execVM', _nearestunits];
               _thisCiv addMagazines ["HandGrenade_Stone", 10];
               _thisCiv addEventHandler ["Fired", {
                  if ( (_this select 2) isEqualTo "HandGrenade_Stone" ) then
                  {
                     (_this select 6) spawn
                     {_throw = selectRandom ["glass","bricks","bricks"];               
                        UIsleep 1;
                              [_this,_throw] remoteExecCall ["say3D", 0];
                        UIsleep 2;
                              [_this,_throw] remoteExecCall ["say3D", 0];
                        UIsleep 1;
                        deleteVehicle _this;
                     };
                  };
               }];
               _thisCiv dotarget _x;
               [_thisciv,_pissedcivsound] remoteExecCall ["say3D", 0];
               _thisCiv dofire _x;
               _bFired = true;
            }  
            else
            {
               if (selectRandom[false,false,true,false,false]) then {
                  if (vehicle _thisCiv != _thisCiv) then {
                     [_thisciv,_broke] remoteExecCall ["say3D", 0];
                     sleep 1;
                     _carbroke = false;
                     _car = vehicle _thisCiv;
                     _thisCiv disableAi "fsm";
                     _thisCiv disableAi "path";
                     _thisCiv switchmove _civAction1;
                     vehicle _thisCiv setunloadincombat [false,false];
                     sleep 1;
                     vehicle _thisCiv setdamage 0.4;
                     vehicle _thisCiv sethitpointdamage ["hitEngine",1];
                     sleep 2;
                     _oil = "Oil_Spill_F" createVehicle getpos _thisCiv;
                     [_thisCiv,_pissedcivsound] remoteExecCall ["say3D", 0];
                     sleep 2;
                     _bFired = true;
                     while {(damage _car >= 0.39)} do {
                        _carbroke = false;
                        sleep 2;
                     };
                     if (!isNull _car) then {
                        _carbroke = true;
                        [_thisCiv,_happycivsound] remoteExecCall ["say3D", 0];
                        _thisCiv switchmove _civAction;
                        sleep 4;
                        [[], 'scripts\intel.sqf'] remoteExec ['BIS_fnc_execVM', _nearestunits];
                        nul = _thisCiv execvm "scripts\infantry.sqf";
                        sleep 1;
                        _mus2 = [_thisciv, 150, random 360] call BIS_fnc_relPos;
                        _mus1 = nearestBuilding _mus2;
                        [_mus1,_music] remoteExecCall ["say3D", 0];
                        sleep 5;
                        _pos2 = [_thisciv, 800, 360] call BIS_fnc_relPos;
                        _pos = nearestBuilding _pos2;
                        sleep 1.5;
                        [[], 'scripts\intelied.sqf'] remoteExec ['BIS_fnc_execVM', _nearestunits];
                        "ied1" setMarkerpos getpos _pos;
                        hint "IED Marked";
                        nul = execvm "scripts\roadside.sqf";
                        sleep 5;
                        _thisCiv disableAi "path";
                        _thisCiv disableAi "fsm";
                     };
                  };
                  _thisCiv addMagazine "rhs_mag_9x19_17"; 
                  unAssignVehicle _thisCiv;
                  _thisCiv action ["eject",vehicle _thisCiv];
                  sleep (2 + random 10);
                  _thisCiv switchmove _civflee1;
                  [_thisciv,_pissedcivsound] remoteExecCall ["say3D", 0];
                  [[], 'scripts\badintel.sqf'] remoteExec ['BIS_fnc_execVM', _nearestunits];
                  nul = _thisCiv execvm "scripts\infantry.sqf";
               }
               else
               {
                  if (selectRandom[false,false,true,false,false]) then {
                     _thisCiv addMagazine "rhs_mag_9x19_17"; 
                     unAssignVehicle _thisCiv;
                     _thisCiv action ["eject",vehicle _thisCiv];
                     sleep (2 + random 10);
                     [_thisciv,_pissedcivsound] remoteExecCall ["say3D", 0];
                     [[], 'scripts\badintel.sqf'] remoteExec ['BIS_fnc_execVM', _nearestunits];
                     _thisCiv setCombatMode "Red";
                     _thisCiv addMagazine "rhs_mag_9x19_17"; 
                     _thisCiv addWeapon "rhs_weap_pya";
                     _thisCiv dotarget _x;
                     _thisCiv dofire _x;
                     _thisCiv domove getpos _x; 
                     _grpName = createGroup east;
                     [_thisCiv] join _grpName;
                     _bFired = true;
                  }
                  else
                  {
                     if (selectRandom[false,false,true,false,false,false]) then {

                        _thisCiv domove getpos _x;
                        nul = _thisCiv execvm "scripts\mortar.sqf";
                        unAssignVehicle _thisCiv;
                        _thisCiv action ["eject",vehicle _thisCiv];
                        sleep 1.5;
                        [_thisCiv,_pissedcivsound] remoteExecCall ["say3D", 0];
                        [[], 'scripts\badintel.sqf'] remoteExec ['BIS_fnc_execVM', _nearestunits];
                        _thisCiv switchmove _civflee1;
                        _bFired = true;
                     }
                     else
                     {
                        if (selectRandom[true,false]) then {
                           unAssignVehicle _thisCiv;
                           _thisCiv action ["eject",vehicle _thisCiv];
                           sleep 1.5;
                           [_thisCiv,_pissedcivsound] remoteExecCall ["say3D", 0];
                           [[], 'scripts\badintel.sqf'] remoteExec ['BIS_fnc_execVM', _nearestunits];
                           sleep 1;
                           [_thisCiv,_pissedcivsound] remoteExecCall ["say3D", 0];
                           _thisCiv addMagazines ["HandGrenade_Stone", 10];
                           _thisCiv addEventHandler ["Fired", {
                              if ( (_this select 2) isEqualTo "HandGrenade_Stone" ) then
                              {
                                 (_this select 6) spawn
                                 {
                                    _throw = selectRandom ["glass","bricks","bricks"];               
                                    UIsleep 1;
                                    [_this,_throw] remoteExecCall ["say3D", 0];
                                    UIsleep 2;
                                    [_this,_throw] remoteExecCall ["say3D", 0];
                                    UIsleep 1;
                                    deleteVehicle _this;
                                 };
                              };
                           }];
                           _thisCiv dotarget _x;
                           [_thisciv,_pissedcivsound] remoteExecCall ["say3D", 0];
                           _thisCiv dofire _x;
                           _bFired = true;
                        } 
                        else
                        {                  
                           if (selectRandom[true,false]) then {
                              unAssignVehicle _thisCiv;
                              _thisCiv action ["eject",vehicle _thisCiv];
                              [_thisCiv,_pissedcivsound] remoteExecCall ["say3D", 0];
                              sleep 1;
                              civ = false;
                              nul = _thisCiv execvm "scripts\enemy.sqf";
                              [[], 'scripts\badintel.sqf'] remoteExec ['BIS_fnc_execVM', _nearestunits];
                              _thisCiv switchmove _civflee;
                              nul = _thisCiv execvm "scripts\enemy.sqf";
                              _thisCiv addMagazines ["HandGrenade_Stone", 2];
                              _thisCiv addMagazines ["rhs_mag_9x19_17", 1];
                              [_thisCiv,_pissedcivsound] remoteExecCall ["say3D", 0];
                              _thisCiv switchmove _civflee1;
                              _bFired = true;
                           }                     
                           else
                           { 
                              while {alive _thisCiv && !_bFired} do {
                                 _mus2 = [_thisciv, 150, random 360] call BIS_fnc_relPos;
                                 _mus1 = nearestBuilding _mus2;
                                 _mus = "Land_FMradio_F" createVehicle getpos _mus1;
                                 [_mus,_music] remoteExecCall ["say3D", 0];
                                 if (vehicle _thisCiv != _thisCiv) then {[vehicle _thisCiv,_music] remoteExecCall ["say3D", 0];};
                                 nul = _thisCiv execvm "scripts\mortar.sqf";
                                 _thisCiv addMagazine "rhs_mag_9x19_17";
                                 [_thisCiv,_pissedcivsound] remoteExecCall ["say3D", 0];
                                 unAssignVehicle _thisCiv;
                                 _thisCiv action ["eject",vehicle _thisCiv];
                                 sleep (2 + random 10);
                                 [_thisCiv,_pissedcivsound] remoteExecCall ["say3D", 0];
                                 _thisCiv switchmove _civflee1;
                                 [_thisCiv,_pissedcivsound] remoteExecCall ["say3D", 0];
                                 [[], 'scripts\badintel.sqf'] remoteExec ['BIS_fnc_execVM', _nearestunits];
                                 _thisCiv addMagazines ["rhs_mag_9x19_17", 1];
                                 _thisCiv addMagazines ["HandGrenade_Stone", 6];
                                 _thisCiv addEventHandler ["Fired", {
                                    if ( (_this select 2) isEqualTo "HandGrenade_Stone" ) then
                                    {
                                       (_this select 6) spawn
                                       {_throw = selectRandom ["glass","bricks","bricks"];               
                                          UIsleep 1;
                                          [_this,_throw] remoteExecCall ["say3D", 0];
                                          UIsleep 2;
                                          [_this,_throw] remoteExecCall ["say3D", 0];
                                          UIsleep 1;
                                          deleteVehicle _this;
                                       };
                                    };
                                 }];
                                 _thisCiv dotarget _x;
                                 [_thisciv,_pissedcivsound] remoteExecCall ["say3D", 0];
                                 _thisCiv dofire _x;
                                 _bFired = true;
                              };
                           };
                        };
                     };
                  }; 
               };
            };
         };
      };
   } forEach _nearestunits;
   sleep 2;
   {
      if ((isPlayer _x) && (weaponLowered _x)) then {
         if (!_bActivated) then {
            _bActivated = true;
            [_thisCiv,["Check ID","scripts/detain.sqf",[],1,false,true,"","_this distance _target < 8"]] remoteExec ["addAction",0];
            if (selectRandom[true,false]) then {
               unAssignVehicle _thisCiv;
               _thisCiv action ["eject",vehicle _thisCiv];
               sleep 3;
               _thisCiv domove getpos _x;
               [_thisCiv,_happycivsound] remoteExecCall ["say3D", 0];
               [[], 'scripts\goodintel.sqf'] remoteExec ['BIS_fnc_execVM', _nearestunits];
            }
            else
            {
               if (selectRandom[false,false,true,false]) then {
                  waitUntil { sleep 3; (_thisciv distance _x) < 80 };
                  if (vehicle _thisCiv != _thisCiv) then {
                     _bFired = true;
                     [_thisciv,_broke] remoteExecCall ["say3D", 0];
                     sleep 1;
                     _carbroke = false;
                     _car = vehicle _thisCiv;
                     _thisCiv disableAi "fsm";
                     _thisCiv disableAi "path";
                     sleep 1;
                     [_thisCiv,_pissedcivsound] remoteExecCall ["say3D", 0];
                     vehicle _thisCiv setdamage 0.4;
                     vehicle _thisCiv sethitpointdamage ["hitEngine",1];
                     _oil = "Oil_Spill_F" createVehicle getpos _thisCiv;
                     _thisCiv domove getpos _x;
                     sleep 2;
                     _thisCiv switchmove _civAction1;
                     while {(damage _car >= 0.39)} do {
                     _carbroke = false;
                     sleep 2;
                  };
                  if (!isNull _car) then {
                     _carbroke = true;
                     [_thisCiv,_happycivsound] remoteExecCall ["say3D", 0];
                     _thisCiv switchmove _civAction;
                     sleep 4;
                     [[], 'scripts\intel.sqf'] remoteExec ['BIS_fnc_execVM', _nearestunits];
                     nul = _thisCiv execvm "scripts\infantry.sqf";
                     sleep 1;
                     _pos2 = [_thisciv, 200, 360] call BIS_fnc_relPos;
                     _pos = nearestBuilding _pos2;
                     sleep 1.5;
                     "con1" setMarkerpos getpos _pos;
                     sleep 1;
                     nul = execvm "scripts\convoyGeneral.sqf";
                     _thisCiv enableAi "fsm";
                     _thisCiv enableAi "path";
                     _thisCiv switchmove "";
                  };
               };
            }
            else
               {
                  if (selectRandom[false,false,true,false,false]) then {
                     _thisCiv addMagazine "rhs_mag_9x19_17"; 
                     unAssignVehicle _thisCiv;
                     _thisCiv action ["eject",vehicle _thisCiv];
                     sleep 1.5;
                     [_thisCiv,_happycivsound] remoteExecCall ["say3D", 0];
                     sleep (2 + random 10);
                     [_thisciv,_pissedcivsound] remoteExecCall ["say3D", 0];
                     _thisCiv setCombatMode "Red";
                     _thisCiv addMagazine "rhs_mag_9x19_17"; 
                     _thisCiv addWeapon "rhs_weap_pya";
                     _thisCiv dotarget _x;
                     _thisCiv dofire _x;
                     _thisCiv domove getpos _x; 
                     _grpName = createGroup east;
                     [_thisCiv] join _grpName;
                     _bFired = true;
                  }
                  else
                  {
                     if (selectRandom[false,false,true,false,false,false]) then {
                        _thisCiv domove getpos _x;
                        unAssignVehicle _thisCiv;
                        _thisCiv action ["eject",vehicle _thisCiv];
                        sleep 4;
                        _thisCiv disableAi "fsm";
                        _thisCiv disableAi "path";
                        sleep 1;
                        _thisCiv switchmove _civAction1;
                        [_thisCiv,_happycivsound] remoteExecCall ["say3D", 0];
                        [[], 'scripts\goodintel.sqf'] remoteExec ['BIS_fnc_execVM', _nearestunits];
                        waitUntil { sleep 2; ((_thisciv distance _x) < 4) && (alive _thisciv)};
                        [_thisCiv,_happycivsound1] remoteExecCall ["say3D", 0];
                        [[], 'scripts\intel.sqf'] remoteExec ['BIS_fnc_execVM', _nearestunits];
                        _thisCiv domove getpos _x;
                        _thisCiv switchmove _civAction;
                        sleep 1.5;
                        _pos2 = [_thisciv, 3500, 360] call BIS_fnc_relPos;
                        _pos = nearestBuilding _pos2;
                        sleep 1.5;
                        _marker = "Markername" + (str _pos);
                        _marker1 = "Markername1" + (str _pos);
                        createMarker [_marker,getPos _pos];
                        createMarker [_marker1,getPos _pos];
                        _marker1 setMarkersize [30,30];
                        _marker setMarkerType "hd_Warning";
                        _marker setMarkerText "Civilian Intel";
                        _marker setMarkercolor "ColorRed";
                        "con1" setMarkerpos getpos _pos;
                        sleep 0.5;
                        _obj2 = "CamoNet_BLUFOR_open_F" createVehicle getpos _pos;
                        _obj1 = "SatelliteAntenna_01_Small_Sand_F" createVehicle getpos _pos;
                        //addaction on object	
                        //_addActionParams = ["Take USB", {_obj1 = _this select 0;}];	
                        _addActionParams = ["Take USB", {_obj1 = _this select 0;a4a = true;publicvariable "a4a";_obj1 say3d["rhs_rus_land_rc_11",100,1];}];	
                        [_obj1,_addActionParams] remoteExec ["addAction", 0, true];
                        "ied" setmarkerpos getpos _pos;
                        sleep 1.5;
                        [_thisCiv,_happycivsound1] remoteExecCall ["say3D", 0];
                        nul = [] execVM "scripts\ied.sqf";
                        hint "Intel Marked";
                        null = [[_marker1],[2,1,100],[2,0,50],[1,1,50],[0,0,0],[1,50],[0,0,0],[0,1,5000,EAST,false,false]] call EOS_Spawn;
                        _thisCiv enableAi "path";
                        _thisCiv enableAi "fsm";
                        _thisCiv switchmove "";
                        _bFired = true;
                     }
                     else
                     {
                        if (selectRandom[true,false]) then {
                           _mus2 = [_thisciv, 150, random 360] call BIS_fnc_relPos;
                           _mus1 = nearestBuilding _mus2;
                           _mus = "Land_FMradio_F" createVehicle getpos _mus1;
                           [_mus,_music] remoteExecCall ["say3D", 0];
                           unAssignVehicle _thisCiv;
                           _thisCiv action ["eject",vehicle _thisCiv];
                           _thisCiv domove getpos _x;
                           [_thisCiv,_happycivsound] remoteExecCall ["say3D", 0];
                           [[], 'scripts\goodintel.sqf'] remoteExec ['BIS_fnc_execVM', _nearestunits];
                           _bFired = true;
                        }
                        else
                        {                  
                           if (selectRandom[true,false]) then {
                              unAssignVehicle _thisCiv;
                              _thisCiv action ["eject",vehicle _thisCiv];
                              _thisCiv domove getpos _x;
                              [_thisCiv,_happycivsound] remoteExecCall ["say3D", 0];
                              [[], 'scripts\goodintel.sqf'] remoteExec ['BIS_fnc_execVM', _nearestunits];
                              _bFired = true;
                           }                     
                           else
                           { 
                              while {alive _thisCiv && !_bFired} do {
                                 _mus2 = [_thisciv, 150, random 360] call BIS_fnc_relPos;
                                 _mus1 = nearestBuilding _mus2;
                                 _mus = "Land_FMradio_F" createVehicle getpos _mus1;
                                 [_mus,_music] remoteExecCall ["say3D", 0];
                                 if (vehicle _thisCiv != _thisCiv) then {[vehicle _thisCiv,_music] remoteExecCall ["say3D", 0];};
                                 unAssignVehicle _thisCiv;
                                 _thisCiv action ["eject",vehicle _thisCiv];   
                                 _thisCiv domove getpos _x;           
                                 [_thisCiv,_happycivsound] remoteExecCall ["say3D", 0];
                                 _bFired = true;
                              };
                           };
                        };
                     };
                  }; 
               };
            };
         };
      };
   } forEach _nearestunits;
   sleep 2;
}; 