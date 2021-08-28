object FrmAdmin: TFrmAdmin
  Left = 0
  Top = 0
  Caption = 'Admin'
  ClientHeight = 327
  ClientWidth = 501
  Color = clAppWorkSpace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PgCtrlAdmin: TPageControl
    Left = 0
    Top = 0
    Width = 501
    Height = 327
    ActivePage = TabReports
    Align = alClient
    TabOrder = 0
    OnChange = PgCtrlAdminChange
    object TabRacerSponsor: TTabSheet
      Caption = 'Racers and Sponsors'
      object DBGrid1: TDBGrid
        Left = 4
        Top = 0
        Width = 486
        Height = 169
        DataSource = DMConnection.DSCRacer2
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      object BtnCreate: TButton
        Left = 0
        Top = 175
        Width = 75
        Height = 32
        Hint = 'Click here to create a new record'
        Caption = 'New Record'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = BtnCreateClick
      end
      object BtnDelete: TButton
        Left = 81
        Top = 175
        Width = 88
        Height = 32
        Hint = 'Click here to delete a record'
        Caption = 'Delete Record'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = BtnDeleteClick
      end
      object BtnEdit: TButton
        Left = 0
        Top = 213
        Width = 75
        Height = 37
        Hint = 'Click here to edit a record'
        Caption = 'Edit Record'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = BtnEditClick
      end
      object CmbEdit: TComboBox
        Left = 81
        Top = 221
        Width = 88
        Height = 21
        TabOrder = 4
        Text = 'Select Field'
        OnChange = CmbEditChange
        Items.Strings = (
          'Age'
          'Wins'
          'Podiums'
          'Seasons')
      end
      object RichEdit1: TRichEdit
        Left = 175
        Top = 174
        Width = 316
        Height = 115
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
      end
      object BtnStats: TButton
        Left = 0
        Top = 256
        Width = 169
        Height = 32
        Hint = 'Click here for some numbers'
        Caption = 'All time statistics'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
        OnClick = BtnStatsClick
      end
    end
    object TabHelpEdits: TTabSheet
      Caption = 'Edit Help files'
      ImageIndex = 1
      object LblCaption: TLabel
        Left = 184
        Top = 3
        Width = 123
        Height = 21
        Caption = 'Editing help files'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Century Gothic'
        Font.Style = []
        ParentFont = False
      end
      object RedHelp: TRichEdit
        Left = 3
        Top = 30
        Width = 488
        Height = 201
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object BtnNewsletter: TButton
        Left = 160
        Top = 237
        Width = 169
        Height = 25
        Hint = 'Click here to load the newsletter help file'
        Caption = 'Newsletter'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Century Gothic'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = BtnNewsletterClick
      end
      object BtnSponsor: TButton
        Left = 335
        Top = 237
        Width = 156
        Height = 25
        Hint = 'Click here to load the sponsors help file'
        Caption = 'Donations'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Century Gothic'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = BtnSponsorClick
      end
      object BtnDrivers: TButton
        Left = 0
        Top = 237
        Width = 154
        Height = 25
        Hint = 'Click here to load the driver help file'
        Caption = 'Drivers'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Century Gothic'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = BtnDriversClick
      end
      object BtnSaveChanges: TButton
        Left = 0
        Top = 274
        Width = 493
        Height = 25
        Hint = 'Click here to save changes of the help file'
        Align = alBottom
        Caption = 'Save changes'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Century Gothic'
        Font.Style = [fsUnderline]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        OnClick = BtnSaveChangesClick
      end
    end
    object TabReports: TTabSheet
      Caption = 'Reports'
      ImageIndex = 2
      object BtnChartDonations: TButton
        Left = 0
        Top = 274
        Width = 493
        Height = 25
        Align = alBottom
        Caption = 'Generate Chart for Racer Podiums'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsUnderline]
        ParentFont = False
        TabOrder = 0
        OnClick = BtnChartDonationsClick
      end
      object BtnChartRacers: TButton
        Left = 0
        Top = 249
        Width = 493
        Height = 25
        Align = alBottom
        Caption = 'Generate Chart for Racer Wins'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsUnderline]
        ParentFont = False
        TabOrder = 1
        OnClick = BtnChartRacersClick
      end
      object Chrt: TChart
        Left = 0
        Top = 3
        Width = 490
        Height = 240
        Title.Text.Strings = (
          'TChart')
        LeftAxis.Title.Caption = 'Number of Wins/Podiums'
        LeftAxis.TitleSize = 1
        TabOrder = 2
        object Series1: TLineSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
          Data = {
            0619000000000000000040704000000020FF0000000000000000000064400000
            0020FF04000000434C43360000000000F06E4000000020FF0000000000000000
            0030614000000020FF000000000000000000803B4000000020FF000000000000
            000000404A4000000020FF000000000000000000A0644000000020FF00000000
            000000000000444000000020FF00000000000000000080364000000020FF0000
            0000000000000000394000000020FF000000000000000000C05C4000000020FF
            00000000000000000020524000000020FF000000000000000000C05740000000
            20FF00000000000000000000594000000020FF00000000000000000040604000
            000020FF00000000000000000070674000000020FF000000000000000000A059
            4000000020FF00000000000000000080464000000020FF000000000000000000
            30614000000020FF000000000000000000C0624000000020FF00000000000000
            000020574000000020FF00000000000000000070674000000020FF0000000000
            0000000090604000000020FF000000000000000000E0504000000020FF000000
            000000000000D06640FFFFFF1FFF00000000}
        end
      end
    end
    object Donors: TTabSheet
      Caption = 'Donors'
      ImageIndex = 3
      object DBDonors: TDBGrid
        Left = 0
        Top = 0
        Width = 490
        Height = 266
        DataSource = DMConnection.DSCDonor
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      object BtnUpdate: TButton
        Left = 0
        Top = 272
        Width = 490
        Height = 25
        Hint = 'Click here to update table if changes are not reflected'
        Caption = 'Update Table'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = BtnUpdateClick
      end
    end
    object Donations: TTabSheet
      Caption = 'Donations'
      ImageIndex = 4
      object DBGrid2: TDBGrid
        Left = 3
        Top = 3
        Width = 487
        Height = 265
        DataSource = DMConnection.DSCDonation
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      object BtnUpdate2: TButton
        Left = 0
        Top = 274
        Width = 493
        Height = 25
        Hint = 'Click here to update grid if new changes are not reflected'
        Align = alBottom
        Caption = 'Update'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = BtnUpdate2Click
        ExplicitLeft = 3
        ExplicitTop = 271
        ExplicitWidth = 75
      end
    end
    object Logout: TTabSheet
      Caption = 'Log Out'
      ImageIndex = 5
      object BtnLogout: TButton
        Left = 80
        Top = 128
        Width = 345
        Height = 41
        Caption = 'Log Out'
        TabOrder = 0
        OnClick = BtnLogoutClick
      end
    end
  end
  object BitBtn1: TBitBtn
    Left = 419
    Top = 1
    Width = 75
    Height = 17
    DoubleBuffered = True
    Kind = bkClose
    ParentDoubleBuffered = False
    TabOrder = 1
  end
end
