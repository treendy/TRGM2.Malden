params ["_objManName","_thisInitPos","_objMan","_walkRadius"];

_currentManPos = getPos _objMan;

_MoveType = selectRandom ["Man","OpenArea"];
_WalkToPos = getPos _objMan;

if (_MoveType == "OpenArea") then {
	_flatPos = nil;
	_flatPos = [_thisInitPos , 10, _walkRadius, 7, 0, 0.5, 0,[[_currentManPos,10]],[_thisInitPos,_thisInitPos]] call BIS_fnc_findSafePos;		
	_WalkToPos = _flatPos;
};
if (_MoveType == "Man") then {
	_nearMen = nearestObjects [_thisInitPos, ["man"], _walkRadius];
	if (count _nearMen > 1) then { //more than one, because we dont want to count our target guy!
		//HERE set array then remove our guy from the array
		_tempMenArray = _nearMen;
		_ItemsToRemove = [_objMan];
		_tempArrayToUse = _tempMenArray - _ItemsToRemove;
		_WalkToPos = getPos (selectRandom _tempArrayToUse);
															
	};
														
};


_objMan doMove (_WalkToPos);

sleep 2;


waitUntil {sleep 1; speed _objMan == 0};
_nearMen = nearestObjects [_thisInitPos, ["man"], 7];
if (count _nearMen > 1) then {
	_nearMan = _nearMen select 0;
	_azimuth = _objMan getDir _nearMan;
	_objMan setDir _azimuth;
	_animType = selectRandom [1,2,3,4];
														
	if (_animType == 1) then { //salute
															
	};
	if (_animType == 2) then { //talk
			//TALK
			if (alive(_objMan)) then {[_objMan,"STAND","ASIS"] call BIS_fnc_ambientAnimCombat;};
			sleep selectRandom [30,60,120];
			if (!(_objMan getVariable ["StopWalkScript", false])) then {
				_objMan call BIS_fnc_ambientAnim__terminate
			};

	};
	if (_animType == 3) then { //talk
			//TALK
			if (alive(_objMan)) then {[_objMan,"WATCH","ASIS"] call BIS_fnc_ambientAnimCombat;};
			sleep selectRandom [30,60,120];
			if (!(_objMan getVariable ["StopWalkScript", false])) then {
				_objMan call BIS_fnc_ambientAnim__terminate
			};
	};
	if (_animType == 4) then { //talk
			//TALK
			if (alive(_objMan)) then {[_objMan,"STAND","ASIS"] call BIS_fnc_ambientAnimCombat;};
			sleep selectRandom [30,60,120];
			if (!(_objMan getVariable ["StopWalkScript", false])) then {
				_objMan call BIS_fnc_ambientAnim__terminate
			};
	};
}
else {
	//no man nearby
	_animType = selectRandom [1,2];
	if (_animType == 1) then { //stretch
		if (alive(_objMan)) then {[_objMan,"STAND","ASIS"] call BIS_fnc_ambientAnimCombat;};
		sleep selectRandom [30,60,120];
		if (!(_objMan getVariable ["StopWalkScript", false])) then {
			_objMan call BIS_fnc_ambientAnim__terminate
		};
	};
	if (_animType == 1) then { //Radio
		if (!(_objMan getVariable ["StopWalkScript", false])) then {
			_objMan switchMove "AinvPercMstpSnonWnonDnon_G01";
		};
	};
};
