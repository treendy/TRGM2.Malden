//Reads the advanced settings dialog (display 6000) into AdvancedSettings and broadcasts it (does nothing if the dialog is not open)
disableSerialization;

if (!isNull (findDisplay 6000)) then {
	AdvancedSettings = [];
	{
		_x params ["_ctrlId", "", "_ctrlType", "", "_values"];
		private _inputIdc = _ctrlId + 1;
		private "_value";
		if (_ctrlType == "RscCombo") then {
			_value = _values select (lbCurSel ((findDisplay 6000) displayCtrl _inputIdc));
		};
		if (_ctrlType == "RscEdit") then {
			_value = ctrlText _inputIdc;
		};
		AdvancedSettings pushBack _value;
	} forEach AdvControls;
	publicVariable "AdvancedSettings";
};
