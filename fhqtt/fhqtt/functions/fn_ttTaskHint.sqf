if (!FHQ_TTI_is_arma3) then 
{
    /* Arma 2 */
 	private ["_desc", "_state", "_color", "_icon", "_text"];
    
	_desc = _this select 0;
	_state = _this select 1;
    
	_color = [1, 1, 1, 1];
	_icon = "taskNew";
	_text = "New Task";

	switch (tolower(_state)) do
	{
		case "created":
		{
			_color = [1, 1, 1, 1];
			_icon = "taskNew";
			_text = localize "str_taskNew";
		};
		case "assigned":
		{
			_color = [1, 1, 1, 1];
			_icon = "taskCurrent";
		 	_text = localize "str_taskSetCurrent";
		};
		case "succeeded":
		{
			_color = [0.600000,0.839215,0.466666,1];
			_icon = "taskDone";
			_text = localize "str_taskAccomplished";
		};
		case "canceled":
		{
			_color = [0.75,0.75,0.75,1];
			_icon = "taskFailed";
			_text = localize "str_taskCancelled";
		};
		case "cancelled":
		{
			_color = [0.75,0.75,0.75,1];
			_icon = "taskFailed";
			_text = localize "str_taskCancelled";
		};
		case "failed":
		{
			_color = [0.972549,0.121568,0,1];
			_icon = "taskFailed";
			_text = localize "str_taskFailed";
		};
        case "newbriefing":
		{
			_color = [1, 1, 1, 1];
			_icon = "taskCurrent";
		 	_text = "Briefing updated";//localize "str_taskSetCurrent";
		};
	};
    
    taskHint [format ["%1\n%2", _text, _desc], _color, _icon];
} else {
    /* Arma 3 */
    private ["_notifyTemplate", "_desc", "_state"];
        
    _desc = [_this, 0, ""] call BIS_fnc_param;
	_state = [_this, 1, "created"] call BIS_fnc_param;
    _notifyTemplate = "TaskCreated";
        
    switch (tolower _state) do 
    {
		case "created":
        {
            _notifyTemplate = "TaskCreated";
        };
		case "assigned":
        {
            _notifyTemplate = "TaskAssigned";
        };
		case "succeeded":
        {
            _notifyTemplate = "TaskSucceeded";
        };
		case "canceled":
        {
            _notifyTemplate = "TaskCanceled";
        };
		case "cancelled":
        {
            _notifyTemplate = "TaskCanceled";
        };
		case "failed":
        {
            _notifyTemplate = "TaskFailed";
        };
        case "newbriefing":
        {
            _notifyTemplate = "TaskAssigned";
            if (isClass (missionConfigFile >> "CfgNotifications" >> "NewBriefing")) then {
               _notifyTemplate = "NewBriefing";
            };
        };
	};
        
    [_notifyTemplate, ["", _desc]] call BIS_fnc_showNotification;
};