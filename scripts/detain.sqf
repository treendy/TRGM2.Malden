_unit = _this select 0;
_unitplayer = _this select 1;
_happy = selectRandom ["chat","chat2","chat3","chat4","chat5","chat6","chat7","chat8"];
_pissed = selectRandom ["angryciv","angryciv1","angryciv2","angryciv3","angryciv4","angryciv5","angryciv6","angryciv7","angryciv8","angryciv9"]; 
_throw1 = selectRandom [""]; 

       if (!alive _unit) then {
hint "no response";
}
else
{
       if (weaponLowered _unitplayer) then {
removeAllActions _unit;
_unit setcaptive true;
UIsleep 0.6;
_unit domove getpos _unitplayer;
[_unit,_happy] remoteExecCall ["say3D", 0];
UIsleep 1;
hint format["Here is my ID, i am a %1 and my ID %2",getText (configFile >> "CfgVehicles" >> typeOf _unit >> "displayname"),name _unit];
if (selectRandom[false,false,false,true,false,false,false]) then {
       _unit disableAi "move";
       _happycivsound1 = ["mister"];
       [_unit,_happycivsound1] remoteExecCall ["say3D", 0];
       [[], 'scripts\goodintel.sqf'] remoteExec ['BIS_fnc_execVM', _nearestunits];
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
                     nul = [] execVM "scripts\ied.sqf";
                    hint "Intel Marked";
};
[_unit,_happy] remoteExecCall ["say3D", 0];
UIsleep 1;
_unit disableAi "move";
_unit domove getpos _unitplayer;
sleep (6 + random 10);
_unit enableAi "move";
[_unit,_happy] remoteExecCall ["say3D", 0];
_unit setcaptive false;
}
else
{
_unit setcaptive true;
UIsleep 0.6;
removeAllActions _unit;
_unit domove getpos _unitplayer;
[_unit,_pissed] remoteExecCall ["say3D", 0];
UIsleep 0.6;
hint format["Please dont shoot, i am a %1 and my ID %2",getText (configFile >> "CfgVehicles" >> typeOf _unit >> "displayname"),name _unit];
_unit switchmove "Acts_JetsMarshallingStop_loop";
_unit disableAi "anim";
_unit switchmove "Acts_JetsMarshallingStop_loop";
hint format["Here is my ID, i am a %1 and my ID %2",getText (configFile >> "CfgVehicles" >> typeOf _unit >> "displayname"),name _unit];
if (selectRandom[false,false,false,true,false,false,false]) then {
       _unit disableAi "move";
       [[], 'scripts\goodintel.sqf'] remoteExec ['BIS_fnc_execVM', _nearestunits];
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
                     nul = [] execVM "scripts\ied.sqf";
                    hint "Intel Marked";
};
sleep (6 + random 10);
_unit enableAi "anim";
[_unit,_pissed] remoteExecCall ["say3D", 0];
_unit setcaptive false;
};
};
