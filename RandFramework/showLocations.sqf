			_markerstrLeader = createMarker ["TaskLoc1", Task1Location];
			_markerstrLeader setMarkerShape "ICON";
			_markerstrLeader setMarkerType "hd_dot";
			_markerstrLeader setMarkerText "";
			_markerstrLeader setMarkerColor "ColorRed";	
			
			_markerstrLeader2 = createMarker ["TaskLoc2", Task2Location];
			_markerstrLeader2 setMarkerShape "ICON";
			_markerstrLeader2 setMarkerType "hd_dot";
			_markerstrLeader2 setMarkerText "";
			_markerstrLeader2 setMarkerColor "ColorRed";
			
[[HQMan,"EnemyBaseIntel"],"sideRadio",true,true] call BIS_fnc_MP;