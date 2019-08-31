private ["_hr","_rebelMoney","_typeX","_costs","_markerX","_garrison","_positionX","_unit","_groupX","_veh","_pos"];

_hr = server getVariable "hr";

if (_hr < 1) exitWith {hint "You lack the HR to recruit a new unit!"};

_rebelMoney = server getVariable "rebelMoney";

_typeX = _this select 0;

_costs = 0;

if (_typeX isEqualType "") then
	{
	_costs = server getVariable _typeX;
	_costs = _costs + ([rebelMortar] call A3A_fnc_vehiclePrice);
	}
else
	{
	_typeX = if (random 20 <= rebelTrainingLevel) then {_typeX select 1} else {_typeX select 0};	//difficulty feature
	_costs = server getVariable _typeX;
	};

if (_costs > _rebelMoney) exitWith {hint format ["You do not have enough money for this kind of unit (%1 € needed)",_costs]};

_markerX = positionXGarr;

if ((_typeX == rebelStaticCrew) and (_markerX in rebelWatchpostsAndRoadblocks)) exitWith {hint "You cannot add mortars to a Roadblock garrison"};

_positionX = getMarkerPos _markerX;

if (surfaceIsWater _positionX) exitWith {hint "This Garrison is still updating, please try again in a few seconds"};

if ([_positionX,500] call A3A_fnc_enemyNearCheck) exitWith {Hint "You cannot Recruit Garrison Units with enemies near the zone"};
_nul = [-1,-_costs] remoteExec ["A3A_fnc_rebelResources",2];
_countX = count (garrison getVariable _markerX);
[_typeX,rebelSide,_markerX,1] remoteExec ["A3A_fnc_garrisonUpdate",2];
waitUntil {(_countX < count (garrison getVariable _markerX)) or (sidesX getVariable [_markerX,sideUnknown] != rebelSide)};

if (sidesX getVariable [_markerX,sideUnknown] == rebelSide) then
	{
	hint format ["Soldier recruited.%1",[_markerX] call A3A_fnc_garrisonInfo];

	if (spawner getVariable _markerX != 2) then
		{
		[_markerX,_typeX] remoteExec ["A3A_fnc_createSDKGarrisonsTemp",2];
		};
	};

