object DMConnection: TDMConnection
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 339
  Width = 423
  object ConDB: TADOConnection
    Left = 24
    Top = 8
  end
  object DSCDonation: TDataSource
    Left = 192
    Top = 16
  end
  object DSCDonor: TDataSource
    Left = 192
    Top = 64
  end
  object DSCItem: TDataSource
    Left = 192
    Top = 112
  end
  object DSCTransaction: TDataSource
    Left = 192
    Top = 208
  end
  object TblDonation: TADOTable
    Left = 72
    Top = 16
  end
  object TblDonor: TADOTable
    Left = 72
    Top = 64
  end
  object TblItem: TADOTable
    Left = 72
    Top = 112
  end
  object TblTransaction: TADOTable
    Left = 72
    Top = 208
  end
  object QryRacer: TADOQuery
    Parameters = <>
    Left = 72
    Top = 160
  end
  object DSCRacer: TDataSource
    DataSet = TblRacer
    Left = 192
    Top = 160
  end
  object TblRacer: TADOTable
    Left = 264
    Top = 160
  end
  object DSCRacer2: TDataSource
    Left = 328
    Top = 160
  end
end
