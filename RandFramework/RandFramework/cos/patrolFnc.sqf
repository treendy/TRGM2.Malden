_group=group (_this select 0);
_group setBehaviour "Combat";
_group setSpeedMode "Normal";

	if (side (_this select 0) == CIVILIAN) 
		then {
	_index = currentWaypoint group player;
	deleteWaypoint [_group, _index];
	_group allowFleeing 1;
		}else{
		deleteWaypoint [_group, _index];
			};
	
(_this select 0) removeAllEventHandlers "FiredNear";