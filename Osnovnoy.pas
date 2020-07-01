unit Osnovnoy;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, bass, ComCtrls,code;

type
  TForm1 = class(TForm)
    StatusBar: TStatusBar;
    Pole: TImage;
    Panel: TPanel;
    Start: TSpeedButton;
    Pause: TSpeedButton;
    BronjaGB: TGroupBox;
    LTJMax: TLabel;
    Label2: TLabel;
    LTJ: TLabel;
    Vivod: TTimer;
    TankMove: TTimer;
    GlobalTimer: TTimer;
    SozPulTimer: TTimer;
    Karta: TSpeedButton;
    LPause: TLabel;
    Bonus: TGroupBox;
    LBonus: TLabel;
    BonT: TGroupBox;
    Nastroy: TSpeedButton;
    Ochki: TGroupBox;
    LOchki: TLabel;
    UvelOchkiTimer: TTimer;
    ReytinB: TSpeedButton;
    Opublicovat: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure VivodTimer(Sender: TObject);
    procedure StartClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TankMoveTimer(Sender: TObject);
    procedure GlobalTimerTimer(Sender: TObject);
    function OprTipPuli(Urov:Integer):Integer;
    procedure SozPulTimerTimer(Sender: TObject);
    procedure DvijeniePuli(Sender: TObject);
    function Vilet(index,x,y,w,h,nap:Integer):Boolean;
    function PulTank(index,x,y,w,h,nap:Integer):Boolean;
    Procedure UdalitPulIndex(index:Integer);
    procedure VzrivKoord(x1,y1,w1,h1,x2,y2,w2,h2:Integer);
    Procedure VzrivSozdat(x,y:Integer);
    Procedure UdalitVzrTimer(Sender: TObject);
    Procedure OynjatJiznTanka(TipPuli:Integer);
    Procedure KonecIgri;
    Procedure MultEnd (Sender:TObject);
    Procedure StolkPuliPuli(Index:Integer);
    Procedure BonusSozd;
    Procedure Perimetr (Per:Integer);
    procedure PauseClick(Sender: TObject);
    Procedure PostroitKArtu;
    procedure KartaClick(Sender: TObject); //создаем карту
    procedure ZapListBon(Tip,Time:Integer;Povtor:Boolean);
    procedure VivestiVremjaBon;
    Procedure OtnjatTimeBon;
    procedure UdalitTimeBon(Tip:Integer);
    procedure NastroyClick(Sender: TObject);
    procedure UvelichitOchki(Tip:Integer);
    procedure UvelOchkiTimerTimer(Sender: TObject);
    procedure ReytinBClick(Sender: TObject);
    procedure OpublicovatClick(Sender: TObject);
    procedure Rezultat (Global:Boolean);

  private
    { Private declarations }
  public
    { Public declarations }
  //Для Буффера
  PulNom,PulName,PulX,PulY,PulW,PulH,PulNap:TStringlist;
  BufFon,BufFons:TBitmap;
  Buf11,Buf12,Buf13,Buf14,Buf21,Buf22,Buf23,Buf24,Buf31,Buf32,Buf33,Buf34,Buf41,Buf42,Buf43,Buf44:TBitmap;
  BufTanks,BufTank, BufBronjas,BufBronja:TBitmap;
  Buf:TBitmap;
  BufVzriv:TBitmap;
  BufVzorTanks,BufVzorTank:TBitmap;
  VzrNom,VzrX,VzrY:TStringlist;
  BufBonus:TBitmap;
  //----------------
   //Звук
  SoundMusc:cardinal;
  SoundMove:cardinal;
  SoundBonus:cardinal;
  SoundVzriv:cardinal;
  SoundEnd:cardinal;
  SoundEndGame, SoundStartGame:cardinal;
  SoundPause, SoundPauseEnd:cardinal;
  VolumeMusic, VolumeSound:Integer;
  SoundKarta:cardinal;
  //-------------
  //Очки
  Och, OchMax:Integer;
  //----------
  Nik:String;
  end;

var
  Form1: TForm1;
  Game:String;
  GlobalTime:Integer;
  OldGlobalTime:Integer;
  Uroven:Integer;
  KolSozPul, MaxKolPulPole:Integer;
  Time:TTimer;
  NomerPul,PulShag:Integer;
  NomerVzr:Integer;
  VzrPolW,VzrPolH:Integer;
  TVzorNomkadr,TVzorKolKadr:Integer;
  //Танк
  TX,TY,TW,TH,TNap,TShag,TKadr,TKolKadr:Integer;
  TJ,TJMax:Integer;
  //-------------
  //Броня
  BrW,BrH:Integer;
  //-------------
  //Бонус
  BX,BY,BW,BH,BTip:Integer;
  OldBonusTime:Integer;
  //--------
  //Бонусы
  UmenKolPul:Integer;
  ZamSozPul:Integer;
  SpeedTank,Neujazvimost,ZamedSozdPul,OstonSozdPul,PuliPuli,Zamorozka:Boolean;
  //---------
  //Продолжительность Бонуса
  L6,L8,L10,L12,L16,L18:TLabel;
  BonTip,BonTime:TStringList;
  //-------------
implementation

uses Buffer, Nastroyka, Reyting, Niks;

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
Randomize;
//Устанавливаем размеры
//Размеры окна
Form1.ClientWidth:=650;
Form1.ClientHeight:=525;
//Размеры панели
Panel.Width:=150;
//Размеры статус бара
StatusBar.Height:=25;
//------------------

//Загружаем картинки и стринглисты в буффер
Buffer.ZagruzkaBuffer;
//-----------------

//Создат лэйбы и стринглисты для продолжительности бонуса
BonTip:=TStringList.Create;
BonTime:=TStringlist.Create;
L6:=tlabel.Create(Self);
L6.Parent:=BonT;
L6.Visible:=False;
L6.Font:=LBonus.Font;
L8:=tlabel.Create(Self);
L8.Parent:=BonT;
L8.Visible:=False;
L8.Font:=LBonus.Font;
L10:=tlabel.Create(Self);
L10.Parent:=BonT;
L10.Visible:=False;
L10.Font:=LBonus.Font;
L12:=tlabel.Create(Self);
L12.Parent:=BonT;
L12.Visible:=False;
L12.Font:=LBonus.Font;
L16:=tlabel.Create(Self);
L16.Parent:=BonT;
L16.Visible:=False;
L16.Font:=LBonus.Font;
L18:=tlabel.Create(Self);
L18.Parent:=BonT;
L18.Visible:=False;
L18.Font:=LBonus.Font;
//---------------

//Создаем карту
PostroitKArtu;
//---------------

//Записываем параметры переменных
Game:='Zagruzka';
//------------------

//Звук
BASS_Init(-1, 44100, 0, 0, nil);
BASS_SetVolume(10);
VolumeMusic:=30;
VolumeSound:=50;
//загружаем файлы звуков в каналы
BASS_StreamFree(SoundMusc);
SoundMusc:= BASS_StreamCreateFile(False, PChar('data\music.wav'), 0, 0, BASS_SAMPLE_LOOP);
BASS_StreamFree(SoundMove);
SoundMove:= BASS_StreamCreateFile(False, PChar('data\move.wav'), 0, 0, BASS_SAMPLE_LOOP);
BASS_StreamFree(SoundBonus);
SoundBonus:= BASS_StreamCreateFile(False, PChar('data\bonus.wav'), 0, 0, 0);
BASS_StreamFree(SoundVzriv);
SoundVzriv:= BASS_StreamCreateFile(False, PChar('data\vzriv.wav'), 0, 0, 0);
BASS_StreamFree(SoundEnd);
SoundEnd:= BASS_StreamCreateFile(False, PChar('data\end.wav'), 0, 0, 0);
BASS_StreamFree(SoundEndGame);
SoundEndGame:= BASS_StreamCreateFile(False, PChar('data\end_Game.wav'), 0, 0, 0);
BASS_StreamFree(SoundPause);
SoundStartGame:= BASS_StreamCreateFile(False, PChar('data\start_game.wav'), 0, 0, 0);
SoundPause:= BASS_StreamCreateFile(False, PChar('data\Pause.wav'), 0, 0, 0);
BASS_StreamFree(SoundPauseEnd);
SoundPauseEnd:= BASS_StreamCreateFile(False, PChar('data\Pause_End.wav'), 0, 0, 0);
BASS_StreamFree(SoundKarta);
SoundKarta:= BASS_StreamCreateFile(False, PChar('data\Karta.wav'), 0, 0, 0);
//Устанавливаем начальные значения уровня громкости
BASS_ChannelSetAttributes(SoundMusc, 44100, VolumeMusic, 0);
BASS_ChannelSetAttributes(SoundMove, 44100, VolumeSound, 0);
BASS_ChannelSetAttributes(SoundBonus, 44100, VolumeSound, 0);
BASS_ChannelSetAttributes(SoundVzriv, 44100, VolumeSound, 0);
BASS_ChannelSetAttributes(SoundEnd, 44100, VolumeSound, 0);
BASS_ChannelSetAttributes(SoundEndGame, 44100, VolumeSound, 0);
BASS_ChannelSetAttributes(SoundStartGame, 44100, VolumeSound, 0);
BASS_ChannelSetAttributes(SoundPause, 44100, VolumeSound, 0);
BASS_ChannelSetAttributes(SoundPauseEnd, 44100, VolumeSound, 0);
BASS_ChannelSetAttributes(SoundKarta, 44100, VolumeSound, 0);
//Запуск фоновой музыки
BASS_ChannelPlay(SoundMusc, False);
//--------------------

Opublicovat.Enabled:=False;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
var i:Integer;
begin
//очистить каналы от музыки
BASS_StreamFree(SoundMusc);
BASS_StreamFree(SoundMove);
BASS_StreamFree(SoundBonus);
BASS_StreamFree(SoundVzriv);
BASS_StreamFree(SoundEnd);
BASS_StreamFree(SoundEndGame);
BASS_StreamFree(SoundStartGame);
BASS_StreamFree(SoundPause);
BASS_StreamFree(SoundPauseEnd);
BASS_StreamFree(SoundKarta);
//------------

//Остановить таймеры
GlobalTimer.Enabled:=False;
SozPulTimer.Enabled:=False;
TankMove.Enabled:=False;
Vivod.Enabled:=False;
//------------

//Удалить динамически созданные таймеры
For I:=ComponentCount-1 Downto 0 do
If (Components[i] is TTimer) and (Components[i].Name<>'GlobalTimer')
and (Components[i].Name<>'SozPulTimer') and (Components[i].Name<>'TankMove')
and (Components[i].Name<>'Vivod') Then Components[i].Free;
//-------------

//Выгрузить буффер
Buffer.VigruzitBuffer;
//--------------

//Удалить лэйбы и стринглисты для продолжительности бонуса
BonTip.Free;
BonTime.Free;
L6.Free;
L8.Free;
L10.Free;
L12.Free;
L16.Free;
L18.Free;
//---------------
end;

procedure TForm1.VivodTimer(Sender: TObject);
Var i:Integer;
begin
//Фон
Buf.Canvas.CopyRect(Bounds(0,0,Pole.Width,Pole.Height), BufFon.Canvas, Bounds(0,0,BufFon.Width,BufFon.Height));
//-----

//Бонус
Buf.Canvas.Draw(BX,BY,BufBonus);
//------

//Танк
If Game='Play' then Buf.Canvas.Draw(TX,TY,BufTank);
//-------

//Рисуем броню
IF Neujazvimost=True Then
Begin
Case TNap of
  1: BufBronja.Canvas.CopyRect(Bounds(0,0,BrW,BrH), BufBronjas.Canvas,Bounds((TNap-1)*BrW,0,BrW,BrH));
  2: BufBronja.Canvas.CopyRect(Bounds(0,0,BrW,BrH), BufBronjas.Canvas,Bounds((TNap-1)*BrW,0,BrW,BrH));
  3: BufBronja.Canvas.CopyRect(Bounds(0,0,BrW,BrH), BufBronjas.Canvas,Bounds((TNap-1)*BrW,0,BrW,BrH));
  4: BufBronja.Canvas.CopyRect(Bounds(0,0,BrW,BrH), BufBronjas.Canvas,Bounds((TNap-1)*BrW,0,BrW,BrH));
end;
Buf.Canvas.Draw(TX,TY,BufBronja);
end;
//------------

//Выод взорваного танка
If Game='End' then Buf.Canvas.Draw(TX,TY,BufVzorTank);
//------

//Взрыв
For i:=0 to VzrNom.Count-1 do
  Buf.Canvas.Draw(StrToInt(VzrX.Strings[i]),StrToInt(VzrY.Strings[i]),BufVzriv);;
//-----

//Пули
For i:=0 to PulNom.Count-1 do
Begin
  Case StrToInt(PulName.Strings[i]) of
    11: Buf.Canvas.Draw(StrToInt(Pulx.Strings[i]),StrToInt(Puly.Strings[i]),buf11);
    12: Buf.Canvas.Draw(StrToInt(Pulx.Strings[i]),StrToInt(Puly.Strings[i]),buf12);
    13: Buf.Canvas.Draw(StrToInt(Pulx.Strings[i]),StrToInt(Puly.Strings[i]),buf13);
    14: Buf.Canvas.Draw(StrToInt(Pulx.Strings[i]),StrToInt(Puly.Strings[i]),buf14);
    21: Buf.Canvas.Draw(StrToInt(Pulx.Strings[i]),StrToInt(Puly.Strings[i]),buf21);
    22: Buf.Canvas.Draw(StrToInt(Pulx.Strings[i]),StrToInt(Puly.Strings[i]),buf22);
    23: Buf.Canvas.Draw(StrToInt(Pulx.Strings[i]),StrToInt(Puly.Strings[i]),buf23);
    24: Buf.Canvas.Draw(StrToInt(Pulx.Strings[i]),StrToInt(Puly.Strings[i]),buf24);
    31: Buf.Canvas.Draw(StrToInt(Pulx.Strings[i]),StrToInt(Puly.Strings[i]),buf31);
    32: Buf.Canvas.Draw(StrToInt(Pulx.Strings[i]),StrToInt(Puly.Strings[i]),buf32);
    33: Buf.Canvas.Draw(StrToInt(Pulx.Strings[i]),StrToInt(Puly.Strings[i]),buf33);
    34: Buf.Canvas.Draw(StrToInt(Pulx.Strings[i]),StrToInt(Puly.Strings[i]),buf34);
    41: Buf.Canvas.Draw(StrToInt(Pulx.Strings[i]),StrToInt(Puly.Strings[i]),buf41);
    42: Buf.Canvas.Draw(StrToInt(Pulx.Strings[i]),StrToInt(Puly.Strings[i]),buf42);
    43: Buf.Canvas.Draw(StrToInt(Pulx.Strings[i]),StrToInt(Puly.Strings[i]),buf43);
    44: Buf.Canvas.Draw(StrToInt(Pulx.Strings[i]),StrToInt(Puly.Strings[i]),buf44);
  end;
end;
//------

//Вывести на экран
Pole.Canvas.Draw(0,0,Buf);
//--------
end;

procedure TForm1.StartClick(Sender: TObject);
var i:Integer;
begin
//Удалить старые объекты
If Game='End' then FindComponent('TimeEnd').Free;
//останавливаем таймеры
GlobalTimer.Enabled:=False;
SozPulTimer.Enabled:=False;
TankMove.Enabled:=False;
Vivod.Enabled:=False;
UvelOchkiTimer.Enabled:=False;
//Удалить динамически созданные таймеры
For I:=ComponentCount-1 Downto 0 do
If (Components[i] is TTimer) and (Components[i].Name<>'GlobalTimer')
and (Components[i].Name<>'SozPulTimer') and (Components[i].Name<>'TankMove')
and (Components[i].Name<>'Vivod') and(Components[i].Name<>'UvelOchkiTimer') Then Components[i].Free;
//-------------
//----------------
PulNom.Clear;
PulName.Clear;
PulX.Clear;
PulY.Clear;
PulW.Clear;
PulH.Clear;
PulNap.Clear;
VzrX.Clear;
VzrY.Clear;
VzrNom.Clear;
//Очиститьлэйбы и стринглисты для продолжительности бонуса
BonTip.Clear;
BonTime.Clear;
L6.Visible:=False;
L8.Visible:=False;
L10.Visible:=False;
L12.Visible:=False;
L16.Visible:=False;
L18.Visible:=False;
//---------------
//-----------------

//Начальные параметры игры
Game:='Play';
GlobalTime:=0;
OldGlobalTime:=0;
Uroven:=1;
NomerPul:=0;
PulShag:=1;
NomerVzr:=0;
VzrPolW:=Round(BufVzriv.Width/2);
VzrPolH:=Round(BufVzriv.Height/2);
TVzorNomkadr:=1;
TVzorKolKadr:=2;
KolSozPul:=1;
MaxKolPulPole:=0;
Och:=0;
OchMax:=0;
//----------------------

//Начальные параметры Танка
TW:=BufTank.Width;
TH:=BufTank.Height;
TX:=Round(Pole.Width/2-TW/2);
TY:=Round(Pole.Height/2-TH/2);
TNap:=1;
TShag:=1;
TKadr:=1;
TKolKadr:=4;
BufTank.Canvas.CopyRect(Bounds(0,0,TW,TH),BufTanks.Canvas,Bounds(0,0,TW,TH));
TJ:=100;
TJMax:=100;
//----------------------

//Начальные параметры брони
BrW:=TW;
BrH:=TH;
//-------------------

//Начальные параметры Бонуса
BW:=BufBonus.Width;
BH:=BufBonus.Height;
BX:=Random(Pole.Width-BW);
BY:=Random(Pole.Height-BH);
BTip:=0;
//-------------------

//Значения бонусов
UmenKolPul:=0;
ZamSozPul:=0;
SpeedTank:=False;
Neujazvimost:=False;
ZamedSozdPul:=False;
OstonSozdPul:=False;
PuliPuli:=False;
Zamorozka:=False;
//----------------------

//Запустить таймеры
GlobalTimer.Enabled:=True;
SozPulTimer.Enabled:=True;
UvelOchkiTimer.Enabled:=True;
//-----------------

//Заблокировать кнопку
Start.Enabled:=False;
Opublicovat.Enabled:=False;
//------------

//Активировать Паузу
Pause.Enabled:=true;
//--------------

//Запусть обновление картинки
Vivod.Enabled:=True;
//-------------

//Вывести нулевые значения на экран
LTJ.Caption:=IntToStr(TJ);
LTJMax.Caption:=IntToStr(TJMax);
StatusBar.Panels[0].Text:='Время '+IntToStr(GlobalTime)+' c';
StatusBar.Panels[1].Text:='Кол. пуль на поле '+IntToStr(PulNom.Count)+' шт';
StatusBar.Panels[2].Text:='Мах. кол. пуль на поле 0 шт';
StatusBar.Panels[3].Text:='Кол. всех пуль '+IntToStr(NomerPul)+' шт';
StatusBar.Panels[4].Text:='Уровень '+IntToStr(Uroven);
LBonus.Caption:='';
LOchki.Caption:='0';
//-------------

//Звук Старта
BASS_ChannelPlay(SoundStartGame, False);
//----------------
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
IF Game='Play' then
  begin
  If Key=Vk_UP then
    Begin TNap:=1; TankMove.Enabled:=True; BASS_ChannelPlay(SoundMove, False);end
    else If Key=Vk_Right then
      Begin TNap:=2; TankMove.Enabled:=True; BASS_ChannelPlay(SoundMove, False);end
      else If Key=Vk_Down then
        Begin TNap:=3; TankMove.Enabled:=True; BASS_ChannelPlay(SoundMove, False);end
        else If Key=Vk_Left then
          Begin TNap:=4; TankMove.Enabled:=True; BASS_ChannelPlay(SoundMove, False);end;

  end;
end;

procedure TForm1.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
If Game='Play' then
  If (Key=Vk_UP) or  (Key=Vk_Right) or (Key=Vk_Down) or (Key=Vk_Left) then
    Begin
    TankMove.Enabled:=False;
    BASS_ChannelPause(SoundMove);
    end;
end;

procedure TForm1.TankMoveTimer(Sender: TObject);
begin
//Движение танка
Case TNap of
 1: if TY>0 then TY:=TY-TShag;
 2: if TX+TW<Pole.Width then TX:=TX+TShag;
 3: If TY+TH<Pole.Height then TY:=TY+TShag;
 4: If TX>0 then TX:=TX-TShag;
end;
//---------------------

//Мультик танка
Case TNap of
  1: BufTank.Canvas.CopyRect(Bounds(0,0,TW,TH), BufTanks.Canvas,Bounds((TKadr-1)*TW,(TNap-1)*TH,TW,TH));
  2: BufTank.Canvas.CopyRect(Bounds(0,0,TW,TH), BufTanks.Canvas,Bounds((TKadr-1)*TW,(TNap-1)*TH,TW,TH));
  3: BufTank.Canvas.CopyRect(Bounds(0,0,TW,TH), BufTanks.Canvas,Bounds((TKadr-1)*TW,(TNap-1)*TH,TW,TH));
  4: BufTank.Canvas.CopyRect(Bounds(0,0,TW,TH), BufTanks.Canvas,Bounds((TKadr-1)*TW,(TNap-1)*TH,TW,TH));
end;
inc(TKadr);
If TKadr=TKolKadr+1 then TKadr:=1;
//---------------

//Столкновение с бонусом
IF (BY+BH-2>TY)and(BY<TY+TH)and(BX+BW-2>TX)and(BX+2<TX+TW) then
  Begin
  BX:=Random(Pole.Width-BW)+1;
  BY:=Random(Pole.Height-BH)+1;
  OldBonusTime:=GlobalTime;
  BonusSozd;
  UvelichitOchki(7);
  end;
//------------
end;

procedure TForm1.GlobalTimerTimer(Sender: TObject);
begin
// Увеличить время игры на 1 секунду
Inc(GlobalTime);
UvelichitOchki(5);
//Вывести новое значение в статус баре
StatusBar.Panels[0].Text:='Время '+IntToStr(GlobalTime)+' c';
//Увеличение уровня
If GlobalTime=(OldGlobalTime+Round(15+(Uroven-1)*3)) then
  begin
  OldGlobalTime:=GlobalTime;
  Inc(Uroven);
  UvelichitOchki(6);
  KolSozPul:=1+((Uroven-1) div 2)-UmenKolPul;
  //Вывести новое значение уровня в статус баре
  StatusBar.Panels[4].Text:='Уровень '+IntToStr(Uroven);
  SozPulTimer.Interval:=1500-(Uroven div 2)*100+ZamSozPul;
  end;
//Появление бонуса по времени
If GlobalTime=10+OldBonusTime+Uroven-3 then
Begin
OldBonusTime:=GlobalTime;
BX:=Random(Pole.Width-BW)+1;
BY:=Random(Pole.Height-BH)+1;
end;
//отнять секунду у бонусов
OtnjatTimeBon;
//-----------
end;

function TForm1.OprTipPuli(Urov:Integer):Integer;
var x,p2,p3,p4:Integer;
Begin
p2:=Round((Urov-1)*10/2); //v 30% sluchja ot ostatka
p3:=Round((Urov-1)*10/3); //v 20% sluchja ot ostatka
p4:=Round((Urov-1)*10/6); //v 10% sluchja ot ostatka
x:=Random(100)+1;
if x<=100-p2-p3-p4 then
  result:=1
  else If x<=100-p3-p4 then
    result:=2
    else If x<=100-p4 then
      result:=3
      else result:=4;
end;

procedure TForm1.SozPulTimerTimer(Sender: TObject);
Var PulTip,Napravlenie:Integer; Imja:String; i:Integer; X,Y,W,H:Integer;
begin
For i:=0 to KolSozPul do
  Begin
  inc(NomerPul);
  PulTip:=OprTipPuli(Uroven);
  UvelichitOchki(PulTip);
  Napravlenie:=(Random(800) div 200)+1;
  Imja:=IntToStr(PulTip)+IntToStr(Napravlenie);
  //Размеры пули
  Case StrToInt(Imja) of
    11: Begin W:=6; H:=10; end; //V Verh
    12: Begin W:=10; H:=6; end; // V Levo
    13: Begin W:=6; H:=10; end; //V Niz
    14: Begin W:=10; H:=6; end; //V Npravo
    21: Begin W:=8; H:=14; end; //V Verh
    22: Begin W:=14; H:=8; end; // V Levo
    23: Begin W:=8; H:=14; end; //V Niz
    24: Begin W:=14; H:=8; end; //V Npravo
    31: Begin W:=10; H:=18; end; //V Verh
    32: Begin W:=18; H:=10; end; // V Levo
    33: Begin W:=10; H:=18; end; //V Niz
    34: Begin W:=18; H:=10; end; //V Npravo
    41: Begin W:=12; H:=22; end; //V Verh
    42: Begin W:=22; H:=12; end; // V Levo
    43: Begin W:=12; H:=22; end; //V Niz
    44: Begin W:=22; H:=12; end; //V Npravo
  end;
  //------------
  //Координаты создания пули
  Case Napravlenie of
    1: Begin x:=Random(Pole.Width-10)+5; y:=Pole.Height+1;end; //V Verh
    2: Begin x:=-W-1; y:=Random(Pole.Height-10)+5; end; // V Levo
    3: Begin x:=Random(Pole.Width-10)+5; y:=-H-1; end; //V Niz
    4: Begin x:=Pole.Width+1; y:=Random(Pole.Height-10)+22; end; //V Npravo
  end;
  //-----------
  //Записываем дынне пули в Стинглист
  PulNom.Add('TimeP'+IntToStr(NomerPul));
  PulName.Add(Imja);
  PulX.Add(IntTostr(X));
  PulY.Add(IntTostr(Y));
  PulW.Add(IntTostr(W));
  PulH.Add(IntTostr(H));
  PulNap.Add(IntTostr(Napravlenie));
  //------------
  //Создаем таймер движения для пули
  Time:=TTimer.Create(Self);
  Case PulTip of
    1: Time.Interval:=25;
    2: Time.Interval:=30;
    3: Time.Interval:=35;
    4: Time.Interval:=40;
  end;
  Time.OnTimer:=DvijeniePuli;
  Time.Name:='TimeP'+IntToStr(NomerPul);
  //------------
  end;
//Считаем максимальное количество пуль на поле
If PulNom.Count>MaxKolPulPole then MaxKolPulPole:=PulNom.Count;
//---------------
//Вывести Количество пуль
StatusBar.Panels[1].Text:='Кол. пуль на поле '+IntToStr(PulNom.Count)+' шт';
StatusBar.Panels[2].Text:='Мах. кол. пуль на поле '+IntToStr(MaxKolPulPole)+' шт';
StatusBar.Panels[3].Text:='Кол. всех пуль '+IntToStr(NomerPul)+' шт';
//-------------
end;

function TForm1.Vilet(index,x,y,w,h,nap:Integer):Boolean;
Begin
Case Nap of
  1: If (y<-h-1) then Begin UdalitPulIndex(index); Result:=True; Exit; end;
  2: If (x>(Pole.Width+1)) then Begin UdalitPulIndex(index); Result:=True; Exit; end;
  3: If (y>(Pole.Height+1)) then Begin UdalitPulIndex(index); Result:=True; Exit; end;
  4: If (x<-w-1) then Begin UdalitPulIndex(index); Result:=True; Exit; end;
end;
Result:=False;
end;

function TForm1.PulTank(index,x,y,w,h,nap:Integer):Boolean;
Begin
IF (y+h-2>TY)and(y<TY+TH)and(x+w-2>TX)and(x+2<TX+TW) then
  begin
  //Отнять жизни танка
  If Neujazvimost=False Then
  OynjatJiznTanka(StrToInt(Copy(PulName.Strings[index],0,1)));
  //Создать взрыв
  VzrivKoord(x,y,w,h,TX,TY,TW,TH);
  //Удалить пулю
  UdalitPulIndex(index);
  Result:=True;
  exit;
  end;
Result:=False;
end;

procedure TForm1.DvijeniePuli(Sender: TObject);
Var Imja:String; i,index,X,Y,W,H,Nap:Integer; PulNaydena:Boolean;
Begin
//Ищем индекс пули по порядку
PulNaydena:=False;
Imja:=(Sender as TTimer).Name;
For i:=0 to PulNom.Count-1 do
  Begin
    If PulNom.Strings[i]=Imja then
      begin
      index:=i;
      PulNaydena:=True;
      Break;
      end;
  end;
//---------------
If PulNaydena=True then
  begin
  //Перемещаем пулю
  If Zamorozka=False then
    begin
    x:=StrToInt(Pulx.Strings[index]);
    y:=StrToInt(Puly.Strings[index]);
    Case StrToInt(Pulnap.Strings[index]) of
      1:Puly.Strings[index]:=IntToStr(y-PulShag);
      2:Pulx.Strings[index]:=IntToStr(x+PulShag);
      3:Puly.Strings[index]:=IntToStr(y+PulShag);
      4:Pulx.Strings[index]:=IntToStr(x-PulShag);
    end;
    end;
  //-------------

  //Проверка на столкновение и вылет
  x:=StrToInt(Pulx.Strings[index]);
  y:=StrToInt(Puly.Strings[index]);
  w:=StrToInt(Pulw.Strings[index]);
  h:=StrToInt(Pulh.Strings[index]);
  nap:=StrToInt(Pulnap.Strings[index]);
  If Vilet(index,x,y,w,h,nap)=True then
    begin
    StatusBar.Panels[1].Text:='Кол. пуль на поле '+IntToStr(PulNom.Count)+' шт';
    Exit;
    end;
  If Game='Play' then
    Begin
    If PulTank(index,x,y,w,h,nap)=True then
      begin
      StatusBar.Panels[1].Text:='Кол. пуль на поле '+IntToStr(PulNom.Count)+' шт';
      Exit;
      end;
    end;
  If PuliPuli=True then StolkPuliPuli(Index);
  end;
end;


Procedure TForm1.UdalitPulIndex(index:Integer);
Begin
FindComponent(PulNom.Strings[index]).Free;
PulNom.Delete(index);
PulName.Delete(index);
PulX.Delete(index);
PulY.Delete(index);
PulW.Delete(index);
PulH.Delete(index);
PulNap.Delete(index);
end;

Procedure TForm1.VzrivKoord(x1,y1,w1,h1,x2,y2,w2,h2:Integer);
Var vx,vw,vy,vh:integer;
Begin
If (x1<x2) and (x1+w1<x2+w2) Then
    Begin
    vx:=x2;
    vw:=x1+w1-x2;
    end
    else If (x1>x2) and (x1+w1>x2+x2) Then
      Begin
      vx:=x1;
      vw:=x2+w2-x1;
      end
      else
        Begin
        vx:=x1;
        vw:=w1;
        end;
If (y1<y2) and (y1+h1<y2+h2) Then
  Begin
  vy:=y2;
  vh:=y1+h1-y2;
  end
  else If (y1>y2) and (y1+h1>y2+h2) Then
    Begin
    vy:=y1;
    vh:=y2+h2-y1;
    end
    else
      Begin
      vy:=y1;
      vh:=h1;
      end;
VzrivSozdat(Round(vx+vw/2),Round(vy+vh/2));
end;

Procedure TForm1.VzrivSozdat(x,y:Integer);
Begin
//Звук взрыва
BASS_ChannelPlay(SoundVzriv, False);
//----------
inc(NomerVzr);
VzrNom.Add('TimeV'+IntToStr(NomerVzr));
VzrX.Add(IntToStr(x-VzrPolW));
VzrY.Add(IntToStr(y-VzrPolH));
Time:=TTimer.Create(Self);
Time.Enabled:=True;
Time.Interval:=100;
Time.OnTimer:=UdalitVzrTimer;
Time.Name:='TimeV'+IntToStr(NomerVzr);
end;

Procedure TForm1.UdalitVzrTimer(Sender: TObject);
Var Imja:String; i:Integer;
Begin
Imja:=(Sender as TTimer).Name;
For i:=0 to VzrNom.Count-1 do
  Begin
  If VzrNom.Strings[i]=Imja then
    begin
    Sender.Free;
    VzrNom.Delete(i);
    VzrX.Delete(i);
    VzrY.Delete(i);
    Exit;
    end;
  end;
end;

Procedure TForm1.OynjatJiznTanka(TipPuli:Integer);
Begin
Case TipPuli of
  1: TJ:=TJ-10;
  2: TJ:=TJ-15;
  3: TJ:=TJ-25;
  4: TJ:=TJ-35;
end;

If TJ<=0 then
 Begin
 TJ:=0;
 KonecIgri;
 end;
//Вывести значения жин
LTJ.Caption:=IntToStr(TJ);
end;

Procedure TForm1.KonecIgri;
Begin
Game:='End';
//остновить таймеры
GlobalTimer.Enabled:=False;
TankMove.Enabled:=False;
SozPulTimer.Enabled:=False;
//-----------
//Отключить звук движения танка
BASS_ChannelPause(SoundMove);
//----------------
//Звук взорваного танка
BASS_ChannelPlay(SoundEnd,False);
BASS_ChannelPlay(SoundEndGame,False);
//----------------
//Создать взорваный танк и его таймер
BufVzorTank.Canvas.CopyRect(Bounds(0,0,TW,TH), BufVzorTanks.Canvas,Bounds(0,(TNap-1)*TH,TW,TH));
BufTank.Canvas.Draw(0,0,BufVzorTank);
Time:=TTimer.Create(Self);
Time.Enabled:=True;
Time.Interval:=200;
Time.OnTimer:=MultEnd;
Time.Name:='TimeEnd';
//-------------------

//Активировать кнопку
Start.Enabled:=True;
Pause.Enabled:=False;
//Opublicovat.Enabled:=True;   Кнопку убрал публикация автоматически запускается
Opublicovat.OnClick(Self);
//-----------
end;

Procedure TForm1.MultEnd(Sender:TObject);
Begin
BufVzorTank.Canvas.CopyRect(Bounds(0,0,TW,TH), BufVzorTanks.Canvas,Bounds((TVzorNomkadr-1)*TW,(TNap-1)*TH,TW,TH));
inc(TVzorNomkadr);
If TVzorNomkadr=TVzorKolKadr+1 then TVzorNomkadr:=1;
end;

Procedure TForm1.StolkPuliPuli(Index:Integer);
Var x,y,w,h,i,j,x2,y2,w2,h2:Integer; N,N2:String;
Begin
x:=StrToInt(PulX.Strings[Index]);
y:=StrToInt(PulY.Strings[Index]);
w:=StrToInt(PulW.Strings[Index]);
h:=StrToInt(PulH.Strings[Index]);
For i:=PulNom.Count-1 downto 0 do
  Begin
  If i<>Index then
    Begin
    x2:=StrToInt(PulX.Strings[i]);
    y2:=StrToInt(PulY.Strings[i]);
    w2:=StrToInt(PulW.Strings[i]);
    h2:=StrToInt(PulH.Strings[i]);
    If (y+h>y2)and(y<y2+h2)and
    (x+w>x2)and(x<x2+w2) then
      Begin
      //Вычисляем координты взрыва
      VzrivSozdat(Round(x+w/2),Round(y+h/2));
      VzrivSozdat(Round(x2+w2/2),Round(y2+h2/2));
      //---------------
      N:=pulNom.Strings[index];
      n2:=pulNom.Strings[i];
      FindComponent('n').Free;
      FindComponent('n2').Free;
      PulNom.Delete(index);
      PulName.Delete(index);
      PulX.Delete(index);
      PulY.Delete(index);
      PulW.Delete(index);
      PulH.Delete(index);
      PulNap.Delete(index);
      For j:=PulNom.Count-1 downto 0 do
        begin
        If PulNom.Strings[j]=n2 then
          begin
          PulNom.Delete(j);
          PulName.Delete(j);
          PulX.Delete(j);
          PulY.Delete(j);
          PulW.Delete(j);
          PulH.Delete(j);
          PulNap.Delete(j);
          end;
        end;
      StatusBar.Panels[1].Text:='Кол. пуль на поле '+IntToStr(PulNom.Count)+' шт';
      exit;
      end;
    end;
  end;
end;

Procedure TForm1.BonusSozd;
Var Tip:Integer; Stop:Boolean; i:Integer; TimerBonusa:TTimer;
Begin
//Звук бонуса
BASS_ChannelPlay(SoundBonus, False);
//------------
//Определяем тип бонуса
Stop:=False;
repeat
Tip:=Random(19)+1;
Case Tip Of
  1..3: If TJ<>TJMax then Stop:=True
  else Stop:=False;
  4,5,6,8..19: Stop:=True;
  7: If KolSozPul>1 Then Stop:=True else Stop:=False;
End;
until Stop=True;
//-------------------

//Вывести информацию о бонусе на экран
case Tip of
  1: LBonus.Caption:='Броня +30';
  2: LBonus.Caption:='Броня +60';
  3: LBonus.Caption:='Броня полностью восстановлена';
  4: LBonus.Caption:='Уровень брони +25';
  5: LBonus.Caption:='Уровень брони +50';
  6: LBonus.Caption:='Скосрость увеличена на 10с.';
  7: LBonus.Caption:='Кол. создаваемых пуль уменьшено';
  8: LBonus.Caption:='Неуязвимость 6c';
  9: LBonus.Caption:='Неуязвимость 10c';
  10: LBonus.Caption:='Создание пуль замедлено 15c';
  11: LBonus.Caption:='Создание пуль замедлено 25c';
  12: LBonus.Caption:='Создание пуль остановлено 8c';
  13: LBonus.Caption:='Уничтожение пуль в периметре 250х250';
  14: LBonus.Caption:='Уничтожение пуль в периметре 350х350';
  15: LBonus.Caption:='Уничтожены все пули';
  16: LBonus.Caption:='Пули уничтожают друг друга 10c';
  17: LBonus.Caption:='Пули уничтожают друг друга 15c';
  18: LBonus.Caption:='Пули заморожены 6c';
  19: LBonus.Caption:='Пули заморожены 10c';
end;
//-------------------

//Операция под выбраный тип бонуса
Case Tip Of
  1: Begin If TJ+30>TJMax Then TJ:=TJMax else TJ:=TJ+30; LTJ.Caption:=IntToStr(TJ); end;
  2: Begin If TJ+60>TJMax Then TJ:=TJMax else TJ:=TJ+60; LTJ.Caption:=IntToStr(TJ); end;
  3: Begin TJ:=TJMax; LTJ.Caption:=IntToStr(TJ); end;
  4: Begin TJMax:=TJMax+25; LTJMax.Caption:=IntToStr(TJMax); end;
  5: Begin TJMax:=TJMax+50; LTJMax.Caption:=IntToStr(TJMax); end;
  6: If SpeedTank=False then
      Begin
      TankMove.Interval:=10;
      SpeedTank:=True;
      ZapListBon(6,10,False);
      end
      Else ZapListBon(6,10,True);
  7: Begin inc(UmenKolPul); KolsozPul:=KolsozPul-1; end;
  8: If Neujazvimost=False then
      Begin
      Neujazvimost:=True;
      ZapListBon(8,6,False);
      end
      Else ZapListBon(8,6,True);
  9: If Neujazvimost=False then
      Begin
      Neujazvimost:=True;
      ZapListBon(8,10,False);
      end
      Else ZapListBon(8,10,True);
  10: If ZamedSozdPul=False then
      Begin
      ZamedSozdPul:=True;
      ZamSozPul:=1000;
      SozPulTimer.Interval:=SozPulTimer.Interval+1000;
      ZapListBon(10,15,False);
      end
      Else ZapListBon(10,15,True);
  11: If ZamedSozdPul=False then
      Begin
      ZamedSozdPul:=True;
      ZamSozPul:=1000;
      SozPulTimer.Interval:=SozPulTimer.Interval+1000;
      ZapListBon(10,25,False);
      end
      Else ZapListBon(10,25,True);
  12: If OstonSozdPul=False then
      Begin
      OstonSozdPul:=True;
      SozPulTimer.Enabled:=False;
      ZapListBon(12,8,False);
      end
      Else ZapListBon(12,8,True);
  13: Perimetr (Round(200/2));
  14: Perimetr (Round(350/2));
  15: Perimetr (500);
  16: If PuliPuli=False then
      Begin
      PuliPuli:=True;
      ZapListBon(16,10,False);
      end
      Else ZapListBon(16,10,True);
  17: If PuliPuli=False then
      Begin
      PuliPuli:=True;
      ZapListBon(16,15,False);
      end
      Else ZapListBon(16,15,True);
  18: If Zamorozka=False then
      Begin
      Zamorozka:=True;
      SozPulTimer.Enabled:=False;
      ZapListBon(18,6,False);
      end
      Else ZapListBon(18,6,True);
  19: If Zamorozka=False then
      Begin
      Zamorozka:=True;
      SozPulTimer.Enabled:=False;
      ZapListBon(18,10,False);
      end
      Else ZapListBon(18,10,True);
end;
//-----------------
end;

Procedure TForm1.Perimetr (Per:Integer);
var index:Integer; x,xw,y,yh,x2,w2,y2,h2:Integer;
Begin
//Кординаты периметра
x:=TX-Per;
xw:=TX+TW+Per;
y:=TY-Per;
yh:=TY+TH+Per;
//--------------------
//Находим и удаляем пули в периметре
For index:=PulNom.Count-1 downto 0  do
  Begin
  x2:=StrToInt(PulX.Strings[index]);
  w2:=StrToInt(PulW.Strings[index]);
  y2:=StrToInt(PulY.Strings[index]);
  h2:=StrToInt(PulH.Strings[index]);
  IF (y2+h2>y)and (y2<yh)and(x2+w2>x)and(x2<xw)then
    begin
    //Определяем координаты взрыва,Создаем взрыв
    VzrivSozdat(Round(x2+w2/2),Round(y2+h2/2));
    //Удалить пулю и ее таймер и отнять от количества пуль
    UdalitPulIndex(index);
    end;
  end;
//-----------------------
end;

procedure TForm1.PauseClick(Sender: TObject);
var i:Integer;
begin
If Game='Play' then
  Begin
  LPause.Left:=Round(Pole.Width/2-LPause.Width/2);
  LPause.Top:=Round(Pole.Height/2-LPause.Height/2);
  LPause.Visible:=true;
  Pause.Caption:='ПРОДОЛЖИТЬ';
  Game:='Pause';
  GlobalTimer.Enabled:=False;
  SozPulTimer.Enabled:=False;
  TankMove.Enabled:=False;
  Vivod.Enabled:=False;
  For i:=ComponentCount-1 Downto 0 do
  If (Components[i] is TTimer) and (Components[i].Name<>'GlobalTimer')
  and (Components[i].Name<>'SozPulTimer') and (Components[i].Name<>'TankMove')
  and (Components[i].Name<>'Vivod') Then (Components[i] as TTimer).Enabled:=False;
  BASS_ChannelPlay(SoundPause, False);
  end
  else If Game='Pause' then
  Begin
    LPause.Visible:=False;
    Pause.Caption:='ПАУЗА';
    Game:='Play';
    GlobalTimer.Enabled:=True;
    SozPulTimer.Enabled:=True;
    Vivod.Enabled:=True;
    For i:=ComponentCount-1 Downto 0 do
    If (Components[i] is TTimer) and (Components[i].Name<>'GlobalTimer')
    and (Components[i].Name<>'SozPulTimer') and (Components[i].Name<>'TankMove')
    and (Components[i].Name<>'Vivod') Then (Components[i] as TTimer).Enabled:=True;
    BASS_ChannelPlay(SoundPauseEnd, False);
  end;
end;

Procedure TForm1.PostroitKArtu; //создаем карту
var i,j,x,y,k,n:Integer;
Begin
BASS_ChannelPlay(SoundKarta, False);
BufFons:=TBitmap.Create;
BufFons.Width:=400;
BufFons.Height:=50;
BufFons.LoadFromFile('Data\Fon.bmp');
//Заполняем карту только травой
For i:=0 to Round(Pole.Width/50) do begin
  For j:=0 to Round(Pole.Height/50) do begin
  BufFon.Canvas.CopyRect(Bounds(i*50,j*50,50,50), BufFons.Canvas,Bounds(0,0,50,50));
  end;
end;
//Добавляем на карту разные элеметы
n:=random(10)+25; //количесвто элементов
For i:=0 to n do begin
 x:=Random(Round(Pole.Width/50)+1);//положение элемента по х
 y:=Random(Round(Pole.Height/50)+1);//положение элемента по у
 k:=Random(7)+1;//выбираем элемент
 BufFon.Canvas.CopyRect(Bounds(x*50,y*50,50,50), BufFons.Canvas,Bounds(k*50,0,50,50));
end;
//Вывести карту на экран
Pole.Canvas.Draw(0,0,BufFon);
//--------------
BufFons.Free;
end;

procedure TForm1.KartaClick(Sender: TObject);
begin
PostroitKArtu;
end;

procedure TForm1.ZapListBon(Tip,Time:Integer;Povtor:Boolean);
var i:integer;
Begin
If Povtor=False Then
  Begin
    BonTip.Add(IntToStr(Tip));
    BonTime.Add(IntToStr(Time));
  end
  else
  Begin
    For i:=BonTip.Count-1 downTo 0 do
      Begin
      If BonTip.Strings[i]=IntToStr(Tip) then
        BonTime.Strings[i]:=IntToStr(StrToInt(BonTime.Strings[i])+Time);
      end;
  end;
VivestiVremjaBon;
end;

procedure TForm1.VivestiVremjaBon;
Var i:Integer;
Begin
L6.Visible:=False;
L8.Visible:=False;
L10.Visible:=False;
L12.Visible:=False;
L16.Visible:=False;
L18.Visible:=False;

For i:=0 To BonTip.Count-1 do
  Begin
  Case StrToInt(BonTip.Strings[i]) of
    6:Begin
      L6.Caption:='Скорость '+BonTime.Strings[i]+'c';
      L6.Left:=8;
      L6.Top:=18+L6.Height*i+3*i;
      L6.Visible:=True;
      end;
    8:Begin
      L8.Caption:='Неуязвимость '+BonTime.Strings[i]+'c';
      L8.Left:=8;
      L8.Top:=18+L6.Height*i+3*i;
      L8.Visible:=True;
      end;
    10:Begin
      L10.Caption:='Замед. созд. пуль '+BonTime.Strings[i]+'c';
      L10.Left:=8;
      L10.Top:=18+L6.Height*i+3*i;
      L10.Visible:=True;
      end;
    12:Begin
      L12.Caption:='Ост. созд. пуль '+BonTime.Strings[i]+'c';
      L12.Left:=8;
      L12.Top:=18+L6.Height*i+3*i;
      L12.Visible:=True;
      end;
    16:Begin
      L16.Caption:='Пули унич. пули '+BonTime.Strings[i]+'c';
      L16.Left:=8;
      L16.Top:=18+L6.Height*i+3*i;
      L16.Visible:=True;
      end;
    18:Begin
      L18.Caption:='Заморозка пуль '+BonTime.Strings[i]+'c';
      L18.Left:=8;
      L18.Top:=16+L6.Height*i+3*i;
      L18.Visible:=True;
      end;
  end;
  end;
end;

Procedure TForm1.OtnjatTimeBon;
var i:Integer;
begin
For i:=BonTip.Count-1 DownTo 0 do
  Begin
  BonTime.Strings[i]:=IntToStr(StrToInt(BonTime.Strings[i])-1);
  IF StrToInt(BonTime.Strings[i])=0 Then UdalitTimeBon(StrToInt(BonTip.Strings[i]));
  end;
VivestiVremjaBon;
end;

procedure TForm1.UdalitTimeBon(Tip:Integer);
var i:Integer;
begin
For i:=BonTip.Count-1 downTo 0 do
  Begin
  If BonTip.Strings[i]=IntToStr(Tip) then
    Begin
    BonTime.Delete(i);
    BonTip.Delete(i);
    end;
  end;

Case Tip of
  6: Begin
     SpeedTank:=False;
     TankMove.Interval:=16;
     end;
  8: Begin
     Neujazvimost:=False;
     end;
  10: Begin ZamedSozdPul:=False;
      ZamSozPul:=0;
      SozPulTimer.Interval:=SozPulTimer.Interval-1000;
      end;
  12: Begin
      OstonSozdPul:=False;
      If Zamorozka=False Then SozPulTimer.Enabled:=True;
      end;
  16: Begin
      PuliPuli:=False;
      end;
  18: Begin
      Zamorozka:=False;
      If OstonSozdPul=False Then SozPulTimer.Enabled:=True;
      end;
end;
end;

procedure TForm1.NastroyClick(Sender: TObject);
begin
If Game='Play' then PauseClick(Sender);
Nastroyki.ShowModal;
end;

procedure TForm1.UvelichitOchki(Tip:Integer);
Var Uv:Integer;
Begin
Case tip Of
  1:Uv:=2; //Пуля 1
  2:Uv:=3; //Пуля 2
  3:Uv:=4; //Пуля 3
  4:Uv:=5; //Пуля 4
  5:Uv:=1; //За 1 секунду
  6:Uv:=25; //За 1 уровень
  7:Uv:=15; //За взятый бонус
end;
OchMax:=OchMax+Uv;
end;

procedure TForm1.UvelOchkiTimerTimer(Sender: TObject);
begin
If Och+1<=OchMax Then
Begin
Och:=Och+1;
LOchki.Caption:=IntToStr(Och);
Application.ProcessMessages;
end;

If OchMax-Och>100 then
  Begin
  Och:=Och+100;
  LOchki.Caption:=IntToStr(Och);
  Application.ProcessMessages;
  end
  else If OchMax-Och>10 then
    Begin
    Och:=Och+10;
    LOchki.Caption:=IntToStr(Och);
    Application.ProcessMessages;
    end
    else If OchMax-Och>1 then
      Begin
      Och:=Och+1;
      LOchki.Caption:=IntToStr(Och);
      Application.ProcessMessages;
      end
end;

procedure TForm1.ReytinBClick(Sender: TObject);
begin
If Game='Play' then PauseClick(Sender);
Reyt.ShowModal;
end;


procedure TForm1.OpublicovatClick(Sender: TObject);
var s:String; F:TextFile;
begin
Form2.Edit1.Text:=Nik;
If Form2.ShowModal=mrOk then
  Begin
  //Подготовили строку
  s:=IntToStr(OchMax)+';'+Nik+';'+IntToStr(GlobalTime)+';'+IntToStr(Uroven)+';'+IntToStr(MaxKolPulPole)+';'+IntToStr(NomerPul)+';'+DateToStr(Date)+';';
  //Кодируем
  S:=Code_Code(s);
  //Записываем в локальный файл
  AssignFile(f,'Data\Rezult.txt');
  {$I-}
  Append(f);
  if IOResult<>0 then // не найден файл
    begin
    Rewrite(f); // Создаем
    end;
    WriteLn(f,s);
    CloseFile(f);
    Rezultat(True);
  end;
end;

Procedure TForm1.Rezultat(Global:Boolean);
Var s:String;
Begin
If Global=True then s:='опубликовано.'
else s:='неопубликовано.';
ShowMessage('Ваш результат:'+#13+#10+
            'Очки: '+PChar(IntToStr(OchMax))+#13+#10+
            'Время игры: '+PChar(IntToStr(GlobalTime))+' с.'+#13+#10+
            'Уровень: '+PChar(IntToStr(Uroven))+#13+#10+
            'Мах. количесвто пуль на поле: '+PChar(IntToStr(MaxKolPulPole))+' шт.'+#13+#10+
            'Всего создано пуль: '+PChar(IntToStr(NomerPul))+' шт.'+#13+#10+
            'В рейтинге - опубликовано.');
end;

end.
