
class MyFirstDialog			//Dialog class name, gets called by: handle = CreateDialog "name"
{
	idd=1100;						//Display control number
	movingenable=false;			//True/False to enable moving the dialog with mouse
	enableSimulation = 1;		//True/False to enable world simulation in the background
	class controls {
		class RscText			
		{
			access = 0;			//0 - Read and Write, 1 - Read and create, 2 - Read, 3 - Read verified
			type = CT_STATIC;	//type of the control
 			idc = -1;			//control ID number
			style = ST_LEFT;	//style of the control
			w = 1.8;			//width (0-1)
			h = 0.05;			//height (0-1)
			x = 0.1;			//position on X axis (0-1)
			y = 0.5;			//position on Y axis (0-1)
			font = GUI_FONT_NORMAL;		//font style
			sizeEx = 0.06;				//font size
			colorBackground[] = {0,0,0,0};		//background color, RGBA format (currently transparent)
			colorText[] = {1,1,1,1};			//background color, RGBA format (currently white)
			text = "Enter Pin: ";				//text field
			fixedWidth = 0;				//0,1
			shadow = 0;				//0 - none, 1 - color affected by background, 2 - black
		};	//end: RscText class
		class RscButton
		{
    
  			access = 0;				//same as above
			idc = -1;				//ID number
			type = CT_BUTTON;		//type of the control
			text = "Close";		//text field
			colorText[] = {1,1,1,1};		//color of the text (currently white)
			colorDisabled[] = {0.4,0.4,0.4,0};		//color when disabled (currently gray)
			colorBackground[] = {0,0,1,1};			//background color (currently blue)
			colorBackgroundDisabled[] = {0.9,0.9.0.9,0};		//background color when disabled (currently light gray)
			colorBackgroundActive[] = {1,0,0,1};		//background color when active (selected, or hovered over) (currently red)
			colorFocused[] = {0,1,0,1};			//bakcground color when focused (selected) (currently green)
			colorShadow[] = {0.023529,0,0.0313725,0};		//shadow color (currently dark gray)
			colorBorder[] = {0.023529,0,0.0313725,0};		//border color (currently dark gray)
  			soundEnter[] = {"",0.09,1};			//sound upon hovering over the control (sound, volume, pitch)
    		soundPush[] = {"",0,0};			//sound upon pushing the button (sound, volume, pitch)
    		soundClick[] = {"",0.07,1};			//sound upon clicking the button (sound, volume, pitch)
    		soundEscape[] = {"",0.09,1};		//sound upon releasing the pushed button (sound, volume, pitch)
			x = 0.25;			//position on X axis (0-1)
			y = 0.75;			//position on Y axis (0-1)
			w = 0.2;			//width (0-1)
			h = 0.1;			//height (0-1)
    		style = 2;		//style of the control
    		shadow = 2;			//above
    		font = GUI_FONT_BOLD;	//font type
    		sizeEx = 0.05;			//font size
    		offsetX = 0;		//offset when not pressed on X axis
    		offsetY = 0;		//offset when not pressed on Y axis
    		offsetPressedX = 0.003;			//offset when pressed on X axis
    		offsetPressedY = 0.003;			//offset when pressed on Y axis
    		borderSize = 0;			//border size (duh)
			action = "closedialog 0";	//action executed upon clicking the button (currently closes the dialog itself)
		};		//end: RscButton class

		class RscButton2
		{
    
  			access = 0;				//same as above
			idc = -1;				//ID number
			type = CT_BUTTON;		//type of the control
			text = "Enter";		//text field
			colorText[] = {1,1,1,1};		//color of the text (currently white)
			colorDisabled[] = {0.4,0.4,0.4,0};		//color when disabled (currently gray)
			colorBackground[] = {0,0,1,1};			//background color (currently blue)
			colorBackgroundDisabled[] = {0.9,0.9.0.9,0};		//background color when disabled (currently light gray)
			colorBackgroundActive[] = {1,0,0,1};		//background color when active (selected, or hovered over) (currently red)
			colorFocused[] = {0,1,0,1};			//bakcground color when focused (selected) (currently green)
			colorShadow[] = {0.023529,0,0.0313725,0};		//shadow color (currently dark gray)
			colorBorder[] = {0.023529,0,0.0313725,0};		//border color (currently dark gray)
  			soundEnter[] = {"",0.09,1};			//sound upon hovering over the control (sound, volume, pitch)
    		soundPush[] = {"",0,0};			//sound upon pushing the button (sound, volume, pitch)
    		soundClick[] = {"",0.07,1};			//sound upon clicking the button (sound, volume, pitch)
    		soundEscape[] = {"",0.09,1};		//sound upon releasing the pushed button (sound, volume, pitch)
			x = 0.5;			//position on X axis (0-1)
			y = 0.75;			//position on Y axis (0-1)
			w = 0.2;			//width (0-1)
			h = 0.1;			//height (0-1)
    		style = 2;		//style of the control
    		shadow = 2;			//above
    		font = GUI_FONT_BOLD;	//font type
    		sizeEx = 0.05;			//font size
    		offsetX = 0;		//offset when not pressed on X axis
    		offsetY = 0;		//offset when not pressed on Y axis
    		offsetPressedX = 0.003;			//offset when pressed on X axis
    		offsetPressedY = 0.003;			//offset when pressed on Y axis
    		borderSize = 0;			//border size (duh)
			action = " if (ctrlText 1001 == ""4682"") then {if (lockedDriver (player getVariable ""currentVeh"")) then {hint ""unlocked""; (player getVariable ""currentVeh"") lockDriver false; (player getVariable ""currentVeh"") lockTurret [[0], false];} else {hint ""locked"";(player getVariable ""currentVeh"") lockDriver true; (player getVariable ""currentVeh"") lockTurret [[0], true];}} else {hint ""Incorrect Pin""}; ";	//action executed upon clicking the button (currently closes the dialog itself)
		};		//end: RscButton2 class


		class txtEditTest
			{
				idc = 1001;
				type = 2;
				style = 0; // multi line + no border
				x = 0.3;			//position on X axis (0-1)
				y = 0.5;			//position on Y axis (0-1)
				w = 0.4;			//width (0-1)
				h = 0.1;			//height (0-1)
				font = "PuristaMedium";
				sizeEx = 0.04;
				autocomplete = "";
				canModify = true; 
				maxChars = 100; 
				forceDrawCaret = false;
				colorSelection[] = {0,1,0,1};
				colorText[] = {1,1,1,1};
				colorDisabled[] = {1,0,0,1}; 
				colorBackground[] = {0,0,0,0.5}; 
				text = ""; // how to output multiline
				tooltip = "Enter Pin";
			};		//end: RscButton2 class



		};	//end: controls class

	};	//end: MyFirstDialog class











	class DialogArtiRequest			//Dialog class name, gets called by: handle = CreateDialog "name"
	{
		idd=1000;						//Display control number
		movingenable=false;			//True/False to enable moving the dialog with mouse
		enableSimulation = 1;		//True/False to enable world simulation in the background

		//label to say entter 6,8 or 10 gridref, textbox to enter grid ref, button to get ETA, button to fire guidedround (Fire Guided Round [0.2pt])
		//when arti fired, post hint saying fired and time (be nice for this to be radio message), also rearm (will only do this if training)
		class controls {

		class RscText			
		{
			access = 0;			//0 - Read and Write, 1 - Read and create, 2 - Read, 3 - Read verified
			type = CT_STATIC;	//type of the control
 			idc = -1;			//control ID number
			style = ST_LEFT;	//style of the control
			w = 1.8;			//width (0-1)
			h = 0.05;			//height (0-1)
			x = 0.1;			//position on X axis (0-1)
			y = 0.5;			//position on Y axis (0-1)
			font = GUI_FONT_NORMAL;		//font style
			sizeEx = 0.06;				//font size
			colorBackground[] = {0,0,0,0};		//background color, RGBA format (currently transparent)
			colorText[] = {1,1,1,1};			//background color, RGBA format (currently white)
			text = "Enter 6,8 or 10 gridref";				//text field
			fixedWidth = 0;				//0,1
			shadow = 0;				//0 - none, 1 - color affected by background, 2 - black
		};	//end: RscText class
		class RscButton
		{
    
  			access = 0;				//same as above
			idc = -1;				//ID number
			type = CT_BUTTON;		//type of the control
			text = "Get ETA";		//text field
			colorText[] = {1,1,1,1};		//color of the text (currently white)
			colorDisabled[] = {0.4,0.4,0.4,0};		//color when disabled (currently gray)
			colorBackground[] = {0,0,1,1};			//background color (currently blue)
			colorBackgroundDisabled[] = {0.9,0.9.0.9,0};		//background color when disabled (currently light gray)
			colorBackgroundActive[] = {1,0,0,1};		//background color when active (selected, or hovered over) (currently red)
			colorFocused[] = {0,1,0,1};			//bakcground color when focused (selected) (currently green)
			colorShadow[] = {0.023529,0,0.0313725,0};		//shadow color (currently dark gray)
			colorBorder[] = {0.023529,0,0.0313725,0};		//border color (currently dark gray)
  			soundEnter[] = {"",0.09,1};			//sound upon hovering over the control (sound, volume, pitch)
    		soundPush[] = {"",0,0};			//sound upon pushing the button (sound, volume, pitch)
    		soundClick[] = {"",0.07,1};			//sound upon clicking the button (sound, volume, pitch)
    		soundEscape[] = {"",0.09,1};		//sound upon releasing the pushed button (sound, volume, pitch)
			x = 0.25;			//position on X axis (0-1)
			y = 0.75;			//position on Y axis (0-1)
			w = 0.2;			//width (0-1)
			h = 0.1;			//height (0-1)
    		style = 2;		//style of the control
    		shadow = 2;			//above
    		font = GUI_FONT_BOLD;	//font type
    		sizeEx = 0.05;			//font size
    		offsetX = 0;		//offset when not pressed on X axis
    		offsetY = 0;		//offset when not pressed on Y axis
    		offsetPressedX = 0.003;			//offset when pressed on X axis
    		offsetPressedY = 0.003;			//offset when pressed on Y axis
    		borderSize = 0;			//border size (duh)
			action = "[[[ctrlText 3001,ctrlText 3002,""2Rnd_155mm_Mo_guided""],'RandFramework\getArtiETA.sqf'],'BIS_fnc_execVM',player] call BIS_fnc_MP;";
		};		//end: RscButton class

		class RscButton2
		{
    
  			access = 0;				//same as above
			idc = -1;				//ID number
			type = CT_BUTTON;		//type of the control
			text = "Fire guided round";		//text field
			colorText[] = {1,1,1,1};		//color of the text (currently white)
			colorDisabled[] = {0.4,0.4,0.4,0};		//color when disabled (currently gray)
			colorBackground[] = {0,0,1,1};			//background color (currently blue)
			colorBackgroundDisabled[] = {0.9,0.9.0.9,0};		//background color when disabled (currently light gray)
			colorBackgroundActive[] = {1,0,0,1};		//background color when active (selected, or hovered over) (currently red)
			colorFocused[] = {0,1,0,1};			//bakcground color when focused (selected) (currently green)
			colorShadow[] = {0.023529,0,0.0313725,0};		//shadow color (currently dark gray)
			colorBorder[] = {0.023529,0,0.0313725,0};		//border color (currently dark gray)
  			soundEnter[] = {"",0.09,1};			//sound upon hovering over the control (sound, volume, pitch)
    		soundPush[] = {"",0,0};			//sound upon pushing the button (sound, volume, pitch)
    		soundClick[] = {"",0.07,1};			//sound upon clicking the button (sound, volume, pitch)
    		soundEscape[] = {"",0.09,1};		//sound upon releasing the pushed button (sound, volume, pitch)
			x = 0.5;			//position on X axis (0-1)
			y = 0.75;			//position on Y axis (0-1)
			w = 0.35;			//width (0-1)
			h = 0.1;			//height (0-1)
    		style = 2;		//style of the control
    		shadow = 2;			//above
    		font = GUI_FONT_BOLD;	//font type
    		sizeEx = 0.05;			//font size
    		offsetX = 0;		//offset when not pressed on X axis
    		offsetY = 0;		//offset when not pressed on Y axis
    		offsetPressedX = 0.003;			//offset when pressed on X axis
    		offsetPressedY = 0.003;			//offset when pressed on Y axis
    		borderSize = 0;			//border size (duh)
			action = "[[[ctrlText 3001,ctrlText 3002,""2Rnd_155mm_Mo_guided""],'RandFramework\fireArti.sqf'],'BIS_fnc_execVM',player] call BIS_fnc_MP; ";
					//action = " if (ctrlText 2001 == ""4646"") then {if (locked (player getVariable ""currentVeh"")) then {hint ""unlocked"";}}; ";	//action executed upon clicking the button (currently closes the dialog itself)
		};		//end: RscButton2 class


		class txtEditTestX
		{
			idc = 3001;
			type = 2;
			style = 0; // multi line + no border
			x = 0.5;			//position on X axis (0-1)
			y = 0.5;			//position on Y axis (0-1)
			w = 0.2;			//width (0-1)
			h = 0.1;			//height (0-1)
			font = "PuristaMedium";
			sizeEx = 0.04;
			autocomplete = "";
			canModify = true; 
			maxChars = 100; 
			forceDrawCaret = false;
			colorSelection[] = {0,1,0,1};
			colorText[] = {1,1,1,1};
			colorDisabled[] = {1,0,0,1}; 
			colorBackground[] = {0,0,0,0.5}; 
			text = ""; // how to output multiline
			tooltip = "Enter Grid Ref";
		};		//end: RscButton2 class
		class txtEditTestY
		{
			idc = 3002;
			type = 2;
			style = 0; // multi line + no border
			x = 0.74;			//position on X axis (0-1)
			y = 0.5;			//position on Y axis (0-1)
			w = 0.2;			//width (0-1)
			h = 0.1;			//height (0-1)
			font = "PuristaMedium";
			sizeEx = 0.04;
			autocomplete = "";
			canModify = true; 
			maxChars = 100; 
			forceDrawCaret = false;
			colorSelection[] = {0,1,0,1};
			colorText[] = {1,1,1,1};
			colorDisabled[] = {1,0,0,1}; 
			colorBackground[] = {0,0,0,1}; 
			text = ""; // how to output multiline
			tooltip = "Enter Grid Ref";
		};		//end: RscButton2 class


	};	//end: controls class

};	//end: MyFirstDialog class




class DialogArtiLock			//Dialog class name, gets called by: handle = CreateDialog "name"
{
	idd=2000;						//Display control number
	movingenable=false;			//True/False to enable moving the dialog with mouse
	enableSimulation = 1;		//True/False to enable world simulation in the background
	class controls {
		class RscText			
		{
			access = 0;			//0 - Read and Write, 1 - Read and create, 2 - Read, 3 - Read verified
			type = CT_STATIC;	//type of the control
 			idc = -1;			//control ID number
			style = ST_LEFT;	//style of the control
			w = 1.8;			//width (0-1)
			h = 0.05;			//height (0-1)
			x = 0.1;			//position on X axis (0-1)
			y = 0.5;			//position on Y axis (0-1)
			font = GUI_FONT_NORMAL;		//font style
			sizeEx = 0.06;				//font size
			colorBackground[] = {0,0,0,0};		//background color, RGBA format (currently transparent)
			colorText[] = {1,1,1,1};			//background color, RGBA format (currently white)
			text = "Enter Pin: ";				//text field
			fixedWidth = 0;				//0,1
			shadow = 0;				//0 - none, 1 - color affected by background, 2 - black
		};	//end: RscText class
		class RscButton
		{
    
  			access = 0;				//same as above
			idc = -1;				//ID number
			type = CT_BUTTON;		//type of the control
			text = "Close";		//text field
			colorText[] = {1,1,1,1};		//color of the text (currently white)
			colorDisabled[] = {0.4,0.4,0.4,0};		//color when disabled (currently gray)
			colorBackground[] = {0,0,1,1};			//background color (currently blue)
			colorBackgroundDisabled[] = {0.9,0.9.0.9,0};		//background color when disabled (currently light gray)
			colorBackgroundActive[] = {1,0,0,1};		//background color when active (selected, or hovered over) (currently red)
			colorFocused[] = {0,1,0,1};			//bakcground color when focused (selected) (currently green)
			colorShadow[] = {0.023529,0,0.0313725,0};		//shadow color (currently dark gray)
			colorBorder[] = {0.023529,0,0.0313725,0};		//border color (currently dark gray)
  			soundEnter[] = {"",0.09,1};			//sound upon hovering over the control (sound, volume, pitch)
    		soundPush[] = {"",0,0};			//sound upon pushing the button (sound, volume, pitch)
    		soundClick[] = {"",0.07,1};			//sound upon clicking the button (sound, volume, pitch)
    		soundEscape[] = {"",0.09,1};		//sound upon releasing the pushed button (sound, volume, pitch)
			x = 0.25;			//position on X axis (0-1)
			y = 0.75;			//position on Y axis (0-1)
			w = 0.2;			//width (0-1)
			h = 0.1;			//height (0-1)
    		style = 2;		//style of the control
    		shadow = 2;			//above
    		font = GUI_FONT_BOLD;	//font type
    		sizeEx = 0.05;			//font size
    		offsetX = 0;		//offset when not pressed on X axis
    		offsetY = 0;		//offset when not pressed on Y axis
    		offsetPressedX = 0.003;			//offset when pressed on X axis
    		offsetPressedY = 0.003;			//offset when pressed on Y axis
    		borderSize = 0;			//border size (duh)
			action = "closedialog 0";	//action executed upon clicking the button (currently closes the dialog itself)
		};		//end: RscButton class

		class RscButton2
		{
    
  			access = 0;				//same as above
			idc = -1;				//ID number
			type = CT_BUTTON;		//type of the control
			text = "Enter";		//text field
			colorText[] = {1,1,1,1};		//color of the text (currently white)
			colorDisabled[] = {0.4,0.4,0.4,0};		//color when disabled (currently gray)
			colorBackground[] = {0,0,1,1};			//background color (currently blue)
			colorBackgroundDisabled[] = {0.9,0.9.0.9,0};		//background color when disabled (currently light gray)
			colorBackgroundActive[] = {1,0,0,1};		//background color when active (selected, or hovered over) (currently red)
			colorFocused[] = {0,1,0,1};			//bakcground color when focused (selected) (currently green)
			colorShadow[] = {0.023529,0,0.0313725,0};		//shadow color (currently dark gray)
			colorBorder[] = {0.023529,0,0.0313725,0};		//border color (currently dark gray)
  			soundEnter[] = {"",0.09,1};			//sound upon hovering over the control (sound, volume, pitch)
    		soundPush[] = {"",0,0};			//sound upon pushing the button (sound, volume, pitch)
    		soundClick[] = {"",0.07,1};			//sound upon clicking the button (sound, volume, pitch)
    		soundEscape[] = {"",0.09,1};		//sound upon releasing the pushed button (sound, volume, pitch)
			x = 0.5;			//position on X axis (0-1)
			y = 0.75;			//position on Y axis (0-1)
			w = 0.2;			//width (0-1)
			h = 0.1;			//height (0-1)
    		style = 2;		//style of the control
    		shadow = 2;			//above
    		font = GUI_FONT_BOLD;	//font type
    		sizeEx = 0.05;			//font size
    		offsetX = 0;		//offset when not pressed on X axis
    		offsetY = 0;		//offset when not pressed on Y axis
    		offsetPressedX = 0.003;			//offset when pressed on X axis
    		offsetPressedY = 0.003;			//offset when pressed on Y axis
    		borderSize = 0;			//border size (duh)
			action = " if (ctrlText 2001 == ""4646"") then {if (locked (player getVariable ""currentVeh"") == 2) then {hint ""unlocked""; (player getVariable ""currentVeh"") setVehicleLock ""UNLOCKED"";} else {hint ""locked"";(player getVariable ""currentVeh"") setVehicleLock ""LOCKED""; (player getVariable ""currentVeh"") lockTurret [[0], true];}} else {hint ""Incorrect Pin""}; ";	//action executed upon clicking the button (currently closes the dialog itself)
			//action = " if (ctrlText 2001 == ""4646"") then {if (locked (player getVariable ""currentVeh"")) then {hint ""unlocked"";}}; ";	//action executed upon clicking the button (currently closes the dialog itself)
		};		//end: RscButton2 class


		class txtEditTest
		{
			idc = 2001;
			type = 2;
			style = 0; // multi line + no border
			x = 0.3;			//position on X axis (0-1)
			y = 0.5;			//position on Y axis (0-1)
			w = 0.4;			//width (0-1)
			h = 0.1;			//height (0-1)
			font = "PuristaMedium";
			sizeEx = 0.04;
			autocomplete = "";
			canModify = true; 
			maxChars = 100; 
			forceDrawCaret = false;
			colorSelection[] = {0,1,0,1};
			colorText[] = {1,1,1,1};
			colorDisabled[] = {1,0,0,1}; 
			colorBackground[] = {0,0,0,0.5}; 
			text = ""; // how to output multiline
			tooltip = "Enter Pin";
		};		//end: RscButton2 class



	};	//end: controls class

};	//end: MyFirstDialog class







class DialogMessAround			//Dialog class name, gets called by: handle = CreateDialog "name"
{
	idd=3000;						//Display control number
	movingenable=false;			//True/False to enable moving the dialog with mouse
	enableSimulation = 1;		//True/False to enable world simulation in the background
	class controls {
		class RscText			
		{
			access = 0;			//0 - Read and Write, 1 - Read and create, 2 - Read, 3 - Read verified
			type = CT_STATIC;	//type of the control
 			idc = -1;			//control ID number
			style = ST_MULTI;	//style of the control
			lineSpacing = 1;
			w = 1;			//width (0-1)
			h = 0.7;			//height (0-1)
			x = 0.1;			//position on X axis (0-1)
			y = 0;			//position on Y axis (0-1)
			font = GUI_FONT_NORMAL;		//font style
			sizeEx = 0.05;				//font size
			colorBackground[] = {0,0,0,1};		//background color, RGBA format (currently transparent)
			colorText[] = {0,1,0,1};			//background color, RGBA format (currently white)
			text = "!!!WARNING!!!\n\nPoint system in place\n\nDO NOT mess around at base\n\nONLY fly if you know AFM, or are being trained.\n\nDestroying vehicles will mark points and ruin the experience for others!!!";				//text field
			fixedWidth = 0;				//0,1
			shadow = 0;				//0 - none, 1 - color affected by background, 2 - black
		};	//end: RscText class
		class RscButton
		{
    
  			access = 0;				//same as above
			idc = -1;				//ID number
			type = CT_BUTTON;		//type of the control
			text = "Close";		//text field
			colorText[] = {1,1,1,1};		//color of the text (currently white)
			colorDisabled[] = {0.4,0.4,0.4,0};		//color when disabled (currently gray)
			colorBackground[] = {0,0,1,1};			//background color (currently blue)
			colorBackgroundDisabled[] = {0.9,0.9.0.9,0};		//background color when disabled (currently light gray)
			colorBackgroundActive[] = {1,0,0,1};		//background color when active (selected, or hovered over) (currently red)
			colorFocused[] = {0,1,0,1};			//bakcground color when focused (selected) (currently green)
			colorShadow[] = {0.023529,0,0.0313725,0};		//shadow color (currently dark gray)
			colorBorder[] = {0.023529,0,0.0313725,0};		//border color (currently dark gray)
  			soundEnter[] = {"",0.09,1};			//sound upon hovering over the control (sound, volume, pitch)
    		soundPush[] = {"",0,0};			//sound upon pushing the button (sound, volume, pitch)
    		soundClick[] = {"",0.07,1};			//sound upon clicking the button (sound, volume, pitch)
    		soundEscape[] = {"",0.09,1};		//sound upon releasing the pushed button (sound, volume, pitch)
			x = 0.25;			//position on X axis (0-1)
			y = 0.75;			//position on Y axis (0-1)
			w = 0.2;			//width (0-1)
			h = 0.1;			//height (0-1)
    		style = 2;		//style of the control
    		shadow = 2;			//above
    		font = GUI_FONT_BOLD;	//font type
    		sizeEx = 0.05;			//font size
    		offsetX = 0;		//offset when not pressed on X axis
    		offsetY = 0;		//offset when not pressed on Y axis
    		offsetPressedX = 0.003;			//offset when pressed on X axis
    		offsetPressedY = 0.003;			//offset when pressed on Y axis
    		borderSize = 0;			//border size (duh)
			action = "closedialog 0";	//action executed upon clicking the button (currently closes the dialog itself)
		};		//end: RscButton class



	};	//end: controls class
};	//end: MyFirstDialog class




class Trend_DialogTest
	{
	idd = 5000;
	movingEnabled = false;

	class controls {

		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by treendy, v1.063, #Nazety)
		////////////////////////////////////////////////////////

		class RscPicture_1201: RscPicture
		{
			idc = 1201;
			text = "RandFramework\Media\table1.paa";
			x = 0.226718 * safezoneW + safezoneX;
			y = 0.0446 * safezoneH + safezoneY;
			w = 0.531094 * safezoneW;
			h = 0.935 * safezoneH;
		};

		//class IGUIBack_2200: IGUIBack
		//{
		//	idc = 5200;
		//	x = 0.29375 * safezoneW + safezoneX;
		//	y = 0.225 * safezoneH + safezoneY;
		//	w = 0.4125 * safezoneW;
		//	h = 0.55 * safezoneH;
		//};
		class RscText_1001: RscText
		{
			idc = 5001;
			style = ST_MULTI;
			lineSpacing = 1;
			text = "Details about it here"; //--- ToDo: Localize;
			x = 0.489686 * safezoneW + safezoneX;
			y = 0.317436 * safezoneH + safezoneY;
			w = 0.211441 * safezoneW;
			h = 0.241947 * safezoneH;
		};
		class RscCombo_2100: RscCombo
		{
			idc = 5100;
			text = "Weather"; //--- ToDo: Localize;
			x = 0.381406 * safezoneW + safezoneX;
			y = 0.61221 * safezoneH + safezoneY;
			w = 0.154713 * safezoneW;
			h = 0.0219952 * safezoneH;
		};
		class RscText_1004: RscText
		{
			idc = 5004;
			text = "Reputation System"; //--- ToDo: Localize;
			x = 0.302 * safezoneW + safezoneX;
			y = 0.610007 * safezoneH + safezoneY;
			w = 0.0773437 * safezoneW;
			h = 0.022 * safezoneH;
			colorText[] = {0,1,0,1};
		};
		class RscText_1005: RscText
		{
			idc = 5005;
			text = "Weather"; //--- ToDo: Localize;
			x = 0.302 * safezoneW + safezoneX;
			y = 0.643006 * safezoneH + safezoneY;
			w = 0.0773437 * safezoneW;
			h = 0.022 * safezoneH;
			colorText[] = {0,1,0,1};
		};
		class RscCombo_2101: RscCombo
		{
			idc = 5101;
			text = "Weather"; //--- ToDo: Localize;
			x = 0.381406 * safezoneW + safezoneX;
			y = 0.64521 * safezoneH + safezoneY;
			w = 0.154713 * safezoneW;
			h = 0.0219952 * safezoneH;
		};
		class RscCombo_2102: RscCombo
		{
			idc = 5102;
			text = "Weather"; //--- ToDo: Localize;
			x = 0.381406 * safezoneW + safezoneX;
			y = 0.678203 * safezoneH + safezoneY;
			w = 0.154713 * safezoneW;
			h = 0.0219952 * safezoneH;
		};
		class RscText_1006: RscText
		{
			idc = 5006;
			text = "NVG"; //--- ToDo: Localize;
			x = 0.302 * safezoneW + safezoneX;
			y = 0.676003 * safezoneH + safezoneY;
			w = 0.0773437 * safezoneW;
			h = 0.022 * safezoneH;
			colorText[] = {0,1,0,1};
		};
		class RscText_1007: RscText
		{
			idc = 5007;
			text = "Revive"; //--- ToDo: Localize;
			x = 0.303031 * safezoneW + safezoneX;
			y = 0.709006 * safezoneH + safezoneY;
			w = 0.0773437 * safezoneW;
			h = 0.022 * safezoneH;
			colorText[] = {0,1,0,1};
		};
		class RscCombo_2103: RscCombo
		{
			idc = 5103;
			text = "Weather"; //--- ToDo: Localize;
			x = 0.381406 * safezoneW + safezoneX;
			y = 0.71121 * safezoneH + safezoneY;
			w = 0.154713 * safezoneW;
			h = 0.0219952 * safezoneH;
		};
		class RscButton_1600: RscButton
		{
			idc = 5600;
			text = "Begin"; //--- ToDo: Localize;
			x = 0.582514 * safezoneW + safezoneX;
			y = 0.642969 * safezoneH + safezoneY;
			w = 0.103142 * safezoneW;
			h = 0.0989783 * safezoneH;
			colorBackground[] = {0,0.5,0,1};
			colorActive[] = {0,1,0,1};
			action = "[_this] execVM 'RandFramework\GUI\SetParamsAndBegin.sqf'; false";
		};
		class RscListbox_1500: RscListbox
		{
			idc = 5500;
			x = 0.298873 * safezoneW + safezoneX;
			y = 0.315236 * safezoneH + safezoneY;
			w = 0.180498 * safezoneW;
			h = 0.219952 * safezoneH;
			onLBSelChanged = "[_this] execVM 'RandFramework\GUI\MissionTypeSelection.sqf'; false; ";
		};
		class RscText_1000: RscText
		{
			idc = 5033;
			text = "Select your options"; //--- ToDo: Localize;
			x = 0.298824 * safezoneW + safezoneX;
			y = 0.236 * safezoneH + safezoneY;
			w = 0.175341 * safezoneW;
			h = 0.0659856 * safezoneH;
			colorText[] = {0,1,0,1};
		};
		class RscText_1002: RscText
		{
			idc = 5002;
			text = "Objective"; //--- ToDo: Localize;
			x = 0.301968 * safezoneW + safezoneX;
			y = 0.576983 * safezoneH + safezoneY;
			w = 0.0773437 * safezoneW;
			h = 0.022 * safezoneH;
			colorText[] = {0,1,0,1};
		};
		class RscCombo_2104: RscCombo
		{
			idc = 5104;
			text = "Weather"; //--- ToDo: Localize;
			x = 0.381387 * safezoneW + safezoneX;
			y = 0.576983 * safezoneH + safezoneY;
			w = 0.154713 * safezoneW;
			h = 0.0219952 * safezoneH;
		};
		class RscText_1003: RscText
		{
			idc = 5003;
			text = ""; //--- ToDo: Localize;
			x = 0.538171 * safezoneW + safezoneX;
			y = 0.577 * safezoneH + safezoneY;
			w = 0.0154751 * safezoneW;
			h = 0.022 * safezoneH;
			colorText[] = {1,1,1,1};
		};
		class RscText_1008: RscText
		{
			idc = 5008;
			text = "[?]"; //--- ToDo: Localize;
			x = 0.538171 * safezoneW + safezoneX;
			y = 0.61 * safezoneH + safezoneY;
			w = 0.0154751 * safezoneW;
			h = 0.022 * safezoneH;
			colorText[] = {1,1,1,1};
			tooltip = "If this is enabled, you will have to keep your Reputation up with high command.\nKilling civs, losing main assets and units, killing friendly rebels or any other mistakes will lower your Reputation.\nIf your Reputation is too low, your mission will be unassigned and you will have to return to base!\n(I introduced this point system to make mistakes more costly, to make you think carefully about your actions\nand to feel any vehicle assets you use are not expendable!"; //--- ToDo: Localize;
		};
		class RscText_1009: RscText
		{
			idc = 5009;
			text = ""; //--- ToDo: Localize;
			x = 0.538171 * safezoneW + safezoneX;
			y = 0.643 * safezoneH + safezoneY;
			w = 0.0154751 * safezoneW;
			h = 0.022 * safezoneH;
			colorText[] = {1,1,1,1};
		};
		class RscText_1010: RscText
		{
			idc = 5010;
			text = ""; //--- ToDo: Localize;
			x = 0.538171 * safezoneW + safezoneX;
			y = 0.676 * safezoneH + safezoneY;
			w = 0.0154751 * safezoneW;
			h = 0.022 * safezoneH;
			colorText[] = {1,1,1,1};
		};
		class RscText_1011: RscText
		{
			idc = 5011;
			text = ""; //--- ToDo: Localize;
			x = 0.538171 * safezoneW + safezoneX;
			y = 0.709 * safezoneH + safezoneY;
			w = 0.0154751 * safezoneW;
			h = 0.022 * safezoneH;
			colorText[] = {1,1,1,1};
		};
		class RscPicture_1200: RscPicture
		{
			idc = 5201;
			text = "RandFramework\Media\TRGM7.paa";
			x = 0.536108 * safezoneW + safezoneX;
			y = 0.159 * safezoneH + safezoneY;
			w = 0.165067 * safezoneW;
			h = 0.242 * safezoneH;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////



	};
};