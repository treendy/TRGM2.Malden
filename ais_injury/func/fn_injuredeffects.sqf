// by EightSix
// or maybee BI...
private ["_unit","_display", "_texLower", "_texMiddle", "_texUpper", "_x", "_y", "_w", "_h"];
_unit = _this select 0;
if (_unit != player) exitWith {};

disableSerialization;
if (isnil {uinamespace getvariable "RscHealthTextures"}) then {uinamespace setvariable ["RscHealthTextures",displaynull]};
if (isnull (uinamespace getvariable "RscHealthTextures")) then {(["HealthPP_blood"] call bis_fnc_rscLayer) cutrsc ["RscHealthTextures","plain"]};
_display = uinamespace getvariable "RscHealthTextures";

_texLower = _display displayctrl 1211;//1013; //1001
_texLower ctrlsetfade 1;
_texLower ctrlcommit 0;

_texMiddle = _display displayctrl 1212;
_texMiddle ctrlsetfade 1;	
_texMiddle ctrlcommit 0;

_texUpper = _display displayctrl 1213;
_texUpper ctrlsetfade 1;	
_texUpper ctrlcommit 0;

_x = ((0 * safezoneW) + safezoneX) + ((safezoneW - (2.125 * safezoneW * 3/4)) / 2); //textura vycentrovana na støed (pøièítá se polovina místa které zbývá od konce textury k pravému okraji obrazovky)
_y = (-0.0625 * safezoneH) + safezoneY; //levy horni roh o 10% nad obrazovkou
_w = 2.125 * safezoneW * 3/4;//safezoneW * 3/4;  //sirka o 20% vetsi nez sirka obrazovky (10% presah vlevo, 10% presah vpravo)
_h = 1.125 * safezoneH;

_texLower ctrlsetposition [_x, _y, _w, _h];
_texMiddle ctrlsetposition [_x, _y, _w, _h];
_texUpper ctrlsetposition [_x, _y, _w, _h];

_texLower ctrlcommit 0;
_texMiddle ctrlcommit 0;
_texUpper ctrlcommit 0;

_texLower ctrlsetfade 0.2;
_texMiddle ctrlsetfade 0.7;
_texUpper ctrlsetfade 0.7;

_texLower ctrlcommit 0.2;
_texMiddle ctrlcommit 0.2;
_texUpper ctrlcommit 0.2;

waituntil {ctrlcommitted _texUpper};
waitUntil {!(_unit getVariable ["tcb_ais_agony",false]) || {!alive _unit}};

sleep 0.5;

_texLower ctrlsetfade 1;
_texMiddle ctrlsetfade 1;
_texUpper ctrlsetfade 1;

_texUpper ctrlcommit 1.5;
sleep 1;
_texMiddle ctrlcommit 1;
sleep 0.5;
_texLower ctrlcommit 0.8;