//Not used... may consider settings this for militia units???
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TRGM_GLOBAL_fnc_log;
_Unit = _this select 0;
_Unit setSkill ["aimingaccuracy", 0.1];
_Unit setSkill ["aimingshake", 0.1];

true;