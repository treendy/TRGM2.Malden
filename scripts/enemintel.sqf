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

		
		_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.4' color='#ffffff'>" + "Those Americans will be kissing my feet"+"</t>"; 
		[_texta,/* poz x */ -0.3,/* poz y */ 0.250,/*durata*/ 3,/* fade in?*/ 1,0,txt1Layera] spawn BIS_fnc_dynamicText;
sleep 4;
txt1Layerb = "txt1b" call BIS_fnc_rscLayer;
txt2Layerb = "txt2b" call BIS_fnc_rscLayer;

		
		_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.4' color='#ffffff'>" + "I am going to shamma those infidels"+"</t>"; 
		[_texta,/* poz x */ -0.3,/* poz y */ 0.250,/*durata*/ 3,/* fade in?*/ 1,0,txt1Layerb] spawn BIS_fnc_dynamicText;

sleep 4;

txt1Layerc = "txt1c" call BIS_fnc_rscLayer;
txt2Layerc = "txt2c" call BIS_fnc_rscLayer;

		
		_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.4' color='#ffffff'>" + "Those scum wont know what hit them"+"</t>"; 
		[_texta,/* poz x */ -0.3,/* poz y */ 0.250,/*durata*/ 3,/* fade in?*/ 1,0,txt1Layerc] spawn BIS_fnc_dynamicText;
};




//
//INTEL-TASK
//

if (_TType == 2) then {
txt1Layera = "txt1a" call BIS_fnc_rscLayer;
txt2Layera = "txt2a" call BIS_fnc_rscLayer;

		
		_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.4' color='#ffffff'>" + "What was that noise outside ?"+"</t>"; 
		[_texta,/* poz x */ -0.4,/* poz y */ 0.550,/*durata*/ 3,/* fade in?*/ 1,0,txt1Layera] spawn BIS_fnc_dynamicText;
sleep 4;
txt1Layerb = "txt1b" call BIS_fnc_rscLayer;
txt2Layerb = "txt2b" call BIS_fnc_rscLayer;

		
		_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.4' color='#ffffff'>" + "Get your dick out that goat and get over hear"+"</t>"; 
		[_texta,/* poz x */ -0.4,/* poz y */ 0.550,/*durata*/ 3,/* fade in?*/ 1,0,txt1Layerb] spawn BIS_fnc_dynamicText;

sleep 4;

txt1Layerc = "txt1c" call BIS_fnc_rscLayer;
txt2Layerc = "txt2c" call BIS_fnc_rscLayer;

		
		_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.4' color='#ffffff'>" + "They wouldnt dare come here"+"</t>"; 
		[_texta,/* poz x */ -0.4,/* poz y */ 0.550,/*durata*/ 3,/* fade in?*/ 1,0,txt1Layerc] spawn BIS_fnc_dynamicText;

};



//
//CACHE-TASK
//

if (_TType == 3) then {
["Private", "Testing Locality Testing Locality"] spawn BIS_fnc_showsubtitle;
txt1Layera = "txt1a" call BIS_fnc_rscLayer;
txt2Layera = "txt2a" call BIS_fnc_rscLayer;

		
		_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.4' color='#ffffff'>" + "I cant wait to become a Martyr"+"</t>"; 
		[_texta,/* poz x */ 0.4,/* poz y */ 0.050,/*durata*/ 3,/* fade in?*/ 1,0,txt1Layera] spawn BIS_fnc_dynamicText;
sleep 4;
txt1Layerb = "txt1b" call BIS_fnc_rscLayer;
txt2Layerb = "txt2b" call BIS_fnc_rscLayer;

		
		_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.4' color='#ffffff'>" + "I have waited my whole life"+"</t>"; 
		[_texta,/* poz x */ 0.4,/* poz y */ 0.050,/*durata*/ 3,/* fade in?*/ 1,0,txt1Layerb] spawn BIS_fnc_dynamicText;


};



//
//Retrieval
//
if (_TType == 4) then {
txt1Layera = "txt1a" call BIS_fnc_rscLayer;
txt2Layera = "txt2a" call BIS_fnc_rscLayer;

		
		_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.4' color='#ffffff'>" + "Since they killed my family"+"</t>"; 
		[_texta,/* poz x */ -0.4,/* poz y */ 0.100,/*durata*/ 3,/* fade in?*/ 1,0,txt1Layera] spawn BIS_fnc_dynamicText;
sleep 4;
txt1Layerb = "txt1b" call BIS_fnc_rscLayer;
txt2Layerb = "txt2b" call BIS_fnc_rscLayer;

		
		_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.4' color='#ffffff'>" + "i have sworn to get my revenge"+"</t>"; 
		[_texta,/* poz x */ -0.4,/* poz y */ 0.100,/*durata*/ 3,/* fade in?*/ 1,0,txt1Layerb] spawn BIS_fnc_dynamicText;

sleep 4;

txt1Layerc = "txt1c" call BIS_fnc_rscLayer;
txt2Layerc = "txt2c" call BIS_fnc_rscLayer;

		
		_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.4' color='#ffffff'>" + "I will see my family soon god willing"+"</t>"; 
		[_texta,/* poz x */ -0.4,/* poz y */ 0.100,/*durata*/ 3,/* fade in?*/ 1,0,txt1Layerc] spawn BIS_fnc_dynamicText;
};

//
//Destroy
//

if (_TType == 5) then {
["Private", "Testing Locality Testing Locality"] spawn BIS_fnc_showsubtitle;
txt1Layera = "txt1a" call BIS_fnc_rscLayer;
txt2Layera = "txt2a" call BIS_fnc_rscLayer;

		
		_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.4' color='#ffffff'>" + "Haha if only they new"+"</t>"; 
		[_texta,/* poz x */ 0.4,/* poz y */ 0.150,/*durata*/ 3,/* fade in?*/ 1,0,txt1Layera] spawn BIS_fnc_dynamicText;
sleep 4;
txt1Layerb = "txt1b" call BIS_fnc_rscLayer;
txt2Layerb = "txt2b" call BIS_fnc_rscLayer;

		
		_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.4' color='#ffffff'>" + "Our Commanding officer is here in Lythium"+"</t>"; 
		[_texta,/* poz x */ 0.4,/* poz y */ 0.150,/*durata*/ 3,/* fade in?*/ 1,0,txt1Layerb] spawn BIS_fnc_dynamicText;

sleep 4;

txt1Layerc = "txt1c" call BIS_fnc_rscLayer;
txt2Layerc = "txt2c" call BIS_fnc_rscLayer;

		
		_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.4' color='#ffffff'>" + "He is staying near Nefer in the North west"+"</t>"; 
		[_texta,/* poz x */ 0.4,/* poz y */ 0.150,/*durata*/ 3,/* fade in?*/ 1,0,txt1Layerc] spawn BIS_fnc_dynamicText;
};






