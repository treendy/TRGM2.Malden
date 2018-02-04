


_unit = _this select 0;

_unitVarType = _unit getVariable ["UnitRole",""];

_tempMergedLoadoutData = LoadoutDataDefault + "#" + LoadoutData;



_chrLineBreak = "
"; // <<< no idea how to find the ascii or char value that i can use to split a string on line breaks... this works for now
_chrTab = "	";

//hint _unitVarType;
if (_tempMergedLoadoutData != "" && _unitVarType !="") then {
	//hint "test3";
	_errorMessage = "";
	_Roles = _tempMergedLoadoutData splitString "#";
	{
		_RoleDetails = _x splitString ":";
		_roleType = _RoleDetails select 0;
		_roleType = _roleType splitString " " joinString ""; 
		_roleType = _roleType splitString _chrLineBreak joinString ""; 		
		_roleType = _roleType splitString _chrTab joinString ""; 		
		
		//hint str(_roleType + " " + _unitVarType);
		//sleep 0.5;
		if (_roleType == _unitVarType) then {
			_loadoutoptions = (_RoleDetails select 1) splitString ";";
			removeAllWeapons _unit;
			removeAllItems _unit;
			removeAllAssignedItems _unit;
			removeUniform _unit;
			removeVest _unit;
			removeBackpack _unit;
			removeHeadgear _unit;
			removeGoggles _unit;
			//sleep 2;
			{
				_line = _x splitString "=";
				//hint str(_line);
				//sleep 0.5;
				_command = _line select 0;
				_object = _line select 1;

				if (!isNil "_command" && !isNil "_object") then {
					_command = _command splitString " " joinString ""; 
					_command = _command splitString _chrLineBreak joinString ""; 		
					_command = _command splitString _chrTab joinString "";
					_object = _object splitString " " joinString ""; 
					_object = _object splitString _chrLineBreak joinString ""; 		
					_object = _object splitString _chrTab joinString ""; 	
					//_object = str(_object);

					//hint _command;
					//sleep 0.5;
					//hint format ["%1 - %2",_command,_object];
					//sleep 1;
					switch (_command) do {
						case "forceAddUniform" : {							
							_unit forceAddUniform _object;
						};
						case "addItemToUniform" : {
							_unit addItemToUniform _object;
						};
						case "addVest" : {
							_unit addVest _object;
						};
						case "addItemToVest" : {
							_unit addItemToVest _object;
						};
						case "addBackpack" : {
							_unit addBackpack _object;
						};
						case "addItemToBackpack" : {
							_unit addItemToBackpack _object;
						};
						case "addHeadgear" : {
							_unit addHeadgear _object;
						};
						case "addGoggles" : {
							_unit addGoggles _object;
						};
						case "addWeapon" : {
							_unit addWeapon _object;
						};
						case "addPrimaryWeaponItem" : {
							_unit addPrimaryWeaponItem _object;
						};
						case "linkItem" : {
							_unit linkItem _object;
						};
						case "setFace" : {
							_unit setFace _object;
						};
						case "setSpeaker" : {
							_unit setSpeaker _object;
						};
					};
				};

			} forEach _loadoutoptions;
		};

	} forEach _Roles;
	if (_errorMessage != "") then {
		hint  _errorMessage;
	};
};



