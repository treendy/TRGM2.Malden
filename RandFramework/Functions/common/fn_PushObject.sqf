params ["_Object", "_caller", "_id", "_args"];
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;

if (count crew _Object > 0) then {
	[(localize "STR_TRGM2_PushObject_PushEmpty")] call TREND_fnc_notify;
}
else {
	if (_caller isEqualTo player) then {
		_Object allowdamage false;
		_Object setdamage 0;

		if (!local _Object) then {
			private _makeLocalStartTime = time;
			_Object setOwner (owner player);
			waitUntil {sleep 2; local _Object || time > _makeLocalStartTime + 1.5};
		};

		sleep 0.5;

		_actionReleaseObject = player addAction [format [localize "STR_TRGM2_openDialogRequests_VehicleRelease", getText (configFile >> "CfgVehicles" >> (typeOf _Object)>> "displayName")], {
			params ["_player", "_caller", "_actionId", "_arguments"];
			_arguments params ["_target"];
			detach _target;
			_target setPos [getPos _target select 0, getPos _target select 1];
			_target setVectorUp surfaceNormal position _target;
			_target allowDamage true;
			_player removeAction _actionId;
			[_target, [format [localize "STR_TRGM2_UnloadDingy_push", getText (configFile >> "CfgVehicles" >> (typeOf _target) >> "displayName")],{_this spawn TREND_fnc_PushObject;}, [], -99, false, false, "", "_this isEqualTo player && count crew _target isEqualTo 0"]] remoteExec ["addAction", 0];
		}, [_Object], 5, true, true];

		private _largeObjectCorrection = if (((boundingBoxReal _Object select 1 select 1) - (boundingBoxReal _Object select 0 select 1)) != 0 && {
				((boundingBoxReal _Object select 1 select 0) - (boundingBoxReal _Object select 0 select 0)) > 3.2 &&
				((boundingBoxReal _Object select 1 select 0) - (boundingBoxReal _Object select 0 select 0)) / ((boundingBoxReal _Object select 1 select 1) - (boundingBoxReal _Object select 0 select 1)) > 1.25 })
				then { 90; } else { 0; };

		private _attachPos = [
			(boundingCenter _Object select 0) * cos _largeObjectCorrection - (boundingCenter _Object select 1) * sin _largeObjectCorrection,
			((-(boundingBoxReal _Object select 0 select 0) * sin _largeObjectCorrection) max (-(boundingBoxReal _Object select 1 select 0) * sin _largeObjectCorrection)) + ((-(boundingBoxReal _Object select 0 select 1) * cos _largeObjectCorrection) max (-(boundingBoxReal _Object select 1 select 1) * cos _largeObjectCorrection)) + 2 + 0.3 * (((boundingBoxReal _Object select 1 select 1)-(boundingBoxReal _Object select 0 select 1)) * abs sin _largeObjectCorrection + ((boundingBoxReal _Object select 1 select 0)-(boundingBoxReal _Object select 0 select 0)) * abs cos _largeObjectCorrection),
			-(boundingBoxReal _Object select 0 select 2)
		];
		_Object attachTo [player, _attachPos, "head"];
		_Object removeAction _id;
	} else {
		_newPos = _Object getPos [3, [_caller, _Object] call BIS_fnc_dirTo];
		_Object setPos _newPos;
	};
};
