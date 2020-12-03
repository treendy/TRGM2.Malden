/* Eden compatible mission tasks 
 * This function is called like 
 * [_value] call FHQ_fnc_ttiMissionTasks;
 * 
 * _value is an array of tasks. Each entry is an identifier followed by
 * a full FHQ TT task entry
 * 
 */

missionNamespace setVariable ["FHQ_tt_MissionTasks", param [0, []]]; 