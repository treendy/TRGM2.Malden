# AI Skill Configuration - Quick Reference Guide

## Overview
The TRGM 2.0 Malden mission now includes a centralized AI skill configuration system. This allows you to easily customize AI behavior for different agent types.

## Configuration File
**Location:** `CustomMission/TRGMAISkillSettings.sqf`

## Quick Start

### Available Skill Profiles

| Profile | Purpose | Key Stats | Use Case |
|---------|---------|-----------|----------|
| `TRGM_AI_Skill_Militia` | Low-skill militia | Accuracy: 0.2, Spotting: 0.1 | Basic enemies, poorly trained forces |
| `TRGM_AI_Skill_Regular` | Standard forces | Accuracy: 0.3, Spotting: 0.2 | Regular army units, checkpoints |
| `TRGM_AI_Skill_Veteran` | Experienced units | Accuracy: 0.3, Spotting: 0.3 | Elite infantry, experienced fighters |
| `TRGM_AI_Skill_Elite` | Special forces | Accuracy: 0.4, Spotting: 0.5 | Spetsnaz, elite units |
| `TRGM_AI_Skill_Sniper` | Snipers | Accuracy: 0.8, Spotting: 1.0 | Long-range threats, overwatch |
| `TRGM_AI_Skill_AAA` | AAA crews | Accuracy: 1.0, Spotting: 1.0 | Anti-aircraft artillery operators |
| `TRGM_AI_Skill_AdverseWeather` | Weather debuff | Accuracy: 0.1, Spotting: 0.1 | Snow, fog, general bad weather |
| `TRGM_AI_Skill_SandstormSevere` | Sandstorm | Accuracy: 0.01, Spotting: 0.01 | Severe sandstorm conditions |
| `TRGM_AI_Skill_SandstormRecovery` | Post-sandstorm | Accuracy: 0.15, Spotting: 0.5 | After sandstorm clears |

### Using Skill Profiles

#### For a Single Unit
```sqf
[enemyUnit, TRGM_AI_Skill_Veteran] call TRGM_fnc_applyAISkills;
```

#### For an Entire Group
```sqf
[enemyGroup, TRGM_AI_Skill_Elite] call TRGM_fnc_applyAISkillsToGroup;
```

#### In a Switch Statement (e.g., reinforcements)
```sqf
switch (_skillLevel) do {
    case 1: { [_group, TRGM_AI_Skill_Militia] call TRGM_fnc_applyAISkillsToGroup; };
    case 2: { [_group, TRGM_AI_Skill_Regular] call TRGM_fnc_applyAISkillsToGroup; };
    case 3: { [_group, TRGM_AI_Skill_Veteran] call TRGM_fnc_applyAISkillsToGroup; };
    case 4: { [_group, TRGM_AI_Skill_Elite] call TRGM_fnc_applyAISkillsToGroup; };
};
```

## Customizing Profiles

Edit `CustomMission/TRGMAISkillSettings.sqf` and modify the values:

```sqf
TRGM_AI_Skill_Regular = [
    ["general", 1],
    ["aimingAccuracy", 0.35],  // Increased from 0.3
    ["aimingShake", 0.3],
    ["aimingSpeed", 0.7],
    // ... rest of skills
];
```

## Skill Parameters

| Parameter | Range | Description |
|-----------|-------|-------------|
| `aimingAccuracy` | 0-1 | Shot accuracy (higher = more accurate) |
| `aimingShake` | 0-1 | Aim stability (higher = more stable) |
| `aimingSpeed` | 0-1 | Target acquisition speed |
| `spotDistance` | 0-1 | Visual range for spotting enemies |
| `spotTime` | 0-1 | Speed of enemy detection |
| `courage` | 0-1 | Willingness to stay in combat |
| `reloadSpeed` | 0-1 | How fast weapons are reloaded |
| `commanding` | 0-1 | Leadership effectiveness |
| `general` | 0-1 | Overall AI capability |
| `endurance` | 0-1 | Stamina and fatigue resistance |

## Tips

1. **Start conservative**: High skill values (>0.5 accuracy) can be very challenging
2. **Test incrementally**: Change one value at a time to see the impact
3. **Use context**: Match skills to the tactical situation (e.g., lower at night)
4. **Balance is key**: Not all skills need to be high for an effective AI

## Files Modified

- `CustomMission/TRGMAISkillSettings.sqf` - Skill definitions
- `RandFramework/mainInit.sqf` - Initialization and sandstorm handling
- `RandFramework/reinforcements.sqf` - Reinforcement spawning
- `RandFramework/RandScript/createEnemySniper.sqf` - Sniper spawning
- `RandFramework/RandScript/trendFunctions.sqf` - AAA spawning
- `RandFramework/LetItSnow.sqf` - Adverse weather handling

## Complete Documentation

For detailed documentation, see: `CustomMission/AI_SKILL_CONFIGURATION_README.md`

---

**Version:** 1.0  
**Last Updated:** 2025-12-22
