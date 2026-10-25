//Spawns _count checkpoints/sentries (TRGM_fnc_setCheckpoint), each on a safe position away from the base and existing checkpoints/sentries
params [
	"_aoPos",				//AO centre, passed on to setCheckpoint
	"_count",				//number of checkpoints to try to spawn
	"_guideDist",			//0 = search around _aoPos, otherwise around a random point this far from _aoPos (new random direction per checkpoint)
	"_minDist",				//min distance from the search point
	"_areaRange",			//max distance from the search point (also passed on to setCheckpoint)
	"_roadOnly",
	"_side",
	"_unitTypes",
	"_allowBarricade",		//bool, or an array of bools to pick from at random per checkpoint
	"_dirAwayFromAO",
	"_isCheckpoint",		//true = checkpoint, false = sentry
	"_scoutVehicles",
	"_spacing",
	["_allowAnimation", true],
	["_avoidBase", true],	//also keep away from the base area (mrkHQ)
	["_searchRange", -1]	//max distance for the position search if it should differ from _areaRange (-1 = same as _areaRange)
];
if (_searchRange < 0) then {_searchRange = _areaRange;};

for "_i" from 1 to _count do {
	private _guidePos = _aoPos;
	if (_guideDist > 0) then {_guidePos = _aoPos getPos [_guideDist, floor(random 360)];};

	private _blacklist = CheckPointAreas + SentryAreas;
	if (_avoidBase) then {_blacklist = [[getMarkerPos "mrkHQ", BaseAreaRange]] + _blacklist;};

	private _flatPos = [_guidePos, _minDist, _searchRange, 10, 0, 0.2, 0, _blacklist, [[0,0,0],[0,0,0]]] call BIS_fnc_findSafePos;
	if (_flatPos select 0 > 0) then {
		private _barricade = _allowBarricade;
		if (_allowBarricade isEqualType []) then {_barricade = selectRandom _allowBarricade;};
		[_aoPos, _flatPos, _areaRange, _roadOnly, _side, _unitTypes, _barricade, _dirAwayFromAO, _isCheckpoint, _scoutVehicles, _spacing, _allowAnimation] spawn TRGM_fnc_setCheckpoint;
	};
};
