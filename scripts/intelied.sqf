_x = _this select 0;

//random task
_TaskTitel = ["Kill","Intel","Cache","Retrieval","Destroy"] call BIS_fnc_selectRandom; 
_TType = 0;
if (_TaskTitel == "Kill") then {_TType = 1};
if (_TaskTitel == "Intel") then {_TType = 2};
if (_TaskTitel == "Cache") then {_TType = 3};
if (_TaskTitel == "Retrieval") then {_TType = 4};
if (_TaskTitel == "Destroy") then {_TType = 5};




//
//WARLORD-TASK
//


if (_TType == 1) then {

	//create conversation
	line1 = ["Civilian", "Mister Mister, Please Please i can tell you where a IED is"];
	line2 = ["Civilian", "I see it not far from here"];
	line3 = ["Civilian", "Its on the road, i mark it on the map"];
	[[line1,line2,line3],"DIRECT",0.15,true] execVM "scripts\fn_simpleConv.sqf";

}; 



//
//INTEL-TASK
//
if (_TType == 2) then {

	//create conversation
	line1 = ["Civilian", "Mister Mister, Please Please"];
	line2 = ["Civilian", "Its very dangerous for me to talk now"];
	line3 = ["Civilian", "i can tell you where a IED is, its on the road, i mark it on the map"];
        [[line1,line2,line3],"DIRECT",0.15,true] execVM "scripts\fn_simpleConv.sqf";

};



//
//CACHE-TASK
//
if (_TType == 3) then {

	//create conversation
	line1 = ["Civilian", "Mister Mister"];
	line2 = ["Civilian", "I know of a bomb close to hear"];
	line3 = ["Civilian", "i can show you on the map"];
        [[line1,line2,line3],"DIRECT",0.15,true] execVM "scripts\fn_simpleConv.sqf";

};



//
//Retrieval
//
if (_TType == 4) then {

	//create conversation
	line1 = ["Civilian", "Mister Please Mister Please"];
	line2 = ["Civilian", "Please Please i can tell you where a IED is"];
	line3 = ["Civilian", "Please i can show you on the map"];
        [[line1,line2,line3],"DIRECT",0.15,true] execVM "scripts\fn_simpleConv.sqf";

};

//
//Destroy
//
if (_TType == 5) then {

	//create conversation
	line1 = ["Civilian", "Mister Mister, Please be quick"];
	line2 = ["Civilian", "I must not be seen talking to you"];
	line3 = ["Civilian", "Please i can tell you a IED i know the not far from here"];
        [[line1,line2,line3],"DIRECT",0.15,true] execVM "scripts\fn_simpleConv.sqf";

};




