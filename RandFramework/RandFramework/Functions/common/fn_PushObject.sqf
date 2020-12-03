params ["_Object", "_caller", "_id", "_args"];

if (count crew _Object > 0) then {
	hint (localize "STR_TRGM2_PushObject_PushEmpty");
}
else {
	if (_caller == player) then {
		_Object allowdamage false;
		_Object setdamage 0;

		if (!local _Object) then {
			private _makeLocalStartTime = time;
			_Object setOwner (owner player);
			waitUntil {local _Object || time > _makeLocalStartTime + 1.5};
		};

		sleep 0.5;

		_actionReleaseObject = _Object addAction [format [localize "STR_TRGM2_openDialogRequests_VehicleRelease", getText (configFile >> "CfgVehicles" >> (typeOf _Object)>> "displayName")], {
			params ["_target", "_caller", "_actionId", "_arguments"];
			detach _target;
			_target setPos [getPos _target select 0, getPos _target select 1];
			_target setVectorUp surfaceNormal position _target;
			_target allowDamage true;
			_target removeAction _actionId;
			[_target, [format [localize "STR_TRGM2_UnloadDingy_push", getText (configFile >> "CfgVehicles" >> (typeOf _target) >> "displayName")],{[_this select 0, _this select 1, _this select 2, _this select 3] spawn TREND_fnc_PushObject;}, [], -99, false, false, "", "_this == player"]] remoteExec ["addAction", 0];
		}, nil, 25, true, true];

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

//hint str(count crew _Object);

