
_DiamPatrolGroupTower = createGroup east;
_wp1Pos = ObjectivePossitions select 0;
_wp2Pos = ObjectivePossitions select 1;
_wp1Tower = _DiamPatrolGroupTower addWaypoint [_wp1Pos, 0];
_wp2Tower = _DiamPatrolGroupTower addWaypoint [_wp2Pos, 0];
if (count ObjectivePossitions > 2) then {
	_wp3Pos = ObjectivePossitions select 2;
	_wp3Tower = _DiamPatrolGroupTower addWaypoint [_wp3Pos, 0];
};


if selectRandom [true,false] then {
	sAAMan createUnit [_wp1Pos, _DiamPatrolGroupTower];
	_iHasAA = 1;
}
else {
	sATMan createUnit [_wp1Pos, _DiamPatrolGroupTower];
	_iHasAT = 1;
};

sRifleman createUnit [_wp1Pos, _DiamPatrolGroupTower];
if selectRandom [true,false] then {sRifleman createUnit [_wp1Pos, _DiamPatrolGroupTower]};
if selectRandom [true,false] then {sRifleman createUnit [_wp1Pos, _DiamPatrolGroupTower]};
if selectRandom [true,false] then {sRifleman createUnit [_wp1Pos, _DiamPatrolGroupTower]};
if selectRandom [true,false] then {sRifleman createUnit [_wp1Pos, _DiamPatrolGroupTower]};


[_DiamPatrolGroupTower, 0] setWaypointSpeed "LIMITED";
[_DiamPatrolGroupTower, 0] setWaypointBehaviour "SAFE";
[_DiamPatrolGroupTower, 1] setWaypointSpeed "LIMITED";
[_DiamPatrolGroupTower, 1] setWaypointBehaviour "SAFE";
[_DiamPatrolGroupTower, count ObjectivePossitions - 1] setWaypointType "CYCLE";
_DiamPatrolGroupTower setBehaviour "SAFE";