//Jonas Aschenbrenner's Dictionaries

class Dictionary {
	class functions {
		file = "dictionary\functions";
		class new {
			description = "Returns a new empty dictionary. \nExample: _myDictionary = call Dictionary_fnc_new;";
		};
		class get {
			description = "Returns the value of the key or objNull if the key doesn't exist. \nExample: [_myDictionary, _myKey] call Dictionary_fnc_get;";
		};
		class set {
			description = "Sets the key to a new value. Overwrites the previous value if the key already existed. \nExample: [_myDictionary, _myNewKey, _myNewValue] call Dictionary_fnc_set;";
		};
		class remove {
			description = "Removes a key from the dictionary. \nExample: _oldValue = [_myDictionary, _keyToRemove] call Dictionary_fnc_remove;";
		};
		class isEmpty {
			description = "Returns true if the dictionary is empty. \nExample: _isDictionaryEmpty = _myDictionary call Dictionary_fnc_isEmpty;";
		};
		class containsKey {
			description = "Returns true if the dictionary contains the key. \nExample: _dictionaryContainsKey = [_myDictionary, _myKey] call Dictionary_fnc_containsKey;";
		};
		class containsValue {
			description = "Returns true if the dictionary contains the value. \nExample: _dictionaryContainsValue = [_myDictionary, _myValue] call Dictionary_fnc_containsValue;";
		};
		class size {
			description = "Returns the number of elements in the dictionary. \nExample: _count = _myDictionary call Dictionary_fnc_size;"
		};
		class keys {
			description = "Returns the keys as an array. \nExample: _keys = _myDictionary call Dictionary_fnc_keys;";
		};
		class values {
			description = "Returns the values as an array. \nExample: _values = _myDictionary call Dictionary_fnc_values;";
		};
	}
}