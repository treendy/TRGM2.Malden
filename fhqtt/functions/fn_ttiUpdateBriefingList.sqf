private ["_i", "_idx", "_current", "_record", "_filter", "_units", "_x", "_briefing", "_list", "_existing", "_notify"];
    
_briefing = _this;
_notify = false;
    
{
    _list = [];
  	for [{_i = 0}, {_i < count _briefing}, {_i = _i + 1}] do {
        _current = _briefing select _i;		// [_filter, [_section, _subject, _text]]

        _filter = _current select 0;
       	_units = [_filter] call FHQ_fnc_ttiFilterUnits;
            
        if (_x in _units) then {
			_record = _current select 1;
       		_list = _list + [[_record select 0, [_record select 1, _record select 2]]];
       	};
    };
        
    /* Now add them in reverse order */
    _existing = _x getVariable ["FHQ_TTI_ClientBriefingList", []];
	for [{_i = count _list - 1}, {_i >= 0}, {_i = _i - 1}] do {
        _current = _list select _i;

        if (!([_existing, _current] call FHQ_fnc_ttiHasBriefingEntry)) then {
			/* Check if the section exists and create it if necessary, then add the record */
    		if (!(_x diarySubjectExists (_current select 0))) then {
    				_x createDiarySubject [_current select 0, _current select 0];
       		};
           
	       	_x createDiaryRecord [_current select 0, [(_current select 1) select 0, (_current select 1) select 1]];
                
            if (player == _x  && !FHQ_TTI_supressTaskHints) then
       		{
                private "_title";
                _title = _current select 0;
                if (_title == "Diary") then {
                    if (FHQ_TTI_is_arma3) then {
                      	_title = "Briefing";
                    } else {
                        _title = "Notes";
                    };
                };
				[format ["%1/%2", _title, (_current select 1) select 0], "newbriefing"] call FHQ_fnc_ttTaskHint;
			};
		};                
	};
    _x setVariable ["FHQ_TTI_ClientBriefingList", _list];  // FIXME ? 
} foreach (if (isMultiplayer) then {playableUnits} else {switchableUnits});