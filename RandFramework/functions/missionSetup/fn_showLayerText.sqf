//shows centred white EtelkaMonospaceProBold text for 7 seconds on the named rsc layer (local)
params ["_text", "_size", "_y", "_layerName"];

private _layer = _layerName call BIS_fnc_rscLayer;
private _sText = format["<t font ='EtelkaMonospaceProBold' align = 'center' size='%1' color='#ffffff'>%2</t>", _size, _text];
[_sText, 0, _y, 7, 1, 0, _layer] spawn BIS_fnc_dynamicText;
