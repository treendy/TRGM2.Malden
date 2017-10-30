//({ (alive _x)&&(_x inArea TREND_trg_baseArea) } count (call BIS_fnc_listPlayers))==({ (alive _x) } count (call BIS_fnc_listPlayers))


_thisThis = _this select 0;
_thisThisList = _this select 1;
_FirstPos = _this select 2;
_SecondPos = _this select 3;

if (isServer) then {
	_SpottedUnit = _thisThisList select 0;
	SpottedActiveFinished = false;
	PublicVariable "SpottedActiveFinished";
	
	//_SpottedUnitCount = count _thisThisList;
	//_SpottedUnitCount = FriendlySide countSide nearestObjects [_SpottedUnitPos, [sTeamleader, sTeamleaderUrban], 250];
	_SpottedUnitCount = {_x distance _SpottedUnit < 200} count units group _SpottedUnit;
	_AlivePlayerCount = {alive _x} count allplayers;
	if (_SpottedUnitCount > 2 || _AlivePlayerCount < 8) then {
		
		//hint "Started";
				
		_SpottedUnitPos = getpos (_thisThisList select 0);


		
		//hint "SpottedUnits more than 4";
			_nearestTLs = nearestObjects [_SpottedUnitPos, [sTeamleader, sTeamleaderUrban], 1500];
			if (count _nearestTLs > 0) then {
				_nearestTL1 = _nearestTLs select 0;
				
				_nearestTL1 commandMove (_SpottedUnitPos); 
				group _nearestTL1 setCombatMode "RED";
				group _nearestTL1 setFormation "WEDGE";
				group _nearestTL1 setSpeedMode "FULL";

			};
			

		

		sleep 300; //5 mins

		
		//hint "Ended";
	};
	SpottedActiveFinished = true;
	PublicVariable "SpottedActiveFinished";
};