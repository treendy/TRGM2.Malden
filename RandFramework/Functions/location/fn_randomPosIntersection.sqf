scriptname "BIS_fnc_randomPosIntersection";
/*
	Author: Riccardo Argiolas

	Description:
	Returns random 2D position inside the intersection of two circles. [-1,-1] is returned if the circles do not intersect.

 	Parameters:
 	Select 0 - OBJECT/STRING/ARRAY : First circle. Can be a trigger, a marker or an array of [circleCenter, radius], where circleCenter is [xCenterPosition, yCenterPosition]
	Select 1 - OBJECT/STRING/ARRAY : Second circle. Same as above.
	Select 2 - NUMBER : If a value between 0 and 1 is passed (0 and 1 included), then a gaussian distribution is used. This will influence the random position along the axis which connects the two circles' centers. A lower value means the position will be close to the first circle.
	Select 3 - NUMBER : If a value between 0 and 1 is passed (0 and 1 included), then a gaussian distribution is used. This will influence the random position along the axis perpendicular to the axis which connects the two circles' centers.
	Returns:
	ARRAY : 2D Position in [x,y] format
*/

//circle can be: trigger(object), marker(string), center/radius(array)
params
[
	[ "_firstCircle", objNull, [objNull, "", []]],
	[ "_secondCircle", objNull, [objNull, "", []]],
	[ "_gaussianMidX", -1, [0]],
	[ "_gaussianMidY", -1, [0]]
];

//variables for holding info about circles
private _circles = [_firstCircle, _secondCircle];
private _radii = [0,0];
private _positions = [[0,0],[0,0]];

//check whether each circle is a trigger, marker or array and set its variable (radius and center) accordingly
{
	switch (true) do
	{
		//trigger
		case (typeName _x isEqualTo "OBJECT") :
		{
			if(triggerArea _x select 0 != triggerArea _x select 1) then
			{
				["Error: trigger is not a circle. Using x_size as radius anyway"] call BIS_fnc_error;
			};

			_radii set [_forEachIndex, triggerArea _x select 0];
			_positions set [_forEachIndex, getPos _x];
		};
		case (typeName _x isEqualTo "STRING") :
		{
			if(getmarkersize _x select 0 != getmarkersize _x select 1) then
			{
				["Error: marker is not a circle. Using x_size as radius anyway"] call BIS_fnc_error;
			};

			_radii set [_forEachIndex, getmarkersize _x select 0];
			_positions set [_forEachIndex, getmarkerpos _x];
		};
		case (typeName _x isEqualTo "ARRAY") :
		{
			_radii set [_forEachIndex, _x select 1];

			if(typeName (_x select 0) isEqualTo "ARRAY") then
			{
				_positions set [_forEachIndex, _x select 0];
			}
			else
			{
				["Error: wrong center position passed, expected array"] call BIS_fnc_error;
			};
		};
	};
}
forEach _circles;


//calcualte radius and distance between two circles
private _r1 = _radii select 0;
private _r2 = _radii select 1;
private _d = [(_positions select 0) select 0, (_positions select 0) select 1] distance2D [(_positions select 1) select 0, (_positions select 1) select 1];

switch (true) do
{
	//2 intersection points
	case (abs (_r1 - _r2) < _d && _d < (_r1 + _r2)) :
	{
		//2 intersection points

		//to simplify everything, we're gonna use a custom set of cartesian axes where the circles are centered in (0,0) and (d,0), where d is the distance between the two centers
		//after we are done with our calculations, we'll go back to arma's cartesian axes

		//first, we gotta at what x the intersection starts and ends. We'll then get a random number (_A) between those two points.
		//we'll then find another random number (_B) between the min and max height of the intersetcion at _A.

		private ["_A", "_B"];

		//calculate stuff
		if(_gaussianMidX < 0 || _gaussianMidX > 1)then
		{
			//average distribution
			_A = random (_r1 + _r2 - _d);
		}
		else
		{
			//gaussian distribution
			_A = random [0, (_r1 + _r2 - _d) * _gaussianMidX, (_r1 + _r2 - _d)];
		};

		//calculate position, relatively to t1, of intersection
		private _dIntersect = 0;

		_dIntersect = _d - ((_d^2 - _r1^2 + _r2^2) / (2*_d));

		_dIntersect = _dIntersect - _d + _r2;

		private "_tempY";

		//due to approximation, the argument of the sqrt might result smaller than 0, thus making _tempY equal to -1.#IND
		//because of this, we're using "max 0" to ensure the argument of the sqrt is never smaller than 0
		if(_A > _dIntersect) then
		{
			//use t1 for calculations
			_tempY = sqrt( (_r1^2 - (_d - _r2 + _A)^2) max 0 );
		}
		else
		{
			//use t2 for calculations
			_tempY = sqrt( (_r2^2 - (_r2 - _A)^2) max 0 );
		};

		//randomize between -tempY and tempY, but since we can't just randomize from 0 to 2tempY and do -tempY
		if(_gaussianMidY < 0 || _gaussianMidY > 1)then
		{
			//average distribution
			_B = random ( 2 * _tempY);
		}
		else
		{
			//gaussian distribution
			_B = random [0, 2 * _tempY * _gaussianMidY, 2 * _tempY];
		};


		_B = _B - _tempY;

		//we now got the center of our new circle in our custom cartesian axes, now we gotta go back to arma's axes

		//calculate the m of the line that passes through the centers of circles and get the alpha of that line
		private _deltaX = ((_positions select 1) select 0) - ((_positions select 0) select 0);
		private _deltaY = ((_positions select 1) select 1) - ((_positions select 0) select 1);
		private _alpha = _deltaY atan2 _deltaX;

		//calculate x1 and y1, which are basically the X' of the lens
		private _x1Res = (cos _alpha) * (_d - _r2 + _A);
		private _y1Res = (sin _alpha) * (_d - _r2 + _A);

		//calculate x2 and y2, which are basically the Y' of the lens
		private _x2Res = (sin _alpha) * _B;
		private _y2Res = -1 * (cos _alpha) * _B;
		//_x2Res = 0;
		//_y2Res = 0;

		//apply position relatively to center of t1
		private _xRes = _x1Res + _x2Res + ((_positions select 0) select 0);
		private _yRes = _y1Res + _y2Res + ((_positions select 0) select 1);

		[_xRes, _yRes];
	};

	//1 intersection point
	case (_d isEqualTo _r1 + _r2) :
	{
		//1 intersection point

		//calculate x1 and y1, which are basically the X' of the lens
		private _x1Res = (cos _alpha) * (_r1);
		private _y1Res = (sin _alpha) * (_r1);

		//apply position relatively to center of t1
		private _xRes = _x1Res + ((_positions select 0) select 0);
		private _yRes = _y1Res + ((_positions select 0) select 1);

		[_xRes, _yRes];
	};

	//one inside the other
	case (abs (_r1 - _r2) >= _d) :
	{
		//one inside the other

		private ["_position"];

		if(_r1 > _r2) then
		{
			_position = [ [(_positions select 1) select 0, (_positions select 1) select 1] , _r2] call BIS_fnc_randomPosTrigger;
		}
		else
		{
			_position = [ [(_positions select 0) select 0, (_positions select 0) select 1] , _r1] call BIS_fnc_randomPosTrigger;
		};

		[_position select 0, _position select 1];
	};

	//0 intersection point
	case (_r1 + _r2 < _d) :
	{
		//no intersection
		[-1, -1];
	};
	default
	{
		[-1, -1];
	};
};