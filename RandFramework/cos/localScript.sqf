"COSTownLabel" addPublicVariableEventHandler
{
private ["_GHint","_GHint1","_Hintg","_sizeX","_sizeY"];
_Hintg = (_this select 1);
_GHint = (_Hintg select 0);
_GHint1= (_Hintg select 1);
	_sizeX=getMarkerSize _GHint1 select 0;
	_sizeY=getMarkerSize _GHint1 select 1;
	
 if (_sizeY>_sizeX) then {_mSize=_sizeY}else{_mSize=_sizeX};
	if (player distance markerpos _GHint1 < (COS_distance+ _mSize)) 
		then {
		_population=format ["Population: %1",_GHint];
		0=[markertext _GHint1,_population] spawn BIS_fnc_infoText;
			};
};

//ENABLE GLOBAL SIDECHAT
"COSGlobalSideChat" addPublicVariableEventHandler
{
private ["_GHint","_ghint1","_ghint2","_ghint3","_hintg"];
_hintg= (_this select 1);
_GHint = (_hintg select 0);
_ghint1= (_hintg select 1);
_ghint2= (_hintg select 2);
_ghint3= (_hintg select 3);
player groupChat (format ["Town:%4 .Civilians:%1 .Vehicles:%2 .Parked:%3",_GHint,_ghint1,_ghint2, _ghint3]);
};