program Demo;

uses
  Vcl.Forms,
  Main in 'Main.pas' {Form7},
  UnitsStr in '..\UnitsStr.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm7, Form7);
  Application.Run;
end.
