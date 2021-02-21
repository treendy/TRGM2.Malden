private ["_key", "_keys", "_values", "_keyIndex"];

_key = _this select 1;
_this = _this select 0;
_keys = _this select 0;
_values = _this select 1;

_keyIndex = _keys find _key;

if (_keyIndex == -1) then { objNull }
else { _values select _keyIndex }
