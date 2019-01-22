// by ALIAS

fnc_SetPitchBankYaw = { 
    private ["_object","_rotations","_aroundX","_aroundY","_aroundZ","_dirX","_dirY","_dirZ","_upX","_upY","_upZ","_dir","_up","_dirXTemp","_upXTemp"];
    _object = _this select 0; 
    _rotations = _this select 1; 
    _aroundX = _rotations select 0; 
    _aroundY = _rotations select 1; 
    _aroundZ = (360 - (_rotations select 2)) - 360; 
    _dirX = 0; 
    _dirY = 1; 
    _dirZ = 0; 
    _upX = 0; 
    _upY = 0; 
    _upZ = 1; 
    if (_aroundX != 0) then { 
        _dirY = cos _aroundX; 
        _dirZ = sin _aroundX; 
        _upY = -sin _aroundX; 
        _upZ = cos _aroundX; 
    }; 
    if (_aroundY != 0) then { 
        _dirX = _dirZ * sin _aroundY; 
        _dirZ = _dirZ * cos _aroundY; 
        _upX = _upZ * sin _aroundY; 
        _upZ = _upZ * cos _aroundY; 
    }; 
    if (_aroundZ != 0) then { 
        _dirXTemp = _dirX; 
        _dirX = (_dirXTemp* cos _aroundZ) - (_dirY * sin _aroundZ); 
        _dirY = (_dirY * cos _aroundZ) + (_dirXTemp * sin _aroundZ);        
        _upXTemp = _upX; 
        _upX = (_upXTemp * cos _aroundZ) - (_upY * sin _aroundZ); 
        _upY = (_upY * cos _aroundZ) + (_upXTemp * sin _aroundZ); 		
    }; 
    _dir = [_dirX,_dirY,_dirZ]; 
    _up = [_upX,_upY,_upZ]; 
    _object setVectorDirAndUp [_dir,_up]; 
};

private ["_vik_aaa","_gunner_aaa","_rot","_ii","_obiect_search"];

if (!hasInterface) exitWith {};

_vik_aaa = _this select 0;
_sound_AAA = _this select 1;

if (_sound_AAA) then {
	[_vik_aaa] spawn {
		_voice_AAA_search = _this select 0;
		while {(alive _voice_AAA_search)&&al_search_light} do {
			_voice_AAA_search say3d ["alarma_aeriana_scurt",2500];
			sleep 30;
		};
	};
};

_obiect_search = createSimpleObject ["A3\data_f\VolumeLight_searchLight.p3d",getposasl _vik_aaa];
_ii=30;
_rot=10+random 350;
while {alive _vik_aaa} do 
{
	while {_ii<150} do {
	[_obiect_search,[(-1)*_ii,0,_rot]] call fnc_SetPitchBankYaw;	//[_obiect_search,[0,0,_ii*2]] call fnc_SetPitchBankYaw;
	_ii=_ii+0.2;
	_rot=_rot-0.2;
	sleep 0.01;
	};
	sleep random 1;
	while {_ii>30} do {
	[_obiect_search,[(-1)*_ii,0,_rot]] call fnc_SetPitchBankYaw;
	_ii=_ii-0.2;
	_rot=_rot+1;
	sleep 0.01;
	};
};