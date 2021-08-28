unit GuestHome_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, jpeg, ExtCtrls, StdCtrls, Buttons, OleCtrls, SHDocVw,
  Grids, DBGrids, Math, EASendMailObjLib_TLB, Login_u;

type
  TFrmGuest = class(TForm)
    PgCtrlGuest: TPageControl;
    TabDrivers: TTabSheet;
    TabNewsletter: TTabSheet;
    TabDonations: TTabSheet;
    TabHelp: TTabSheet;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    BtBtnClose: TBitBtn;
    RedHelp: TRichEdit;
    BtnDrivers: TButton;
    BtnNewsletter: TButton;
    BtnSponsors: TButton;
    BtnsingupNewsletter: TButton;
    Web: TWebBrowser;
    DBGrid1: TDBGrid;
    BtnFirst: TButton;
    LblEdtDonorID: TLabeledEdit;
    CmbType: TComboBox;
    MmoItem: TMemo;
    PnlOptions: TPanel;
    CmbPlace: TComboBox;
    BtnConfirm: TButton;
    BtnMoneyDonation: TButton;
    LblEdtAmount: TLabeledEdit;
    EdtItem: TEdit;
    BtnWins: TButton;
    BtnPodiums: TButton;
    BtnSearch: TButton;
    CmbExperience: TComboBox;
    BtnAge: TButton;
    BtnDonate: TButton;
    AdminLogin: TTabSheet;
    BtnLogin: TButton;
    procedure FormCreate(Sender: TObject);
    procedure BtnDriversClick(Sender: TObject);
    procedure BtnNewsletterClick(Sender: TObject);
    procedure BtnSponsorsClick(Sender: TObject);
    procedure BtnsingupNewsletterClick(Sender: TObject);
    procedure PgCtrlGuestChange(Sender: TObject);
    procedure BtnFirstClick(Sender: TObject);
    procedure CmbTypeChange(Sender: TObject);
    procedure BtnMoneyDonationClick(Sender: TObject);
    procedure BtnConfirmClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BtnWinsClick(Sender: TObject);
    procedure BtnPodiumsClick(Sender: TObject);
    procedure CmbExperienceChange(Sender: TObject);
    procedure BtnSearchClick(Sender: TObject);
    procedure BtnAgeClick(Sender: TObject);
    procedure MmoItemClick(Sender: TObject);
    procedure BtnDonateClick(Sender: TObject);
    procedure BtnLoginClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  ConnectNormal = 0;
  ConnectSSLAuto = 1;
  ConnectSTARTTLS = 2;
  ConnectDirectSSL = 3;
  ConnectTryTLS = 4;

var
  FrmGuest: TFrmGuest;
  Line: String;
  TFile: Textfile;

implementation

uses Checkout_u, DMConnection_u;
{$R *.dfm}

// ===========SQL sorting by age==============//
procedure TFrmGuest.BtnAgeClick(Sender: TObject);
begin
  with DMConnection do
  begin
    QryRacer.SQL.Clear;
    QryRacer.SQL.Add('SELECT * FROM TblRacer ORDER BY Age DESC');
    QryRacer.Open;
    DBGrid1.Columns[0].Width := 55;
    DBGrid1.Columns[1].Width := 83;
    DBGrid1.Columns[2].Width := 98;
    DBGrid1.Columns[3].Width := 42;
    DBGrid1.Columns[4].Width := 42;
    DBGrid1.Columns[5].Width := 65;
    DBGrid1.Columns[6].Width := 62;
  end;
end;

// =======for first time donations(error checking and storing to 3 tables)========//
procedure TFrmGuest.BtnConfirmClick(Sender: TObject);
VAR
  DonationID, DonorID, ItemDetails, Item, ItemID: String;
  bFlag: Boolean;
begin
  bFlag := false;
  DonorID := LblEdtDonorID.Text;
  DonationID := IntToStr(RandomRange(1, 99)) + copy(DonorID, 1, 1) + IntToStr
    (RandomRange(1, 99));
  Item := EdtItem.Text;
  ItemDetails := MmoItem.Text;
  ItemID := copy(Item, 1, 1) + IntToStr(RandomRange(1, 99)) + copy(DonorID, 1,
    1);
  with DMConnection do
  begin
    TblDonor.First;
    while not TblDonor.eof do
    begin
      if DonorID = TblDonor['DonorID'] then
      begin
        // code to create record for donation table
        TblDonation.Last;
        TblDonation.Insert;
        TblDonation['DonationID'] := DonationID;
        TblDonation['DonorID'] := DonorID;
        TblDonation['DonationDate'] := Date;
        TblDonation['ItemID'] := ItemID;
        TblDonation.Post;
        TblDonation.Refresh;
        // code to create record for item table
        TblItem.Last;
        TblItem.Insert;
        TblItem['ItemID'] := ItemID;
        TblItem['Item'] := Item;
        TblItem['Description'] := ItemDetails;
        TblItem['DonorID'] := DonorID;
        TblItem.Post;
        TblItem.Refresh;
        bFlag := true;
        showmessage('Thank you for your donation. It is much appreciated.');
      end;
      TblDonor.Next;
    end;
    if bFlag = false then
    begin
      showmessage(
        'This DonorID is not stored in our db, if this is your first donation, please click on the first time donating button to donate.');
    end;
  end;
end;

// ============donation===============//
procedure TFrmGuest.BtnDonateClick(Sender: TObject);
VAR
  RacerID, SponsorID: String;
  Amount: Real;
  bFlag: Boolean;
begin
  bFlag := false;
  RacerID := InputBox('Enter a racer''s ID',
    'Please enter the ID of the racer you would like to donate to', '');
  Amount := StrToFloat(InputBox('Amount',
      'Please enter the amount you would like to donate', ''));
  SponsorID := copy(RacerID, 1, 2) + IntToStr
    (DMConnection.TblTransaction.RecordCount);

  with DMConnection do
  begin
    TblRacer.First;
    while not TblRacer.eof do
    begin
      if RacerID = TblRacer['RacerID'] then
      begin
        bFlag := true;
      end;
      TblRacer.Next;
    end; // loop end
    if bFlag = true then
    begin
      TblTransaction['TransactionID'] := SponsorID;
      TblTransaction['RacerID'] := RacerID;
      TblTransaction['TransactionDate'] := Now;
      TblTransaction['TransactionAmount'] := Amount;
      showmessage('Donation successful');
    end
    else
    begin
      showmessage('Driver not found.');
      exit;
    end;

  end;

end;

// help file//
procedure TFrmGuest.BtnDriversClick(Sender: TObject);
begin
  RedHelp.Clear;
  if fileexists('Drivers.txt') then
  begin
    assignfile(TFile, 'Drivers.txt');
    reset(TFile);
    while not eof(TFile) do
      readln(TFile, Line);
    RedHelp.Lines.Add(Line);
  end
  else
  begin
    showmessage('Error loading help file.');
  end;
end;

procedure TFrmGuest.BtnFirstClick(Sender: TObject);
begin
  FrmCheckout.Show;
  FrmGuest.Hide;
end;

procedure TFrmGuest.BtnLoginClick(Sender: TObject);
begin
  FrmLogin.Show;
  FrmGuest.Hide;
end;

// ===============for first time monetary donations(2 tables)==========//
procedure TFrmGuest.BtnMoneyDonationClick(Sender: TObject);
VAR
  DonorID, DonationID: String;
  Amount: Real;
  bFlag: Boolean;
begin
  LblEdtAmount.NumbersOnly := true; // only numbers can be entered.
  bFlag := false;
  Amount := StrToFloat(LblEdtAmount.Text);
  DonorID := LblEdtDonorID.Text;
  with DMConnection do
  begin
    TblDonation.First;
    while not TblDonation.eof do
    begin
      if DonorID = TblDonor['DonorID'] then
      begin
        DonationID := IntToStr(RandomRange(1, 99)) + copy(DonorID, 1, 1)
          + IntToStr(RandomRange(1, 99));
        // TblDonation['Amount'] := TblDonation['Amount'] + Amount;
        TblDonor.Edit;
        TblDonor['NumofDonations'] := TblDonor['NumofDonations'] + 1;
        TblDonor.Post;
        TblDonor.Refresh;
        // code to create record for donation table
        TblDonation.Last;
        TblDonation.Insert;
        TblDonation['DonationID'] := DonationID;
        TblDonation['DonorID'] := DonorID;
        TblDonation['DonationDate'] := Date;
        TblDonation['Amount'] := Amount;
        TblDonation.Post;
        TblDonation.Refresh;
        bFlag := true;
        showmessage('Thank you for your donation. It is much appreciated.');
      end; // if end
      TblDonation.Next;
    end; // While end
    if bFlag = false then
    begin
      showmessage(
        'This DonorID is not stored in our db, if this is your first donation, please click on the first time donating button to donate.');
    end; // bflag condition

  end; // with end
end;

// help file//
procedure TFrmGuest.BtnNewsletterClick(Sender: TObject);
begin
  RedHelp.Clear;
  if fileexists('Newsletter.txt') then
  begin
    assignfile(TFile, 'Newsletter.txt');
    reset(TFile);
    while not eof(TFile) do
      readln(TFile, Line);
    RedHelp.Lines.Add(Line);
  end
  else
  begin
    showmessage('Error loading help file.');
  end;
end;

// ================filtering SQL==================//
procedure TFrmGuest.BtnPodiumsClick(Sender: TObject);
begin

  with DMConnection do
  begin
    QryRacer.SQL.Clear;
    QryRacer.SQL.Add(
      'SELECT * FROM TblRacer WHERE Podiums > 0 ORDER BY Podiums DESC');
    QryRacer.Open;
    DBGrid1.Columns[0].Width := 55;
    DBGrid1.Columns[1].Width := 83;
    DBGrid1.Columns[2].Width := 98;
    DBGrid1.Columns[3].Width := 42;
    DBGrid1.Columns[4].Width := 42;
    DBGrid1.Columns[5].Width := 65;
    DBGrid1.Columns[6].Width := 62;
  end;
end;

// ======================Quoted STR SQL=====================//
procedure TFrmGuest.BtnSearchClick(Sender: TObject);
VAR
  sName: String;
begin
  sName := InputBox('Enter a driver"s name', 'Enter the first name only', '');
  with DMConnection do
  begin
    QryRacer.SQL.Clear;
    QryRacer.SQL.Add('SELECT * FROM TblRacer WHERE RacerName = ' + QuotedStr
        (sName));
    QryRacer.Open;
    DBGrid1.Columns[0].Width := 55;
    DBGrid1.Columns[1].Width := 83;
    DBGrid1.Columns[2].Width := 98;
    DBGrid1.Columns[3].Width := 42;
    DBGrid1.Columns[4].Width := 42;
    DBGrid1.Columns[5].Width := 65;
    DBGrid1.Columns[6].Width := 62;
  end;
end;

// help file//
procedure TFrmGuest.BtnSponsorsClick(Sender: TObject);
begin
  RedHelp.Clear;
  RedHelp.ScrollBars := ssVertical;
  if fileexists('Donation.txt') then
  begin
    assignfile(TFile, 'Donation.txt');
    reset(TFile);
    while not eof(TFile) do
      readln(TFile, Line);
    RedHelp.Lines.Add(Line);
  end
  else
  begin
    showmessage('Error loading help file.');
  end;
end;

// =================send user newsletter webpage via email=============//
procedure TFrmGuest.BtnsingupNewsletterClick(Sender: TObject);
VAR
  Name, Email: String;
  Ipos: Integer;
  oSmtp: TMail;
begin
  Name := InputBox('Particulars', 'Enter your name', 'John Doe');
  Email := InputBox('Particulars', 'Enter your email address',
    'someone@example.com');
  Ipos := pos('@', Email);
  if Ipos > 1 then
  begin
    // code to send email
    oSmtp := TMail.Create(Application);
    oSmtp.LicenseCode := 'TryIt';

    // sender Gmail email address
    oSmtp.FromAddr := 'missionwinnow11@gmail.com';

    // recipient email address
    oSmtp.AddRecipientEx(Email, 0);

    // email subject
    oSmtp.Subject := 'Mission Winnow Newsletter';
    // email attachment
    oSmtp.AddAttachment('Newsletter.html');

    // email body
    oSmtp.BodyText := 'Below is our Formula 2 newsletter.';

    // Gmail SMTP server address
    oSmtp.ServerAddr := 'smtp.gmail.com';

    oSmtp.UserName := 'missionwinnow11@gmail.com';
    oSmtp.Password := 'Scuderia';

    // set 25 or 587 port
    oSmtp.ServerPort := 587;

    // detect SSL/TLS automatically
    oSmtp.ConnectType := ConnectSSLAuto;

    If oSmtp.SendMail() = 0 Then
    begin
      showmessage('Email was sent successfully!')
    end
    Else
    begin
      showmessage('Failed to send email with the following error: ' +
          oSmtp.GetLastErrDescription());
    end; // email send statement

  end // if ipos end
  else
  begin
    showmessage('Invalid email address entered. Please try again.');
    exit;
  end;

end;

// =========filtering SQL================//
procedure TFrmGuest.BtnWinsClick(Sender: TObject);
begin

  with DMConnection do
  begin
    QryRacer.SQL.Clear;
    QryRacer.SQL.Add
      ('SELECT * FROM TblRacer WHERE Wins > 0 ORDER BY Wins DESC');
    QryRacer.Open;
    DBGrid1.Columns[0].Width := 55;
    DBGrid1.Columns[1].Width := 83;
    DBGrid1.Columns[2].Width := 98;
    DBGrid1.Columns[3].Width := 42;
    DBGrid1.Columns[4].Width := 42;
    DBGrid1.Columns[5].Width := 65;
    DBGrid1.Columns[6].Width := 62;
  end;
end;

// ============Sorting SQL=====================//
procedure TFrmGuest.CmbExperienceChange(Sender: TObject);
begin
  if CmbExperience.ItemIndex = 0 then
  begin
    with DMConnection do
    begin
      QryRacer.SQL.Clear;
      QryRacer.SQL.Add('SELECT * FROM TblRacer ORDER BY Seasons DESC');
      QryRacer.Open;
      DBGrid1.Columns[0].Width := 55;
      DBGrid1.Columns[1].Width := 83;
      DBGrid1.Columns[2].Width := 98;
      DBGrid1.Columns[3].Width := 42;
      DBGrid1.Columns[4].Width := 42;
      DBGrid1.Columns[5].Width := 65;
      DBGrid1.Columns[6].Width := 62;
    end;

  end
  else if CmbExperience.ItemIndex = 1 then
  begin
    with DMConnection do
    begin
      QryRacer.SQL.Clear;
      QryRacer.SQL.Add('SELECT * FROM TblRacer ORDER BY Seasons');
      QryRacer.Open;
      DBGrid1.Columns[0].Width := 55;
      DBGrid1.Columns[1].Width := 83;
      DBGrid1.Columns[2].Width := 98;
      DBGrid1.Columns[3].Width := 42;
      DBGrid1.Columns[4].Width := 42;
      DBGrid1.Columns[5].Width := 65;
      DBGrid1.Columns[6].Width := 62;
    end;

  end;
end;

procedure TFrmGuest.CmbTypeChange(Sender: TObject);
begin
  if CmbType.ItemIndex = 0 then
  begin
    BtnMoneyDonation.Visible := true;
    LblEdtAmount.Visible := true;
    PnlOptions.Visible := false;
  end
  else if CmbType.ItemIndex = 1 then
  begin
    showmessage('Please enter the item details in the space provided.');
    // MmoItem.SetFocus;
    PnlOptions.Visible := true;
    BtnMoneyDonation.Visible := false;
    LblEdtAmount.Visible := false;
  end;

end;

procedure TFrmGuest.FormActivate(Sender: TObject);
begin
  // Formatting the DBgrid
  DBGrid1.Columns[0].Width := 55;
  DBGrid1.Columns[1].Width := 83;
  DBGrid1.Columns[2].Width := 98;
  DBGrid1.Columns[3].Width := 42;
  DBGrid1.Columns[4].Width := 42;
  DBGrid1.Columns[5].Width := 65;
  DBGrid1.Columns[6].Width := 62;
end;

procedure TFrmGuest.FormCreate(Sender: TObject);
begin
  PnlOptions.Visible := false;
  BtnMoneyDonation.Visible := false;
  LblEdtAmount.Visible := false;
  PgCtrlGuest.TabIndex := 0;
  FrmGuest.Position := poDesktopCenter;
  Web.Silent := true; // Avoid Errors
  Web.Navigate('https://www.fiaformula2.com/Latest');
  RedHelp.Clear;
  MmoItem.Clear;

  //
  { }
end;

procedure TFrmGuest.MmoItemClick(Sender: TObject);
begin
  MmoItem.Clear;
end;

procedure TFrmGuest.PgCtrlGuestChange(Sender: TObject);
begin
  // Clearing and setting componenets to original values
  LblEdtDonorID.Clear;
  CmbExperience.Text := 'Sort by experience.';
  PnlOptions.Visible := false;
  BtnMoneyDonation.Visible := false;
  LblEdtAmount.Visible := false;
  RedHelp.Clear;
  CmbType.Text := 'Type of Donation.';
  with DMConnection do
  begin
    QryRacer.SQL.Clear;
    QryRacer.SQL.Add('SELECT * FROM TblRacer');
    QryRacer.Open;
  end;

  case PgCtrlGuest.TabIndex of // Case statement to change size of Form
    0: // and placement of componenets
      begin
        FrmGuest.ClientHeight := 250;
        FrmGuest.ClientWidth := 500;
        BtBtnClose.Left := 417;
        BtBtnClose.Top := 217;
      end; // O end
    1:
      begin
        FrmGuest.ClientHeight := 360;
        FrmGuest.ClientWidth := 685;
        BtnsingupNewsletter.Left := 3;
        BtnsingupNewsletter.Top := 300;
        BtBtnClose.Left := 602;
        BtBtnClose.Top := 327;
      end; // 1 end
    2:
      begin
        FrmGuest.ClientHeight := 250;
        FrmGuest.ClientWidth := 500;
        BtBtnClose.Left := 417;
        BtBtnClose.Top := 217;
      end;
    3:
      begin
        FrmGuest.ClientHeight := 250;
        FrmGuest.ClientWidth := 500;
        BtBtnClose.Left := 417;
        BtBtnClose.Top := 217;
      end;
  end; // Case end
end;

end.
