params ["_convoyID", "_startPos", "_endPos", "_units", "_sideConvoy", "_convoyType", ["_arguments", []]];

switch (_convoyType) do
{
  case ("attack"):
  {
    //This is not yet implemented
  };
  case ("patrol"):
  {
    //Patrol arrived, nothing found on the way, return to start point
    //Cause thats how patrols work
    sleep 15;
    [_convoyID, _backRoute, _speed, _units, _sideConvoy, "return"] spawn A3A_fnc_createConvoy;
  };
  case ("convoy"):
  {
    //End convoy mission
    ["CONVOY", "FAILED"] call BIS_fnc_taskSetState;
    ["CONVOY1", "SUCCEEDED"] call BIS_fnc_taskSetState;
  };
  case ("airstrike"):
  {
    //Engage in a fight, not yet implemented
  };
  case ("reinforce"):
  {

  };
  case ("return"):
  {
    //Nothing happening, units are not really pulled or moved
  };
};
