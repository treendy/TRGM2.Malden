#include "../../setUnitGlobalVars.sqf";
#include "trendFunctions.sqf";

//SPAWN vehicle to move from location a and b========================
	try {
		_randInitRoad1 = selectRandom ((getMarkerPos "mrkFirstLocation") nearRoads 300);
		_randInitRoad2 = selectRandom ((getMarkerPos "mrksecondLocation") nearRoads 300);
		
		_groupv1 = createGroup east;
		_iVehDice = (floor random 2) + 1;
		if (_iVehDice == 1) then {
			[position _randInitRoad1, 180, sTank1, _groupv1] call bis_fnc_spawnvehicle;
		};
		if (_iVehDice == 2) then {
			[position _randInitRoad1, 180, sTank2, _groupv1] call bis_fnc_spawnvehicle;
			//_veh = "O_MRAP_02_gmg_F" createVehicle position _road;
		};
		if (_iVehDice == 3) then {
			[position _randInitRoad1,  180, sTank3, _groupv1] call bis_fnc_spawnvehicle;
			//_veh = "O_G_Offroad_01_armed_F" createVehicle position _road;
		};
		
		_v1wp1 =_groupv1 addWaypoint [position _randInitRoad1, 0];
		_v1wp2 =_groupv1 addWaypoint [getMarkerPos "mrkFirstLocation", 0];
		_v1wp3 =_groupv1 addWaypoint [position _randInitRoad2, 0];
		_v1wp4 =_groupv1 addWaypoint [getMarkerPos "mrksecondLocation", 0];
		_v1wp5 =_groupv1 addWaypoint [position _randInitRoad1, 0];
		[_groupv1, 0] setWaypointSpeed "LIMITED";
		[_groupv1, 0] setWaypointBehaviour "SAFE";
		[_groupv1, 1] setWaypointSpeed "LIMITED";
		[_groupv1, 1] setWaypointBehaviour "SAFE";
		[_groupv1, 4] setWaypointType "CYCLE";
		_groupv1 setBehaviour "SAFE";	
		//===================================================================
	}
	catch {
	};
		
		
		
		//Spawn inf to move from a to b and back=============================
		if (selectRandom [true,true,bViolent]) then {
			_groupFromTo = createGroup east; 
			sRifleman createUnit [getMarkerPos "mrkFirstLocation", _groupFromTo];	
			sRifleman createUnit [getMarkerPos "mrkFirstLocation", _groupFromTo];	
			if (selectRandom [true,bViolent]) then {
				sRifleman createUnit [getMarkerPos "mrkFirstLocation", _groupFromTo];	
			};
			_wp1 = _groupFromTo addWaypoint [getMarkerPos "mrkFirstLocation", 0];
			_wp2 = _groupFromTo addWaypoint [getMarkerPos "mrksecondLocation", 0];
			_wp3 = _groupFromTo addWaypoint [getMarkerPos "mrkFirstLocation", 0];
			[_groupFromTo, 0] setWaypointSpeed "LIMITED";
			[_groupFromTo, 0] setWaypointBehaviour "SAFE";
			[_groupFromTo, 1] setWaypointSpeed "LIMITED";
			[_groupFromTo, 1] setWaypointBehaviour "SAFE";
			[_groupFromTo, 2] setWaypointType "CYCLE";
			_groupFromTo setBehaviour "SAFE";
		};
		//===================================================================
		
		_AAAinitX1 = (getMarkerPos "mrkFirstLocation") select 0;
		_AAAinitY1 = (getMarkerPos "mrkFirstLocation") select 1;
	
		_AAAinitX2 = (getMarkerPos "mrksecondLocation") select 0;
		_AAAinitY2 = (getMarkerPos "mrksecondLocation") select 1;
			
		_averageAAAX = (_AAAinitX1 + _AAAinitX2) / 2;
		_averageAAAY = (_AAAinitY1 + _AAAinitY2) / 2;	

		//add minefield============================
	if (AllowMineField) then {
		_distanceToObjLocations = getMarkerPos "mrkFirstLocation" distance [_averageAAAX, _averageAAAY];			
		
		_WhichFieldActive = selectRandom[1,2];
		
		_iMineFieldBotLeftX = 0;
		_iMineFieldBotLeftY = 0;
		_iMineXLen = 0;
		_iMineYLen = 0;
		_iMaxMines = 150;
		_iMinePosition = selectRandom[1,2];		
		_iCountMines = 0;
		_bMinesPlaced = false;
		
		if (_WhichFieldActive == 1) then {
		while {!_bMinesPlaced} do {	
			_iCountMines = _iCountMines + 1;
			
			_MineRandX = 0;
			_MineRandY = 0;
			if (_iMinePosition == 1) then {
				//top section
				_iMineFieldBotLeftX = _averageAAAX - 250;
				_iMineFieldBotLeftY = _averageAAAY + (_distanceToObjLocations + 250);
				_iMineXLen = 500;
				_iMineYLen = 150;
				_MineRandX = _iMineFieldBotLeftX + (floor random 500);
				_MineRandY = _iMineFieldBotLeftY + (floor random 150);
			};
			if (_iMinePosition == 2) then {
				//right section	
				_iMineFieldBotLeftX = _averageAAAX + (_distanceToObjLocations + 250);
				_iMineFieldBotLeftY = _averageAAAY -250;
				_iMineXLen = 150;
				_iMineYLen = 500;
				_MineRandX = _iMineFieldBotLeftX + (floor random 150);
				_MineRandY = _iMineFieldBotLeftY + (floor random 500);			
				
			};
			if (_iMinePosition == 3) then {
				//bottom section
				_iMineFieldBotLeftX = _averageAAAX - 250;
				_iMineFieldBotLeftY = _averageAAAY - (_distanceToObjLocations + 250);
				_iMineXLen = 500;
				_iMineYLen = 150;
				_MineRandX = _iMineFieldBotLeftX + (floor random 500);
				_MineRandY = _iMineFieldBotLeftY + (floor random 150);				
			};
			if (_iMinePosition == 4) then {
				//left section
				_iMineFieldBotLeftX = _averageAAAX - (_distanceToObjLocations + 250);
				_iMineFieldBotLeftY = _averageAAAY - 250;
				_iMineXLen = 150;
				_iMineYLen = 500;
				_MineRandX = _iMineFieldBotLeftX + (floor random 150);
				_MineRandY = _iMineFieldBotLeftY + (floor random 500);				
			};
			
			_objMine = createMine [selectRandom["APERSMine"], [_MineRandX,_MineRandY], [], 0];
			//_objMine = createMine [selectRandom["APERSMine","ATMine"], [_MineRandX,_MineRandY], [], 0];
			//objMine = selectRandom["APERSMine","ATMine"] createVehicle [_MineRandX,_MineRandY];
			//APERSMine  ATMine
			if ("TEST" == "NO") then {
				_markerstrcache = createMarker [format ["CacheLoc%1",_iCountMines],[_MineRandX,_MineRandY]];
				_markerstrcache setMarkerShape "ICON";
				_markerstrcache setMarkerType "hd_dot";
				_markerstrcache setMarkerText "";	
			};
			
			if (_iCountMines == _iMaxMines) then {
				_bMinesPlaced = true;
			};
			
		};	
		};
		
		_iMineFieldBotLeftX = 0;
		_iMineFieldBotLeftY = 0;
		_iMineXLen = 0;
		_iMineYLen = 0;
		_iMaxMines = 150;
		_iMinePosition = selectRandom[3,4];		
		_iCountMines = 0;
		_bMinesPlaced = false;
		
		if (_WhichFieldActive == 2) then {
		while {!_bMinesPlaced} do {	
			_iCountMines = _iCountMines + 1;
			
			_MineRandX = 0;
			_MineRandY = 0;
			if (_iMinePosition == 1) then {
				//top section
				_iMineFieldBotLeftX = _averageAAAX - 250;
				_iMineFieldBotLeftY = _averageAAAY + (_distanceToObjLocations + 250);
				_iMineXLen = 500;
				_iMineYLen = 150;
				_MineRandX = _iMineFieldBotLeftX + (floor random 500);
				_MineRandY = _iMineFieldBotLeftY + (floor random 150);
			};
			if (_iMinePosition == 2) then {
				//right section	
				_iMineFieldBotLeftX = _averageAAAX + (_distanceToObjLocations + 250);
				_iMineFieldBotLeftY = _averageAAAY -250;
				_iMineXLen = 150;
				_iMineYLen = 500;
				_MineRandX = _iMineFieldBotLeftX + (floor random 150);
				_MineRandY = _iMineFieldBotLeftY + (floor random 500);			
				
			};
			if (_iMinePosition == 3) then {
				//bottom section
				_iMineFieldBotLeftX = _averageAAAX - 250;
				_iMineFieldBotLeftY = _averageAAAY - (_distanceToObjLocations + 250);
				_iMineXLen = 500;
				_iMineYLen = 150;
				_MineRandX = _iMineFieldBotLeftX + (floor random 500);
				_MineRandY = _iMineFieldBotLeftY + (floor random 150);				
			};
			if (_iMinePosition == 4) then {
				//left section
				_iMineFieldBotLeftX = _averageAAAX - (_distanceToObjLocations + 250);
				_iMineFieldBotLeftY = _averageAAAY - 250;
				_iMineXLen = 150;
				_iMineYLen = 500;
				_MineRandX = _iMineFieldBotLeftX + (floor random 150);
				_MineRandY = _iMineFieldBotLeftY + (floor random 500);				
			};
			
			//_objMine2 = createMine [selectRandom["APERSMine","ATMine"], [_MineRandX,_MineRandY], [], 0];
			_objMine2 = createMine [selectRandom["APERSMine"], [_MineRandX,_MineRandY], [], 0];
			//objMine = selectRandom["APERSMine","ATMine"] createVehicle [_MineRandX,_MineRandY];
			//APERSMine  ATMine
			if ("TEST" == "NO") then {
				_markerstrcache = createMarker [format ["CacheLoc2%1",_iCountMines],[_MineRandX,_MineRandY]];
				_markerstrcache setMarkerShape "ICON";
				_markerstrcache setMarkerType "hd_dot";
				_markerstrcache setMarkerText "";	
			};
			
			if (_iCountMines == _iMaxMines) then {
				_bMinesPlaced = true;
			};
			
		};
		};
	};	
		//_iMineFieldBotLeftX,_iMineFieldBotLeftY  <<< these will be set for each mine, but will always be set the same... Im just being lazy
		//_markerstr = createMarker [format ["MineLoc%1",_iCountMines], [_iMineFieldBotLeftX+(_iMineXLen/2),_iMineFieldBotLeftY+(_iMineYLen/2)]];
		//_markerstr setMarkerShape "RECTANGLE";
		//_markerstr setMarkerSize [_iMineXLen/2,_iMineYLen/2];	
		//_markerstr setMarkerBrush "DIAGGRID";	
		//_markerstr setMarkerColor "ColorRed";
		//_markerstr setMarkerText "Minefield";
		
		
		//===================================================================
		
		
		
			
		//Add AAA inbetweeen locations.. or sometone around about ==========
		if (selectRandom [true,true,false]) then {
			
			_groupAAAv1 = createGroup east;
			
			_aaaX = _averageAAAX;
			_aaaY = _averageAAAY;
			
			if (selectRandom [true,false]) then {
				_aaaX = (_averageAAAX - 600) + (floor random 600);	
				_aaaY = (_averageAAAY - 600) + (floor random 600);	
			};
	
			_bIsBoat = false;
			_AAAMarkerText = sAAALabel;
			
			if (surfaceIsWater [_aaaX,_aaaY]) then {
				_bIsBoat = true;
				[[_aaaX,_aaaY], (floor random 175+1), sBoatUnit, _groupAAAv1] call bis_fnc_spawnvehicle;
			}
			else {
				[[_aaaX,_aaaY], (floor random 175+1), sAAAVeh, _groupAAAv1] call bis_fnc_spawnvehicle;
			};
			
			_allBuildingsAAA = nearestObjects [[_aaaX,_aaaY], ["house"], 200];
			if (count _allBuildingsAAA > 0) then {
				_randBuildingAAA = selectRandom _allBuildingsAAA;
				_groupInnerHouseAAA = createGroup east; 
				sRifleman createUnit [position _randBuildingAAA, _groupInnerHouseAAA, ""];
				sRifleman createUnit [position _randBuildingAAA, _groupInnerHouseAAA, "[getPosATL this, units group this, -1, false, false] execVM ""RandFramework\Zen_OccupyHouse.sqf"""];
			};
				
			if (!_bIsBoat) then {
			
				_markerstrcache = createMarker ["AAALoc", [_aaaX,_aaaY]];
				_markerstrcache setMarkerColor "ColorRed";
				_markerstrcache setMarkerShape "ICON";
				_markerstrcache setMarkerType selectRandom AAAIcon;
				_markerstrcache setMarkerText _AAAMarkerText;	
			};
		};
		
		//Add ARTIL inbetweeen locations.. or sometone around about ==========
		if (selectRandom [true]) then {
					
			
			_groupAAAv1 = createGroup east;
			
			_aaaX = _averageAAAX;
			_aaaY = _averageAAAY;
			
			if (selectRandom [true]) then {
				//will always be somewhere random (if centered it could land on top of AAA
				_aaaX = (_averageAAAX - 600) + (floor random 600);	
				_aaaY = (_averageAAAY - 600) + (floor random 600);	
			};
	
			
			_AAAMarkerText = sArtiLabel;
			_isBoat = false;
			if (surfaceIsWater [_aaaX,_aaaY]) then {
				_isBoat = true;
				[[_aaaX,_aaaY], (floor random 175+1), sBoatUnit, _groupAAAv1] call bis_fnc_spawnvehicle;
			}
			else {
				[[_aaaX,_aaaY], (floor random 175+1), sArtilleryVeh, _groupAAAv1] call bis_fnc_spawnvehicle;
			};
			
			_allBuildingsAAA = nearestObjects [[_aaaX,_aaaY], ["house"], 200];
			if (count _allBuildingsAAA > 0) then {
				_randBuildingAAA = selectRandom _allBuildingsAAA;
				_groupInnerHouseAAA = createGroup east; 
				sRifleman createUnit [position _randBuildingAAA, _groupInnerHouseAAA, ""];
				sRifleman createUnit [position _randBuildingAAA, _groupInnerHouseAAA, "[getPosATL this, units group this, -1, false, false] execVM ""RandFramework\Zen_OccupyHouse.sqf"""];
			};
				
			if (!_isBoat) then {
				_markerstrcache = createMarker ["ArtilleryLoc", [_aaaX,_aaaY]];
				_markerstrcache setMarkerColor "ColorRed";
				_markerstrcache setMarkerShape "ICON";
				_markerstrcache setMarkerType selectRandom ArtiIcon;
				_markerstrcache setMarkerText _AAAMarkerText;	
			};
		};
		
		//Check if radio tower is near
		//Land_TTowerBig_2_F    Land_TTowerBig_1_F       Land_Communication_F       Land_TBox_F
		_TowerBuildings = TowerBuildings;
		_TowersNear = nearestObjects [[_averageAAAX, _averageAAAY], _TowerBuildings, TowerRadius];
		
		bCommsBlocked = false;
		publicVariable "bCommsBlocked";
		
		if (count _TowersNear == 0) then {
			//[6829.87,20427,1.10159], [7252.98,15862.1,0.835732], [6392.06,12430.5,1.12605], [8171.09,11932.6,0.651466], [11581.8,18393,1.30815],  [13588.5,12170.3,1.023, 02], [15421.3,18911,0.854424], [19992,7956.27,0.97459], [20228.7,12667.5,1.22187], [20905.4,14619.3,1.03596],  [23061.3,21718.5,0.867586]

			_meters = [_averageAAAX, _averageAAAY] distance [6829.87,20427,1.10159];
			_nearestTowerPos = [6829.87,20427,1.10159];
			//for "_i_BaseposCountInnerCount" from 0 to 10 do { 
			//I should really have set this as a loop through an array of locations....
			_meters2 = [_averageAAAX, _averageAAAY] distance [7252.98,15862.1,0.835732];
			if (_meters2 < _meters) then {_nearestTowerPos = [7252.98,15862.1,0.835732]; _meters = _meters2};
			
			_meters2 = [_averageAAAX, _averageAAAY] distance [6392.06,12430.5,1.12605];
			if (_meters2 < _meters) then {_nearestTowerPos = [6392.06,12430.5,1.12605]; _meters = _meters2};
			
			_meters2 = [_averageAAAX, _averageAAAY] distance [8171.09,11932.6,0.651466];
			if (_meters2 < _meters) then {_nearestTowerPos = [8171.09,11932.6,0.651466]; _meters = _meters2};
						
			_meters2 = [_averageAAAX, _averageAAAY] distance [11581.8,18393,1.30815];
			if (_meters2 < _meters) then {_nearestTowerPos = [11581.8,18393,1.30815]; _meters = _meters2};
						
			_meters2 = [_averageAAAX, _averageAAAY] distance [13588.5,12170.3,1.023];
			if (_meters2 < _meters) then {_nearestTowerPos = [13588.5,12170.3,1.023]; _meters = _meters2};
						
			_meters2 = [_averageAAAX, _averageAAAY] distance [15421.3,18911,0.854424];
			if (_meters2 < _meters) then {_nearestTowerPos = [15421.3,18911,0.854424]; _meters = _meters2};
						
			_meters2 = [_averageAAAX, _averageAAAY] distance [19992,7956.27,0.97459];
			if (_meters2 < _meters) then {_nearestTowerPos = [19992,7956.27,0.97459]; _meters = _meters2};
						
			_meters2 = [_averageAAAX, _averageAAAY] distance [20228.7,12667.5,1.22187];
			if (_meters2 < _meters) then {_nearestTowerPos = [20228.7,12667.5,1.22187]; _meters = _meters2};
						
			_meters2 = [_averageAAAX, _averageAAAY] distance [20905.4,14619.3,1.03596];
			if (_meters2 < _meters) then {_nearestTowerPos = [20905.4,14619.3,1.03596]; _meters = _meters2};
						
			_meters2 = [_averageAAAX, _averageAAAY] distance [23061.3,21718.5,0.867586];
			if (_meters2 < _meters) then {_nearestTowerPos = [23061.3,21718.5,0.867586]; _meters = _meters2};
			

			_generatedTower = "Land_TTowerBig_2_F" createVehicle _nearestTowerPos;
			_TowersNear = [_generatedTower]
			//};
		};

		if (count _TowersNear > 0 && selectRandom CommsTowerProbability) then {
		//if (!(isNull _pepe)) then {
			TowerBuild = _TowersNear select 0;
			publicVariable "TowerBuild";
			_TowerX = position TowerBuild select 0;
			_TowerY = position TowerBuild select 1;
			_distanceHQ = getMarkerPos "mrkHQ" distance [_TowerX, _TowerY];	
			if (_distanceHQ > 2000) then {
				if (selectRandom[true,true,false]) then {
					_PatrolDist = 70;
					_wayX = _TowerX;
					_wayY = _TowerY;
					_wp1PosTower = [ _wayX + _PatrolDist, _wayY + _PatrolDist, 0];
					_wp2PosTower = [ _wayX + _PatrolDist, _wayY - _PatrolDist, 0];
					_wp3PosTower = [ _wayX - _PatrolDist, _wayY - _PatrolDist, 0];						
					_wp4PosTower = [ _wayX - _PatrolDist, _wayY + _PatrolDist, 0];							
					_wp5PosTower = [ _wayX + _PatrolDist, _wayY + _PatrolDist, 0];
			
			
					if (!(surfaceIsWater _wp1PosTower) && !(surfaceIsWater _wp2PosTower) && !(surfaceIsWater _wp3PosTower) && !(surfaceIsWater _wp4PosTower)) then {
						//1 in (_maxGroups*2) chance of having an AA/AT guy

						_DiamPatrolGroupTower = createGroup east; 
							if selectRandom [true,false] then {
								sAAMan createUnit [[_wayX, _wayY], _DiamPatrolGroupTower];
								_iHasAA = 1;
							}
							else {	
								sATMan createUnit [[_wayX, _wayY], _DiamPatrolGroupTower];		
								_iHasAT = 1;
							};
						
						sRifleman createUnit [[_wayX, _wayY], _DiamPatrolGroupTower];
						if selectRandom [true,false] then {sRifleman createUnit [[_wayX, _wayY], _DiamPatrolGroupTower]};
						if selectRandom [true,false] then {sRifleman createUnit [[_wayX, _wayY], _DiamPatrolGroupTower]};
						if selectRandom [true,false] then {sRifleman createUnit [[_wayX, _wayY], _DiamPatrolGroupTower]};
						if selectRandom [true,false] then {sRifleman createUnit [[_wayX, _wayY], _DiamPatrolGroupTower]};	
						
						_wp1Tower = _DiamPatrolGroupTower addWaypoint [_wp1PosTower, 0];
						_wp2Tower = _DiamPatrolGroupTower addWaypoint [_wp2PosTower, 0];
						_wp3Tower = _DiamPatrolGroupTower addWaypoint [_wp3PosTower, 0];
						_wp4Tower = _DiamPatrolGroupTower addWaypoint [_wp4PosTower, 0];
						_wp5Tower = _DiamPatrolGroupTower addWaypoint [_wp5PosTower, 0];
						[_DiamPatrolGroupTower, 0] setWaypointSpeed "LIMITED";
						[_DiamPatrolGroupTower, 0] setWaypointBehaviour "SAFE";
						[_DiamPatrolGroupTower, 1] setWaypointSpeed "LIMITED";
						[_DiamPatrolGroupTower, 1] setWaypointBehaviour "SAFE";
						[_DiamPatrolGroupTower, 4] setWaypointType "CYCLE";
						_DiamPatrolGroupTower setBehaviour "SAFE";
					};
				
				};
				
				
				if (selectRandom [true,true,true]) then {
					
					
					//_baseBuild = _pepe;
					//_pepeX = position _baseBuild select 0;
					//_pepeY = position _baseBuild select 1;
					_markerstrcache = createMarker ["MidTowerLoc", [_TowerX, _TowerY]];
					_markerstrcache setMarkerShape "ICON";
					_markerstrcache setMarkerType selectRandom CommsTowerIcon;
					_markerstrcache setMarkerText "Enemy Comms Tower";
					_pepeIndex = _pepeIndex + 1;
				
					if (ShowLocationIfCaptureTower) then {
						//TowerBuild addaction ["Hack comms for target location", "RandFramework\showLocations.sqf"];
						[[TowerBuild, ["Hack intel","RandFramework\showLocations.sqf"]],"addAction",true,true] call BIS_fnc_MP;
					};
					

					_trg = createTrigger ["EmptyDetector", position TowerBuild];
					_trg setTriggerArea [100, 100, 0, false];
					_sSTringPos = format["%1,%2", position TowerBuild select 0, position TowerBuild select 1];
					_trg setTriggerStatements ["!alive(nearestObject [[" + _sSTringPos + "], ""Land_TTowerBig_2_F""])", "bCommsBlocked = true; publicVariable ""bCommsBlocked""; [this] execVM ""RandFramework\RandScript\commsBlocked.sqf"";", ""];					

					publicVariable "TowerBuild";
				};
			
			
			};
		};	
		

		//move our enemyAir support trigger!
		//enemyAirSupportTrigger setPos [_averageAAAX,_averageAAAY,0];
		enemyAirSupportTrigger1 = createTrigger ["EmptyDetector", [_averageAAAX,_averageAAAY]];
		enemyAirSupportTrigger1 setTriggerArea [2000, 2000, 0, false];
		enemyAirSupportTrigger1 setTriggerActivation [FriendlySideString, format["%1 D", EnemySideString], false];
		//enemyAirSupportTrigger1 setTriggerActivation ["WEST", "EAST D", false];

		_sEnemyAirTrigText = format["nul = [this] execVM ""RandFramework\RandScript\enemyAirSupport.sqf"";[""%1"",""playMusic"",true,true] call BIS_fnc_MP; deleteVehicle hp1; deleteVehicle hp2; deleteVehicle hp3; FirstSpottedHasHappend = true; publicVariable ""FirstSpottedHasHappend""",AmbientTrack01a_F];
		enemyAirSupportTrigger1 setTriggerStatements ["this", _sEnemyAirTrigText, ""];
		//enemyAirSupportTrigger1 setTriggerStatements ["this", "nul = [this] execVM ""RandFramework\RandScript\enemyAirSupport.sqf"";[""AmbientTrack01a_F"",""playMusic"",true,true] call BIS_fnc_MP; deleteVehicle hp1; deleteVehicle hp2; deleteVehicle hp3; ", ""];

		
		if (bUseCustomAIScript) then {
			trgCustomAIScript = createTrigger ["EmptyDetector", [_averageAAAX,_averageAAAY]];
			trgCustomAIScript setTriggerArea [2000, 2000, 0, false];
			trgCustomAIScript setTriggerActivation [FriendlySideString, format["%1 D", EnemySideString], true];
			trgCustomAIScript setTriggerStatements ["this && SpottedActiveFinished", "nul = [this, thisList, getMarkerPos ""mrkFirstLocation"", getMarkerPos ""mrksecondLocation""] execVM ""RandFramework\RandScript\CustomAIScript.sqf"";", ""];
		};
		
		//fill any base with troops
		_pepeIndex = 0;
		_MilBuildings = MilBuildings;
		_pepe = nearestObjects [[_averageAAAX, _averageAAAY], _MilBuildings, 500];
		if (count _pepe == 0) then {
			_pepe = nearestObjects [[_averageAAAX, _averageAAAY], _MilBuildings, 750];
			if (count _pepe == 0) then {	
				_pepe = nearestObjects [[_averageAAAX, _averageAAAY], _MilBuildings, 1000];
				//if (count _pepe == 0) then {	
					//_pepe = nearestObjects [[_averageAAAX, _averageAAAY], _MilBuildings, 1500];
					//if (count _pepe == 0) then {	
					//	_pepe = nearestObjects [[_averageAAAX, _averageAAAY], _MilBuildings, 2500];
					//};
				//};
			};
		};
		 
		//_pepe = nearestObject [[_averageAAAX, _averageAAAY], _MilBuildings];
		if (count _pepe > 0) then {
		//if (!(isNull _pepe)) then {
			_baseBuild = selectRandom _pepe;
			_pepeX = position _baseBuild select 0;
			_pepeY = position _baseBuild select 1;
			
			_distanceHQ = getMarkerPos "mrkHQ" distance [_pepeX, _pepeY];	
		    if (_distanceHQ > 1500) then {
				
				_trg2ShowLocation = createTrigger ["EmptyDetector", position _baseBuild];
				_trg2ShowLocation setTriggerArea [15, 15, 0, false];
				_trg2ShowLocation setTriggerActivation ["WEST", "PRESENT", false];
				_trg2ShowLocation setTriggerStatements ["{_x in thisList} count (playableUnits + switchableUnits) > 0", "nul = [this] execVM ""RandFramework\showLocations.sqf""; hint ""Location of objectives updated"";", ""];
							
				//get nearest mil buildings within 100 meters, then get average position
				//loop through all buildings to get count of buildings with at least 3 positions within
				//also building up average position
				//_y = _x;
				_BasebuildTotCount = 0;
				_BaseallClusterBuildings = nearestObjects [position _baseBuild, _MilBuildings, 200];
				_BasetotX = 0;
		      	_BasetotY = 0;
			      _baseGroupCount = 0;
				{
					_BaseallpositionsInner = _x buildingPos -1;
					_BaseposCountInner = (count _BaseallpositionsInner);
					if (_BaseposCountInner > 0 && _baseGroupCount < 4) then {
						_BasebuildTotCount = _BasebuildTotCount + 1;
						_BasetotX = _BasetotX + ((getPos _x) select 0);
						_BasetotY = _BasetotY + ((getPos _x) select 1);
						if (_BasebuildTotCount == 1 || selectRandom[true,true,false]) then {
							_baseGroupCount = _baseGroupCount + 1;
							_groupInnerHouseBase1 = createGroup east; 
							for "_i_BaseposCountInnerCount" from 0 to 2 do { //_BaseposCountInner-1 do {
								
								//_groupInnerHouseBase2 = createGroup east; 
								//_groupInnerHouseBase3 = createGroup east; 
								sRifleman createUnit [position _x, _groupInnerHouseBase1, "[getPosATL this, units group this, -1, false, false] execVM ""RandFramework\Zen_OccupyHouse.sqf"""];
								//sTargetLeader createUnit [position _x, _groupInnerHouseBase1, ""];
								//baseMan = sTargetLeader createUnit [0,0,500];
								//baseMan setPosATL (selectRandom _BaseallpositionsInner);
							};
							//[getPosATL _x, units _groupInnerHouseBase1, -1, false, false] execVM "Zen_OccupyHouse.sqf";
							//sRifleman createUnit [position _x, _groupInnerHouseBase1, ""];
							//sRifleman createUnit [position _x, _groupInnerHouseBase1, "[getPosATL this, units group this, -1, false, false] execVM ""Zen_OccupyHouse.sqf"""];
						};
					};
				}  forEach _BaseallClusterBuildings;
				if (_BasebuildTotCount > 0) then {
					_pepeX = _BasetotX / _BasebuildTotCount;
					_pepeY = _BasetotY / _BasebuildTotCount;
				};
				
				//trying to get patrol to walk from building location to location.., but wasnt very reliable!!!
				//if statement just so variable names are kept only within the if statement
				//if ("DOTHIS" == "DOTHIS") then {
				//	_base1allBuildingsToPatrol = nearestObjects [[_pepeX, _pepeY], _MilBuildings, 200];
				//	_base1randBuildingToPatrolInit = selectRandom _base1allBuildingsToPatrol;
				//	_base1housePatrolGroup = createGroup east; 
				//	"O_Soldier_AA_F" createUnit [position _base1randBuildingToPatrolInit, _base1housePatrolGroup];
				//	"O_Soldier_AA_F" createUnit [position _base1randBuildingToPatrolInit, _base1housePatrolGroup];
				//	if (selectRandom [true,false]) then {
				//		"O_Soldier_AA_F" createUnit [position _base1randBuildingToPatrolInit, _base1housePatrolGroup];	
				//	};
				//	//sRifleman
				//	
				//	base1wp1 = _base1housePatrolGroup addWaypoint [selectRandom (selectRandom _base1allBuildingsToPatrol buildingPos - 1), 0];
				//	base1wp2 = _base1housePatrolGroup addWaypoint [selectRandom (selectRandom _base1allBuildingsToPatrol buildingPos - 1), 0];						
				//	base1wp3 = _base1housePatrolGroup addWaypoint [selectRandom (selectRandom _base1allBuildingsToPatrol buildingPos - 1), 0];
				//	base1wp4 = _base1housePatrolGroup addWaypoint [selectRandom (selectRandom _base1allBuildingsToPatrol buildingPos - 1), 0];
				//	base1wp5 = _base1housePatrolGroup addWaypoint [selectRandom (selectRandom _base1allBuildingsToPatrol buildingPos - 1), 0];
				//	base1wp6 = _base1housePatrolGroup addWaypoint [selectRandom (selectRandom _base1allBuildingsToPatrol buildingPos - 1), 0];				
				//						
				//	[_base1housePatrolGroup, 0] setWaypointSpeed "LIMITED";
				//	[_base1housePatrolGroup, 0] setWaypointBehaviour "SAFE";
				//	[_base1housePatrolGroup, 1] setWaypointSpeed "LIMITED";
				//	[_base1housePatrolGroup, 1] setWaypointBehaviour "SAFE";
				//	[_base1housePatrolGroup, 5] setWaypointType "CYCLE";
				//	_base1housePatrolGroup setBehaviour "SAFE";	
				//};	
			
				//if statement just so variable names are kept only within the if statement
				if ("DOTHIS" == "DOTHIS") then {
					_PatrolDist = 70;
					_wayX = _pepeX;
					_wayY = _pepeY;
					_wp1Pos = [ _wayX + _PatrolDist, _wayY + _PatrolDist, 0];
					_wp2Pos = [ _wayX + _PatrolDist, _wayY - _PatrolDist, 0];
					_wp3Pos = [ _wayX - _PatrolDist, _wayY - _PatrolDist, 0];						
					_wp4Pos = [ _wayX - _PatrolDist, _wayY + _PatrolDist, 0];							
					_wp5Pos = [ _wayX + _PatrolDist, _wayY + _PatrolDist, 0];
			
			
					if (!(surfaceIsWater _wp1Pos) && !(surfaceIsWater _wp2Pos) && !(surfaceIsWater _wp3Pos) && !(surfaceIsWater _wp4Pos)) then {
						//1 in (_maxGroups*2) chance of having an AA/AT guy

						_DiamPatrolGroup = createGroup east; 
							if selectRandom [true,false] then {
								sAAMan createUnit [[_wayX, _wayY], _DiamPatrolGroup];
								_iHasAA = 1;
							}
							else {	
								sATMan createUnit [[_wayX, _wayY], _DiamPatrolGroup];		
								_iHasAT = 1;
							};
						
						sRifleman createUnit [[_wayX, _wayY], _DiamPatrolGroup];
						sRifleman createUnit [[_wayX, _wayY], _DiamPatrolGroup];
						if (selectRandom [true,false]) then {
							sRifleman createUnit [[_wayX, _wayY], _DiamPatrolGroup];	
						};
						_wp1 = _DiamPatrolGroup addWaypoint [_wp1Pos, 0];
						_wp2 = _DiamPatrolGroup addWaypoint [_wp2Pos, 0];
						_wp3 = _DiamPatrolGroup addWaypoint [_wp3Pos, 0];
						_wp4 = _DiamPatrolGroup addWaypoint [_wp4Pos, 0];
						_wp5 = _DiamPatrolGroup addWaypoint [_wp5Pos, 0];
						[_DiamPatrolGroup, 0] setWaypointSpeed "LIMITED";
						[_DiamPatrolGroup, 0] setWaypointBehaviour "SAFE";
						[_DiamPatrolGroup, 1] setWaypointSpeed "LIMITED";
						[_DiamPatrolGroup, 1] setWaypointBehaviour "SAFE";
						[_DiamPatrolGroup, 4] setWaypointType "CYCLE";
						_DiamPatrolGroup setBehaviour "SAFE";
					};
				
				};
				
				//if statement just so variable names are kept only within the if statement
				if ("DOTHIS" == "DOTHIS") then {
					_PatrolDist = 15;
					_wayX = _pepeX;
					_wayY = _pepeY;
					_wp1Pos = [ _wayX + _PatrolDist, _wayY + _PatrolDist, 0];
					_wp2Pos = [ _wayX + _PatrolDist, _wayY - _PatrolDist, 0];
					_wp3Pos = [ _wayX - _PatrolDist, _wayY - _PatrolDist, 0];						
					_wp4Pos = [ _wayX - _PatrolDist, _wayY + _PatrolDist, 0];							
					_wp5Pos = [ _wayX + _PatrolDist, _wayY + _PatrolDist, 0];
			
			
					if (!(surfaceIsWater _wp1Pos) && !(surfaceIsWater _wp2Pos) && !(surfaceIsWater _wp3Pos) && !(surfaceIsWater _wp4Pos)) then {
						//1 in (_maxGroups*2) chance of having an AA/AT guy

						_DiamPatrolGroup = createGroup east; 
							if selectRandom [true,false] then {
								sAAMan createUnit [[_wayX, _wayY], _DiamPatrolGroup];
								_iHasAA = 1;
							}
							else {	
								sATMan createUnit [[_wayX, _wayY], _DiamPatrolGroup];		
								_iHasAT = 1;
							};
						
						sRifleman createUnit [[_wayX, _wayY], _DiamPatrolGroup];
						sRifleman createUnit [[_wayX, _wayY], _DiamPatrolGroup];
						sRifleman createUnit [[_wayX, _wayY], _DiamPatrolGroup];
						if (selectRandom [true,false]) then {
							sRifleman createUnit [[_wayX, _wayY], _DiamPatrolGroup];	
						};
						_wp1 = _DiamPatrolGroup addWaypoint [_wp1Pos, 0];
						_wp2 = _DiamPatrolGroup addWaypoint [_wp2Pos, 0];
						_wp3 = _DiamPatrolGroup addWaypoint [_wp3Pos, 0];
						_wp4 = _DiamPatrolGroup addWaypoint [_wp4Pos, 0];
						_wp5 = _DiamPatrolGroup addWaypoint [_wp5Pos, 0];
						[_DiamPatrolGroup, 0] setWaypointSpeed "LIMITED";
						[_DiamPatrolGroup, 0] setWaypointBehaviour "SAFE";
						[_DiamPatrolGroup, 1] setWaypointSpeed "LIMITED";
						[_DiamPatrolGroup, 1] setWaypointBehaviour "SAFE";
						[_DiamPatrolGroup, 4] setWaypointType "CYCLE";
						_DiamPatrolGroup setBehaviour "SAFE";
					};
				
				};
				
			
			if (selectRandom [true,true,false]) then {
				iBaseExisits = 2;
				publicVariable "iBaseExisits";
					
				//_baseBuild = _pepe;
				//_pepeX = position _baseBuild select 0;
				//_pepeY = position _baseBuild select 1;
				//_markerstrcache = createMarker [format["MidBaseLoc%1", _pepeIndex], [_pepeX, _pepeY]];
				_markerstrcache = createMarker ["MidBaseLoc1", [_pepeX, _pepeY]];
				_markerstrcache setMarkerShape "ICON";
				_markerstrcache setMarkerType selectRandom EnemyBaseIcon;
				_markerstrcache setMarkerText "Enemy Base";
				_pepeIndex = _pepeIndex + 1;
			
				if (selectRandom [true,true,false]) then {
					iBaseExisits = 3;
					publicVariable "iBaseExisits";
					//create task
					[FriendlySide,["tskCaptureBase", "(Optional) Clear the <font color='#ffff00'><marker name='MidBaseLoc1'>enemy base</marker></font> only if it looks possible. Suggest you recon this area first, If enemy numbers are high, maybe call artillery on this location to soften the threat before you move in. If you gain access to this base, we should find some intel of the exact locations of our targets!", "(Optional) Clear Enemy Base",""]] call FHQ_TT_addTasks;
					
					//ActiveTasks pushBack "tskCaptureBase"; 
					//publicVariable "ActiveTasks";	
	
					_trg = createTrigger ["EmptyDetector", position _baseBuild];
					_trg setTriggerArea [100, 100, 0, false];
					_trg setTriggerActivation ["EAST", "NOT PRESENT", false];
					_trg setTriggerStatements ["this", "[""tskCaptureBase"", ""succeeded""] call FHQ_TT_setTaskState;  ", ""];
				};
			};

			//because we have a base, we see if a helipad is aviable for an attack chopper
			_HeliPads = nearestObjects [[_pepeX, _pepeY], ["Land_HelipadCircle_F","Land_HelipadSquare_F"], 200];
			if (count _HeliPads > 0) then {
				baseHeliPad = selectRandom _HeliPads;
				publicVariable "baseHeliPad";
				bBaseHasChopper = true;
				publicVariable "bBaseHasChopper";
				_BaseChopperGroup = createGroup EnemySide;
				_EnemyBaseChopper = sAirSup2 createVehicle getPosATL baseHeliPad;
				
				sEnemyHeliPilot createUnit [[(getPos baseHeliPad select 0)+10,(getPos baseHeliPad select 1)+10], _BaseChopperGroup];	
				sEnemyHeliPilot createUnit [[(getPos baseHeliPad select 0)+12,(getPos baseHeliPad select 1)+10], _BaseChopperGroup];	
				//EnemyBaseChopperPilot = getNEAREST sEnemyHeliPilot to chopper
				_EnemyBaseChopperPilots = nearestObjects [getPos baseHeliPad, [sEnemyHeliPilot], 250];
				EnemyBaseChopperPilot = _EnemyBaseChopperPilots select 0;
				publicVariable "EnemyBaseChopperPilot";
				// _BaseChopperGroup

			};
			
		   };
			//sRifleman createUnit [position _randBuildingAAA, _groupInnerHouseAAA, ""];
			//sRifleman createUnit [position _randBuildingAAA, _groupInnerHouseAAA, "[getPosATL this, units group this, -1, false, false] execVM ""Zen_OccupyHouse.sqf"""];
				
		};
		if ("DOTHIS" == "DOTHIS") then {
			_groupCamp1 = createGroup east;
			
			_aaaX = _averageAAAX;
			_aaaY = _averageAAAY;
		
			_aaaX = (_averageAAAX - 250) + (floor random 250);	
			_aaaY = (_averageAAAY - 250) + (floor random 250);	
			
			_campMarkerText = "Camp";
			if (surfaceIsWater [_aaaX,_aaaY]) then {
				[[_aaaX,_aaaY], (floor random 175+1), "O_Boat_Armed_01_hmg_F", _groupCamp1] call bis_fnc_spawnvehicle;
				_campMarkerText = "Armed Boat";
			}
			else {
				sRifleman createUnit [[_aaaX+1, _aaaY], _groupCamp1];
				sRifleman createUnit [[_aaaX, _aaaY+1], _groupCamp1];
				sRifleman createUnit [[_aaaX+1, _aaaY+1], _groupCamp1];
				sRifleman createUnit [[_aaaX-1, _aaaY], _groupCamp1];
				sRifleman createUnit [[_aaaX, _aaaY-1], _groupCamp1];
				_camp = "FirePlace_burning_F" createVehicle [_aaaX,_aaaY];			
			};
			//
			
			if (selectRandom [false,false,false]) then {
				_markerstrcache = createMarker ["CampLoc", [_aaaX,_aaaY]];
				_markerstrcache setMarkerShape "ICON";
				_markerstrcache setMarkerType "hd_dot";
				_markerstrcache setMarkerText _campMarkerText;
			};
		};		
		

		call compile preprocessFileLineNumbers "RandFramework\RandScript\randomMission.sqf"; 