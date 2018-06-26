/*
 * Author: psycho

 * Diary entry.

 * Arguments:
	-

 * Return value:
	Bool
 */

private _who_can_revive = switch (AIS_MEDICAL_EDUCATION) do {
	case (0) : {localize "STR_TRGM2_fndiary_EDUCATION0"};
	case (1) : {localize "STR_TRGM2_fndiary_EDUCATION1"};
	case (2) : {localize "STR_TRGM2_fndiary_EDUCATION2"};
};
private _revive_guaranty = if (AIS_REVIVE_GUARANTY) then {localize "STR_TRGM2_fndiary_NoInstantDeath"} else {localize "STR_TRGM2_fndiary_InstantDeath"};
private _revive_heal = if (AIS_REVIVE_HEAL) then {localize "STR_TRGM2_fndiary_TotalHeal"} else {localize "STR_TRGM2_fndiary_SepHeal"};

_subject = player createDiarySubject ["ais_settings", localize "STR_TRGM2_fndiary_AISSettings"];
_log_briefing = player createDiaryRecord ["ais_settings", [localize "STR_TRGM2_fndiary_MedicalEducation", "
<font face='PuristaMedium' size=15 color='#8E8E8E'>" + localize "STR_TRGM2_fndiary_WhoCanRevive" + " </font>" + _who_can_revive]];
_log_briefing = player createDiaryRecord ["ais_settings", [localize "STR_TRGM2_fndiary_HeavyDamageHandling", "
<font face='PuristaMedium' size=15 color='#8E8E8E'>" + localize "STR_TRGM2_fndiary_ReviveChance" + "</font>" + _revive_guaranty]];
_log_briefing = player createDiaryRecord ["ais_settings", [localize "STR_TRGM2_fndiary_BleedoutTime",
format ["<font face='PuristaMedium' size=15 color='#8E8E8E'>" + localize "STR_TRGM2_fndiary_BleedoutTimeStatus" + "</font>%1", AIS_BLEEDOUT_TIME]]];
_log_briefing = player createDiaryRecord ["ais_settings", [localize "STR_TRGM2_fndiary_HealingStatus", "
<font face='PuristaMedium' size=15 color='#8E8E8E'>" + localize "STR_TRGM2_fndiary_AfterDamage" + "</font>" + _revive_heal]];

_subject = player createDiarySubject ["ais", localize "STR_TRGM2_fndiary_FirstAidSystem"];
_log_briefing = player createDiaryRecord ["ais", [localize "STR_TRGM2_fndiary_AboutAndCredits", localize "STR_TRGM2_fndiary_AboutAndCreditsDesc"]];

_log_briefing = player createDiaryRecord ["ais", [localize "STR_TRGM2_fndiary_Instructions", localize "STR_TRGM2_fndiary_InstructionsDesc"]];

_log_briefing = player createDiaryRecord ["ais", [localize "STR_TRGM2_fndiary_AboutWoundingDeath", localize "STR_TRGM2_fndiary_AboutWoundingDeathDesc"]];

_log_briefing = player createDiaryRecord ["ais", [localize "STR_TRGM2_fndiary_Description", localize "STR_TRGM2_fndiary_DescriptionDesc"]];


true