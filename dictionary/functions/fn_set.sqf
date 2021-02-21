private ["_key", "_value", "_keys", "_values", "_keyIndex"];

_key = _this select 1;
_value = _this select 2;
_this = _this select 0;
_keys = _this select 0;
_values = _this select 1;

_keyIndex = _keys find _key;
if (_keyIndex == -1) then {
    _keysCount = count _keys;
    _keys set [_keysCount, _key];
    _values set [_keysCount, _value];
} else {
    _values set [_keyIndex, _value];
};
