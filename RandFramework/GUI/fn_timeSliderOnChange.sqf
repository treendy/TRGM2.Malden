disableSerialization;
format["%1 called by %2", _fnc_scriptName, _fnc_scriptNameParent] call TREND_fnc_log;

params ["_ctrl", "_newvalue", "_ctrlStr"];

_display = findDisplay 5000;
_ctrlSlider = _display displayCtrl 5115;
_ctrlHour = _display displayCtrl 5116;
_ctrlMinute = _display displayCtrl 5117;
_ctrlSecond = _display displayCtrl 5118;

switch (_ctrlStr) do {
	case "Slider": {
		_value = _newvalue * 3600;
		_valueHour = floor (_value / 3600);
		_valueMinute = floor ((_value / 60) mod 60);
		_valueSecond = floor (_value mod 60);
		_textHour = if (_valueHour < 10) then {'0' + str _valueHour} else {str _valueHour};
		_textMinute = if (_valueMinute < 10) then {'0' + str _valueMinute} else {str _valueMinute};
		_textSecond = if (_valueSecond < 10) then {'0' + str _valueSecond} else {str _valueSecond};
		_ctrlHour ctrlSetText _textHour;
		_ctrlMinute ctrlSetText _textMinute;
		_ctrlSecond ctrlSetText _textSecond;
	};
	case "Edit": {
		_value = (round (parseNumber ctrlText _ctrlHour) + round (parseNumber ctrlText _ctrlMinute) / 60 + round (parseNumber ctrlText _ctrlSecond) / 3600) * 3600;
		_ctrlSlider sliderSetPosition (_value / 3600);
	};
	case "Init": {
		_valueHour = _newvalue select 0;
		_valueMinute = _newvalue select 1;
		_valueSecond = 0;
		_textHour = if (_valueHour < 10) then {'0' + str _valueHour} else {str _valueHour};
		_textMinute = if (_valueMinute < 10) then {'0' + str _valueMinute} else {str _valueMinute};
		_textSecond = if (_valueSecond < 10) then {'0' + str _valueSecond} else {str _valueSecond};
		_ctrlHour ctrlSetText _textHour;
		_ctrlMinute ctrlSetText _textMinute;
		_ctrlSecond ctrlSetText _textSecond;
		_value = (round (_valueHour) + round (_valueMinute) / 60 + round (_valueSecond) / 3600) * 3600;
		_ctrlSlider sliderSetPosition (_value / 3600);
		TREND_arrayTime = [_valueHour, _valueMinute]; publicVariable "TREND_arrayTime";
	};
	default {};
};