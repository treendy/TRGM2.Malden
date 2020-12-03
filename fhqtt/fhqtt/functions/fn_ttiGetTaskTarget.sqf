#define FHQ_TTIF_TASKNAME	0
#define FHQ_TTIF_TASKDESC	1
#define FHQ_TTIF_TASKTITLE	2
#define FHQ_TTIF_TASKWP		3
#define FHQ_TTIF_TASKTARGET	4
#define FHQ_TTIF_TASKSTATE	5

/* Might not be present */
private _res = "";

if (count _this > FHQ_TTIF_TASKTARGET) then {

    _thing = _this select FHQ_TTIF_TASKTARGET;
    /* A string means it's the initial state (unless starting with # or @), so if it's not, it's either
     * a position (array) or target (object)
     */
    switch (typename _thing) do {
      	case "ARRAY": {
            _res = nil;
            _res = _thing;
        };
        case "OBJECT": {
            _res = nil;
            _res = _thing;
        };
        case "CODE": {
          	_res = nil;
            _res = call _thing;  
        };
        case "STRING": {
            _res = nil;

            if (_thing find "#" == 0) exitWith {
            	private _parts = _thing select [1];
            	_res = call compile _parts ;
            };
            if (_thing find "@" == 0) exitWith {
                private _parts = _thing select [1];
                _res = getMarkerPos _parts;
            };
            _res = "";
        };
   	};
};
    
_res;                
