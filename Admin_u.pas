unit Admin_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Grids, DBGrids, TeEngine, ExtCtrls, TeeProcs,
  Chart, Math, jpeg, Buttons, Series, Login_u;

type
  TFrmAdmin = class(TForm)
    PgCtrlAdmin: TPageControl;
    TabRacerSponsor: TTabSheet;
    TabHelpEdits: TTabSheet;
    TabReports: TTabSheet;
    DBGrid1: TDBGrid;
    BtnCreate: TButton;
    BtnDelete: TButton;
    BtnEdit: TButton;
    CmbEdit: TComboBox;
    RichEdit1: TRichEdit;
    BtnStats: TButton;
    RedHelp: TRichEdit;
    LblCaption: TLabel;
    BtnNewsletter: TButton;
    BtnSponsor: TButton;
    BtnDrivers: TButton;
    BtnSaveChanges: TButton;
    BtnChartDonations: TButton;
    BitBtn1: TBitBtn;
    BtnChartRacers: TButton;
    Chrt: TChart;
    Series1: TLineSeries;
    Donors: TTabSheet;
    Donations: TTabSheet;
    DBDonors: TDBGrid;
    BtnUpdate: TButton;
    DBGrid2: TDBGrid;
    BtnUpdate2: TButton;
    Logout: TTabSheet;
    BtnLogout: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BtnDeleteClick(Sender: TObject);
    procedure BtnCreateClick(Sender: TObject);
    procedure BtnEditClick(Sender: TObject);
    procedure BtnStatsClick(Sender: TObject);
    procedure CmbEditChange(Sender: TObject);
    procedure BtnDriversClick(Sender: TObject);
    procedure BtnNewsletterClick(Sender: TObject);
    procedure BtnSponsorClick(Sender: TObject);
    procedure BtnSaveChangesClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PgCtrlAdminChange(Sender: TObject);
    procedure BtnChartDonationsClick(Sender: TObject);
    procedure BtnChartRacersClick(Sender: TObject);
    procedure BtnUpdateClick(Sender: TObject);
    procedure BtnUpdate2Click(Sender: TObject);
    procedure BtnLogoutClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmAdmin: TFrmAdmin;
  Line: String;
  TFile: Textfile;
  UpDown, RacerID, sName: String;
  cArray: Array [1 .. 26] Of Char = (
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z'
  );
  iArrayPodiums: Array [1 .. 11] of Integer;
  iArrayWins: Array [1 .. 11] of Integer;
  sArrayDriver: Array [1 .. 11] of String;

implementation

uses DMConnection_u;
{$R *.dfm}

// ===========Generate Charts==================//
procedure TFrmAdmin.BtnChartDonationsClick(Sender: TObject);
VAR
  I, P: Integer;
begin
  DMConnection.TblRacer.first;
  Chrt.Series[0].Title := 'Race Podiums per driver';
  for P := 1 to 11 do
  begin
    sArrayDriver[P] := DMConnection.TblRacer['RacerName'];
    iArrayWins[P] := DMConnection.TblRacer['Podiums'];
    DMConnection.TblRacer.Next;
  end;

  Chrt.Series[0].Clear;
  with Chrt.Series[0] do
  begin
    for I := 1 to 11 do
    begin
      AddXY(I, iArrayWins[I], sArrayDriver[I], random($FFFFFF));
    end;
  end; // with end
end;

// =============Generate some more charts================//
procedure TFrmAdmin.BtnChartRacersClick(Sender: TObject);
VAR
  I, P: Integer;
begin
  DMConnection.TblRacer.first;
  Chrt.Series[0].Title := 'Race Wins per driver';
  for P := 1 to 11 do
  begin
    sArrayDriver[P] := DMConnection.TblRacer['RacerName'];
    iArrayWins[P] := DMConnection.TblRacer['Wins'];
    DMConnection.TblRacer.Next;
  end;

  Chrt.Series[0].Clear;
  with Chrt.Series[0] do
  begin
    for I := 1 to 11 do
    begin
      AddXY(I, iArrayWins[I], sArrayDriver[I], random($FFFFFF));
    end;
  end; // with end
end;

procedure TFrmAdmin.BtnCreateClick(Sender: TObject);
// ===============creating a racer=========================//
VAR
  Name, Surname: String;
  Letter: Char;
  I, Age, Wins, Podiums, Seasons: Integer;
begin
  I := RandomRange(1, 26);
  Letter := cArray[I];
  Name := InputBox('Driver Details', 'Enter the drivers name', '');
  Surname := InputBox('Driver Details', 'Enter the drivers surname', '');
  Age := StrToInt(InputBox('Driver Details', 'Enter the drivers age', ''));
  Wins := StrToInt(InputBox('Driver Details', 'Enter the drivers wins tally',
      ''));
  Podiums := StrToInt(InputBox('Driver Details',
      'Enter the drivers podium tally', ''));
  Seasons := StrToInt(InputBox('Driver Details',
      'Enter the drivers number of completed seasons', ''));
  RacerID := name[1] + Surname[1] + inttostr(Age) + Letter;
  with DMConnection do
  begin
    TblRacer.Last;
    TblRacer.Insert;
    TblRacer['RacerID'] := RacerID;
    TblRacer['RacerName'] := Name;
    TblRacer['RacerSurname'] := Surname;
    TblRacer['Age'] := Age;
    TblRacer['Wins'] := Wins;
    TblRacer['Podiums'] := Podiums;
    TblRacer['Seasons'] := Seasons;
    TblRacer.Post;
    TblRacer.Refresh;
  end;
end;

// =========================deleting a record==================//
procedure TFrmAdmin.BtnDeleteClick(Sender: TObject);
begin
  RacerID := InputBox('RacerID',
    'Enter the ID of the racer whose details you would like to delete', '');
  if uppercase(InputBox('Delete a record?', 'Y/N', '')) = 'Y' then
  begin
    with DMConnection do
    begin
      QryRacer.SQL.Clear;
      QryRacer.SQL.Add('DELETE * FROM TblRacer WHERE RacerID = ' + QuotedStr
          (RacerID));
      QryRacer.execsql;
      ShowMessage('Delete successful.');
    end;
    // With end
  end
  else
  begin
    ShowMessage('Delete cancelled.');
    exit;
  end; // if end
end;

// ==============load drivers help file=====================//
procedure TFrmAdmin.BtnDriversClick(Sender: TObject);
begin
  sName := 'Drivers';
  RedHelp.Clear;
  assignfile(TFile, 'Drivers.txt');
  reset(TFile);
  while not eof(TFile) do
  begin
    readln(TFile, Line);
    RedHelp.Lines.Add(Line);
  end;
  closefile(TFile);
end;

// =======================editing a record===============//
procedure TFrmAdmin.BtnEditClick(Sender: TObject);
VAR
  RacerID: String;
begin
  DMConnection.TblRacer.Edit;
  DMConnection.TblRacer.Insert;
  RacerID := InputBox('RacerID',
    'Enter the ID of the racer whose details you would like to change', '');
  if RacerID = ' ' then
  begin
    ShowMessage('Invalid RacerID entered.');
    exit;
  end;
  if CmbEdit.ItemIndex = -1 then
  begin
    ShowMessage('No field edit selected.');
    exit;
  end
  else if (CmbEdit.ItemIndex = 0) and (uppercase(UpDown) = 'INCREASE') then
  begin
    with DMConnection do
    begin
      TblRacer.Edit;
      TblRacer.first;
      while not TblRacer.eof do
      begin
        TblRacer.Next;
        if RacerID = TblRacer['RacerID'] then
        begin
          TblRacer.Edit;
          TblRacer['Age'] := TblRacer['Age'] + 1;
          TblRacer.Post;
          TblRacer.Refresh;
        end; // If End
      end; // while end

      ShowMessage('Change made!');
    end; // with end
  end
  else if (CmbEdit.ItemIndex = 1) and (uppercase(UpDown) = 'INCREASE') then
  begin
    with DMConnection do
    begin
      TblRacer.first;
      while not TblRacer.eof do
      begin
        TblRacer.Next;
        if RacerID = TblRacer['RacerID'] then
        begin
          TblRacer.Edit;
          TblRacer['Wins'] := TblRacer['Wins'] + 1;
          TblRacer.Post;
          TblRacer.Refresh;
        end; // If End
      end; // while end

      ShowMessage('Change made!');
    end; // with end
  end
  else if (CmbEdit.ItemIndex = 2) and (uppercase(UpDown) = 'INCREASE') then
  begin
    with DMConnection do
    begin
      TblRacer.first;
      while not TblRacer.eof do
      begin
        TblRacer.Next;
        if RacerID = TblRacer['RacerID'] then
        begin
          TblRacer.Edit;
          TblRacer['Podiums'] := TblRacer['Podiums'] + 1;
          TblRacer.Post;
          TblRacer.Refresh;
        end; // If End
      end; // while end

      ShowMessage('Change made!');
    end; // with end
  end
  else if (CmbEdit.ItemIndex = 3) and (uppercase(UpDown) = 'INCREASE') then
  begin
    with DMConnection do
    begin
      TblRacer.first;
      while not TblRacer.eof do
      begin
        TblRacer.Next;
        if RacerID = TblRacer['RacerID'] then
        begin
          TblRacer.Edit;
          TblRacer['Seasons'] := TblRacer['Seasons'] + 1;
          TblRacer.Post;
          TblRacer.Refresh;
        end; // If End
      end; // while end

      ShowMessage('Change made!');
    end; // with end
  end; // If-Statement End

  if (CmbEdit.ItemIndex = 0) and (uppercase(UpDown) = 'DECREASE') then
  begin
    with DMConnection do
    begin
      TblRacer.first;
      while not TblRacer.eof do
      begin
        TblRacer.Next;
        if RacerID = TblRacer['RacerID'] then
        begin
          TblRacer.Edit;
          TblRacer['Age'] := TblRacer['Age'] - 1;
          TblRacer.Post;
          TblRacer.Refresh;
        end; // If End
      end; // while end

      ShowMessage('Change made!');
    end; // with end
  end
  else if (CmbEdit.ItemIndex = 1) and (uppercase(UpDown) = 'DECREASE') then
  begin
    with DMConnection do
    begin
      TblRacer.first;
      while not TblRacer.eof do
      begin
        TblRacer.Next;
        if RacerID = TblRacer['RacerID'] then
        begin
          TblRacer.Edit;
          TblRacer['Wins'] := TblRacer['Wins'] - 1;
          TblRacer.Post;
          TblRacer.Refresh;
        end; // If End
      end; // while end

      ShowMessage('Change made!');
    end; // with end
  end
  else if (CmbEdit.ItemIndex = 2) and (uppercase(UpDown) = 'DECREASE') then
  begin
    with DMConnection do
    begin
      TblRacer.first;
      while not TblRacer.eof do
      begin
        TblRacer.Next;
        if RacerID = TblRacer['RacerID'] then
        begin
          TblRacer.Edit;
          TblRacer['Podiums'] := TblRacer['Podiums'] - 1;
          TblRacer.Post;
          TblRacer.Refresh;
        end; // If End
      end; // while end

      ShowMessage('Change made!');
    end; // with end
  end
  else if (CmbEdit.ItemIndex = 3) and (uppercase(UpDown) = 'DECREASE') then
  begin
    with DMConnection do
    begin
      TblRacer.first;
      while not TblRacer.eof do
      begin
        TblRacer.Next;
        if RacerID = TblRacer['RacerID'] then
        begin
          TblRacer.Edit;
          TblRacer['Seasons'] := TblRacer['Seasons'] - 1;
          TblRacer.Post;
          TblRacer.Refresh;
        end; // If End
      end; // while end

      ShowMessage('Change made!');
    end; // with end
  end; // If-Statement End
end;

procedure TFrmAdmin.BtnLogoutClick(Sender: TObject);
begin
  FrmLogin.Show;
  FrmAdmin.Hide;
end;

// =====================loading newsletter help file================//
procedure TFrmAdmin.BtnNewsletterClick(Sender: TObject);
begin
  sName := 'Newsletter';
  RedHelp.Clear;
  assignfile(TFile, 'Newsletter.txt');
  reset(TFile);
  while not eof(TFile) do
  begin
    readln(TFile, Line);
    RedHelp.Lines.Add(Line);
  end;
  closefile(TFile);
end;

// ================save help file changes=========================//
procedure TFrmAdmin.BtnSaveChangesClick(Sender: TObject);
begin
  Line := RedHelp.Text;

  if sName = '' then
  begin
    ShowMessage('No help file edited.');
    exit;
  end
  else if sName = 'Drivers' then
  begin
    assignfile(TFile, 'Drivers.txt');
    rewrite(TFile);
    writeln(TFile, Line);
    closefile(TFile);
    ShowMessage('Changes made');
  end
  else if sName = 'Newsletter' then
  begin
    assignfile(TFile, 'Newsletter.txt');
    rewrite(TFile);
    writeln(TFile, Line);
    closefile(TFile);
    ShowMessage('Changes made');
  end
  else if sName = 'Donation' then
  begin
    assignfile(TFile, 'Donation.txt');
    rewrite(TFile);
    writeln(TFile, Line);
    closefile(TFile);
    ShowMessage('Changes made');
  end;
  RedHelp.Clear;
end;

// =================loading domations help file===================//
procedure TFrmAdmin.BtnSponsorClick(Sender: TObject);
begin
  sName := 'Donation';
  RedHelp.Clear;
  assignfile(TFile, 'Donation.txt');
  reset(TFile);
  while not eof(TFile) do
  begin
    readln(TFile, Line);
    RedHelp.Lines.Add(Line);
  end;
  closefile(TFile);
end;

// ====================calculations and formatting===================//
procedure TFrmAdmin.BtnStatsClick(Sender: TObject);
VAR
  AvgWins, AvgPodiums, AvgAge: Real;
  TtlWins, TtlPodiums, TtlAge, iHigh: Integer;
begin
  iHigh := 1;
  TtlWins := 0;
  TtlPodiums := 0;
  TtlAge := 0;
  with DMConnection do
  begin
    TblRacer.first;
    while not TblRacer.eof do
    begin
      TtlWins := TtlWins + TblRacer['Wins'];
      TtlPodiums := TtlPodiums + TblRacer['Podiums'];
      TtlAge := TtlAge + TblRacer['Age'];
      if TblRacer['Wins'] > iHigh then
      begin
        iHigh := TblRacer['Wins'];
      end;
      // if end
      TblRacer.Next;
    end; // while end
    TblRacer.first;
    while not TblRacer.eof do
    begin
      // tblRacer.First;
      if iHigh = TblRacer['Wins'] then
      begin
        RichEdit1.Lines.Add('The most successful driver is: ' + TblRacer
            ['RacerName'] + ' ' + TblRacer['RacerSurname']
            + '. With ' + inttostr(TblRacer['Wins']) + ' wins and ' + inttostr
            (TblRacer['Podiums']) + ' podiums. ' + inttostr
            (TblRacer['Seasons']) + ' seasons under his belt at the age of ' +
            inttostr(TblRacer['Age']) + '.' + #13#13);
      end; // If end
      TblRacer.Next;
    end; // while end

    AvgWins := round(TtlWins / TblRacer.RecordCount);
    AvgPodiums := round(TtlPodiums / TblRacer.RecordCount);
    AvgAge := round(TtlAge / TblRacer.RecordCount);
  end; // With End
  RichEdit1.Lines.Add('All Time Statistics for Drivers' + #13#13 +
      'The average amount of wins per driver is: ' + FloatToStr(AvgWins)
      + #13 + 'The average amount of podiums per driver is: ' + FloatToStr
      (AvgPodiums) + #13 +
      'The average age between all drivers on the grid is: ' + FloatToStr
      (AvgAge));

end;

// ============================Updating Grid to reflecf changes============//
procedure TFrmAdmin.BtnUpdate2Click(Sender: TObject);
begin
  DMConnection.TblDonation.Edit;
  DMConnection.TblDonation.Post;
  DMConnection.TblDonation.Refresh;
end;

procedure TFrmAdmin.BtnUpdateClick(Sender: TObject);
begin
  DMConnection.TblDonor.Edit;
  DMConnection.TblDonor.Post;
  DMConnection.TblDonor.Refresh;
end;

// =====================determining whether the record will increase or decrease======//
procedure TFrmAdmin.CmbEditChange(Sender: TObject);
begin
  UpDown := InputBox('Edit',
    'Would you like the data to increase or decrease?', 'Increase/Decrease');
end;

// ========================formatting columns=========================//
procedure TFrmAdmin.FormActivate(Sender: TObject);
begin
  DBGrid1.Columns[0].Width := 55;
  DBGrid1.Columns[1].Width := 83;
  DBGrid1.Columns[2].Width := 98;
  DBGrid1.Columns[3].Width := 42;
  DBGrid1.Columns[4].Width := 42;
  DBGrid1.Columns[5].Width := 65;
  DBGrid1.Columns[6].Width := 62;
  Chrt.Series[0].Clear;

  DBDonors.Columns[0].Width := 55;
  DBDonors.Columns[1].Width := 68;
  DBDonors.Columns[2].Width := 83;
  DBDonors.Columns[3].Width := 155;
  DBDonors.Columns[4].Width := 85;

  DBGrid2.Columns[0].Width := 75;
  DBGrid2.Columns[1].Width := 68;
  DBGrid2.Columns[2].Width := 83;
  DBGrid2.Columns[3].Width := 135;
  DBGrid2.Columns[4].Width := 85;
end;

procedure TFrmAdmin.FormCreate(Sender: TObject);
begin
  FrmAdmin.Position := poDesktopCenter;
  PgCtrlAdmin.TabIndex := 0;
end;

procedure TFrmAdmin.FormShow(Sender: TObject);
begin
  RichEdit1.Clear;
  RedHelp.Clear;
end;

procedure TFrmAdmin.PgCtrlAdminChange(Sender: TObject);
begin
  RichEdit1.Clear;
  RedHelp.Clear;
end;

end.
