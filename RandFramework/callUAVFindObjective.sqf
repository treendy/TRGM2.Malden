[HQMan,localize "STR_TRGM2_callUAVFindObjective_UAVInbound"] remoteExecCall ["sideChat",0,false];
sleep 10;
[HQMan,localize "STR_TRGM2_callUAVFindObjective_UAVScanned"] remoteExecCall ["sideChat",0,false];

//AODetails select 0
_sTargetName = format["objInformant%1",(AODetails select 0) select 0];
_officerObject = missionNamespace getVariable [_sTargetName , objNull];
_targetPos = getPos _officerObject;
_test = nil;
_markerName = format["MrkTargetLocation%1%2",_targetPos select 0, _targetPos select 1];
_test = createMarker [_markerName, _targetPos];
_test setMarkerShape "ICON";
_test setMarkerType "o_inf";
_test setMarkerText (localize "STR_TRGM2_callUAVFindObjective_HVTLocation");

sleep 10;

deleteMarker _markerName;