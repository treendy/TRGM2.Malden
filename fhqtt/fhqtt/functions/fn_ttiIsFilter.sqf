/* Internal function */
private "_x";
private _filter = _this;
private _res = false;

switch (typename _filter) do
{
    case "CODE":
    {
        _res = true;
    };
    case "GROUP":
    {
        _res = true;
    };
    case "OBJECT":
    {
        _res = true;
    };
    case "SIDE":
    {
        _res = true;
    };
    case "STRING":
    {
        _res = true;
    };
    case "ARRAY":
    {
        /* The complex case: If all elements are objects, then it's a filter */
        private _nonObjects = 0;
        {
            if (typename _x != "OBJECT") then {
                _nonObjects = _nonObjects + 1;
            };
        } foreach _filter;
        if (_nonObjects == 0) then {
            _res = true;
        };
    };
};

_res;