
#define FADE_DELAY	0.15

#define STATS\
	["maxspeed","armor","fuelcapacity","threat"],\
	[false,true,false,false]

disableSerialization;

_mode = [_this,0,"Open",[displaynull,""]] call BIS_fnc_param;
_this = [_this,1,[]] call BIS_fnc_param;

private _fnc_compareTextures =
{
	params ["_vehtex", "_cfgtex"];
	if (_cfgtex isEqualTo "") exitWith { true }; // empty/absent config texture == any texture
	if (_vehtex find "\" != 0) then {_vehtex = "\" + _vehtex};
	if (_cfgtex find "\" != 0) then {_cfgtex = "\" + _cfgtex};
	_vehtex == _cfgtex
};

private _checkboxTextures =
[
	tolower gettext (configFile >> "RscCheckBox" >> "textureUnchecked"),
	tolower gettext (configFile >> "RscCheckBox" >> "textureChecked")
];

///////////////////////////////////////////////////////////////////////////////////////////
if (_mode isEqualTo "draw3D") exitWith
{
	private _display = uiNamespace getVariable ["TREND_vehicleDisplay", findDisplay 8080];

	private _cam = uiNamespace getvariable ["TREND_vehicleCam", objnull];
	private _center = uiNamespace getvariable ["TREND_vehicleCenter", player];
	private _target = uiNamespace getvariable ["TREND_vehicleTarget", player];

	TREND_vehicleCamPos params ["_dis", "_dirH", "_dirV", "_targetPos"];

	[_target, [_dirH + 180, -_dirV, 0]] call BIS_fnc_setObjectRotation;
	_target attachTo [_center, _targetPos, ""]; //--- Reattach for smooth movement
	_cam attachto [_target,[0, -_dis, 0],""];
	_cam setdir 0;

	//--- Make sure the camera is not underground
	if ((getPosASLVisual _cam select 2) < (getPosASLVisual _center select 2)) then
	{
		_cam attachto [_target,[0, -_dis * (((getPosASLVisual _target select 2) - (getPosASLVisual _center select 2)) / ((getPosASLVisual _target select 2) - (getPosASLVisual _cam select 2) + 0.001)), 0],""];
		_cam setdir 0;
	};
};

///////////////////////////////////////////////////////////////////////////////////////////
if (_mode isEqualTo "Mouse") exitwith
{
	params ["_ctrl", "_mX", "_mY"];
	private _cam = uiNamespace getvariable ["TREND_vehicleCam", objnull];
	private _center = uiNamespace getvariable ["TREND_vehicleCenter", player];
	private _target = uiNamespace getvariable ["TREND_vehicleTarget", player];

	TREND_vehicleCamPos params ["_dis", "_dirH", "_dirV", "_targetPos"];

	TREND_vehicleButtons params ["_LMB", "_RMB"];

	if (isnull _ctrl) then { _LMB = [0,0] }; //--- Init

	if (count _LMB > 0) then
	{
		_LMB params ["_cX", "_cY"];

		TREND_vehicleButtons set [0, [_mX, _mY]];

		(boundingboxreal _center) params ["_minBox", "_maxBox"];
		private _centerSizeBottom = _minBox select 2;
		private _centerSizeUp = _maxBox select 2;
		private _centerSize = sqrt ([_minBox select 0, _minBox select 1] distance2D [_maxBox select 0, _maxBox select 1]);

		private _z = _targetPos select 2;
		_targetPos = _targetPos getPos [(_cX - _mX) * _centerSize, _dirH - 90];
		_z = (_z - (_cY - _mY) * _centerSize) max _centerSizeBottom min _centerSizeUp;
		_targetPos = [0,0,0] getPos [([0,0,0] distance2D _targetPos) min _centerSize, [0,0,0] getDir _targetPos];
		_targetPos set [2, _z max ((_minBox select 2) + 0.2)];

		TREND_vehicleCamPos set [3, _targetPos];
	};

	if (count _RMB > 0) then
	{
		_RMB params ["_cX", "_cY"];

		private _dX = (_cX - _mX) * 0.75;
		private _dY = (_cY - _mY) * 0.75;
		private _z = _targetPos select 2;

		_targetPos = [0,0,0] getPos [[0,0,0] distance2D _targetPos, ([0,0,0] getDir _targetPos) - _dX * 180];
		_targetPos set [2, _z];

		TREND_vehicleCamPos set [1, (_dirH - _dX * 180) % 360];
		TREND_vehicleCamPos set [2, (_dirV - _dY * 100) max -89 min 89];
		TREND_vehicleCamPos set [3, _targetPos];
		TREND_vehicleButtons set [1, [_mX,_mY]];
	};

	if (isnull _ctrl) then { TREND_vehicleButtons = [[],[]]; };

	//--- Terminate when unit is dead
	if (!alive _center || isnull _center) then
	{
		["Exit",[]] call TREND_fnc_openVehicleCustomizationDialog;
	};
};

switch _mode do {
	case "Open": {
		params ["_center"];
		if !(isnull (uinamespace getvariable ["TREND_vehicleCam", objnull])) exitwith { "Vehicle customization is already running" call TREND_fnc_log };
		["BIS_fnc_arsenal"] call BIS_fnc_startLoadingScreen;
		_displayMission = call BIS_fnc_displayMission;
		_display = _displayMission createDisplay "Trend_DialogRequests_VehicleCustomization";
		uiNamespace setVariable ["TREND_vehicleDisplay", _display];
		uiNamespace setVariable ["TREND_vehicleCenter", _center];

		["InitGUI",[_display]] call TREND_fnc_openVehicleCustomizationDialog;
		["Preload"] call TREND_fnc_openVehicleCustomizationDialog;
		["ListAdd",[_display]] call TREND_fnc_openVehicleCustomizationDialog;

		["BIS_fnc_arsenal"] call BIS_fnc_endLoadingScreen;
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "Preload": {
		//--- load only animations and textures
		["bis_fnc_garage_preload"] call BIS_fnc_startLoadingScreen;
		private ["_data"];
		_data = [];
		_center = (uiNamespace getVariable ["TREND_vehicleCenter", player]);
		_centerFaction = faction _center;
		{
			_items = [];
			{
				_configName = configname _x;
				_displayName = gettext (_x >> "displayName");
				_factions = getarray (_x >> "factions");
				if (count _factions == 0) then {_factions = [_centerFaction];};
				if (
					_displayName != ""
					&&
					{getnumber (_x >> "scope") > 1 || !isnumber (_x >> "scope")}
					&&
					{{_x == _centerFaction} count _factions > 0}
				) then {
					_items pushback [_x,_displayName];
				};
			} foreach (configproperties [_x,"isclass _x",true]);
			_data pushback _items;
		} foreach [
			configfile >> "cfgvehicles" >> typeof _center >> "animationSources",
			configfile >> "cfgvehicles" >> typeof _center >> "textureSources"
		];

		uiNamespace setVariable ["TREND_vehicleData",_data];
		["bis_fnc_garage_preload"] call BIS_fnc_endLoadingScreen;
		true
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "ListAdd": {
		_display = uiNamespace getVariable ["TREND_vehicleDisplay", findDisplay 8080];
		_data = uiNamespace getVariable "TREND_vehicleData";
		_center = uiNamespace getVariable ["TREND_vehicleCenter", player];
		_centerTextures = getobjecttextures _center;
		_ctrlList = controlnull;
		{
			_items = _x;
			_idc = _foreachindex;
			_ctrlList = _display displayctrl (960 + _idc);
			{
				_configName = configname (_x select 0);
				_displayName = _x select 1;
				_addToList = true;
				if (_idc == 0) then {
					private _checkCfg = (configfile >> "cfgvehicles" >> typeof _center >> "AnimationSources" >> _configName);
					_addToList = ((getNumber(_checkCfg >> "initPhase") != 1) && !(isText(_checkCfg >> "onPhaseChanged")));
				};
				if (_addToList) then {
					_lbAdd = _ctrlList lbadd _displayName;
					_ctrlList lbsetdata [_lbAdd,_configName];
					_ctrlList lbsettooltip [_lbAdd,_displayName];
					if (_idc == 0) then
					{
						_ctrlList lbsetpicture [_lbAdd,_checkboxTextures select ((_center animationphase _configName) max 0)];
					}
					else
					{
						private _cfg = configfile >> "cfgvehicles" >> typeof _center >> "texturesources" >> _configName;

						private _configTextures = getarray (_cfg >> "textures");
						private _decals = getarray (_cfg >> "decals");
						private _selected =
						({
							if !(_forEachIndex in _decals || { [_x, _configTextures param [_forEachIndex, ""]] call _fnc_compareTextures }) exitWith { false };
							true
						}
						forEach _centerTextures);

						_ctrlList lbsetpicture [_lbAdd,_checkboxTextures select _selected];
					};
				};
			}
			foreach _items;
			lbsort _ctrlList;

			_ctrlListDisabled = _display displayctrl (860 + _idc);
			_ctrlListDisabled ctrlshow (lbsize _ctrlList == 0);
		} foreach _data;
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "Exit":
	{
		with missionnamespace do {
			[missionnamespace,"garageClosed",[displaynull,false]] call BIS_fnc_callScriptedEventHandler;
		};

		removeMissionEventHandler ["draw3D", (uiNamespace getVariable "TREND_vehicleDraw3D")];

		private _cam = uinamespace getvariable ["TREND_vehicleCam", objnull];
		private _target = uinamespace getvariable ["TREND_vehicleTarget", player];
		_camData = [getPosASLVisual _cam,(getPosASLVisual _cam) vectorfromto (getPosASLVisual _target)];
		_cam cameraeffect ["terminate","back"];
		camdestroy _cam;

		private _center = uinamespace getvariable ["TREND_vehicleCenter", player];

		//--- Restore original camera view
		player switchcamera (uiNamespace getVariable "TREND_playerBaseView");
		showhud true;

		// exit
		TREND_vehicleCamPos = nil;
		uiNamespace setvariable ["TREND_vehicleCam", nil];

		deletevehicle (uiNamespace getvariable ["TREND_vehicleTarget", objnull]);

		uiNamespace setVariable ["TREND_vehicleTarget", nil];
		uiNamespace setVariable ["TREND_vehicleCenter", nil];

		if !(isnull curatorcamera) then {
			curatorcamera setPosASL (_camData select 0);
			curatorcamera setvectordir (_camData select 1);
			curatorcamera cameraeffect ["internal","back"];
		};

		with missionnamespace do {
			[missionnamespace,"arsenalClosed",[displaynull,false]] call BIS_fnc_callScriptedEventHandler;
		};

		uiNamespace setVariable ["TREND_vehicleDisplay", nil];
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "MouseButtonDown": {
		TREND_vehicleButtons set [_this select 1, [_this select 2, _this select 3]];
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "MouseButtonUp": {
		TREND_vehicleButtons set [_this select 1,[]];
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "MouseZChanged":
	{
		private _cam = uinamespace getvariable ["TREND_vehicleCam", objnull];
		private _center = uinamespace getvariable ["TREND_vehicleCenter", player];
		private _target = uinamespace getvariable ["TREND_vehicleTarget", player];

		private _disMax = (boundingboxreal _center select 0 vectordistance (boundingboxreal _center select 1)) * 1.5;
		private _dis = TREND_vehicleCamPos select 0;
		_dis = _dis - ((_this select 1) / 10);
		_dis = _dis max (_disMax * 0.15) min _disMax;
		TREND_vehicleCamPos set [0, _dis];
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "buttonInterface": {
		_display = uiNamespace getVariable ["TREND_vehicleDisplay", findDisplay 8080];
		_show = !ctrlshown (_display displayctrl 44046);
		{
			_tab = _x;
			{
				_ctrl = _display displayctrl (_tab + _x);
				_ctrl ctrlshow _show;
				_ctrl ctrlcommit FADE_DELAY;
			} foreach [930,960];
			_ctrl = _display displayctrl (_tab + 860);
			_pos = if (_show) then {ctrlposition (_display displayctrl (_tab + 960))} else {[0,0,0,0]};
			_ctrl ctrlsetposition _pos;
			_ctrl ctrlcommit 0;
		} foreach [0, 1];
		{
			_ctrl = _display displayctrl _x;
			_ctrl ctrlshow _show;
			_ctrl ctrlcommit FADE_DELAY;
		} foreach [44046,1800,1801,1803,1804,1805,930,960,994,27903];
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "TabDeselect": {
		_display = uiNamespace getVariable ["TREND_vehicleDisplay", findDisplay 8080];
		_key = _this select 1;

		//--- Deselect
		if ({count _x > 0} count TREND_vehicleButtons == 0) then {

			//--- When interface is hidden, reveal it
			_shown = ctrlshown (_display displayctrl 44046);
			if (!_shown || _key == 1) exitwith {['buttonInterface',[_display]] call TREND_fnc_openVehicleCustomizationDialog;};

			{
				_idc = _x;
				{
					_ctrlList = _display displayctrl (_x + _idc);
					_ctrlLIst ctrlenable false;
					_ctrlList ctrlsetfade 1;
					_ctrlList ctrlcommit FADE_DELAY;
				} foreach [960,860];

				_ctrlTab = _display displayctrl (930 + _idc);
				{
					_x ctrlenable true;
					_x ctrlsetfade 0;
				} foreach [_ctrlTab];

			} foreach [0, 1];

			{
				_ctrl = _display displayctrl _x;
				_ctrl ctrlsetfade 1;
				_ctrl ctrlcommit 0;
			} foreach [1801,994,1803,1804]
		};
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "buttonOK": {
		_display = uiNamespace getVariable ["TREND_vehicleDisplay", findDisplay 8080];
		_display closeDisplay 1;
		["#(argb,8,8,3)color(0,0,0,1)",false,nil,0,[0,0.5]] call BIS_fnc_textTiles;
		["Exit",[]] call TREND_fnc_openVehicleCustomizationDialog;
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "buttonClose": {
		_display = uiNamespace getVariable ["TREND_vehicleDisplay", findDisplay 8080];
		_display closeDisplay 2;
		["#(argb,8,8,3)color(0,0,0,1)",false,nil,0,[0,0.5]] call BIS_fnc_textTiles;
		["Exit",[]] call TREND_fnc_openVehicleCustomizationDialog;
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "buttonCargo": {
		_center = (uiNamespace getvariable ["TREND_vehicleCenter", player]);
		_display = uiNamespace getVariable ["TREND_vehicleDisplay", findDisplay 8080];
		_add = _this select 1;

		_selected = -1;
		{
			_ctrlList = _display displayctrl (960 + _x);
			if (ctrlenabled _ctrlList) exitwith {_selected = _x;};
		} foreach [0,1];
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "TabSelectLeft": {
		_display = uiNamespace getVariable ["TREND_vehicleDisplay", findDisplay 8080];
		_index = _this select 1;
		_center = (uiNamespace getvariable ["TREND_vehicleCenter", player]);

		{
			_idc = _x;
			_active = _idc == _index;

			{
				_ctrlList = _display displayctrl (_x + _idc);
				_ctrlList ctrlenable _active;
				_ctrlList ctrlsetfade ([1,0] select _active);
				_ctrlList ctrlcommit FADE_DELAY;
			} foreach [960,860];

			_ctrlTab = _display displayctrl (930 + _idc);
			_ctrlTab ctrlenable !_active;

			_ctrlList = _display displayctrl (960 + _idc);
			if (_active) then {
				_ctrlLineTabLeft = _display displayctrl 1804;
				_ctrlLineTabLeft ctrlsetfade 0;
				_ctrlTabPos = ctrlposition _ctrlTab;
				_ctrlLineTabPosX = (_ctrlTabPos select 0) + (_ctrlTabPos select 2) - 0.01;
				_ctrlLineTabPosY = (_ctrlTabPos select 1);
				_ctrlLineTabLeft ctrlsetposition [
					safezoneX,//_ctrlLineTabPosX,
					_ctrlLineTabPosY,
					(ctrlposition _ctrlList select 0) - safezoneX,//_ctrlLineTabPosX,
					ctrlposition _ctrlTab select 3
				];
				_ctrlLineTabLeft ctrlcommit 0;
				ctrlsetfocus _ctrlList;
				if (_idc != 0) then { //--- Don't select animation, it would inverse the state
					['SelectItem',[_display,_display displayctrl (960 + _idc),_idc]] call TREND_fnc_openVehicleCustomizationDialog;
				};
			} else {
				if ((_center getVariable "TREND_vehicleIDC") != _idc) then {_ctrlList lbsetcursel -1;};
			};
		} foreach [0,1];

		{
			_ctrl = _display displayctrl _x;
			_ctrl ctrlsetfade 0;
			_ctrl ctrlcommit FADE_DELAY;
		} foreach [1801,994];
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "SelectItem": {
		private ["_ctrlList","_index","_cursel"];
		_display = uiNamespace getVariable ["TREND_vehicleDisplay", findDisplay 8080];
		_ctrlList = _this select 1;
		_idc = _this select 2;
		_cursel = lbcursel _ctrlList;
		if (_cursel < 0) exitwith {};
		_index = _ctrlList lbvalue _cursel;

		_center = (uiNamespace getvariable ["TREND_vehicleCenter", player]);
		_initVehicle = false;

		switch _idc do {
			case 0: {
				_selected = _checkboxTextures find (_ctrlList lbpicture _cursel);
				_ctrlList lbsetpicture [_cursel,_checkboxTextures select ((_selected + 1) % 2)];
				_initVehicle = true;
			};
			case 1: {
				_selected = _checkboxTextures find (_ctrlList lbpicture _cursel);
				for "_i" from 0 to (lbsize _ctrlList - 1) do {
					_ctrlList lbsetpicture [_i,_checkboxTextures select 0];
				};
				_ctrlList lbsetpicture [_cursel,_checkboxTextures select 1];
				_initVehicle = true;
			};

		};
		if (_initVehicle) then {
			_ctrlListTextures = _display displayctrl (960 + 1);
			_ctrlListAnimations = _display displayctrl (960 + 0);
			_textures = "";
			_animations = [];
			for "_i" from 0 to (lbsize _ctrlListTextures - 1) do {
				if ((_ctrlListTextures lbpicture _i) == (_checkboxTextures select 1)) exitwith {_textures = [_ctrlListTextures lbdata _i, 1];};
			};
			for "_i" from 0 to (lbsize _ctrlListAnimations - 1) do {
				_animations pushback (_ctrlListAnimations lbdata _i);
				_animations pushback (_checkboxTextures find (_ctrlListAnimations lbpicture _i));
			};
			[_center,_textures,_animations,true] remoteExecCall ["BIS_fnc_initVehicle", 0, true];
		};

		["SetAnimationStatus",[_display]] call TREND_fnc_openVehicleCustomizationDialog;
		["SetTextureStatus",[_display]] call TREND_fnc_openVehicleCustomizationDialog;
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "SetAnimationStatus":
	{
		_display = uiNamespace getVariable ["TREND_vehicleDisplay", findDisplay 8080];
		_center = (uiNamespace getvariable ["TREND_vehicleCenter", player]);
		_ctrlListAnimations = _display displayctrl (960 + 0);
		for "_i" from 0 to (lbsize _ctrlListAnimations - 1) do {
			_selected = _center animationphase (_ctrlListAnimations lbdata _i);
			_ctrlListAnimations lbsetpicture [_i,_checkboxTextures select _selected];
		};
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "SetTextureStatus":
	{
		private _display = uiNamespace getVariable ["TREND_vehicleDisplay", findDisplay 8080];
		private _center = (uiNamespace getvariable ["TREND_vehicleCenter", player]);
		private _ctrlListTextures = _display displayctrl (960 + 1);
		private _centerTextures = getObjectTextures _center;

		for "_i" from 0 to (lbsize _ctrlListTextures - 1) do
		{
			private _cfg = configfile >> "cfgvehicles" >> typeof _center >> "texturesources" >> (_ctrlListTextures lbdata _i);

			private _configTextures = getarray (_cfg >> "textures");
			private _decals = getarray (_cfg >> "decals");
			private _selected =
			({
				if !(_forEachIndex in _decals || { [_x, _configTextures param [_forEachIndex, ""]] call _fnc_compareTextures }) exitWith { false };
				true
			}
			forEach _centerTextures);

			_ctrlListTextures lbsetpicture [_i,_checkboxTextures select _selected];
		};
	};

	///////////////////////////////////////////////////////////////////////////////////////////
	case "InitGUI":
	{
		_display = uiNamespace getVariable ["TREND_vehicleDisplay", findDisplay 8080];

		TREND_vehicleButtons = [[],[]];

		private _center = uiNamespace getvariable ["TREND_vehicleCenter", player];
		_center hideObject false;
		cuttext ["","plain"];
		showcommandingmenu "";

		//--- Force internal view to enable consistent screen blurring. Restore the original view after closing Arsenal.
		uiNamespace setVariable ["TREND_playerBaseView", cameraview];
		player switchcamera "internal";

		showhud false;

		_display displayaddeventhandler ["mousebuttondown","['MouseButtonDown',_this] call TREND_fnc_openVehicleCustomizationDialog;"];
		_display displayaddeventhandler ["mousebuttonup","['MouseButtonUp',_this] call TREND_fnc_openVehicleCustomizationDialog;"];

		_ctrlMouseArea = _display displayctrl 899;
		_ctrlMouseArea ctrladdeventhandler ["mousemoving","['Mouse',_this] call TREND_fnc_openVehicleCustomizationDialog;"];
		_ctrlMouseArea ctrladdeventhandler ["mouseholding","['Mouse',_this] call TREND_fnc_openVehicleCustomizationDialog;"];
		_ctrlMouseArea ctrladdeventhandler ["mousebuttonclick","['TabDeselect',[ctrlparent (_this select 0),_this select 1]] call TREND_fnc_openVehicleCustomizationDialog;"];
		_ctrlMouseArea ctrladdeventhandler ["mousezchanged","['MouseZChanged',_this] call TREND_fnc_openVehicleCustomizationDialog;"];
		ctrlsetfocus _ctrlMouseArea;

		_ctrlMouseBlock = _display displayctrl 898;
		_ctrlMouseBlock ctrlenable false;
		_ctrlMouseBlock ctrladdeventhandler ["setfocus",{_this spawn {disableserialization; (_this select 0) ctrlenable false; (_this select 0) ctrlenable true;};}];

		_ctrlMessage = _display displayctrl 996;
		_ctrlMessage ctrlsetfade 1;
		_ctrlMessage ctrlcommit 0;

		//--- UI event handlers
		_ctrlButtonInterface = _display displayctrl 44151;
		_ctrlButtonInterface ctrladdeventhandler ["buttonclick","['buttonInterface',[ctrlparent (_this select 0)]] call TREND_fnc_openVehicleCustomizationDialog;"];

		_ctrlButtonOK = _display displayctrl 44346;
		_ctrlButtonOK ctrladdeventhandler ["buttonclick","['buttonOK',[ctrlparent (_this select 0),'init']] call TREND_fnc_openVehicleCustomizationDialog;"];

		_ctrlArrowLeft = _display displayctrl 992;
		_ctrlArrowLeft ctrladdeventhandler ["buttonclick","['buttonCargo',[ctrlparent (_this select 0),-1]] call TREND_fnc_openVehicleCustomizationDialog;"];

		//--- Menus
		_ctrlIcon = _display displayctrl 930;

		if !(isnull _ctrlIcon) then
		{
			_ctrlIconPos = ctrlposition _ctrlIcon;
			_ctrlTabs = _display displayctrl 1800;
			_ctrlTabsPos = ctrlposition _ctrlTabs;
			_ctrlTabsPosX = _ctrlTabsPos select 0;
			_ctrlTabsPosY = _ctrlTabsPos select 1;
			_ctrlIconPosW = _ctrlIconPos select 2;
			_ctrlIconPosH = _ctrlIconPos select 3;
			_columns = (_ctrlTabsPos select 2) / _ctrlIconPosW;
			_rows = (_ctrlTabsPos select 3) / _ctrlIconPosH;
			_gridH = ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25);
			{
				_idc = _x;
				_ctrlTab = _display displayctrl (930 + _idc);

				_ctrlTab ctrladdeventhandler ["buttonclick",format ["['TabSelectLeft',[ctrlparent (_this select 0),%1]] call TREND_fnc_openVehicleCustomizationDialog;",_idc]];
				_ctrlTab ctrladdeventhandler ["mousezchanged","['MouseZChanged',_this] call TREND_fnc_openVehicleCustomizationDialog;"];

				_ctrlList = _display displayctrl (960 + _idc);
				_ctrlList ctrlenable false;
				_ctrlList ctrlsetfade 1;
				_ctrlList ctrlsetfontheight (_gridH * 0.8);
				_ctrlList ctrlcommit 0;

				_ctrlList ctrladdeventhandler ["lbselchanged",format ["['SelectItem',[ctrlparent (_this select 0),(_this select 0),%1]] call TREND_fnc_openVehicleCustomizationDialog;",_idc]];

				_ctrlListDisabled = _display displayctrl (860 + _idc);
				_ctrlListDisabled ctrlenable false;
			}
			foreach [0,1];
		};

		['TabDeselect',[_display,-1]] call TREND_fnc_openVehicleCustomizationDialog;
		['SelectItem',[_display,controlnull,-1]] call TREND_fnc_openVehicleCustomizationDialog;

		_ctrlButtonClose = _display displayctrl 44448;
		_ctrlButtonClose ctrladdeventhandler ["buttonclick","['buttonClose',[ctrlparent (_this select 0)]] spawn TREND_fnc_openVehicleCustomizationDialog; true"];

		{
			_ctrl = _display displayctrl _x;
			_ctrl ctrlenable false;
			_ctrl ctrlsetfade 1;
			_ctrl ctrlcommit 0;
		}
		foreach [1801,994,1803,1804];

		_ctrlSpace = _display displayctrl 27903;
		_ctrlSpace ctrlsetposition [-1,-1,0,0];
		_ctrlSpace ctrlcommit 0;

		//--- Camera init
		TREND_vehicleCamPos = [5,0,0,[0,0,0.85]];

		private _posCenter = getPosASLVisual _center;

		private _target = createAgent ["Logic", _posCenter, [], 0, "none"];
		_target attachTo [_center, TREND_vehicleCamPos select 3, ""];
		uiNamespace setVariable ["TREND_vehicleTarget", _target];

		private _cam = "camera" camCreate _posCenter;
		//_cam setPosASL _posCenter;
		_cam cameraEffect ["internal", "back"];
		_cam camPrepareFocus [-1,-1];
		_cam camPrepareFov 0.35;
		_cam camCommitPrepared 0;
		//cameraEffectEnableHUD true;
		showCinemaBorder false;
		uiNamespace setVariable ["TREND_vehicleCam", _cam];
		["#(argb,8,8,3)color(0,0,0,1)",false,nil,0,[0,0.5]] call BIS_fnc_textTiles;

		//--- Camera reset
		["Mouse", [controlnull, 0, 0]] call TREND_fnc_openVehicleCustomizationDialog;
		_draw3D = addMissionEventHandler ["draw3D", { ["draw3D"] call TREND_fnc_openVehicleCustomizationDialog; }];
		uiNamespace setVariable ["TREND_vehicleDraw3D", _draw3D];
	};
};