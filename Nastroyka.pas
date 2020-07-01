unit Nastroyka;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls,bass;

type
  TNastroyki = class(TForm)
    Volume: TGroupBox;
    LMusic: TLabel;
    LSound: TLabel;
    BarMusic: TTrackBar;
    BarSound: TTrackBar;
    procedure BarMusicChange(Sender: TObject);
    procedure BarSoundChange(Sender: TObject);
    procedure Izmenitnastroykizvuka;
    procedure BarSoundExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Nastroyki: TNastroyki;

implementation

uses Osnovnoy;

{$R *.dfm}

procedure TNastroyki.BarMusicChange(Sender: TObject);
begin
Form1.VolumeMusic:=BarMusic.Position;
If BarMusic.Position=0 then LMusic.Caption:='Музыка ВЫКЛ.'
else LMusic.Caption:='Музыка '+IntToStr(BarMusic.Position)+'%';
Izmenitnastroykizvuka;
end;

procedure TNastroyki.BarSoundChange(Sender: TObject);
begin
Form1.VolumeSound:=BarSound.Position;
If BarSound.Position=0 then LSound.Caption:='Звуки ВЫКЛ.'
else LSound.Caption:='Звуки '+IntToStr(BarSound.Position)+'%';
BASS_ChannelPlay(Form1.SoundMove, False);
Izmenitnastroykizvuka;
end;

procedure TNastroyki.Izmenitnastroykizvuka;
begin
BASS_ChannelSetAttributes(Form1.SoundMusc, 44100, Form1.VolumeMusic, 0);
BASS_ChannelSetAttributes(Form1.SoundMove, 44100, Form1.VolumeSound, 0);
BASS_ChannelSetAttributes(Form1.SoundBonus, 44100, Form1.VolumeSound, 0);
BASS_ChannelSetAttributes(Form1.SoundVzriv, 44100, Form1.VolumeSound, 0);
BASS_ChannelSetAttributes(Form1.SoundEnd, 44100, Form1.VolumeSound, 0);
BASS_ChannelSetAttributes(Form1.SoundEndGame, 44100, Form1.VolumeSound, 0);
BASS_ChannelSetAttributes(Form1.SoundStartGame, 44100, Form1.VolumeSound, 0);
BASS_ChannelSetAttributes(Form1.SoundPause, 44100, Form1.VolumeSound, 0);
BASS_ChannelSetAttributes(Form1.SoundPauseEnd, 44100, Form1.VolumeSound, 0);
BASS_ChannelSetAttributes(Form1.SoundKarta, 44100, Form1.VolumeSound, 0);
end;

procedure TNastroyki.BarSoundExit(Sender: TObject);
begin
BASS_ChannelPause(Form1.SoundMove);
end;

procedure TNastroyki.FormClose(Sender: TObject; var Action: TCloseAction);
begin
BASS_ChannelPause(Form1.SoundMove);
end;

end.
