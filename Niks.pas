unit Niks;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm2 = class(TForm)
    Opublic: TButton;
    Label1: TLabel;
    Otmena: TButton;
    Edit1: TEdit;
    Ok: TButton;//�������� �� �������;
    procedure OpublicClick(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses Osnovnoy, Buffer, Nastroyka, Reyting;

{$R *.dfm}



procedure TForm2.OpublicClick(Sender: TObject);
var s,s1:String; c:Char; i:Integer;
begin
//���������� �� ������� ;, ���� ���� ; ������� ��
s:=Edit1.Text;
s1:='';
For i:=1 to Length(s) do
begin
c:=s[i];
If c=';' then continue;
s1:=S1+c;
end;
//------------
//��������� ���
If s1='' Then Application.MessageBox('�������� ���', '������',0)
else
Begin
Form1.Nik:=S1;
Ok.Click;
end;
//---------------
end;

procedure TForm2.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
If Key=';' then Key:=#0;
end;

end.
