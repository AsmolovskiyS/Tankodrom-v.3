unit Buffer;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls;

  Procedure ZagruzkaBuffer;
  Procedure VigruzitBuffer;


implementation

uses Osnovnoy;

procedure ZagruzkaBuffer;
begin
//Стринг лист пуль
Form1.PulNom:=TStringList.Create;
Form1.PulName:=TStringList.Create;
Form1.PulX:=TStringList.Create;
Form1.PulY:=TStringList.Create;
Form1.PulW:=TStringList.Create;
Form1.PulH:=TStringList.Create;
Form1.PulNap:=TStringList.Create;
//-------------
//Стринглист взрыв
Form1.VzrNom:=TStringList.Create;
Form1.VzrX:=TStringList.Create;
Form1.VzrY:=TStringList.Create;
//-------------
//Буфер общий
Form1.Buf:=TBitmap.Create;
Form1.Buf.Width:=Form1.Pole.Width;
Form1.Buf.Height:=Form1.Pole.Height;
//---------
//фон
Form1.BufFon:=TBitmap.Create;
Form1.BufFon.Width:=Form1.Pole.Width;
Form1.BufFon.Height:=Form1.Pole.Height;
//------------
//Танк
Form1.BufTanks:=TBitmap.Create;
Form1.BufTanks.Width:=120;
Form1.BufTanks.Height:=120;
Form1.BufTanks.LoadFromFile('Data\Tank.bmp');
Form1.BufTank:=TBitmap.Create;
Form1.BufTank.Width:=30;
Form1.BufTank.Height:=30;
Form1.BufTank.Transparent:=true;
//------------
//Взорваный танк
Form1.BufVzorTanks:=TBitmap.Create;
Form1.BufVzorTanks.Width:=60;
Form1.BufVzorTanks.Height:=30;
Form1.BufVzorTanks.LoadFromFile('Data\End.bmp');
Form1.BufVzorTank:=TBitmap.Create;
Form1.BufVzorTank.Width:=Form1.BufTank.Width;
Form1.BufVzorTank.Height:=Form1.BufTank.Height;
Form1.BufVzorTank.Transparent:=true;
//--------------
//Бонус
Form1.BufBonus:=TBitmap.Create;
Form1.BufBonus.Width:=16;
Form1.BufBonus.Height:=16;
Form1.BufBonus.LoadFromFile('Data\Bonus.bmp');
Form1.BufBonus.Transparent:=true;
//--------
//Броня
Form1.BufBronjas:=TBitmap.Create;
Form1.BufBronjas.Width:=120;
Form1.BufBronjas.Height:=30;
Form1.BufBronjas.LoadFromFile('Data\Bronja.bmp');
Form1.BufBronja:=TBitmap.Create;
Form1.BufBronja.Width:=Form1.BufTank.Width;
Form1.BufBronja.Height:=Form1.BufTank.Height;
Form1.BufBronja.Transparent:=true;
//------------
//Взрыв
Form1.BufVzriv:=TBitmap.Create;
Form1.BufVzriv.Width:=8;
Form1.BufVzriv.Height:=8;
Form1.BufVzriv.LoadFromFile('Data\Vzriv.bmp');
Form1.BufVzriv.Transparent:=true;
//-----------
//Пули
Form1.Buf11:=TBitMap.Create;
Form1.Buf11.LoadFromFile('Data\1-1.bmp');
Form1.Buf11.Width:=6;
Form1.Buf11.Height:=10;
Form1.Buf11.Transparent:=true;
Form1.Buf12:=TBitMap.Create;
Form1.Buf12.LoadFromFile('Data\1-2.bmp');
Form1.Buf12.Width:=10;
Form1.Buf12.Height:=6;
Form1.Buf12.Transparent:=true;
Form1.Buf13:=TBitMap.Create;
Form1.Buf13.LoadFromFile('Data\1-3.bmp');
Form1.Buf13.Width:=6;
Form1.Buf13.Height:=10;
Form1.Buf13.Transparent:=true;
Form1.Buf14:=TBitMap.Create;
Form1.Buf14.LoadFromFile('Data\1-4.bmp');
Form1.Buf14.Width:=10;
Form1.Buf14.Height:=6;
Form1.Buf14.Transparent:=true;

Form1.Buf21:=TBitMap.Create;
Form1.Buf21.LoadFromFile('Data\2-1.bmp');
Form1.Buf21.Width:=8;
Form1.Buf21.Height:=14;
Form1.Buf21.Transparent:=true;
Form1.Buf22:=TBitMap.Create;
Form1.Buf22.LoadFromFile('Data\2-2.bmp');
Form1.Buf22.Width:=14;
Form1.Buf22.Height:=8;
Form1.Buf22.Transparent:=true;
Form1.Buf23:=TBitMap.Create;
Form1.Buf23.LoadFromFile('Data\2-3.bmp');
Form1.Buf23.Width:=8;
Form1.Buf23.Height:=14;
Form1.Buf23.Transparent:=true;
Form1.Buf24:=TBitMap.Create;
Form1.Buf24.LoadFromFile('Data\2-4.bmp');
Form1.Buf24.Width:=14;
Form1.Buf24.Height:=8;
Form1.Buf24.Transparent:=true;

Form1.Buf31:=TBitMap.Create;
Form1.Buf31.LoadFromFile('Data\3-1.bmp');
Form1.Buf31.Width:=10;
Form1.Buf31.Height:=18;
Form1.Buf31.Transparent:=true;
Form1.Buf32:=TBitMap.Create;
Form1.Buf32.LoadFromFile('Data\3-2.bmp');
Form1.Buf32.Width:=18;
Form1.Buf32.Height:=10;
Form1.Buf32.Transparent:=true;
Form1.Buf33:=TBitMap.Create;
Form1.Buf33.LoadFromFile('Data\3-3.bmp');
Form1.Buf33.Width:=10;
Form1.Buf33.Height:=18;
Form1.Buf33.Transparent:=true;
Form1.Buf34:=TBitMap.Create;
Form1.Buf34.LoadFromFile('Data\3-4.bmp');
Form1.Buf34.Width:=18;
Form1.Buf34.Height:=10;
Form1.Buf34.Transparent:=true;

Form1.Buf41:=TBitMap.Create;
Form1.Buf41.LoadFromFile('Data\4-1.bmp');
Form1.Buf41.Width:=12;
Form1.Buf41.Height:=22;
Form1.Buf41.Transparent:=true;
Form1.Buf42:=TBitMap.Create;
Form1.Buf42.LoadFromFile('Data\4-2.bmp');
Form1.Buf42.Width:=22;
Form1.Buf42.Height:=12;
Form1.Buf42.Transparent:=true;
Form1.Buf43:=TBitMap.Create;
Form1.Buf43.LoadFromFile('Data\4-3.bmp');
Form1.Buf43.Width:=12;
Form1.Buf43.Height:=22;
Form1.Buf43.Transparent:=true;
Form1.Buf44:=TBitMap.Create;
Form1.Buf44.LoadFromFile('Data\4-4.bmp');
Form1.Buf44.Width:=22;
Form1.Buf44.Height:=12;
Form1.Buf44.Transparent:=true;
//----------------
end;

procedure VigruzitBuffer;
begin
//Стринглист пуль
Form1.PulNom.Free;
Form1.PulName.Free;
Form1.PulX.Free;
Form1.PulY.Free;
Form1.PulW.Free;
Form1.PulH.Free;
Form1.PulNap.Free;
//--------------
//Стринглист взрыв
Form1.VzrNom.Free;
Form1.VzrX.Free;
Form1.VzrY.Free;
//-----------
//Буфер общий
Form1.Buf.Free;
//Фон
Form1.BufFon.Free;
//Танк
Form1.BufTanks.Free;
Form1.BufTank.Free;
//Бонус
Form1.BufBonus.Free;
//Броня
Form1.BufBronjas.Free;
Form1.BufBronja.Free;
//Взрыв
Form1.BufVzriv.Free;
//Пули
Form1.Buf11.Free;
Form1.Buf12.Free;
Form1.Buf13.Free;
Form1.Buf14.Free;
Form1.Buf21.Free;
Form1.Buf22.Free;
Form1.Buf23.Free;
Form1.Buf24.Free;
Form1.Buf31.Free;
Form1.Buf32.Free;
Form1.Buf33.Free;
Form1.Buf34.Free;
Form1.Buf41.Free;
Form1.Buf42.Free;
Form1.Buf43.Free;
Form1.Buf44.Free;
end;


end.
