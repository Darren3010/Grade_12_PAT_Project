object FrmCheckout: TFrmCheckout
  Left = 0
  Top = 0
  Caption = 'Checkout'
  ClientHeight = 205
  ClientWidth = 533
  Color = clSilver
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Century Gothic'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 17
  object LblExpiryDate: TLabel
    Left = 162
    Top = 81
    Width = 93
    Height = 17
    Caption = 'Card Number:'
  end
  object BtnDonate: TButton
    Left = 162
    Top = 145
    Width = 121
    Height = 25
    Hint = 'Click here to confirm donation'
    Caption = 'Donate'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnClick = BtnDonateClick
  end
  object LblEdtName: TLabeledEdit
    Left = 24
    Top = 48
    Width = 121
    Height = 25
    Hint = 'Enter name here'
    EditLabel.Width = 118
    EditLabel.Height = 17
    EditLabel.Caption = 'Name % Surname:'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    TextHint = 'e.g. Darren Padayachee'
  end
  object LblEdtAmount: TLabeledEdit
    Left = 162
    Top = 48
    Width = 121
    Height = 25
    Hint = 'Enter the donation amount here'
    EditLabel.Width = 121
    EditLabel.Height = 17
    EditLabel.Caption = 'Donation Amount:'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    TextHint = 'e.g. 100'
  end
  object LblEdtCVC: TLabeledEdit
    Left = 24
    Top = 96
    Width = 121
    Height = 25
    Hint = 'Enter your card'#39's CVC'
    EditLabel.Width = 76
    EditLabel.Height = 17
    EditLabel.Caption = 'Card'#39's CVC'
    MaxLength = 3
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    TextHint = 'e.g. 123'
  end
  object RedDisplay: TRichEdit
    Left = 307
    Top = 8
    Width = 218
    Height = 160
    TabOrder = 4
  end
  object LblEdtEmail: TLabeledEdit
    Left = 24
    Top = 143
    Width = 121
    Height = 25
    Hint = 'Enter your email address here'
    EditLabel.Width = 92
    EditLabel.Height = 17
    EditLabel.Caption = 'Email Address:'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    TextHint = 'e.g. Example@gmail.com'
  end
  object BtnReturn: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 17
    Hint = 'Click here to return to previous screen'
    Caption = 'Return'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    OnClick = BtnReturnClick
  end
  object Button1: TButton
    Left = 0
    Top = 176
    Width = 533
    Height = 29
    Align = alBottom
    Caption = 'Send Email with receipt'
    TabOrder = 7
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 162
    Top = 104
    Width = 121
    Height = 25
    ParentShowHint = False
    ShowHint = True
    TabOrder = 8
    TextHint = '16 numbers'
  end
end
