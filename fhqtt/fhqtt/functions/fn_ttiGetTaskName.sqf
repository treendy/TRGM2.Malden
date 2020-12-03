#define FHQ_TTIF_TASKNAME	0
#define FHQ_TTIF_TASKDESC	1
#define FHQ_TTIF_TASKTITLE	2
#define FHQ_TTIF_TASKWP		3
#define FHQ_TTIF_TASKTARGET	4
#define FHQ_TTIF_TASKSTATE	5

private _name = "";

private _task = _this select FHQ_TTIF_TASKNAME;
if (typename _task == "ARRAY") then 
{
   	_name = _task select 0;
}
else
{
	_name = _task;
};
   
_name;