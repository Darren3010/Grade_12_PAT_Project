unit DMConnection_u;

interface

uses
  SysUtils, Classes, DB, ADODB;

type
  TDMConnection = class(TDataModule)
    ConDB: TADOConnection;
    DSCDonation: TDataSource;
    DSCDonor: TDataSource;
    DSCItem: TDataSource;
    DSCTransaction: TDataSource;
    TblDonation: TADOTable;
    TblDonor: TADOTable;
    TblItem: TADOTable;
    TblTransaction: TADOTable;
    QryRacer: TADOQuery;
    DSCRacer: TDataSource;
    TblRacer: TADOTable;
    DSCRacer2: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMConnection: TDMConnection;

implementation

{$R *.dfm}

procedure TDMConnection.DataModuleCreate(Sender: TObject);
begin
  // Sets connection
  ConDB.ConnectionString :=
    'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=' + ExtractFilePath
    (paramstr(0)) + 'DBPAT.mdb;Persist' + ' Security Info=False;';
  ConDB.LoginPrompt := false;
  ConDB.Connected := true;

  TblDonation.Connection := ConDB; // Table Connections
  TblDonor.Connection := ConDB;
  TblItem.Connection := ConDB;
  TblTransaction.Connection := ConDB;
  TblRacer.Connection := ConDB;

  TblDonation.TableName := 'TblDonation';
  TblDonor.TableName := 'TblDonor';
  TblItem.TableName := 'TblItem';
  // qrySponsor.TableName := 'TblSponsor';
  TblTransaction.TableName := 'TblTransaction';
  TblRacer.TableName := 'TblRacer';

  TblDonation.Active := true;
  TblDonor.Active := true;
  TblItem.Active := true;
  TblTransaction.Active := true;
  TblRacer.Active := true;

  QryRacer.Connection := ConDB;
  QryRacer.SQL.Add('SELECT * FROM TblRacer');
  QryRacer.Active := true;
  QryRacer.Open;

  DSCDonation.DataSet := TblDonation;
  DSCDonor.DataSet := TblDonor;
  DSCItem.DataSet := TblItem;
  DSCTransaction.DataSet := TblTransaction;
  DSCRacer.DataSet := QryRacer;
  DSCRacer2.DataSet := TblRacer;
end;

end.
