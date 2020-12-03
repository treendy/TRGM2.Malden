  
/* Internal: Add a briefing record on the server
 * parameters:
 * select 0: Filter
 * select 1: [_section, _subject, _text]
 */

private _record = [_this, 1] call BIS_fnc_param;
private _filter = [_this, 0] call BIS_fnc_param;
    
private _subject = "Diary";
private _topic = _record select 0;
private _text = _record select 1;

if (count _record == 3) then {
  	_subject = _record select 0;
   	_topic = _record select 1;
   	_text = _record select 2;
};

FHQ_TTI_BriefingList = FHQ_TTI_BriefingList + [[_filter, [_subject, _topic, _text]]];
