object Nastroyki: TNastroyki
  Left = 447
  Top = 217
  BiDiMode = bdRightToLeftReadingOnly
  BorderStyle = bsToolWindow
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
  ClientHeight = 141
  ClientWidth = 223
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  ParentBiDiMode = False
  Position = poMainFormCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Volume: TGroupBox
    Left = 8
    Top = 7
    Width = 209
    Height = 122
    Caption = #1043#1088#1086#1084#1082#1086#1089#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
    TabOrder = 0
    object LMusic: TLabel
      Left = 2
      Top = 18
      Width = 205
      Height = 16
      Align = alTop
      Alignment = taCenter
      Caption = #1052#1091#1079#1099#1082#1072' 30%'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LSound: TLabel
      Left = 2
      Top = 64
      Width = 205
      Height = 16
      Align = alTop
      Alignment = taCenter
      Caption = #1047#1074#1091#1082#1080' 50%'
    end
    object BarMusic: TTrackBar
      Left = 2
      Top = 34
      Width = 205
      Height = 30
      Align = alTop
      Ctl3D = True
      Max = 100
      ParentCtl3D = False
      Frequency = 5
      Position = 30
      TabOrder = 0
      OnChange = BarMusicChange
    end
    object BarSound: TTrackBar
      Left = 2
      Top = 80
      Width = 205
      Height = 30
      Align = alTop
      Max = 100
      Frequency = 5
      Position = 50
      TabOrder = 1
      OnChange = BarSoundChange
      OnExit = BarSoundExit
    end
  end
end
