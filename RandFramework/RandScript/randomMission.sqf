#include "../../setUnitGlobalVars.sqf";

Treendy_HelloWorld =
{
	//private ["_a","_b"];
	//_a = _this select 0;
	//_b = _this select 1;
    
    	hint "asdfads";
 };


TreendySetRandomTimeDay =
{
	//private ["_a","_b"];
	//_a = _this select 0;
	//_b = _this select 1;
    
	if (isServer) then {
	    	_year = 2035;
	    	_month = 1;
	    	_day = 1;
	    	_hour = 12;
	    	_min = 0;
	    
	    	_WeatherOption = selectRandom WeatherOptions;
	    
	    	if (_WeatherOption == 1) then { //Sunny Clear
			0 setOvercast 0;
	    		setDate [_year, 1, 14, _hour, _min];    
	 		};
	 		if (_WeatherOption == 2) then {  //Daytime Heavy Overcast
				0 setOvercast 1;
	    			setDate [_year, 1, 14, _hour, _min];    
	 		};
	 		if (_WeatherOption == 3) then { //Day average Overcast
				0 setOvercast 0.5;
	    			setDate [_year, 1, 14, _hour, _min];    
	 		};
			if (_WeatherOption == 4) then {   //Dark Night Clear
				0 setOvercast 0;
	    			setDate [_year, 1, 15, 00, _min];    
	 		};
	 		if (_WeatherOption == 5) then {  //Dark Night Heavy Overcast
				0 setOvercast 1;
	    			setDate [_year, 1, 15, 00, _min];    
	 		};
	 		if (_WeatherOption == 6) then {  //Dark Night Average overcast
				0 setOvercast 0.5;
	    			setDate [_year, 1, 15, 00, _min];   
	 		};
	 		if (_WeatherOption == 7) then {   //EarlyMorning
				0 setOvercast 0.6;
	    			setDate [_year, 1, 14, 8, 15];    
	 		};
			if (_WeatherOption == 8) then {   //moon Night Clear
				0 setOvercast 0;
	    			setDate [_year, 12, 09, 23, _min];    
	 		};
	 		if (_WeatherOption == 9) then {  //moon Night slight overcast
				0 setOvercast 0.4;
	    			setDate [_year, 12, 09, 23, _min];    
	 		};	    
	   		if (_WeatherOption == 10) then {  //moon Night heavy overcast
				0 setOvercast 1;
	    			setDate [_year, 12, 09, 23, _min];    
	 		};
	   		if (_WeatherOption == 11) then {  //Moon Night slight overcast
				0 setOvercast 1;
	    			setDate [_year, 1, 30, 00, _min];    
	 		};
			if (_WeatherOption == 12) then {  //Monsoon (Day)
				0 setOvercast 1;
				setDate [_year, 1, 14, _hour, _min];   
				null = [220,5000,false] execvm "AL_storm\al_monsoon.sqf";   
	 		};			

			iChanceSnow = ("OUT_par_LetItSnow" call BIS_fnc_getParamValue);  // i.e. weather type (need to rename variable)
			if (iChanceSnow == 2) then {
				//0 setOvercast 1;0=[] spawn {while {true} do {1 setRain 0;sleep 1}}; 
			};


	    forceWeatherChange;
	    
	};    
};

TreendySetAreaAI = 
{
	private ["_AreaMarkerName", "_iBuildingSize"];
	_sAreaMarkerName = _this select 0;
	_iBuildingSize = _this select 1;
	

	_iHasAA = 0;
	_iHasAT = 0;
	_iIsHeavilyDefended = -1;
	
	_bStopAdding = false;
	_maxGroups = 0;
	if (_iBuildingSize == -1) then {	
		if (_sAreaMarkerName == "mrkFirstLocation") then {
			_maxGroups = selectRandom customAreaSize1;
		}
		else {
			_maxGroups = selectRandom customAreaSize2;
		};
	};
	if (_iBuildingSize == 0) then {	
		_maxGroups = selectRandom [4,5];
		if (bViolent) then {
			_maxGroups = selectRandom [7,8,9];
		};
		if (_maxGroups == 4) then {
			_iIsHeavilyDefended = 1;
		};
		if (_maxGroups == 1) then {
			_iIsHeavilyDefended = 0;
		};
	};
	if (_iBuildingSize == 1) then {
		_maxGroups = selectRandom [5,6];
		if (bViolent) then {
			_maxGroups = selectRandom [8,9,10];
		};
		if (_maxGroups == 5) then {
			_iIsHeavilyDefended = 1;
		};
	};
	if (_iBuildingSize == 2) then {
		_maxGroups = selectRandom [6,7];
		if (bViolent) then {
			_maxGroups = selectRandom [11,12,13];
		};
		if (_maxGroups == 8) then {
			_iIsHeavilyDefended = 1;
		};
	};


	_BuildingLocationsPopulated = [];
	

	_bHasCivs = false;
	_iAddedGroups = 0;
	while {!_bStopAdding} do {
		_group = createGroup east; 

		_PatrolType = selectRandom ["DIAM","HOUSETOHOUSE"];
		
		
		if (selectRandom[true,false]) then {
			_group2 = createGroup east; 
			_wayX = (getMarkerPos _sAreaMarkerName select 0) + (selectRandom [7,-7]);
			_wayY = (getMarkerPos _sAreaMarkerName select 1) + (selectRandom [7,-7]);
			//1 in (_maxGroups*2) chance of having an AA/AT guy
			if ((floor random (_maxGroups*2)) == 0) then {
				if (selectRandom [true,false,false,false,false]) then {
					sAAMan createUnit [[_wayX, _wayY], _group2];
					_iHasAA = 1;
				}
				else {	
				
					if (selectRandom [true,false,false,false,false]) then {
						sATMan createUnit [[_wayX, _wayY], _group2];		
						_iHasAT = 1;
					}
					else {
						sMachineGunMan createUnit [[_wayX, _wayY], _group2];		
					};
					
				};
			}
			else {
				sRifleman createUnit [[_wayX, _wayY], _group2];
			};
			sRifleman createUnit [[_wayX, _wayY], _group2];
		};
		



		if (_PatrolType == "DIAM") then {
			_group3 = createGroup east; 
			_wayX = (getMarkerPos _sAreaMarkerName select 0) + (selectRandom [15,-15]);
			_wayY = (getMarkerPos _sAreaMarkerName select 1) + (selectRandom [15,-15]);
			
			
			_PatrolDist = 400 + (floor random 600);
			_wayX = getMarkerPos _sAreaMarkerName select 0;
			_wayY = getMarkerPos _sAreaMarkerName select 1;
			_wp1Pos = [ _wayX + _PatrolDist, _wayY + _PatrolDist, 0];
			_wp1bPos = [ _wayX + _PatrolDist, _wayY, 0];
			_wp2Pos = [ _wayX + _PatrolDist, _wayY - _PatrolDist, 0];
			_wp2bPos = [ _wayX, _wayY - _PatrolDist, 0];
			_wp3Pos = [ _wayX - _PatrolDist, _wayY - _PatrolDist, 0];
			_wp3bPos = [ _wayX - _PatrolDist, _wayY, 0];							
			_wp4Pos = [ _wayX - _PatrolDist, _wayY + _PatrolDist, 0];
			_wp4bPos = [ _wayX, _wayY + _PatrolDist, 0];							
			_wp5Pos = [ _wayX + _PatrolDist, _wayY + _PatrolDist, 0];
			
			_iToReduce = 10;
			while {surfaceIsWater _wp1Pos} do {
				_wp1Pos = [ _wayX + (_PatrolDist - _iToReduce), _wayY + (_PatrolDist - _iToReduce), 0];
				_wp5Pos = [ _wayX + (_PatrolDist - _iToReduce), _wayY + (_PatrolDist - _iToReduce), 0];
				_iToReduce = _iToReduce + 10;
			};
			_iToReduce = 10;
			while {surfaceIsWater _wp2Pos} do {
				_wp2Pos = [ _wayX + (_PatrolDist - _iToReduce), _wayY - (_PatrolDist - _iToReduce), 0];
				_iToReduce = _iToReduce + 10;
			};
			_iToReduce = 10;
			while {surfaceIsWater _wp3Pos} do {
				_wp3Pos = [ _wayX - (_PatrolDist - _iToReduce), _wayY - (_PatrolDist - _iToReduce), 0];
				_iToReduce = _iToReduce + 10;
			};
			_iToReduce = 10;
			while {surfaceIsWater _wp4Pos} do {
				_wp4Pos = [ _wayX - (_PatrolDist - _iToReduce), _wayY + (_PatrolDist - _iToReduce), 0];
				_iToReduce = _iToReduce + 10;
			};
			
			
			_iToReduce = 10;
			while {surfaceIsWater _wp1bPos} do {
				_wp1bPos = [ _wayX + (_PatrolDist - _iToReduce), _wayY, 0];
				_iToReduce = _iToReduce + 10;
			};
			_iToReduce = 10;
			while {surfaceIsWater _wp2bPos} do {
				_wp2bPos = [ _wayX, _wayY - (_PatrolDist - _iToReduce), 0];
				_iToReduce = _iToReduce + 10;
			};
			_iToReduce = 10;
			while {surfaceIsWater _wp3bPos} do {
				_wp3bPos = [ _wayX - (_PatrolDist - _iToReduce), _wayY, 0];		
				_iToReduce = _iToReduce + 10;
			};
			_iToReduce = 10;
			while {surfaceIsWater _wp4bPos} do {
				_wp4bPos = [ _wayX, _wayY + (_PatrolDist - _iToReduce), 0];
				_iToReduce = _iToReduce + 10;
			};
			
			
			_startPos = [_wayX - _PatrolDist + (floor random (_PatrolDist*2)),_wayY - _PatrolDist + (floor random (_PatrolDist*2))];
			while { ((_startPos select 2) < 0.5) } do {
				_pos = [_wayX - _PatrolDist + (floor random (_PatrolDist*2)),_wayY - _PatrolDist + (floor random (_PatrolDist*2))];
			};

			//_startPos = selectRandom[_wp1Pos,_wp2Pos,_wp3Pos,_wp4Pos];
			if (!(surfaceIsWater _wp1Pos) && !(surfaceIsWater _wp2Pos) && !(surfaceIsWater _wp3Pos) && !(surfaceIsWater _wp4Pos))  then {
				//1 in (_maxGroups*2) chance of having an AA/AT guy
				//if ((floor random (_maxGroups*2)) == 0) then {
				sTeamleader createUnit [_startPos, _group3];
					if (selectRandom [true,false,false,false,false]) then {
						sAAMan createUnit [_startPos, _group3];
						_iHasAA = 1;
					}
					else {	
						if (selectRandom [true,false,false,false,false]) then {
							sATMan createUnit [_startPos, _group3];		
							_iHasAT = 1;
						}
						else {
							sMachineGunMan createUnit [_startPos, _group3];		
						};
					};
				//};
				if (bAllowLargerPatrols) then {
					_sUnitType = selectRandom [sRifleman, sRifleman, sRifleman, sRifleman, sAmmobearer, sGrenadier, sMedic];
					if (selectRandom [true]) then {_sUnitType createUnit [[(_startPos select 0)+5,(_startPos select 1) + 5], _group3]};
					_sUnitType = selectRandom [sRifleman, sRifleman, sRifleman, sRifleman, sAmmobearer, sGrenadier, sMedic];
					if (selectRandom [true]) then {_sUnitType createUnit [[(_startPos select 0)+10,(_startPos select 1) + 10], _group3]};
					_sUnitType = selectRandom [sRifleman, sRifleman, sRifleman, sRifleman, sAmmobearer, sGrenadier, sMedic];
					if (selectRandom [true]) then {_sUnitType createUnit [[(_startPos select 0)+15,(_startPos select 1) + 15], _group3]};
					_sUnitType = selectRandom [sRifleman, sRifleman, sRifleman, sRifleman, sAmmobearer, sGrenadier, sMedic];
					if (selectRandom [true]) then {_sUnitType createUnit [[(_startPos select 0)+20,(_startPos select 1) + 20], _group3]};
					_sUnitType = selectRandom [sRifleman, sRifleman, sRifleman, sRifleman, sAmmobearer, sGrenadier, sMedic];
					if (selectRandom [true]) then {_sUnitType createUnit [[(_startPos select 0)+25,(_startPos select 1) + 25], _group3]};
					_sUnitType = selectRandom [sRifleman, sRifleman, sRifleman, sRifleman, sAmmobearer, sGrenadier, sMedic, sExpSpec];
				};	
				_sUnitType = selectRandom [sRifleman, sRifleman, sRifleman, sAmmobearer, sGrenadier, sMedic];
				_sUnitType createUnit [_startPos, _group3];
				_sUnitType = selectRandom [sRifleman, sRifleman, sRifleman, sAmmobearer, sGrenadier, sMedic];
				_sUnitType createUnit [_startPos, _group3];
				_sUnitType = selectRandom [sRifleman, sRifleman, sRifleman, sAmmobearer, sGrenadier, sMedic];
				if (selectRandom [true,false]) then {
					_sUnitType createUnit [_startPos, _group3];	
				};
				
				_iWaypointCount = selectRandom[1,2,3,4,5,6,7,8,9];
				_bWaypointsAdded = false;
				_iWaypointLoopCount = 1;
				while {!_bWaypointsAdded} do {	
					if (_iWaypointCount == 1) then {
						_wp1 = _group3 addWaypoint [_wp1Pos, 0];
					};
					if (_iWaypointCount == 2) then {
						_wp1b = _group3 addWaypoint [_wp1bPos, 0];
					};
					if (_iWaypointCount == 3) then {
						_wp2 = _group3 addWaypoint [_wp2Pos, 0];
					};
					if (_iWaypointCount == 4) then {
						_wp2b = _group3 addWaypoint [_wp2bPos, 0];
					};
					if (_iWaypointCount == 5) then {
						_wp3 = _group3 addWaypoint [_wp3Pos, 0];
					};
					if (_iWaypointCount == 6) then {
						_wp3b = _group3 addWaypoint [_wp3bPos, 0];
					};
					if (_iWaypointCount == 7) then {
						_wp4 = _group3 addWaypoint [_wp4Pos, 0];
					};
					if (_iWaypointCount == 8) then {
						_wp4b = _group3 addWaypoint [_wp4bPos, 0];
					};
					if (_iWaypointCount == 9) then {
						_wp5 = _group3 addWaypoint [_wp5Pos, 0];
					};
					_iWaypointCount = _iWaypointCount + 1;
					_iWaypointLoopCount = _iWaypointLoopCount + 1;
					
					if (_iWaypointLoopCount == 10) then {
						_bWaypointsAdded = true;
					};
					
					if (_iWaypointCount == 10) then {
						_iWaypointCount = 1;
					};	
									
				};
							
				
				[_group3, 0] setWaypointSpeed "LIMITED";
				[_group3, 0] setWaypointBehaviour "SAFE";
				[_group3, 1] setWaypointSpeed "LIMITED";
				[_group3, 1] setWaypointBehaviour "SAFE";
				[_group3, 8] setWaypointType "CYCLE";
				_group3 setBehaviour "SAFE";
				_PatrolType = "DIAMCLOSE"; //now we have our distant patrol for this loop, setup the patrols nearer the location
			}
			else {
				_PatrolType = "HOUSETOHOUSE";
			};
		
		};
		if (_PatrolType == "DIAMCLOSE") then {
			_group4 = createGroup east; 
			_wayX = (getMarkerPos _sAreaMarkerName select 0) + (selectRandom [15,-15]);
			_wayY = (getMarkerPos _sAreaMarkerName select 1) + (selectRandom [15,-15]);
			
			
			_PatrolDist = 50 + (floor random 200);
			_wayX = getMarkerPos _sAreaMarkerName select 0;
			_wayY = getMarkerPos _sAreaMarkerName select 1;
			_wp1Pos = [ _wayX + _PatrolDist, _wayY + _PatrolDist, 0];
			_wp1bPos = [ _wayX + _PatrolDist, _wayY, 0];
			_wp2Pos = [ _wayX + _PatrolDist, _wayY - _PatrolDist, 0];
			_wp2bPos = [ _wayX, _wayY - _PatrolDist, 0];
			_wp3Pos = [ _wayX - _PatrolDist, _wayY - _PatrolDist, 0];
			_wp3bPos = [ _wayX - _PatrolDist, _wayY, 0];							
			_wp4Pos = [ _wayX - _PatrolDist, _wayY + _PatrolDist, 0];
			_wp4bPos = [ _wayX, _wayY + _PatrolDist, 0];							
			_wp5Pos = [ _wayX + _PatrolDist, _wayY + _PatrolDist, 0];
			
			_startPos = [_wayX - _PatrolDist + (floor random (_PatrolDist*2)),_wayY - _PatrolDist + (floor random (_PatrolDist*2))];
			while { ((_startPos select 2) < 0.5) } do {
				_pos = [_wayX - _PatrolDist + (floor random (_PatrolDist*2)),_wayY - _PatrolDist + (floor random (_PatrolDist*2))];
			};
			//_startPos = selectRandom[_wp1Pos,_wp2Pos,_wp3Pos,_wp4Pos];
			
			if (!(surfaceIsWater _wp1Pos) && !(surfaceIsWater _wp2Pos) && !(surfaceIsWater _wp3Pos) && !(surfaceIsWater _wp4Pos))  then {
				//1 in (_maxGroups*2) chance of having an AA/AT guy
				//if ((floor random (_maxGroups*2)) == 0) then {
					sTeamleader createUnit [_startPos, _group4];
					
					if (selectRandom [true,false,false,false,false]) then {
						sAAMan createUnit [_startPos, _group4];
						_iHasAA = 1;
					}
					else {	
						if (selectRandom [true,false,false,false,false]) then {
							sATMan createUnit [_startPos, _group4];		
							_iHasAT = 1;
						}
						else {
							sMachineGunMan createUnit [_startPos, _group4];		
						};
					};
				//};
				if (bAllowLargerPatrols) then {
					_sUnitType = selectRandom [sRifleman, sRifleman, sRifleman, sRifleman, sAmmobearer, sGrenadier, sMedic];
					if (selectRandom [true,false]) then {_sUnitType createUnit [[(_startPos select 0)+5,(_startPos select 1) + 5], _group4]};
					_sUnitType = selectRandom [sRifleman, sRifleman, sRifleman, sRifleman, sAmmobearer, sGrenadier, sMedic];
					if (selectRandom [true,false]) then {_sUnitType createUnit [[(_startPos select 0)+10,(_startPos select 1) + 5], _group4]};
					_sUnitType = selectRandom [sRifleman, sRifleman, sRifleman, sRifleman, sAmmobearer, sGrenadier, sMedic];
					if (selectRandom [true,false]) then {_sUnitType createUnit [[(_startPos select 0)+15,(_startPos select 1) + 5], _group4]};
					_sUnitType = selectRandom [sRifleman, sRifleman, sRifleman, sRifleman, sAmmobearer, sGrenadier, sMedic];;
					if (selectRandom [true,false]) then {_sUnitType createUnit [[(_startPos select 0)+20,(_startPos select 1) + 5], _group4]};
					_sUnitType = selectRandom [sRifleman, sRifleman, sRifleman, sRifleman, sAmmobearer, sGrenadier, sMedic];
					if (selectRandom [true,false]) then {_sUnitType createUnit [[(_startPos select 0)+25,(_startPos select 1) + 5], _group4]};
					_sUnitType = selectRandom [sRifleman, sRifleman, sRifleman, sRifleman, sAmmobearer, sGrenadier, sMedic];
					if (selectRandom [true,false]) then {_sUnitType createUnit [[(_startPos select 0)+30,(_startPos select 1) + 5], _group4]};
					_sUnitType = selectRandom [sRifleman, sRifleman, sRifleman, sRifleman, sAmmobearer, sGrenadier, sMedic];
					if (selectRandom [true,false]) then {_sUnitType createUnit [[(_startPos select 0)+35,(_startPos select 1) + 5], _group4]};
				};	
				_sUnitType = selectRandom [sRifleman, sRifleman, sRifleman, sRifleman, sAmmobearer, sGrenadier, sMedic];
				_sUnitType createUnit [_startPos, _group4];
				
				if (selectRandom [true,false]) then {
					_sUnitType = selectRandom [sRifleman, sRifleman, sRifleman, sRifleman, sAmmobearer, sGrenadier, sMedic];
					_sUnitType createUnit [[_wayX, _wayY], _group4];	
				};
				_wp1 = _group4 addWaypoint [_wp1Pos, 0];
				_wp1b = _group4 addWaypoint [_wp1bPos, 0];
				_wp2 = _group4 addWaypoint [_wp2Pos, 0];
				_wp2b = _group4 addWaypoint [_wp2bPos, 0];
				_wp3 = _group4 addWaypoint [_wp3Pos, 0];
				_wp3b = _group4 addWaypoint [_wp3bPos, 0];
				_wp4 = _group4 addWaypoint [_wp4Pos, 0];
				_wp4b = _group4 addWaypoint [_wp4bPos, 0];
				_wp5 = _group4 addWaypoint [_wp5Pos, 0];
				[_group4, 0] setWaypointSpeed "LIMITED";
				[_group4, 0] setWaypointBehaviour "SAFE";
				[_group4, 1] setWaypointSpeed "LIMITED";
				[_group4, 1] setWaypointBehaviour "SAFE";
				[_group4, 8] setWaypointType "CYCLE";
				_group4 setBehaviour "SAFE";
				if (selectRandom [true,false]) then {
					_group4 setCombatMode "RED";
				}
				//_PatrolType = "HOUSETOHOUSE";
			}
			else {
				_PatrolType = "HOUSETOHOUSECLOSE";
			};
		
		};
		
		
		if (_PatrolType == "HOUSETOHOUSE") then {
			
			_allBuildingsToPatrol = nearestObjects [getMarkerPos _sAreaMarkerName, ["house"], 1000];
			if (count _allBuildingsToPatrol > 2) then {
				_randBuildingToPatrolInit = selectRandom _allBuildingsToPatrol;
				_housePatrolGroup = createGroup east; 
				sTeamleaderUrban createUnit [position _randBuildingToPatrolInit, _housePatrolGroup];
				if (bAllowLargerPatrols) then {
					_sUnitType = selectRandom [sRiflemanUrban, sRiflemanUrban, sRiflemanUrban, sAmmobearerUrban, sGrenadierUrban, sMedicUrban];
					if (selectRandom [true,false]) then {_sUnitType createUnit [position _randBuildingToPatrolInit, _housePatrolGroup]};
					_sUnitType = selectRandom [sRiflemanUrban, sRiflemanUrban, sRiflemanUrban, sAmmobearerUrban, sGrenadierUrban, sMedicUrban];
					if (selectRandom [true,false]) then {_sUnitType createUnit [position _randBuildingToPatrolInit, _housePatrolGroup]};
				};	
				_sUnitType = selectRandom [sRiflemanUrban, sRiflemanUrban, sRiflemanUrban, sAmmobearerUrban, sGrenadierUrban, sMedicUrban];
				_sUnitType createUnit [position _randBuildingToPatrolInit, _housePatrolGroup];
				_sUnitType = selectRandom [sRiflemanUrban, sRiflemanUrban, sRiflemanUrban, sAmmobearerUrban, sGrenadierUrban, sMedicUrban];
				_sUnitType createUnit [position _randBuildingToPatrolInit, _housePatrolGroup];
				_sUnitType = selectRandom [sRiflemanUrban, sRiflemanUrban, sRiflemanUrban, sAmmobearerUrban, sGrenadierUrban, sMedicUrban];
				_sUnitType createUnit [position _randBuildingToPatrolInit, _housePatrolGroup];
				if (selectRandom [true,false]) then {
					_sUnitType = selectRandom [sRiflemanUrban, sRiflemanUrban, sRiflemanUrban, sAmmobearerUrban, sGrenadierUrban, sMedicUrban];
					_sUnitType createUnit [position _randBuildingToPatrolInit, _housePatrolGroup];	
				};
				
				_randBuildingToPatrol = selectRandom _allBuildingsToPatrol;
				_wp1 = _housePatrolGroup addWaypoint [position _randBuildingToPatrol, 0];	
				_randBuildingToPatrol2 = selectRandom _allBuildingsToPatrol;
				_wp2 = _housePatrolGroup addWaypoint [position _randBuildingToPatrol2, 0];	
				_randBuildingToPatrol3 = selectRandom _allBuildingsToPatrol;
				_wp3 = _housePatrolGroup addWaypoint [position _randBuildingToPatrol3, 0];	
				_randBuildingToPatrol4 = selectRandom _allBuildingsToPatrol;
				_wp4 = _housePatrolGroup addWaypoint [position _randBuildingToPatrol4, 0];	
				_randBuildingToPatrol5 = selectRandom _allBuildingsToPatrol;
				_wp5 = _housePatrolGroup addWaypoint [position _randBuildingToPatrol5, 0];	
				_randBuildingToPatrol6 = selectRandom _allBuildingsToPatrol;
				_wp6 = _housePatrolGroup addWaypoint [position _randBuildingToPatrol6, 0];
				_randBuildingToPatrol7 = selectRandom _allBuildingsToPatrol;
				_wp7 = _housePatrolGroup addWaypoint [position _randBuildingToPatrol7, 0];
				_randBuildingToPatrol8 = selectRandom _allBuildingsToPatrol;
				_wp8 = _housePatrolGroup addWaypoint [position _randBuildingToPatrol8, 0];
				_randBuildingToPatrol9 = selectRandom _allBuildingsToPatrol;
				_wp9 = _housePatrolGroup addWaypoint [position _randBuildingToPatrol9, 0];
				_randBuildingToPatrol10 = selectRandom _allBuildingsToPatrol;
				_wp10 = _housePatrolGroup addWaypoint [position _randBuildingToPatrol10, 0];
				_randBuildingToPatrol11 = selectRandom _allBuildingsToPatrol;
				_wp11 = _housePatrolGroup addWaypoint [position _randBuildingToPatrol11, 0];
				_randBuildingToPatrol12 = selectRandom _allBuildingsToPatrol;
				_wp12 = _housePatrolGroup addWaypoint [position _randBuildingToPatrol12, 0];
				_randBuildingToPatrol13 = selectRandom _allBuildingsToPatrol;
				_wp13 = _housePatrolGroup addWaypoint [position _randBuildingToPatrol13, 0];
				[_housePatrolGroup, 0] setWaypointSpeed "LIMITED";
				[_housePatrolGroup, 0] setWaypointBehaviour "SAFE";
				[_housePatrolGroup, 1] setWaypointSpeed "LIMITED";
				[_housePatrolGroup, 1] setWaypointBehaviour "SAFE";
				[_housePatrolGroup, 12] setWaypointType "CYCLE";
				_housePatrolGroup setBehaviour "SAFE";	
				_PatrolType = "HOUSETOHOUSECLOSE";
			};
		};
		if (_PatrolType == "HOUSETOHOUSECLOSE") then {
			
			_allBuildingsToPatrol = nearestObjects [getMarkerPos _sAreaMarkerName, ["house"], 250];
			if (count _allBuildingsToPatrol > 2) then {
			
				_randBuildingToPatrolInit = selectRandom _allBuildingsToPatrol;
				_housePatrolGroup2 = createGroup east; 
				sTeamleaderUrban createUnit [position _randBuildingToPatrolInit, _housePatrolGroup2];
				if (bAllowLargerPatrols) then {
					_sUnitType = selectRandom [sRiflemanUrban, sRiflemanUrban, sRiflemanUrban, sAmmobearerUrban, sGrenadierUrban, sMedicUrban];
					if (selectRandom [true,false]) then {_sUnitType createUnit [position _randBuildingToPatrolInit, _housePatrolGroup2]};
					_sUnitType = selectRandom [sRiflemanUrban, sRiflemanUrban, sRiflemanUrban, sAmmobearerUrban, sGrenadierUrban, sMedicUrban];
					if (selectRandom [true,false]) then {_sUnitType createUnit [position _randBuildingToPatrolInit, _housePatrolGroup2]};
					_sUnitType = selectRandom [sRiflemanUrban, sRiflemanUrban, sRiflemanUrban, sAmmobearerUrban, sGrenadierUrban, sMedicUrban];
				};	
				_sUnitType = selectRandom [sRiflemanUrban, sRiflemanUrban, sRiflemanUrban, sAmmobearerUrban, sGrenadierUrban, sMedicUrban];
				_sUnitType createUnit [position _randBuildingToPatrolInit, _housePatrolGroup2];
				if (selectRandom [true,false]) then {
					_sUnitType = selectRandom [sRiflemanUrban, sRiflemanUrban, sRiflemanUrban, sAmmobearerUrban, sGrenadierUrban, sMedicUrban];
					_sUnitType createUnit [position _randBuildingToPatrolInit, _housePatrolGroup2];	
				};
				
				_randBuildingToPatrol = selectRandom _allBuildingsToPatrol;
				_wp1 = _housePatrolGroup2 addWaypoint [position _randBuildingToPatrol, 0];	
				_randBuildingToPatrol2 = selectRandom _allBuildingsToPatrol;
				_wp2 = _housePatrolGroup2 addWaypoint [position _randBuildingToPatrol2, 0];	
				_randBuildingToPatrol3 = selectRandom _allBuildingsToPatrol;
				_wp3 = _housePatrolGroup2 addWaypoint [position _randBuildingToPatrol3, 0];	
				_randBuildingToPatrol4 = selectRandom _allBuildingsToPatrol;
				_wp4 = _housePatrolGroup2 addWaypoint [position _randBuildingToPatrol4, 0];	
				_randBuildingToPatrol5 = selectRandom _allBuildingsToPatrol;
				_wp5 = _housePatrolGroup2 addWaypoint [position _randBuildingToPatrol5, 0];	
				_randBuildingToPatrol6 = selectRandom _allBuildingsToPatrol;
				_wp6 = _housePatrolGroup2 addWaypoint [position _randBuildingToPatrol6, 0];
				_randBuildingToPatrol7 = selectRandom _allBuildingsToPatrol;
				_wp7 = _housePatrolGroup2 addWaypoint [position _randBuildingToPatrol7, 0];
				_randBuildingToPatrol8 = selectRandom _allBuildingsToPatrol;
				_wp8 = _housePatrolGroup2 addWaypoint [position _randBuildingToPatrol8, 0];
				_randBuildingToPatrol9 = selectRandom _allBuildingsToPatrol;
				_wp9 = _housePatrolGroup2 addWaypoint [position _randBuildingToPatrol9, 0];
				_randBuildingToPatrol10 = selectRandom _allBuildingsToPatrol;
				_wp10 = _housePatrolGroup2 addWaypoint [position _randBuildingToPatrol10, 0];
				_randBuildingToPatrol11 = selectRandom _allBuildingsToPatrol;
				_wp11 = _housePatrolGroup2 addWaypoint [position _randBuildingToPatrol11, 0];
				_randBuildingToPatrol12 = selectRandom _allBuildingsToPatrol;
				_wp12 = _housePatrolGroup2 addWaypoint [position _randBuildingToPatrol12, 0];
				[_housePatrolGroup2, 0] setWaypointSpeed "LIMITED";
				[_housePatrolGroup2, 0] setWaypointBehaviour "SAFE";
				[_housePatrolGroup2, 1] setWaypointSpeed "LIMITED";
				[_housePatrolGroup2, 1] setWaypointBehaviour "SAFE";
				[_housePatrolGroup2, 11] setWaypointType "CYCLE";
				_housePatrolGroup2 setBehaviour "SAFE";	
				if (selectRandom [true,false]) then {
					_housePatrolGroup2 setCombatMode "RED";
				}
			};
		};
	
	
	//_BuildingLocationsPopulated
	//_BuildingLocationsPopulated pushBack position _randBuilding; 
	//if (position _randBuilding in _BuildingLocationsPopulated) then {
		
		if (selectRandom [true,false]) then {
			_allBuildings = nearestObjects [getMarkerPos _sAreaMarkerName, ["house"], 250];
			_randBuilding = selectRandom _allBuildings;
			if (!(position _randBuilding in _BuildingLocationsPopulated)) then {
				_BuildingLocationsPopulated pushBack position _randBuilding; 
				_groupInnerHouse = createGroup east; 
				sRifleman createUnit [position _randBuilding, _groupInnerHouse, "[getPosATL this, units group this, -1, false, false] execVM ""RandFramework\Zen_OccupyHouse.sqf"""];
			};
		};	
		
		if (selectRandom [true,false]) then {
			_allBuildings = nearestObjects [getMarkerPos _sAreaMarkerName, ["house"], 150];
			_randBuilding = selectRandom _allBuildings;
			if (!(position _randBuilding in _BuildingLocationsPopulated)) then {
				_BuildingLocationsPopulated pushBack position _randBuilding; 
				_groupInnerHouse2 = createGroup east; 
				sRiflemanUrban createUnit [position _randBuilding, _groupInnerHouse2, "[getPosATL this, units group this, -1, false, false] execVM ""RandFramework\Zen_OccupyHouse.sqf"""];
			};
		};	
		
		if (selectRandom[true,false,false]) then {

			_allBuildings3 = nearestObjects [getMarkerPos _sAreaMarkerName, ["house"], 1500];
			_randBuilding3 = selectRandom _allBuildings3;
			if (!(position _randBuilding3 in _BuildingLocationsPopulated)) then {
				_BuildingLocationsPopulated pushBack position _randBuilding3; 
				_groupInnerHouse3 = createGroup east; 
			
				_distanceSniper = getMarkerPos "mrkHQ" distance position _randBuilding3;	
			    	if (_distanceSniper > 500) then {
					sSniper createUnit [position _randBuilding3, _groupInnerHouse3, "[getPosATL this, units group this, -1, false, false] execVM ""RandFramework\Zen_OccupyHouse.sqf""; this setBehaviour ""COMBAT"""];
				};
			};
		};	
		
		
		_allBuildings2 = nearestObjects [getMarkerPos _sAreaMarkerName, ["house"], 1000];
		_randBuilding2 = selectRandom _allBuildings2;
		if (!(position _randBuilding2 in _BuildingLocationsPopulated)) then {
				_BuildingLocationsPopulated pushBack position _randBuilding2; 
			_groupInnerHouse4 = createGroup east; 
			sRifleman createUnit [position _randBuilding2, _groupInnerHouse4, "[getPosATL this, units group this, -1, false, false] execVM ""RandFramework\Zen_OccupyHouse.sqf"""];
		};	

		_allBuildings2b = nearestObjects [getMarkerPos _sAreaMarkerName, ["house"], 1000];
		_randBuilding2b = selectRandom _allBuildings2b;
		if (!(position _randBuilding2b in _BuildingLocationsPopulated)) then {
				_BuildingLocationsPopulated pushBack position _randBuilding2b; 
			_groupInnerHouse4b = createGroup east; 
			sRifleman createUnit [position _randBuilding2b, _groupInnerHouse4b, "[getPosATL this, units group this, -1, false, false] execVM ""RandFramework\Zen_OccupyHouse.sqf"""];
		};	

		
		if (selectRandom [true,false] || bAllowLargerPatrols) then {
			_allBuildings = nearestObjects [getMarkerPos _sAreaMarkerName, ["house"], 150];
			_randBuilding = selectRandom _allBuildings;
			if (!(position _randBuilding in _BuildingLocationsPopulated)) then {
				_BuildingLocationsPopulated pushBack position _randBuilding; 
				_groupInnerHouse5 = createGroup east; 
				sRiflemanUrban createUnit [position _randBuilding, _groupInnerHouse5, "[getPosATL this, units group this, -1, false, false] execVM ""RandFramework\Zen_OccupyHouse.sqf"""];
				if (bAllowLargerPatrols || selectRandom [true,false]) then {sRiflemanUrban createUnit [position _randBuilding, _groupInnerHouse5, "[getPosATL this, units group this, -1, false, false] execVM ""RandFramework\Zen_OccupyHouse.sqf"""];};
			};
		};	
		if (selectRandom [true,false] || bAllowLargerPatrols) then {
			_allBuildings = nearestObjects [getMarkerPos _sAreaMarkerName, ["house"], 150];
			_randBuilding = selectRandom _allBuildings;
			if (!(position _randBuilding in _BuildingLocationsPopulated)) then {
				_BuildingLocationsPopulated pushBack position _randBuilding; 
				_groupInnerHouse6 = createGroup east; 
				sRiflemanUrban createUnit [position _randBuilding, _groupInnerHouse6, "[getPosATL this, units group this, -1, false, false] execVM ""RandFramework\Zen_OccupyHouse.sqf"""];
				if (bAllowLargerPatrols || selectRandom [true,false]) then {sRiflemanUrban createUnit [position _randBuilding, _groupInnerHouse6, "[getPosATL this, units group this, -1, false, false] execVM ""RandFramework\Zen_OccupyHouse.sqf"""];};
			};
		};	
		if (selectRandom [true,false] || bAllowLargerPatrols) then {
			_allBuildings = nearestObjects [getMarkerPos _sAreaMarkerName, ["house"], 150];
			_randBuilding = selectRandom _allBuildings;
			if (!(position _randBuilding in _BuildingLocationsPopulated)) then {
				_BuildingLocationsPopulated pushBack position _randBuilding; 
				_groupInnerHouse7 = createGroup east; 
								
				sRiflemanUrban createUnit [position _randBuilding, _groupInnerHouse7, "[getPosATL this, units group this, -1, false, false] execVM ""RandFramework\Zen_OccupyHouse.sqf"""];
				if (bAllowLargerPatrols || selectRandom [true,false]) then {
					if (selectRandom [true,false,false,false,false, false]) then {		
						sATManUrban createUnit [position _randBuilding, _groupInnerHouse7, "[getPosATL this, units group this, -1, false, false] execVM ""RandFramework\Zen_OccupyHouse.sqf"""];
						_iHasAT = 1;
					}
					else {
						sRiflemanUrban createUnit [position _randBuilding, _groupInnerHouse7, "[getPosATL this, units group this, -1, false, false] execVM ""RandFramework\Zen_OccupyHouse.sqf"""];
					};
						
				};
			};
		};	
		if (selectRandom [true,false] || bAllowLargerPatrols) then {
			_allBuildings = nearestObjects [getMarkerPos _sAreaMarkerName, ["house"], 150];
			_randBuilding = selectRandom _allBuildings;
			if (!(position _randBuilding in _BuildingLocationsPopulated)) then {
				_BuildingLocationsPopulated pushBack position _randBuilding; 
				_groupInnerHouse8 = createGroup east; 
				sRiflemanUrban createUnit [position _randBuilding, _groupInnerHouse8, "[getPosATL this, units group this, -1, false, false] execVM ""RandFramework\Zen_OccupyHouse.sqf"""];
				if (bAllowLargerPatrols) then {
					if (selectRandom [true,false,false,false]) then {		
						sATManUrban createUnit [position _randBuilding, _groupInnerHouse8, "[getPosATL this, units group this, -1, false, false] execVM ""RandFramework\Zen_OccupyHouse.sqf"""];
						_iHasAT = 1;
					}
					else {
						sRiflemanUrban createUnit [position _randBuilding, _groupInnerHouse8, "[getPosATL this, units group this, -1, false, false] execVM ""RandFramework\Zen_OccupyHouse.sqf"""];
					};
				};
			};
		};	
		//_markerstr = createMarker [format ["tempMarker%1",_iAddedGroups],position _randBuilding2];
		//_markerstr setMarkerShape "ICON";
		//_markerstr setMarkerType "mil_objective";
		//_markerstr setMarkerText "temp";
		
		
		
		//add civilians
		if (_sAreaMarkerName == "mrkFirstLocation") then {
			if (selectRandom[true]) then {
				_bHasCivs = true;
				_allBuildingsToPatrol = nearestObjects [getMarkerPos _sAreaMarkerName, ["house"], 130];
				_randBuildingToPatrolInit = selectRandom _allBuildingsToPatrol;
				_housePatrolGroup = createGroup Civilian; 
				sCivilian createUnit [position _randBuildingToPatrolInit, _housePatrolGroup, "this addEventHandler [""killed"", {_this execVM ""RandFramework\CivKilled.sqf""}]"];
				//_newCiv = sCivilian createUnit [position _randBuildingToPatrolInit, _housePatrolGroup];
				//_newCiv addEventHandler ["killed", {_this exec "RandFramework\CivKilled.sqf"}];
								
				_randBuildingToPatrol = selectRandom _allBuildingsToPatrol;
				_wp1 = _housePatrolGroup addWaypoint [position _randBuildingToPatrol, 0];	
				_randBuildingToPatrol2 = selectRandom _allBuildingsToPatrol;
				_wp1 = _housePatrolGroup addWaypoint [position _randBuildingToPatrol2, 0];	
				_randBuildingToPatrol3 = selectRandom _allBuildingsToPatrol;
				_wp1 = _housePatrolGroup addWaypoint [position _randBuildingToPatrol3, 0];	
				_randBuildingToPatrol4 = selectRandom _allBuildingsToPatrol;
				_wp1 = _housePatrolGroup addWaypoint [position _randBuildingToPatrol4, 0];	
				_randBuildingToPatrol5 = selectRandom _allBuildingsToPatrol;
				_wp1 = _housePatrolGroup addWaypoint [position _randBuildingToPatrol5, 0];	
				_randBuildingToPatrol6 = selectRandom _allBuildingsToPatrol;
				_wp1 = _housePatrolGroup addWaypoint [position _randBuildingToPatrol6, 0];
				[_housePatrolGroup, 0] setWaypointSpeed "FULL";
				[_housePatrolGroup, 0] setWaypointBehaviour "CARELESS";
				[_housePatrolGroup, 1] setWaypointSpeed "FULL";
				[_housePatrolGroup, 1] setWaypointBehaviour "CARELESS";
				[_housePatrolGroup, 5] setWaypointType "CYCLE";
				_housePatrolGroup setBehaviour "CARELESS";	
			};
		};
		
		_iAddedGroups = _iAddedGroups + 1;
		if (_iAddedGroups >= _maxGroups) then {
			_bStopAdding = true;
			AddedGroupTotal = _maxGroups;
			PublicVariable "AddedGroupTotal";
		};
			
	};	
	
	bCivKilled = false;
	publicVariable "bCivKilled";
	//bTooManyCivKilled = false;
	//publicVariable "bTooManyCivKilled";
	CivDeathCount = 0;
	publicVariable "CivDeathCount";
	
	//dont cause unit to be turned against due to friendly fire or killing civs

			
	if (_bHasCivs) then {
		//create task
		[FriendlySide,["tskAvoidCivCas", "(IMPORTANT) AVOID CIVILIAN CASUALTIES!, too many could result in the mission being aborted", "AVOID CIVILIAN CASUALTIES",""]] call FHQ_TT_addTasks;
			_trg = createTrigger ["EmptyDetector", [0,0]];
			_trg setTriggerArea [0, 0, 0, false];	
			_trg setTriggerStatements ["bCivKilled", "[""tskAvoidCivCas"", ""failed""] call FHQ_TT_setTaskState;", ""];					
			
			trgCiv2 = createTrigger ["EmptyDetector", [0,0]];
			trgCiv2 setTriggerArea [0, 0, 0, false];	
			trgCiv2 setTriggerStatements ["CivDeathCount > 2", "hint ""ITS OVER, TOO MANY CIVILIAN DEATHS!"";", ""];								
						
	};
	
	
	try {
		//Now add vehicle
		_bCloseRoundFound = true;
		_randInitRoad = "";
		_roadsWide = [];
		_road = "";
		_endRoad = "";
		_connectedRoads = "";
		_roadsAll = ((getMarkerPos _sAreaMarkerName) nearRoads 150); //150
		if ((count _roadsAll) == 0) then {
			_bCloseRoundFound = false;
			_roadsAll = ((getMarkerPos _sAreaMarkerName) nearRoads 1500); //1500
		}
		else {
			_road = _roadsAll select 0;
		};
	
		_bNoRoadFound = false;
		if ((count _roadsAll) == 0) then {
			//if we still have no road
			_bNoRoadFound = true;
		}
		else {
			_road = _roadsAll select 0;
		};
	    if (!_bNoRoadFound) then {
		if (!_bCloseRoundFound) then {
			_randInitRoad = selectRandom ((getMarkerPos _sAreaMarkerName) nearRoads 1500);
			_roadsWide = ((getMarkerPos _sAreaMarkerName) nearRoads 1500);
			_endRoad = _roadsWide;
			_connectedRoads = roadsConnectedTo _road;
		}
		else {
			_randInitRoad = selectRandom ((getMarkerPos _sAreaMarkerName) nearRoads 150);
			_roadsWide = ((getMarkerPos _sAreaMarkerName) nearRoads 500);
			_endRoad = _roadsWide select ((count _roadsWide) - 1);
			_connectedRoads = roadsConnectedTo _road;
		};
	    };
	
	
	    if (_bNoRoadFound) then {
			if (selectRandom[true,false]) then {
	    			_tankX = (selectRandom [400,-400]) + (getMarkerPos _sAreaMarkerName select 0) + (selectRandom [100,-100]);
				_tankY = (selectRandom [400,-400]) + (getMarkerPos _sAreaMarkerName select 1) + (selectRandom [100,-100]);
				_iVehDice = selectRandom [1,2,3];
				_Tankgroup1 = createGroup east;
				if (_iVehDice == 1) then {
					[[_tankX,_tankY], 180, sTank1, _Tankgroup1] call bis_fnc_spawnvehicle;
				};
				if (_iVehDice == 2) then {
					[[_tankX,_tankY], 180, sTank2, _Tankgroup1] call bis_fnc_spawnvehicle;
					//_veh = "O_MRAP_02_gmg_F" createVehicle position _road;
				};
				if (_iVehDice == 3) then {
					[[_tankX,_tankY],  180, sTank3, _Tankgroup1] call bis_fnc_spawnvehicle;
					//_veh = "O_G_Offroad_01_armed_F" createVehicle position _road;
				};
			};
			if (selectRandom[true,false]) then {
	    			_tankX = (selectRandom [400,-400]) + (getMarkerPos _sAreaMarkerName select 0) + (selectRandom [100,-100]);
				_tankY = (selectRandom [400,-400]) + (getMarkerPos _sAreaMarkerName select 1) + (selectRandom [100,-100]);
				_iVehDice = selectRandom [1,2,3];
				_Tankgroup2 = createGroup east;
				if (_iVehDice == 1) then {
					[[_tankX,_tankY], 180, sTank1, _Tankgroup2] call bis_fnc_spawnvehicle;
				};
				if (_iVehDice == 2) then {
					[[_tankX,_tankY], 180, sTank2, _Tankgroup2] call bis_fnc_spawnvehicle;
					//_veh = "O_MRAP_02_gmg_F" createVehicle position _road;
				};
				if (_iVehDice == 3) then {
					[[_tankX,_tankY],  180, sTank3, _Tankgroup2] call bis_fnc_spawnvehicle;
					//_veh = "O_G_Offroad_01_armed_F" createVehicle position _road;
				};
			};
	    }
	    else {
		if (selectRandom [true,false]) then {
			//O_MBT_02_cannon_F
			//O_MRAP_02_gmg_F
			//O_G_Offroad_01_armed_F
			_groupv1 = createGroup east;
			_iVehDice = selectRandom [1,2,3];
			_xVPos = (position _randInitRoad select 0) + selectRandom[3,-3];
			_yVPos = (position _randInitRoad select 1) + selectRandom[3,-3];
			if (_iVehDice == 1) then {
				[position _randInitRoad, 180, sTank1, _groupv1] call bis_fnc_spawnvehicle;
			};
			if (_iVehDice == 2) then {
				[position _randInitRoad, 180, sTank2, _groupv1] call bis_fnc_spawnvehicle;
				//_veh = "O_MRAP_02_gmg_F" createVehicle position _road;
			};
			if (_iVehDice == 3) then {
				[position _randInitRoad,  180, sTank3, _groupv1] call bis_fnc_spawnvehicle;
				//_veh = "O_G_Offroad_01_armed_F" createVehicle position _road;
			};
			
			//if (_iBuildingSize > 0 && selectRandom [true,false]) then {
			//	_wayX = position _road select 0;
			//	_wayY = position _road select 1;
			//	_wayXEnd = position _endRoad select 0;
			//	_wayYEnd = position _endRoad select 1;
			//	_v1wp1 =_groupv1 addWaypoint [[ _wayX, _wayY, 0], 0];
			//	_v1wp2 =_groupv1 addWaypoint [[ _wayXEnd, _wayXEnd, 0], 0];
			//	_v1wp3 =_groupv1 addWaypoint [[ _wayX, _wayY, 0], 0];
			//	[_groupv1, 0] setWaypointSpeed "LIMITED";
			//	[_groupv1, 0] setWaypointBehaviour "SAFE";
			//	[_groupv1, 1] setWaypointSpeed "LIMITED";
			//	[_groupv1, 1] setWaypointBehaviour "SAFE";
			//	[_groupv1, 2] setWaypointType "CYCLE";
			//	_groupv1 setBehaviour "SAFE";		
			//};
		};
	
		if (selectRandom [true,false]) then {	
			try {
				_groupv2 = createGroup east;
				_iVehDice = selectRandom [1,2,3];
				_randRoad = selectRandom _roadsWide;
				if (_iVehDice == 1) then {
					[position _randRoad, 180, sTank1, _groupv2] call bis_fnc_spawnvehicle;
				};
				if (_iVehDice == 2) then {
					[position _randRoad, 180, sTank2, _groupv2] call bis_fnc_spawnvehicle;
					//_veh = "O_MRAP_02_gmg_F" createVehicle position _road;
				};
				if (_iVehDice == 3) then {
					[position _randRoad,  180, sTank3, _groupv2] call bis_fnc_spawnvehicle;
					//_veh = "O_G_Offroad_01_armed_F" createVehicle position _road;
				};
				//hint str _roadsWide;
			}
			Catch {
				//hint str _roadsWide;
			};
		};
		
		
		_roadsAll2 = ((getMarkerPos _sAreaMarkerName) nearRoads 2000); //1500
		if (bAllowLargerPatrols && selectRandom [true,false]) then {	
			try {
				_groupv2a = createGroup east;
				_iVehDice = selectRandom [1,2,3];
				_randRoad = selectRandom _roadsAll2;
				if (_iVehDice == 1) then {
					[position _randRoad, 180, sTank1, _groupv2a] call bis_fnc_spawnvehicle;
				};
				if (_iVehDice == 2) then {
					[position _randRoad, 180, sTank2, _groupv2a] call bis_fnc_spawnvehicle;
					//_veh = "O_MRAP_02_gmg_F" createVehicle position _road;
				};
				if (_iVehDice == 3) then {
					[position _randRoad,  180, sTank3, _groupv2a] call bis_fnc_spawnvehicle;
					//_veh = "O_G_Offroad_01_armed_F" createVehicle position _road;
				};
				//hint str _roadsWide;
			}
			Catch {
				//hint str _roadsWide;
			};
		};
		if (bAllowLargerPatrols && selectRandom [true,false]) then {	
			try {
				_groupv2b = createGroup east;
				_iVehDice = selectRandom [1,2,3];
				_randRoad = selectRandom _roadsAll2;
				if (_iVehDice == 1) then {
					[position _randRoad, 180, sTank1, _groupv2b] call bis_fnc_spawnvehicle;
				};
				if (_iVehDice == 2) then {
					[position _randRoad, 180, sTank2, _groupv2b] call bis_fnc_spawnvehicle;
					//_veh = "O_MRAP_02_gmg_F" createVehicle position _road;
				};
				if (_iVehDice == 3) then {
					[position _randRoad,  180, sTank3, _groupv2b] call bis_fnc_spawnvehicle;
					//_veh = "O_G_Offroad_01_armed_F" createVehicle position _road;
				};
				//hint str _roadsWide;
			}
			Catch {
				//hint str _roadsWide;
			};
		};
		
		
		
	    };
	}
	catch {
		
	};
	
	publicVariable "sBreifing"; 
	_sBriefing = sBreifing;
	publicVariable "sBreifing"; 
	
	if (_sAreaMarkerName == "Hidden_mrksecondLocation") then {
		_sBriefing = format ["%1<br /><br />Intel regarding equipment cache location:",_sBriefing];
	}
	else
	{
		_sBriefing = format ["%1<br /><br />Intel regarding officer location:",_sBriefing];
	};
	
		
	if (_iHasAA == 0 && selectRandom [true,false]) then {
		_sBriefing = format ["%1<br />-Intel has confirmed that no AA units are present",_sBriefing];
	};
	if (_iHasAA == 1 && selectRandom [true,false]) then {
		_sBriefing = format ["%1<br /><br />Be warned, intel have confirmed AA units are in use!",_sBriefing];
	};
	
	
	if (_iHasAT == 0 && selectRandom [true,false]) then {
		_sBriefing = format ["%1<br />-No AT units are being used",_sBriefing];
	};
	if (_iHasAT == 1 && selectRandom [true,false]) then {
		_sBriefing = format ["%1<br />-We have reports of AT units in use",_sBriefing];
	};
	
	
	
	if (selectRandom [true,false]) then {
		_sBriefing = format ["%1<br />-Unsure of the enemy strengh in this area",_sBriefing];
	}
	else {
		if (_iIsHeavilyDefended == 0 && selectRandom [true,false]) then {
			_sBriefing = format ["%1<br />-We have reports of large enemy activity in this area!",_sBriefing];
		};
	};
		


	sBreifing = _sBriefing;
	publicVariable "sBreifing";	
	
	
		
	_ret = [_iHasAA, _iHasAT, _iIsHeavilyDefended];
	_ret;
};

TreendyGetRandomLocation2 =
{
	private ["_sMarkerText","_sPlayerStartMarker","_iPlayerStartRadius"];
	//_bRet = false;
	_sMarkerText = _this select 0;
      _sPlayerStartMarker = _this select 1;
      _iPlayerStartRadius = _this select 2;
      
      		//TREEND HERE           
           	//DONE sort playerStartRadius, so not too close to start area
           	//switch around, so random building first, then named location... expand location search each time until found 2nd location
           	//DONE - sort marker name for main mission stuff
           	//DONE pass in task title
           //if nearestLocations array is empty, then just use second mainBuildings array (create locations array in global... so can adjust for other maps)

      if (isServer) then {
		_towns = nearestLocations [getMarkerPos _sPlayerStartMarker, sFirstAreaLocationTypes, MainSearchRange];
		
		_townsX = 0;
		_townsY = 0;
		_bLocFound = false;
		
		if (!bUseArea1HardcodedAreas) then {
			_attemptCount = 0;
			while {!_bLocFound} do {
				_attemptCount = _attemptCount + 1;
				_baseBuild = selectRandom _towns;
				_townsX = position _baseBuild select 0;
				_townsY = position _baseBuild select 1;
				_meters = [_townsX,_townsY] distance getMarkerPos _sPlayerStartMarker;
				if (_meters > _iPlayerStartRadius) then {
					_bLocFound = true;
				};
				if (_attemptCount > 500) then {
					//if we have tried 100 times, then just use our found location, regardless of distance
					_bLocFound = true;
				};
			};
		}	
		else {
			_sArea1MarkerName = selectRandom Area1HardCodedAreas;
			hint format ["Loc%1",_sArea1MarkerName];
			_townsX = getMarkerPos _sArea1MarkerName select 0;
			_townsY = getMarkerPos _sArea1MarkerName select 1;			
			//_bLocFound = true;
		};
		
		_buildings = nearestObjects [[_townsX,_townsY], BasicBuildings, iMaxDistFromFirstLocationToSecond];
		
		_townsX2 = 0;
		_townsY2 = 0;
		
		if (!bUseArea2HardcodedAreas) then {
			_bLocFound = false;
			_attemptCount = 0;
			while {!_bLocFound} do {
				_attemptCount = _attemptCount + 1;
				_baseBuild2 = selectRandom _buildings;
				_townsX2 = position _baseBuild2 select 0;
				_townsY2 = position _baseBuild2 select 1;
				_meters = [_townsX,_townsY] distance [_townsX2,_townsY2];
				_metersHQ = [_townsX2,_townsY2] distance getMarkerPos _sPlayerStartMarker;		
				if (_meters > 400 && _metersHQ > 1700) then {
					_bLocFound = true;
				};
				if (_attemptCount > 100) then {
					//if we have tried 100 times, then just use our found location, regardless of distance
					_bLocFound = true;
				};
			};
		}
		else {
			_bLocFound = false;
			_attemptCount = 0;
			_iMaxDistFromFirstLocationToSecond = iMaxDistFromFirstLocationToSecond;
			while {!_bLocFound} do {
				_attemptCount = _attemptCount + 1;
				_sArea2MarkerName = selectRandom Area2HardCodedAreas;
				hint format ["AHGGG Loc2%1 first: %2 - MaxDist: %3",_sArea2MarkerName, [_townsX,_townsY, _iMaxDistFromFirstLocationToSecond]];
				_townsX2 = getMarkerPos _sArea2MarkerName select 0;
				_townsY2 = getMarkerPos _sArea2MarkerName select 1;	
				_meters = [_townsX,_townsY] distance [_townsX2,_townsY2];
				_metersHQ = [_townsX2,_townsY2] distance getMarkerPos _sPlayerStartMarker;		
				if (_meters > iMinDistFromFirstLocationToSecond && _meters < _iMaxDistFromFirstLocationToSecond &&  _metersHQ > iMinDistFromHQToSecond) then {
					_bLocFound = true;
				};
				if (_attemptCount > 100) then {
					_iMaxDistFromFirstLocationToSecond = _iMaxDistFromFirstLocationToSecond + 100;
					//if we have tried 100 times, then just use our found location, regardless of distance
					//_bLocFound = true;
				};
			};
		};	
				
		_sLocationMarkerName = "mrkFirstLocation";
		_sLocationMarkerName2 = "mrksecondLocation";
		_sMarkerText1 = _sMarkerText select 0;
		_sMarkerText2 = _sMarkerText select 1;
		
		_isSwitchFirstAndSecondLocations = selectRandom isSwitchFirstAndSecondLocations;
				
		if (_isSwitchFirstAndSecondLocations) then {
			_sLocationMarkerName = "mrksecondLocation";
			_sLocationMarkerName2 = "mrkFirstLocation";
			_sMarkerText1 = _sMarkerText select 1;
			_sMarkerText2 = _sMarkerText select 0;
		};
		
		_townsXWithOffset = _townsX + selectRandom [-10,0,10];
		_townsYWithOffset = _townsY + selectRandom [-10,10];
		_markerstr = createMarker [_sLocationMarkerName,[_townsXWithOffset,_townsYWithOffset]];
		_markerstr setMarkerShape "ICON";
		//_markerstr setMarkerDir 45;
		//_markerstr setMarkerSize [200, 200];
		//_markerstr setMarkerColor "ColorOPFOR";
		if (IsSingleMission && _isSwitchFirstAndSecondLocations) then {
			_markerstr setMarkerType selectRandom OccupiedAreaIcon;
			_markerstr setMarkerText "Occupied Area";   
		}
		else {
			_markerstr setMarkerType selectRandom TaskOneIcon;
			_markerstr setMarkerText (_sMarkerText1);    
		};
	  
		
		
		
		_markerstr2 = createMarker [_sLocationMarkerName2,[_townsX2,_townsY2]];
		_markerstr2 setMarkerShape "ICON";
		//_markerstr2 setMarkerDir 45;
		//_markerstr setMarkerSize [200, 200];
		//_markerstr setMarkerColor "ColorOPFOR";
		if (IsSingleMission && !_isSwitchFirstAndSecondLocations) then {
			_markerstr2 setMarkerType selectRandom OccupiedAreaIcon;
			_markerstr2 setMarkerText "Occupied Area";   
		}
		else {
			_markerstr2 setMarkerType selectRandom TaskTwoIcon;
			_markerstr2 setMarkerText (_sMarkerText2);   
		};
		
		
				
 		//iMarker = 1;
 		//{
	 	//	_sLocationMarkerName = format["%1_%2",_sLocationMarkerName,iMarker];
		//	 _markerstr = createMarker [_sLocationMarkerName,position _x];
		//	_markerstr setMarkerShape _sMarkerShape;
		//	//_markerstr setMarkerSize [200, 200];
		//	//_markerstr setMarkerColor "ColorOPFOR";
		//	_markerstr setMarkerType _sMarkerType;
		//	_markerstr setMarkerText "T";
		//	iMarker = iMarker + 1;
		//}  forEach _towns;
 
 
	};     

};

//_iClusterAreaSize is the area size for our cluster... for example if we have a cluster of 2 buildings, then we only want these two buildings
//	to be within our area (we allow a couple more then the small cluster)
//playerStartMarker is actually the centroal point to search... and the radius is the to make sure location found isnt within its radius
TreendyGetRandomLocation2Old =
{
	private ["_iSearchRange", "_iBuildingSize","_sMarkerShape","_sMarkerType",
	"_sMarkerText","_sPlayerStartMarker","_iPlayerStartRadius", "_sLocationMarkerName", "_iClusterAreaSize", "_iAttemptsAllowed"];
	_bRet = false;
	_iSearchRange = _this select 0;
	_iBuildingSize = _this select 1;
	_sMarkerShape = _this select 2;
	_sMarkerType = _this select 3;
	_sMarkerText = _this select 4;
      _sPlayerStartMarker = _this select 5;
      _iPlayerStartRadius = _this select 6;
      _sLocationMarkerName = _this select 7;
      _iClusterAreaSize = _this select 8;
      _iAttemptsAllowed = _this select 9;
      
       if (isServer) then {
	    	_iAttemptCount = 0;
	    	_bLocFound = false;
		_bLocFailed = false;
		//hint format ["attempts:%1",_iAttemptCount];
	   	while {!_bLocFound && !_bLocFailed} do {
			_xPos = 0;
	      	_yPos = 0;
	      	//will calculated the average X,Y of our clustered buildings
      		_totX = 0;
	      	_totY = 0;
   			_iAttemptcount = _iAttemptcount + 1;	
   
   		
			//_allBuildings = nearestObjects [getMarkerPos _sPlayerStartMarker, ["house"], _iSearchRange];
			//_randBuilding = selectRandom _allBuildings;
			
			_searchX = (getMarkerPos _sPlayerStartMarker select 0) - (floor(_iSearchRange / 2)) + (floor random _iSearchRange);
			_searchY = (getMarkerPos _sPlayerStartMarker select 1) - (floor(_iSearchRange / 2)) + (floor random _iSearchRange);
						
			
				
				
			_randBuilding = [_searchX,_searchY] nearestObject "house";

			_bIsWaterSurface = false;
			if ((surfaceIsWater [_searchX,_searchY])) then {
				_bIsWaterSurface = true;
			};
			
			_distance = getMarkerPos _sPlayerStartMarker distance _randBuilding;	
			if (_distance > _iPlayerStartRadius && !_bIsWaterSurface) then {	
	
			//_markerstr = createMarker [format ["afafaf%1",_iAttemptcount],[_searchX,_searchY]];
			//_markerstr setMarkerShape _sMarkerShape;
			//_markerstr setMarkerType _sMarkerType;
			//_markerstr setMarkerText _sMarkerText;
			
				_iCondensedClusterArea = 0;
				_iCondensedIdealBuildingCount = 0;
				if (_iBuildingSize == -1) then {	
					_iCondensedClusterArea = 20;
					_iCondensedIdealBuildingCount = 1;
				};
				if (_iBuildingSize == 0) then {	
					_iCondensedClusterArea = 50;
					_iCondensedIdealBuildingCount = 2;
				};
				if (_iBuildingSize == 1) then {
					_iCondensedClusterArea = 70;
					_iCondensedIdealBuildingCount = 5;
				};
				if (_iBuildingSize == 2) then {
					_iCondensedClusterArea = 100;
					_iCondensedIdealBuildingCount = 15;
				};
				_allClusterBuildings = nearestObjects [_randBuilding, ["house"], _iCondensedClusterArea];
	
				//loop through all buildings to get count of buildings with at least 3 positions within
				//also building up average position
				_buildTotCount = 0;
				{
					_allpositionsInner = _x buildingPos -1;
					_posCountInner = (count _allpositionsInner);
					if (_posCountInner > 2) then {
						_buildTotCount = _buildTotCount + 1;
						_totX = _totX + ((getPos _x) select 0);
						_totY = _totY + ((getPos _x) select 1);
					};
				}  forEach _allClusterBuildings;
				if (_buildTotCount > 0) then {
					_xPos = _totX / _buildTotCount;
					_YPos = _totY / _buildTotCount;
				};
		//hint format ["buildCount:%1",_buildTotCount]; sleep 1;
				_bPassFirstPhase = false;							
					
				if (_buildTotCount >= _iCondensedIdealBuildingCount) then {
					_bPassFirstPhase = true;
				};
		
						
				if (_bPassFirstPhase) then {
					_allAreaBuildings = nearestObjects [[_xPos,_yPos], ["house"], _iClusterAreaSize];
					_AllAreaBuildingCount = count _allAreaBuildings;
					if (_iBuildingSize == 0 || _iBuildingSize == -1) then {
						if (_AllAreaBuildingCount < _buildTotCount + 6) then {
							_bLocFound = true;
						};
					};
					if (_iBuildingSize == 1) then {
						if (_AllAreaBuildingCount < _buildTotCount + 17) then {
							_bLocFound = true;
						};
					};
					if (_iBuildingSize == 2) then {
						_bLocFound = true;
					};
					if (_bLocFound) then {
						
						_markerstr2 = createMarker [format ["Hidden_%1",_sLocationMarkerName],_randBuilding];
						_markerstr2 setMarkerShape "ICON";
						_markerstr2 setMarkerType "Empty";
						//_markerstr2 setMarkerType "mil_objective";
						_markerstr2 setMarkerText "hmm";
						
						
						//_markerstr = createMarker [_sLocationMarkerName,_randBuilding];
						_markerstr = createMarker [_sLocationMarkerName,[_xPos,_yPos]];
						_markerstr setMarkerShape _sMarkerShape;
						//_markerstr setMarkerSize [200, 200];
						//_markerstr setMarkerColor "ColorOPFOR";
						_markerstr setMarkerType _sMarkerType;
						_markerstr setMarkerText _sMarkerText;
						//hint format ["attempt:%1",_iAttemptCount]; sleep 1;
					};
				};
				_iPerc = _iAttemptCount/_iAttemptsAllowed*100;
				
				
						
				format ["Receiving Mission Data: Percent: %1",_iPerc] remoteExec ["hintSilent"]; 
				
				//hintSilent format ["Receiving Mission Data:%1 percent...",_iPerc];
				if (_iAttemptCount > _iAttemptsAllowed) then {
					_bLocFailed = true;
					//hint "FAILED";
				};		
			};
		};	
		if (_bLocFound) then {
			_bRet = true;
//hint "FOUND"; 
//sleep 2;
		}
		else {
			_bRet = false;
//hint "NOT FOUND";
//sleep 2;				
		};	
	};
	_bRet;
};
