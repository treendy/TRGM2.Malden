#include "..\..\setUnitGlobalVars.sqf";
disableSerialization;

_thisThis = _this select 0;

_selectedIndex = _thisThis select 1;

_ctrl = (findDisplay 5000) displayCtrl 5001;
_ctrl ctrlSetText format["%1",MissionTypeDescriptions select _selectedIndex];// for Displays
