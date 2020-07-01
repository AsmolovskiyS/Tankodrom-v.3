program Tankodrom3;

uses
  Forms,
  Osnovnoy in 'Osnovnoy.pas' {Form1},
  Buffer in 'Buffer.pas',
  Nastroyka in 'Nastroyka.pas' {Nastroyki},
  Reyting in 'Reyting.pas' {Reyt},
  Niks in 'Niks.pas' {Form2},
  Code in 'Code.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Tankodrom';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TNastroyki, Nastroyki);
  Application.CreateForm(TReyt, Reyt);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
