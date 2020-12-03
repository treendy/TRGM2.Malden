#define FHQ_TTIF_TASKNAME	0
#define FHQ_TTIF_TASKDESC	1
#define FHQ_TTIF_TASKTITLE	2
#define FHQ_TTIF_TASKWP		3
#define FHQ_TTIF_TASKTARGET	4
#define FHQ_TTIF_TASKSTATE	5
#define FHQ_TTIF_TASKTYPE	6

/* Might not be present */
private _res = "";
private _num = count _this;

/* It must be a string, and it must be the last one, so we're just checking if there's more than 4
 * and the last one is a string that is not a target or a state
 */

if (_num > 4) then {
    private _type = _this select (_num - 1);

    if (typename _type == "STRING") then {
  		if (!(_type call FHQ_fnc_ttiIsTaskState) and (_type find "#" != 0) and (_type find "@" != 0)) then {
        	/* Last element is a string, but no position, and no state, so it must be a type */
            _res = _type;  
        };  
    };
};

_res;