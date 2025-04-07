object Form7: TForm7
  Left = 0
  Top = 0
  Caption = 'Form7'
  ClientHeight = 159
  ClientWidth = 446
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Label1: TLabel
    Left = 32
    Top = 64
    Width = 5
    Height = 15
    Caption = '-'
  end
  object Label2: TLabel
    Left = 32
    Top = 96
    Width = 5
    Height = 15
    Caption = '-'
  end
  object Label3: TLabel
    Left = 32
    Top = 125
    Width = 5
    Height = 15
    Caption = '-'
  end
  object Edit1: TEdit
    Left = 32
    Top = 16
    Width = 121
    Height = 23
    Hint = 'type msec string'
    TabOrder = 0
    OnChange = Edit1Change
  end
end
