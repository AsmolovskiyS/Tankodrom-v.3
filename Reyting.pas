unit Reyting;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, Code;

type
  TReyt = class(TForm)
    SG: TStringGrid;
    Local: TButton;
    procedure FormCreate(Sender: TObject);
    Procedure Zagruzka;
    Function Position(X:Integer):Integer;
    procedure LocalClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Reyt: TReyt;
  L4,L1,L2,L3,L0:TStringList;
implementation

uses Buffer, Nastroyka, Osnovnoy;

{$R *.dfm}

procedure TReyt.FormCreate(Sender: TObject);
begin
SG.Cells[0,0]:='Место';
SG.Cells[1,0]:='Ник';
SG.Cells[2,0]:='Результат';
SG.Cells[3,0]:='Время';
SG.Cells[4,0]:='Уровень';
SG.Cells[5,0]:='Пуль на поле';
SG.Cells[6,0]:='Создано пуль';
SG.Cells[7,0]:='Дата';
SG.ColWidths[0]:=40;
SG.ColWidths[1]:=130;
SG.ColWidths[2]:=60;
SG.ColWidths[3]:=40;
SG.ColWidths[4]:=50;
SG.ColWidths[5]:=75;
SG.ColWidths[6]:=75;
SG.ColWidths[7]:=60;
Sg.Width:=540;

end;

Function TReyt.Position(X:Integer):Integer;
Var j,y:Integer;
Begin
If L3.Count=0 then
  Begin
  Result:=-1;
  exit;
  end
Else  For j:=0 to L3.Count-1 do
  Begin
  Y:=StrToInt(L3.Strings[j]);
  If X>=Y then
    Begin
    Result:=j;
    exit;
    end
  else If J=L3.Count-1 then
    Begin
    Result:=-1;
    exit;
    end;
  end;
end;


Procedure TReyt.Zagruzka;
Var X,i,p:Integer; s:String;
Begin
SG.RowCount:=2;
SG.Rows[1].Clear;

L4:=TStringList.Create;
L1:=TStringList.Create;
L2:=TStringList.Create;
L3:=TStringList.Create;
//Декодировать
For i:=0 to L0.Count-1 do
begin
s:=L0.Strings[i];
S:=Code_DeCode(s);
L1.Add(s);
end;

//Копирование только Очки
For i:=0 to L1.Count-1 do
  Begin
  s:=L1.Strings[i];
  p:=Pos(';',s);
  L2.Add(Copy(L1.Strings[i],0,p-1));
  end;

//Сортировка
For i:=L2.Count-1 downto 0 do
  Begin
  X:=StrToInt(L2.Strings[i]);
  p:=Position(x);
  If p<0 then Begin L3.Add(L2.Strings[i]); L4.Add(L1.Strings[i]); end
    else Begin L3.Insert(p,L2.Strings[i]); L4.Insert(p,L1.Strings[i]); end;
  end;

//Записываем в таблицу  
For i:=0 to L4.Count-1 do
  Begin
  SG.RowCount:=L4.Count+1;
  Sg.Cells[0,i+1]:=IntToStr(i+1);
  S:=L4.Strings[i];
  p:=pos(';',s);
  Sg.Cells[2,i+1]:=Copy(s,0,p-1);
  s:=Copy(s,p+1, Length(s));

  p:=pos(';',s);
  Sg.Cells[1,i+1]:=Copy(s,0,p-1);
  s:=Copy(s,p+1, Length(s));

  p:=pos(';',s);
  Sg.Cells[3,i+1]:=Copy(s,0,p-1);
  s:=Copy(s,p+1, Length(s));

  p:=pos(';',s);
  Sg.Cells[4,i+1]:=Copy(s,0,p-1);
  s:=Copy(s,p+1, Length(s));

  p:=pos(';',s);
  Sg.Cells[5,i+1]:=Copy(s,0,p-1);
  s:=Copy(s,p+1, Length(s));

  p:=pos(';',s);
  Sg.Cells[6,i+1]:=Copy(s,0,p-1);
  s:=Copy(s,p+1, Length(s));

  p:=pos(';',s);
  Sg.Cells[7,i+1]:=Copy(s,0,p-1);
  s:=Copy(s,p+1, Length(s));
  end;
L1.Free;
L2.Free;
L3.Free;
L4.Free;
L0.Free;
end;

procedure TReyt.LocalClick(Sender: TObject);
begin
try
L0:=TStringList.Create;
L0.LoadFromFile('Data\Rezult.txt');
Zagruzka;
except
ShowMessage('Файл не найден...');
end;
end;

end.
