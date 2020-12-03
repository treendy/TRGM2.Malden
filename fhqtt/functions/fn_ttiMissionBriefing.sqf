/* Eden compatible mission briefing 
 * This function is called like 
 * [_value] call FHQ_fnc_ttiMissionBriefing;
 * 
 * _value is an array of briefing blocks. Each block is an array in itself,
 * with the following format:
 * ["identifier", [ [FHQ_TT briefing entry],... ]]
 * 
 * "identifier" is a string identifying a "block" of entries. Units can receive one
 * such block, i.e. all briefing entries listed under the identifier will be given to
 * the unit.
 */

missionNamespace setVariable ["FHQ_tt_MissionBriefing", param [0, []]]; 