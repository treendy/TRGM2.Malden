params [
			["_direction",-1,[0]],  // direction 0 to 360
			["_words",false,[false]] // use word style instead of acronyms
		];

if (_direction < 0 ||_direction > 360) then {
	"";
};

_val = round(_direction/45);
if (_words) then {
	switch(_val) do {
		case 8;
		case 0: {"North"};
		case 1: {"North East"};
		case 2: {"East"};
		case 3: {"South East"};
		case 4: {"South"};
		case 5: {"South West"};
		case 6: {"West"};
		case 7: {"North West"};
	};
} else {
	switch(_val) do {
		case 8;
		case 0: {"N"};
		case 1: {"NE"};
		case 2: {"E"};
		case 3: {"SE"};
		case 4: {"S"};
		case 5: {"SW"};
		case 6: {"W"};
		case 7: {"NW"};
	};
};