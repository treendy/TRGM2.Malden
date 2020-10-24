
//random task
_TaskTitel = ["Kill","Intel","Cache","Retrieval","Destroy"] call BIS_fnc_selectRandom; 
_TType = 0;
if (_TaskTitel == "Kill") then {_TType = 1};
if (_TaskTitel == "Intel") then {_TType = 2};
if (_TaskTitel == "Cache") then {_TType = 3};
if (_TaskTitel == "Retrieval") then {_TType = 4};
if (_TaskTitel == "Destroy") then {_TType = 5};


{

//
//WARLORD-TASK
//


if (_TType == 1) then {

	//create conversation
txt1Layera = "txt1a" call BIS_fnc_rscLayer;
txt2Layera = "txt2a" call BIS_fnc_rscLayer;

		
		_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.4' color='#ffffff'>" + "I like your movies British"+"</t>"; 
		[_texta,/* poz x */ 0.4,/* poz y */ 0.250,/*durata*/ 3,/* fade in?*/  1,0,txt1Layera] spawn BIS_fnc_dynamicText;
sleep 4;
txt1Layerb = "txt1b" call BIS_fnc_rscLayer;
txt2Layerb = "txt2b" call BIS_fnc_rscLayer;

		
		_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.4' color='#ffffff'>" + "Charlie Chaplin....Marilyn Monroe"+"</t>"; 
		[_texta,/* poz x */ 0.4,/* poz y */ 0.250,/*durata*/ 3,/* fade in?*/ 1,0,txt1Layerb] spawn BIS_fnc_dynamicText;

sleep 4;

txt1Layerc = "txt1c" call BIS_fnc_rscLayer;
txt2Layerc = "txt2c" call BIS_fnc_rscLayer;

		
		_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.4' color='#ffffff'>" + "Sean Connery...007"+"</t>"; 
		[_texta,/* poz x */ 0.4,/* poz y */ 0.250,/*durata*/ 3,/* fade in?*/  1,0,txt1Layerc] spawn BIS_fnc_dynamicText;

}; 



//
//INTEL-TASK
//
if (_TType == 2) then {
txt1Layera = "txt1a" call BIS_fnc_rscLayer;
txt2Layera = "txt2a" call BIS_fnc_rscLayer;

		
		_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.4' color='#ffffff'>" + "Please give me some money British"+"</t>"; 
		[_texta,/* poz x */ 0.4,/* poz y */ 0.550,/*durata*/ 3,/* fade in?*/  1,0,txt1Layera] spawn BIS_fnc_dynamicText;
sleep 4;
txt1Layerb = "txt1b" call BIS_fnc_rscLayer;
txt2Layerb = "txt2b" call BIS_fnc_rscLayer;

		
		_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.4' color='#ffffff'>" + "What have you got for me"+"</t>"; 
		[_texta,/* poz x */ 0.4,/* poz y */ 0.550,/*durata*/ 3,/* fade in?*/  1,0,txt1Layerb] spawn BIS_fnc_dynamicText;

sleep 4;

txt1Layerc = "txt1c" call BIS_fnc_rscLayer;
txt2Layerc = "txt2c" call BIS_fnc_rscLayer;

		
		_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.4' color='#ffffff'>" + "Go go, you go now Go Go home"+"</t>"; 
		[_texta,/* poz x */ 0.4,/* poz y */ 0.550,/*durata*/ 3,/* fade in?*/   1,0,txt1Layerc] spawn BIS_fnc_dynamicText;


};



//
//CACHE-TASK
//
if (_TType == 3) then {

txt1Layera = "txt1a" call BIS_fnc_rscLayer;
txt2Layera = "txt2a" call BIS_fnc_rscLayer;

		
		_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.4' color='#ffffff'>" + "I can not feed my family please"+"</t>"; 
		[_texta,/* poz x */ 0.4,/* poz y */ 0.250,/*durata*/ 3,/* fade in?*/  1,0,txt1Layera] spawn BIS_fnc_dynamicText;
sleep 4;
txt1Layerb = "txt1b" call BIS_fnc_rscLayer;
txt2Layerb = "txt2b" call BIS_fnc_rscLayer;

		
		_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.4' color='#ffffff'>" + "all right Guvoner"+"</t>"; 
		[_texta,/* poz x */ 0.4,/* poz y */ 0.250,/*durata*/ 3,/* fade in?*/ 1,0,txt1Layerb] spawn BIS_fnc_dynamicText;



};



//
//Retrieval
//
if (_TType == 4) then {
txt1Layera = "txt1a" call BIS_fnc_rscLayer;
txt2Layera = "txt2a" call BIS_fnc_rscLayer;

		
		_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.4' color='#ffffff'>" + "I know you are only ordered here by your filthy goverment"+"</t>"; 
		[_texta,/* poz x */ -0.4,/* poz y */ 0.020,/*durata*/ 3,/* fade in?*/  1,0,txt1Layera] spawn BIS_fnc_dynamicText;
sleep 4;
txt1Layerb = "txt1b" call BIS_fnc_rscLayer;
txt2Layerb = "txt2b" call BIS_fnc_rscLayer;

		
		_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.4' color='#ffffff'>" + "I have nothing for you"+"</t>"; 
		[_texta,/* poz x */ -0.4,/* poz y */ 0.020,/*durata*/ 3,/* fade in?*/ 1,0,txt1Layerb] spawn BIS_fnc_dynamicText;

sleep 4;

txt1Layerc = "txt1c" call BIS_fnc_rscLayer;
txt2Layerc = "txt2c" call BIS_fnc_rscLayer;

		
		_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.4' color='#ffffff'>" + "Hello British"+"</t>"; 
		[_texta,/* poz x */ -0.4,/* poz y */ 0.020,/*durata*/ 3,/* fade in?*/  1,0,txt1Layerc] spawn BIS_fnc_dynamicText;

};

//
//Destroy
//
if (_TType == 5) then {

txt1Layera = "txt1a" call BIS_fnc_rscLayer;
txt2Layera = "txt2a" call BIS_fnc_rscLayer;

		
		_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.4' color='#ffffff'>" + "Now go before ISIS here about you here"+"</t>"; 
		[_texta,/* poz x */ 0.4,/* poz y */ 0.550,/*durata*/ 3,/* fade in?*/   1,0,txt1Layera] spawn BIS_fnc_dynamicText;
sleep 4;
txt1Layerb = "txt1b" call BIS_fnc_rscLayer;
txt2Layerb = "txt2b" call BIS_fnc_rscLayer;

		
		_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.4' color='#ffffff'>" + "Get out before you get in trouble"+"</t>"; 
		[_texta,/* poz x */ 0.4,/* poz y */ 0.550,/*durata*/ 3,/* fade in?*/  1,0,txt1Layerb] spawn BIS_fnc_dynamicText;

sleep 4;

txt1Layerc = "txt1c" call BIS_fnc_rscLayer;
txt2Layerc = "txt2c" call BIS_fnc_rscLayer;

		
		_texta = "<t font ='EtelkaMonospaceProBold' align = 'center' size='0.4' color='#ffffff'>" + "Im sorry for my country men"+"</t>"; 
		[_texta,/* poz x */ 0.4,/* poz y */ 0.550,/*durata*/ 3,/* fade in?*/   1,0,txt1Layerc] spawn BIS_fnc_dynamicText;

};





