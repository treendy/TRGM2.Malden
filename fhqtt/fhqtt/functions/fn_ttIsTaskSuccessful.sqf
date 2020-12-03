/* FHQ_fnc_ttIsTaskSuccessful
 * 
 * Check whether a task is ended successfully. This function can be called on the client as well as
 * the server.
 * 
 * _result = [_taskName] call FHQ_fnc_ttIsTaskSuccessful;
 */

private "_result";
    
_result = (tolower(_this call FHQ_fnc_ttGetTaskState) == "succeeded");
_result;
