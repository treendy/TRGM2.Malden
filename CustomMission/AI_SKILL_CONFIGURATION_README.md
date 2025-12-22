# TRGM AI Skill Configuration System

## Overview

This documentation explains how to configure AI agent skills for the TRGM 2.0 Malden mission. The centralized AI skill system allows you to easily adjust the behavior and difficulty of different AI agent types.

## Configuration File

**Location:** `CustomMission/TRGMAISkillSettings.sqf`

This file is automatically loaded during mission initialization through `RandFramework/mainInit.sqf`.

## AI Skill Profiles

The system includes several predefined skill profiles for different agent types:

### 1. TRGM_AI_Skill_Militia (Skill Level 1)
**Purpose:** Basic militia and low-threat enemies

**Characteristics:**
- Low accuracy (0.2)
- Poor spotting ability (0.1)
- Slow reload speed (0.1)
- Basic leadership (0.5)

**Use Cases:** 
- Initial area defenders
- Poorly trained insurgents
- Civilian militia

### 2. TRGM_AI_Skill_Regular (Skill Level 2)
**Purpose:** Standard enemy reinforcements

**Characteristics:**
- Moderate accuracy (0.3)
- Average spotting (0.2)
- Standard reload speed (0.2)
- Good leadership (0.75)

**Use Cases:**
- Regular army units
- Standard reinforcements
- Checkpoint guards

### 3. TRGM_AI_Skill_Veteran (Skill Level 3)
**Purpose:** Experienced enemy units

**Characteristics:**
- Good accuracy (0.3)
- Fast aiming speed (1.0)
- Better spotting (0.3)
- Strong leadership (1.0)
- High reload speed (0.75)

**Use Cases:**
- Elite infantry
- Special forces
- Experienced fighters

### 4. TRGM_AI_Skill_Elite (Skill Level 4)
**Purpose:** Elite enemy units and special forces

**Characteristics:**
- Very high accuracy (0.4)
- Maximum aiming speed (1.0)
- Excellent spotting (0.5)
- Peak performance across all skills

**Use Cases:**
- Spetsnaz units
- Counter-terrorism forces
- Boss encounters

### 5. TRGM_AI_Skill_Sniper
**Purpose:** Enemy snipers

**Characteristics:**
- Exceptional accuracy (0.8)
- Maximum spotting distance and speed (1.0)
- Slow, deliberate aiming (0.2 speed)
- Minimal aim shake (0.2)

**Use Cases:**
- Dedicated sniper units
- Overwatch positions
- Long-range threats

### 6. TRGM_AI_Skill_AdverseWeather
**Purpose:** AI operating in harsh weather (snow, sandstorms)

**Characteristics:**
- Heavily reduced accuracy (0.1)
- Poor visibility and spotting (0.1)
- Slower reactions

**Use Cases:**
- Automatically applied during sandstorms
- Blizzard conditions
- Heavy fog scenarios

## Skill Parameters Explained

Each AI skill ranges from 0.0 to 1.0, where:
- **0.0** = Minimum capability
- **1.0** = Maximum capability

### Available Skills:

| Skill | Description |
|-------|-------------|
| `aimingAccuracy` | How accurate the AI's shots are |
| `aimingShake` | How much the AI's aim shakes (lower = more stable) |
| `aimingSpeed` | How quickly AI acquires targets |
| `spotDistance` | How far the AI can spot enemies |
| `spotTime` | How quickly AI spots enemies |
| `courage` | AI's tendency to stay in combat vs retreat |
| `reloadSpeed` | How quickly AI reloads weapons |
| `commanding` | AI's effectiveness as a squad leader |
| `general` | Overall AI effectiveness |
| `endurance` | AI's stamina and fatigue resistance |

## How to Use

### Applying Skills to Individual Units

```sqf
// Apply sniper skills to a unit
[enemySniper, TRGM_AI_Skill_Sniper] call TRGM_fnc_applyAISkills;

// Apply veteran skills to a unit
[enemyOfficer, TRGM_AI_Skill_Veteran] call TRGM_fnc_applyAISkills;
```

### Applying Skills to Groups

```sqf
// Apply regular skills to an entire group
[enemyGroup, TRGM_AI_Skill_Regular] call TRGM_fnc_applyAISkillsToGroup;

// Apply elite skills to a special forces group
[specialForcesGroup, TRGM_AI_Skill_Elite] call TRGM_fnc_applyAISkillsToGroup;
```

### Using Skill Levels in Switch Statements

The reinforcements system uses numbered skill levels (1-4) that map to profiles:

```sqf
switch (_skill) do {
    case 1: { [_group, TRGM_AI_Skill_Militia] call TRGM_fnc_applyAISkillsToGroup; };
    case 2: { [_group, TRGM_AI_Skill_Regular] call TRGM_fnc_applyAISkillsToGroup; };
    case 3: { [_group, TRGM_AI_Skill_Veteran] call TRGM_fnc_applyAISkillsToGroup; };
    case 4: { [_group, TRGM_AI_Skill_Elite] call TRGM_fnc_applyAISkillsToGroup; };
};
```

## Customizing AI Skills

### Method 1: Modify Existing Profiles

Edit `CustomMission/TRGMAISkillSettings.sqf` and adjust the values in the skill arrays:

```sqf
TRGM_AI_Skill_Regular = [
    ["general", 1],
    ["aimingAccuracy", 0.35],  // Increased from 0.3 - makes them more accurate
    ["aimingShake", 0.3],
    // ... other skills
];
```

### Method 2: Create New Custom Profiles

Add a new profile in `TRGMAISkillSettings.sqf`:

```sqf
// CUSTOM PROFILE: Night Operations
TRGM_AI_Skill_NightOps = [
    ["general", 1],
    ["aimingAccuracy", 0.25],
    ["aimingShake", 0.4],
    ["aimingSpeed", 0.5],
    ["endurance", 0.3],
    ["spotDistance", 0.15],  // Reduced for night
    ["spotTime", 0.15],      // Reduced for night
    ["courage", 1],
    ["reloadSpeed", 0.3],
    ["commanding", 0.8]
];
publicVariable "TRGM_AI_Skill_NightOps";
```

Then use it in your scripts:

```sqf
[nightPatrol, TRGM_AI_Skill_NightOps] call TRGM_fnc_applyAISkillsToGroup;
```

### Method 3: Create Hybrid Profiles

You can create custom skill arrays on-the-fly:

```sqf
// Custom profile for a specific scenario
_customSkills = [
    ["aimingAccuracy", 0.6],
    ["spotDistance", 0.8],
    ["courage", 0.5]
];
[specialUnit, _customSkills] call TRGM_fnc_applyAISkills;
```

## Implementation Details

### Files Modified

1. **CustomMission/TRGMAISkillSettings.sqf** (NEW)
   - Contains all skill profile definitions
   - Defines helper functions

2. **RandFramework/mainInit.sqf**
   - Added include for TRGMAISkillSettings.sqf

3. **RandFramework/reinforcements.sqf**
   - Updated to use centralized skill system
   - Replaces hardcoded skill values with function calls

4. **RandFramework/RandScript/createEnemySniper.sqf**
   - Updated to use TRGM_AI_Skill_Sniper profile

5. **RandFramework/LetItSnow.sqf**
   - Updated to use TRGM_AI_Skill_AdverseWeather profile

### Helper Functions

#### TRGM_fnc_applyAISkills
Applies a skill profile to a single unit.

**Parameters:**
- `_unit` (Object): The unit to apply skills to
- `_skillProfile` (Array): Array of skill pairs [["skillName", value], ...]

**Example:**
```sqf
[myUnit, TRGM_AI_Skill_Veteran] call TRGM_fnc_applyAISkills;
```

#### TRGM_fnc_applyAISkillsToGroup
Applies a skill profile to all units in a group.

**Parameters:**
- `_group` (Group): The group to apply skills to
- `_skillProfile` (Array): Array of skill pairs [["skillName", value], ...]

**Example:**
```sqf
[myGroup, TRGM_AI_Skill_Elite] call TRGM_fnc_applyAISkillsToGroup;
```

## Troubleshooting

### Skills Not Applying
- Ensure the configuration file is loaded (check RPT logs)
- Verify function calls use correct syntax
- Check that units are alive before applying skills

### Skill Values Not Working
- Remember: values must be between 0.0 and 1.0
- Some skills like `courage` work best at 1.0
- Test in-game to verify behavior

### Performance Issues
- Applying skills to large groups is efficient
- Avoid repeatedly reapplying skills to the same units
- Use appropriate profiles rather than creating many custom ones

## Best Practices

1. **Use Predefined Profiles**: Start with existing profiles before creating custom ones
2. **Test Incrementally**: Adjust one skill at a time to see the impact
3. **Document Changes**: Comment your custom profiles
4. **Consider Game Balance**: Very high skills (>0.5 accuracy) can be frustrating for players
5. **Use Context-Appropriate Skills**: Match skills to the tactical situation

## Future Enhancements

Possible additions to consider:

- Dynamic skill adjustment based on mission progress
- Player feedback system to suggest difficulty adjustments
- Time-of-day specific profiles
- Faction-specific skill profiles
- Save/load custom configurations

## Support

For questions or issues:
- Check the RPT log file for error messages
- Test with debug mode enabled
- Verify all files are properly saved
- Ensure proper SQF syntax in custom profiles

---

**Version:** 1.0  
**Author:** TRGM Mission Team  
**Last Updated:** 2025-12-22
