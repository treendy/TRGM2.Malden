_FirstLocFarWaitTime = floor random 900; //any time up to 15 mins
sleep _FirstLocFarWaitTime;


_markerstrLeader = createMarker ["TaskLoc1", Task1Location];
_markerstrLeader setMarkerShape "ICON";
_markerstrLeader setMarkerType "hd_dot";
_markerstrLeader setMarkerText "";
_markerstrLeader setMarkerColor "ColorRed";
			
[HQMan,"LocationFound"] remoteExec ["sideRadio",2,true];

