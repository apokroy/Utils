## UnitsStr
A small utility module designed for convenient representation of measurements on display, reading/writing to settings files... 

Contains TMilliseconds type, but it can be easily expanded to support other units like size (B, Mb, Gb...), intervals etc.
Allows you to represent values like this:
- `1 day 8 hrs`, instead of `115200000`
- `5m`, instead of `300000`
etc...

### Sample
```Pascal
var M := TMilliseconds.Parse('2 hours');

if TMilliseconds.TryParse(Config.ReadString('Timeout'), M) then
  Connection.DefaultTimeout := M;

//Localization
TMilliseconds.TUnits.Defaults.Add('小时', SecsPerHour * MSecsPerSec, True {Use by default});
TMilliseconds.TUnits.Defaults.Add('ч', SecsPerHour * MSecsPerSec);
```
type TMilliseconds declared as `TMilliseconds = type UInt64;`

