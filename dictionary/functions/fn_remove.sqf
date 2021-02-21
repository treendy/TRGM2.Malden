private ["_key", "_keys", "_values", "_keyIndex"];

_key = _this select 1;
_this = _this select 0;
_keys = _this select 0;
_values = _this select 1;

_keyIndex = _keys find _key;
if (_keyIndex == -1) then {
    objNull
} else {
    _value = _values select _keyIndex;
    _newKeys = [];
    _newValues = [];
    _newDictionaryLength = 0;
    for "_i" from 0 to (count _keys - 1) do
    {
        if (_i != _keyIndex) then
        {
            _newKeys set [_newDictionaryLength, _keys select _i];
            _newValues set [_newDictionaryLength, _values select _i];
            _newDictionaryLength = _newDictionaryLength + 1;
        };
    };
    _this set [0, _newKeys];
    _this set [1, _newValues];
    
    _value
}
