object Form2: TForm2
  Left = 314
  Top = 208
  BorderStyle = bsToolWindow
  Caption = #1053#1080#1082
  ClientHeight = 87
  ClientWidth = 203
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 109
    Height = 13
    Caption = #1053#1080#1082' ('#1076#1086' 25 '#1089#1080#1084#1074#1086#1083#1086#1074')'
  end
  object Opublic: TButton
    Left = 8
    Top = 56
    Width = 89
    Height = 25
    Caption = #1054#1087#1091#1073#1083#1080#1082#1086#1074#1072#1090#1100
    TabOrder = 0
    OnClick = OpublicClick
  end
  object Otmena: TButton
    Left = 104
    Top = 56
    Width = 91
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 1
  end
  object Edit1: TEdit
    Left = 8
    Top = 24
    Width = 185
    Height = 21
    MaxLength = 25
    TabOrder = 2
    OnKeyPress = Edit1KeyPress
  end
  object Ok: TButton
    Left = 168
    Top = 3
    Width = 27
    Height = 17
    Caption = 'Ok'
    ModalResult = 1
    TabOrder = 3
    Visible = False
  end
end
