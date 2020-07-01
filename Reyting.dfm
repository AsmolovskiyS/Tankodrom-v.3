object Reyt: TReyt
  Left = 229
  Top = 168
  BorderStyle = bsToolWindow
  Caption = #1056#1077#1081#1090#1080#1085#1075
  ClientHeight = 288
  ClientWidth = 550
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object SG: TStringGrid
    Left = 0
    Top = 0
    Width = 529
    Height = 241
    BorderStyle = bsNone
    ColCount = 8
    DefaultRowHeight = 18
    FixedColor = clBtnShadow
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
    ParentColor = True
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object Local: TButton
    Left = 1
    Top = 256
    Width = 120
    Height = 25
    Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1088#1077#1081#1090#1080#1085#1075
    TabOrder = 1
    OnClick = LocalClick
  end
end
