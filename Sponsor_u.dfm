object FrmSponsor: TFrmSponsor
  Left = 0
  Top = 0
  Caption = 'Sponsor'
  ClientHeight = 250
  ClientWidth = 500
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Century Gothic'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 17
  object BtnReturn: TButton
    Left = 417
    Top = 217
    Width = 75
    Height = 25
    Caption = 'Return'
    TabOrder = 0
    OnClick = BtnReturnClick
  end
  object BtnConfirm: TButton
    Left = 8
    Top = 217
    Width = 403
    Height = 25
    Caption = 'Sponsor Racer'
    TabOrder = 1
  end
  object LabeledEdit1: TLabeledEdit
    Left = 24
    Top = 56
    Width = 121
    Height = 25
    EditLabel.Width = 83
    EditLabel.Height = 17
    EditLabel.Caption = 'LabeledEdit1'
    TabOrder = 2
  end
  object LabeledEdit2: TLabeledEdit
    Left = 168
    Top = 56
    Width = 121
    Height = 25
    EditLabel.Width = 83
    EditLabel.Height = 17
    EditLabel.Caption = 'LabeledEdit2'
    TabOrder = 3
  end
  object RichEdit1: TRichEdit
    Left = 168
    Top = 104
    Width = 185
    Height = 89
    Lines.Strings = (
      'RichEdit1')
    TabOrder = 4
  end
  object Button1: TButton
    Left = 70
    Top = 160
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 5
  end
end
