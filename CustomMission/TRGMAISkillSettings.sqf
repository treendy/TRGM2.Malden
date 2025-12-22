/*
	TRGM AI Skill Configuration System
	
	This file contains centralized AI skill settings for different agent types.
	Modify these values to adjust AI behavior across the mission.
	
	Skill values range from 0 to 1:
	- aimingAccuracy: How accurate AI aiming is
	- aimingShake: How much the AI's aim shakes
	- aimingSpeed: How quickly AI aims
	- spotDistance: How far AI can spot enemies
	- spotTime: How quickly AI spots enemies
	- courage: AI's tendency to stay in combat vs retreat
	- reloadSpeed: How quickly AI reloads
	- commanding: AI's effectiveness as a leader
	- general: Overall AI effectiveness
	- endurance: AI's stamina and fatigue resistance
*/

// Define global AI skill configurations
if (isServer) then {

	// MILITIA/LOW SKILL AGENTS (Skill Level 1)
	// Used for: Basic militia, low-threat enemies
	TRGM_AI_Skill_Militia = [
		["general", 1],
		["aimingAccuracy", 0.2],
		["aimingShake", 0.2],
		["aimingSpeed", 0.7],
		["endurance", 0.1],
		["spotDistance", 0.1],
		["spotTime", 0.1],
		["courage", 1],
		["reloadSpeed", 0.1],
		["commanding", 0.5]
	];
	publicVariable "TRGM_AI_Skill_Militia";

	// REGULAR FORCES (Skill Level 2)
	// Used for: Standard enemy reinforcements
	TRGM_AI_Skill_Regular = [
		["general", 1],
		["aimingAccuracy", 0.3],
		["aimingShake", 0.3],
		["aimingSpeed", 0.7],
		["endurance", 0.2],
		["spotDistance", 0.2],
		["spotTime", 0.2],
		["courage", 1],
		["reloadSpeed", 0.2],
		["commanding", 0.75]
	];
	publicVariable "TRGM_AI_Skill_Regular";

	// VETERAN FORCES (Skill Level 3)
	// Used for: Experienced enemy units
	TRGM_AI_Skill_Veteran = [
		["general", 1],
		["aimingAccuracy", 0.3],
		["aimingShake", 0.4],
		["aimingSpeed", 1],
		["endurance", 0.5],
		["spotDistance", 0.3],
		["spotTime", 0.3],
		["courage", 1],
		["reloadSpeed", 0.75],
		["commanding", 1]
	];
	publicVariable "TRGM_AI_Skill_Veteran";

	// ELITE FORCES (Skill Level 4)
	// Used for: Elite enemy units, special forces
	TRGM_AI_Skill_Elite = [
		["general", 1],
		["aimingAccuracy", 0.4],
		["aimingShake", 0.5],
		["aimingSpeed", 1],
		["endurance", 0.5],
		["spotDistance", 0.5],
		["spotTime", 0.5],
		["courage", 1],
		["reloadSpeed", 1],
		["commanding", 1]
	];
	publicVariable "TRGM_AI_Skill_Elite";

	// SNIPER SPECIALIST
	// Used for: Enemy snipers
	TRGM_AI_Skill_Sniper = [
		["general", 1],
		["aimingAccuracy", 0.8],
		["aimingShake", 0.2],
		["aimingSpeed", 0.2],
		["spotDistance", 1],
		["spotTime", 1],
		["courage", 1],
		["reloadSpeed", 0.5],
		["commanding", 1],
		["endurance", 1]
	];
	publicVariable "TRGM_AI_Skill_Sniper";

	// ADVERSE WEATHER CONDITIONS (Snow/Sandstorm)
	// Used for: AI operating in harsh weather conditions
	TRGM_AI_Skill_AdverseWeather = [
		["aimingAccuracy", 0.1],
		["aimingShake", 0.2],
		["aimingSpeed", 0.4],
		["endurance", 0.1],
		["spotDistance", 0.1],
		["spotTime", 0.1],
		["courage", 1],
		["reloadSpeed", 0.1],
		["commanding", 0.5]
	];
	publicVariable "TRGM_AI_Skill_AdverseWeather";

	// SANDSTORM SEVERE CONDITIONS
	// Used for: AI during severe sandstorm with near-zero visibility
	TRGM_AI_Skill_SandstormSevere = [
		["aimingAccuracy", 0.01],
		["aimingShake", 0.01],
		["aimingSpeed", 0.01],
		["spotDistance", 0.01],
		["spotTime", 0.01]
	];
	publicVariable "TRGM_AI_Skill_SandstormSevere";

	// SANDSTORM RECOVERY
	// Used for: AI skill restoration after sandstorm subsides
	TRGM_AI_Skill_SandstormRecovery = [
		["aimingAccuracy", 0.15],
		["aimingShake", 0.1],
		["aimingSpeed", 0.2],
		["spotDistance", 0.5],
		["spotTime", 0.5]
	];
	publicVariable "TRGM_AI_Skill_SandstormRecovery";

	// AAA CREW (Anti-Aircraft Artillery)
	// Used for: AAA vehicle crews who need excellent spotting and accuracy
	TRGM_AI_Skill_AAA = [
		["general", 1],
		["aimingAccuracy", 1],
		["aimingShake", 1],
		["aimingSpeed", 1],
		["spotDistance", 1],
		["spotTime", 0.7],
		["courage", 1],
		["commanding", 0.9],
		["endurance", 1.0],
		["reloadSpeed", 0.5]
	];
	publicVariable "TRGM_AI_Skill_AAA";

	// Function to apply AI skills to a unit
	// Usage: [unit, skillProfile] call TRGM_fnc_applyAISkills
	// Example: [enemyUnit, TRGM_AI_Skill_Veteran] call TRGM_fnc_applyAISkills
	TRGM_fnc_applyAISkills = {
		params ["_unit", "_skillProfile"];
		
		// Validate parameters
		if (isNil "_unit" || isNil "_skillProfile") exitWith {
			diag_log "TRGM AI Skills: Invalid parameters - unit or skillProfile is nil";
			false
		};
		
		if (typeName _unit != "OBJECT") exitWith {
			diag_log format ["TRGM AI Skills: Invalid unit type: %1", typeName _unit];
			false
		};
		
		if (typeName _skillProfile != "ARRAY") exitWith {
			diag_log format ["TRGM AI Skills: Invalid skillProfile type: %1", typeName _skillProfile];
			false
		};
		
		if (!alive _unit) exitWith {
			diag_log "TRGM AI Skills: Unit is not alive";
			false
		};
		
		// Apply skills with error handling
		{
			_skillName = _x select 0;
			_skillValue = _x select 1;
			
			if (typeName _skillName == "STRING" && typeName _skillValue == "SCALAR") then {
				if (_skillValue >= 0 && _skillValue <= 1) then {
					_unit setSkill [_skillName, _skillValue];
				} else {
					diag_log format ["TRGM AI Skills: Skill value out of range (0-1): %1 = %2", _skillName, _skillValue];
				};
			} else {
				diag_log format ["TRGM AI Skills: Invalid skill format: %1", _x];
			};
		} forEach _skillProfile;
		
		true
	};
	publicVariable "TRGM_fnc_applyAISkills";

	// Function to apply skills to all units in a group
	// Usage: [group, skillProfile] call TRGM_fnc_applyAISkillsToGroup
	// Example: [enemyGroup, TRGM_AI_Skill_Regular] call TRGM_fnc_applyAISkillsToGroup
	TRGM_fnc_applyAISkillsToGroup = {
		params ["_group", "_skillProfile"];
		
		// Validate parameters
		if (isNil "_group" || isNil "_skillProfile") exitWith {
			diag_log "TRGM AI Skills: Invalid parameters for group - group or skillProfile is nil";
			false
		};
		
		if (typeName _group != "GROUP") exitWith {
			diag_log format ["TRGM AI Skills: Invalid group type: %1", typeName _group];
			false
		};
		
		if (typeName _skillProfile != "ARRAY") exitWith {
			diag_log format ["TRGM AI Skills: Invalid skillProfile type for group: %1", typeName _skillProfile];
			false
		};
		
		// Apply to all units in group
		{
			[_x, _skillProfile] call TRGM_fnc_applyAISkills;
		} forEach units _group;
		
		true
	};
	publicVariable "TRGM_fnc_applyAISkillsToGroup";

};
