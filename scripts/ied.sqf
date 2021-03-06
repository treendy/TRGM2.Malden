iedMkr=["ied"];	//List of markers to spawn IEDs in
iedNum=1;								//Number of IEDs per marker, defined in iedMkr	[Default: 5]
iedDmg=true;							//Can the IED be killed with weapons?			[Default: false] TRUE = Yes | FALSE = Can only be disarmed
Dbug=true;								//Show IED markers on map?						[Default: false]



//!!DO NOT EDIT BELOW!!
iedBlast=["Bo_Mk82","Rocket_03_HE_F","M_Mo_82mm_AT_LG","Bo_GBU12_LGB","Bo_GBU12_LGB_MI10","HelicopterExploSmall"];
iedList=["ACE_IEDUrbanSmall_Range","ACE_IEDLandSmall_Range","ACE_IEDUrbanBig_Range"];
iedAmmo=["IEDUrbanSmall_Remote_Ammo","IEDLandSmall_Remote_Ammo","IEDUrbanBig_Remote_Ammo","IEDLandBig_Remote_Ammo"];
iedJunk=["Land_GarbageHeap_02_F","Land_GarbageHeap_03_F","UK3CB_Lada_Wreck"];
if(!Dbug)then{{_x setMarkerAlpha 0;}forEach iedMkr;};

if(!isServer)exitWith{};
iedAct={_iedObj=_this select 0;
if(mineActive _iedObj)then{
_iedBlast=selectRandom iedBlast;
createVehicle[_iedBlast,(getPosATL _iedObj),[],0,""];
createVehicle["Crater",(getPosATL _iedObj),[],0,""];
{deleteVehicle _x}forEach nearestObjects[getPosATL _iedObj,iedJunk,4];
deleteVehicle _iedObj;};};

{private["_ieds","_trig","_obj","_pos","_grp","_pos2"];_ieds=[];_iedArea=getMarkerSize _x select 0;_iedRoad=(getMarkerPos _x)nearRoads _iedArea;
	for "_i" from 1 to iedNum do{
	if(count _ieds==iedNum*4)exitWith{};
	_iedR=selectRandom _iedRoad;
	_ied=selectRandom iedList;_junk=selectRandom iedJunk;
	_ied=createMine[_ied,getPosATL _iedR,[],8];_ied setPosATL(getPosATL _ied select 2+1);_ied setDir(random 359);
	if(!iedDmg)then{_ied allowDamage false;};
	if(round(random 2)==1)then{_iedJunk=createVehicle[_junk,getPosATL _ied,[],0,""];_iedJunk setPosATL(getPosATL _iedJunk select 2+1);_iedJunk enableSimulationGlobal false;};
	_jnkR=selectRandom _iedRoad;_junk=createVehicle[_junk,getPosATL _jnkR,[],8,""];_junk setPosATL(getPosATL _junk select 2+1);
         _pos = [_ied, 100, random 360] call BIS_fnc_relPos;
         _pos1 = [_ied, 0, random 360] call BIS_fnc_relPos;
	_grp = createGroup east;
        _obj1 = "UK3CB_TKC_O_YAVA" createVehicle _pos;
	_obj = _grp createUnit ["UK3CB_TKC_C_SPOT", _pos, [], 0, "FORM"];
        _addActionParams = ["Halt Bomb Maker", {_obj = _this select 0;_obj disableAI "ANIM";_obj switchmove "Acts_JetsMarshallingStop_loop";}];	
        [_obj,_addActionParams] remoteExec ["addAction", 0, true];
	_junk enableSimulationGlobal false;
	_trig=createTrigger["EmptyDetector",getPosATL _ied];
	_trig setTriggerArea[10,10,0,FALSE,10];
	_trig setTriggerActivation["WEST","PRESENT",false];
	_trig setTriggerTimeout[1,1,1,true];
	if(isMultiplayer)then{
	_trig setTriggerStatements[
		"{vehicle _x in thisList && speed vehicle _x>4}count playableUnits>0",
		"{if((typeOf _x)in iedAmmo)then{[_x]call iedAct;};}forEach nearestObjects[thisTrigger,[],10];",
		"deleteVehicle thisTrigger"];}else{
	_trig setTriggerStatements[
		"{vehicle _x in thisList && isPlayer vehicle _x && speed vehicle _x>4}count allUnits>0",
		"{if((typeOf _x)in iedAmmo)then{[_x]call iedAct;};}forEach nearestObjects[thisTrigger,[],10];",
		"deleteVehicle thisTrigger"];};

	_ieds pushBack _ied;
	if(Dbug)then{
		iedMkrs=[];
		_iedPos=getPosWorld _ied;
		_mkrID=format["m %1",_iedPos];
		_mkr=createMarker[_mkrID,getPosWorld _obj];

_iedPos=getPosWorld _ied;
_grp setBehaviour "STEALTH";
_obj setcaptive true;
while {Alive _obj} do
              {
_grp move getpos _obj1;
sleep 60;
_obj playmove "Acts_carFixingWheel";
sleep 70;
_grp move _iedPos;
sleep 15;
_grp move _iedPos;
sleep 10;
_obj playmove "Acts_carFixingWheel";
sleep 20;
};
		iedMkrs pushBack _mkr;};
	};
}forEach iedMkr;
sleep 5;







