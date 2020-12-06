params ["_objManName","_thisInitPos","_objMan","_walkRadius"];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;

_currentManPos = getPos _objMan;

//hint _objManName;
//sleep 2;
_MoveType = selectRandom ["Man","OpenArea"];
_WalkToPos = getPos _objMan;

//sleep 3;
if (_MoveType == "OpenArea") then {
	_flatPos = nil;
	_flatPos = [_thisInitPos , 10, _walkRadius, 7, 0, 0.5, 0,[[_currentManPos,10]],[_thisInitPos,_thisInitPos], _objMan] call TREND_fnc_findSafePos;
	_WalkToPos = _flatPos;
};
if (_MoveType == "Man") then {
	_nearMen = nearestObjects [_thisInitPos, ["man"], _walkRadius];
	if (count _nearMen > 1) then { //more than one, because we dont want to count our target guy!
		//HERE set array then remove our guy from the array
		_tempMenArray = _nearMen;
		_ItemsToRemove = [_objMan];
		_tempArrayToUse = _tempMenArray - _ItemsToRemove;
		//hint format["ArrayToUse: %1",_tempArrayToUse];
		//sleep 3;
		_WalkToPos = getPos (selectRandom _tempArrayToUse);

	};

};

//hint format["walkto8:%1 - _MoveType: %2 - currentManPos: %3",_WalkToPos,_MoveType,_currentManPos];

//_objMan switchMove "";
_objMan doMove (_WalkToPos);

sleep 2;

format["Man: %1 - WalkToPos: %2 - MoveType: %3",_objMan, _WalkToPos, _MoveType] call TREND_fnc_log;

waitUntil {sleep 1; speed _objMan == 0};
_nearMen = (nearestObjects [_thisInitPos, ["man"], 7]) select {side _x == side _objMan};
_animType = selectRandom [2,3,4];
if (count _nearMen > 1) then {
	_animType = selectRandom [1,2,3,4];
};

if (alive(_objMan) && {behaviour _objMan == "SAFE"}) then {
	switch (_animType) do {
		case 1: { //SALUTE
			_nearMan = _nearMen select 0;
			_azimuth = _objMan getDir _nearMan;
			_objMan setDir _azimuth;
			_azimuth2 = _nearMan getDir _objMan;
			_nearMan setDir _azimuth;
			_objMan playActionNow "Salute";
			_nearMan playActionNow "Salute";
			sleep selectRandom [30,60,120];
			if (!(_objMan getVariable ["StopWalkScript", false])) then {
				_objMan switchMove "";
				_nearMan switchMove "";
			};
		};
		case 2: { //Relax
			_objMan playActionNow "Relax";
			sleep selectRandom [30,60,120];
			if (!(_objMan getVariable ["StopWalkScript", false])) then {
				_objMan switchMove "";
			};
		};
		case 3: { //Binoculars
			_objMan playActionNow "Binoculars";
			sleep selectRandom [30,60,120];
			if (!(_objMan getVariable ["StopWalkScript", false])) then {
				_objMan switchMove "";
			};
		};
		case 4: { //reloadMagazine
			_objMan playActionNow "reloadMagazine";
			sleep selectRandom [30,60,120];
			if (!(_objMan getVariable ["StopWalkScript", false])) then {
				_objMan switchMove "";
			};
		};
		default { };
	};
};

true;