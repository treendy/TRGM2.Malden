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

		if (_SpottedUnitCount > 2 && _SpottedUnitCount < 5 && _AlivePlayerCount > 7) then {
		//hint "SpottedUnits more than 2";
			_nearestTLs = nearestObjects [_SpottedUnitPos, [sTeamleader, sTeamleaderUrban], 1500];
			_nearestTL = _nearestTLs select 0;

			_nearestTL commandMove (_SpottedUnitPos); 
			group _nearestTL setCombatMode "RED";
			group _nearestTL setFormation "WEDGE";
			group _nearestTL setSpeedMode "FULL";


			if (selectRandom[true]) then {
				_nearestTanks = nearestObjects [_SpottedUnitPos, [sTank1,sTank2,sTank3], 5000];
				if (count _nearestTanks > 0) then {
					_nearestTank = selectRandom _nearestTanks;
					_nearestTLTankwPosArray = waypoints group _nearestTank;

					_nearestTank commandMove (_SpottedUnitPos); 
					group _nearestTank setCombatMode "RED";
					group _nearestTank setFormation "WEDGE";
					group _nearestTank setSpeedMode "FULL";
				};
			};

		};

		if (_SpottedUnitCount > 4 || _AlivePlayerCount < 8) then {
		//hint "SpottedUnits more than 4";
			_nearestTLs = nearestObjects [_SpottedUnitPos, [sTeamleader, sTeamleaderUrban], 1500];
			if (count _nearestTLs > 0) then {
				_nearestTL1 = _nearestTLs select 0;
				
				_nearestTL1 commandMove (_SpottedUnitPos); 
				group _nearestTL1 setCombatMode "RED";
				group _nearestTL1 setFormation "WEDGE";
				group _nearestTL1 setSpeedMode "FULL";

			};
			if (count _nearestTLs > 1) then {
				_nearestTL2 = _nearestTLs select 1;

				_nearestTL2 commandMove (_SpottedUnitPos); 
				group _nearestTL2 setCombatMode "RED";
				group _nearestTL2 setFormation "WEDGE";
				group _nearestTL2 setSpeedMode "FULL";

			};

			if (count _nearestTLs > 2) then {
				_nearestTL3 = _nearestTLs select 2;

				_nearestTL3 commandMove (_SpottedUnitPos); 
				group _nearestTL3 setCombatMode "RED";
				group _nearestTL3 setFormation "WEDGE";
				group _nearestTL3 setSpeedMode "FULL";

			};

			if (selectRandom[true]) then {
				_nearestTanks = nearestObjects [_SpottedUnitPos, [sTank1,sTank2,sTank3], 5000];
				if (count _nearestTanks > 0) then {
					_nearestTank = _nearestTanks select 0;
					
					_nearestTank commandMove (_SpottedUnitPos); 
					group _nearestTank setCombatMode "RED";
					group _nearestTank setFormation "WEDGE";
					group _nearestTank setSpeedMode "FULL";

				};
			};

			if (selectRandom[true,false,false]) then {
				_nearestArts = nearestObjects [_SpottedUnitPos, [sArtilleryVeh], 2000];
				if (count _nearestArts > 0) then {
					_nearestArt =  selectRandom _nearestArts;
					_nearestArt reveal selectRandom _thisThisList;
				};
			};

			if (selectRandom[true]) then {
				_nearestAirs = nearestObjects [_SpottedUnitPos, [sAirSup1,sAirSup2], 15000];
				if (count _nearestAirs > 0) then {
					_nearestAir =  selectRandom _nearestAirs;

					_nearestAir commandMove (_SpottedUnitPos); 
					group _nearestAir setCombatMode "RED";
					group _nearestAir setFormation "WEDGE";
					group _nearestAir setSpeedMode "FULL";

					_nearestAir reveal selectRandom _thisThisList;

				};
			};

		};

		sleep 300; //5 mins

		
		//hint "Ended";
	};
	SpottedActiveFinished = true;
	PublicVariable "SpottedActiveFinished";
};