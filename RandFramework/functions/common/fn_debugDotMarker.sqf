sText = _this select 0;
pos = _this select 1;

_mrkDebug = Nil;
_mrkDebug = createMarker [sText, pos];
_mrkDebug setMarkerShape "ICON";
_mrkDebug setMarkerType "hd_dot";
_mrkDebug setMarkerText sText;