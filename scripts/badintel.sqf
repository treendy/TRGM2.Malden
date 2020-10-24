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

txt1Layera = "txt1a" call BIS_fnc_rscLayer;
txt2Layera = "txt2a" call BIS_fnc_rscLayer;

		
		_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.4' color='#ffffff'>" + "You are not welcome here"+"</t>"; 
		[_texta,/* poz x */ -0.3,/* poz y */ 0.250,/*durata*/ 3,/* fade in?*/ 1,0,txt1Layera] spawn BIS_fnc_dynamicText;
sleep 4;
txt1Layerb = "txt1b" call BIS_fnc_rscLayer;
txt2Layerb = "txt2b" call BIS_fnc_rscLayer;

		
		_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.4' color='#ffffff'>" + "Get out before you get in trouble"+"</t>"; 
		[_texta,/* poz x */ -0.3,/* poz y */ 0.250,/*durata*/ 3,/* fade in?*/ 1,0,txt1Layerb] spawn BIS_fnc_dynamicText;

sleep 4;

txt1Layerc = "txt1c" call BIS_fnc_rscLayer;
txt2Layerc = "txt2c" call BIS_fnc_rscLayer;

		
		_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.4' color='#ffffff'>" + "I curse you white devil"+"</t>"; 
		[_texta,/* poz x */ -0.3,/* poz y */ 0.250,/*durata*/ 3,/* fade in?*/ 1,0,txt1Layerc] spawn BIS_fnc_dynamicText;
};




//
//INTEL-TASK
//

if (_TType == 2) then {

txt1Layera = "txt1a" call BIS_fnc_rscLayer;
txt2Layera = "txt2a" call BIS_fnc_rscLayer;

		
		_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.4' color='#ffffff'>" + "What do you want infidel"+"</t>"; 
		[_texta,/* poz x */ -0.4,/* poz y */ 0.550,/*durata*/ 3,/* fade in?*/ 1,0,txt1Layera] spawn BIS_fnc_dynamicText;
sleep 4;
txt1Layerb = "txt1b" call BIS_fnc_rscLayer;
txt2Layerb = "txt2b" call BIS_fnc_rscLayer;

		
		_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.4' color='#ffffff'>" + "I will not help you"+"</t>"; 
		[_texta,/* poz x */ -0.4,/* poz y */ 0.550,/*durata*/ 3,/* fade in?*/ 1,0,txt1Layerb] spawn BIS_fnc_dynamicText;

sleep 4;

txt1Layerc = "txt1c" call BIS_fnc_rscLayer;
txt2Layerc = "txt2c" call BIS_fnc_rscLayer;

		
		_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.4' color='#ffffff'>" + "I spit on you Bastard"+"</t>"; 
		[_texta,/* poz x */ -0.4,/* poz y */ 0.550,/*durata*/ 3,/* fade in?*/ 1,0,txt1Layerc] spawn BIS_fnc_dynamicText;

};



//
//CACHE-TASK
//

if (_TType == 3) then {

txt1Layera = "txt1a" call BIS_fnc_rscLayer;
txt2Layera = "txt2a" call BIS_fnc_rscLayer;

		
		_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.4' color='#ffffff'>" + "GO FUCK YOUR MOTHER"+"</t>"; 
		[_texta,/* poz x */ 0.4,/* poz y */ 0.050,/*durata*/ 3,/* fade in?*/ 1,0,txt1Layera] spawn BIS_fnc_dynamicText;
sleep 4;
txt1Layerb = "txt1b" call BIS_fnc_rscLayer;
txt2Layerb = "txt2b" call BIS_fnc_rscLayer;

		
		_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.4' color='#ffffff'>" + "What do you want from me"+"</t>"; 
		[_texta,/* poz x */ 0.4,/* poz y */ 0.050,/*durata*/ 3,/* fade in?*/ 1,0,txt1Layerb] spawn BIS_fnc_dynamicText;


};



//
//Retrieval
//

if (_TType == 4) then {
txt1Layera = "txt1a" call BIS_fnc_rscLayer;
txt2Layera = "txt2a" call BIS_fnc_rscLayer;

		
		_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.4' color='#ffffff'>" + "Your Bombs killed my family, what do you expect"+"</t>"; 
		[_texta,/* poz x */ -0.4,/* poz y */ 0.100,/*durata*/ 3,/* fade in?*/ 1,0,txt1Layera] spawn BIS_fnc_dynamicText;
sleep 4;
txt1Layerb = "txt1b" call BIS_fnc_rscLayer;
txt2Layerb = "txt2b" call BIS_fnc_rscLayer;

		
		_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.4' color='#ffffff'>" + "I have nothing for you"+"</t>"; 
		[_texta,/* poz x */ -0.4,/* poz y */ 0.100,/*durata*/ 3,/* fade in?*/ 1,0,txt1Layerb] spawn BIS_fnc_dynamicText;

sleep 4;

txt1Layerc = "txt1c" call BIS_fnc_rscLayer;
txt2Layerc = "txt2c" call BIS_fnc_rscLayer;

		
		_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.4' color='#ffffff'>" + "Get out of our country"+"</t>"; 
		[_texta,/* poz x */ -0.4,/* poz y */ 0.100,/*durata*/ 3,/* fade in?*/ 1,0,txt1Layerc] spawn BIS_fnc_dynamicText;
};

//
//Destroy
//

if (_TType == 5) then {

txt1Layera = "txt1a" call BIS_fnc_rscLayer;
txt2Layera = "txt2a" call BIS_fnc_rscLayer;

		
		_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.4' color='#ffffff'>" + "You are not welcome here"+"</t>"; 
		[_texta,/* poz x */ 0.4,/* poz y */ 0.150,/*durata*/ 3,/* fade in?*/ 1,0,txt1Layera] spawn BIS_fnc_dynamicText;
sleep 4;
txt1Layerb = "txt1b" call BIS_fnc_rscLayer;
txt2Layerb = "txt2b" call BIS_fnc_rscLayer;

		
		_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.4' color='#ffffff'>" + "Get out before you get in trouble"+"</t>"; 
		[_texta,/* poz x */ 0.4,/* poz y */ 0.150,/*durata*/ 3,/* fade in?*/ 1,0,txt1Layerb] spawn BIS_fnc_dynamicText;

sleep 4;

txt1Layerc = "txt1c" call BIS_fnc_rscLayer;
txt2Layerc = "txt2c" call BIS_fnc_rscLayer;

		
		_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.4' color='#ffffff'>" + "I curse you white devil"+"</t>"; 
		[_texta,/* poz x */ 0.4,/* poz y */ 0.150,/*durata*/ 3,/* fade in?*/ 1,0,txt1Layerc] spawn BIS_fnc_dynamicText;
};






