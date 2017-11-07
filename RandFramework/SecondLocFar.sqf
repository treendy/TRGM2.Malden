_SecondLocFarWaitTime = floor random 900; //any time up to 15 mins
sleep _SecondLocFarWaitTime;


_markerstrLeader2 = createMarker ["TaskLoc2", Task2Location];
_markerstrLeader2 setMarkerShape "ICON";
_markerstrLeader2 setMarkerType "hd_dot";
_markerstrLeader2 setMarkerText "";
_markerstrLeader2 setMarkerColor "ColorRed";
			
[HQMan,"LocationFound"] remoteExec ["sideRadio",0,true];
