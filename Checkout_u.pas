unit Checkout_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, Math, Receipt_u, EASendMailObjLib_TLB;

type
  TFrmCheckout = class(TForm)
    LblEdtName: TLabeledEdit;
    LblEdtAmount: TLabeledEdit;
    LblEdtCVC: TLabeledEdit;
    RedDisplay: TRichEdit;
    LblEdtEmail: TLabeledEdit;
    BtnDonate: TButton;
    LblExpiryDate: TLabel;
    BtnReturn: TButton;
    Button1: TButton;
    Edit1: TEdit;
    procedure BtnDonateClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnReturnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
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
  FrmCheckout: TFrmCheckout;
  ObjReceipt: TReceipt;

implementation

uses DMConnection_u, GuestHome_u;
{$R *.dfm}

// =============error checking and storing info in db=======================//
procedure TFrmCheckout.BtnDonateClick(Sender: TObject);
VAR
  DonorName, DonorSurname, DonorID, DonorEmail, CVC, DonationID: String;
  iPos: Integer;
  Amount: Real;
  bFlag: Boolean;
  Date: TDate;
  oSmtp: TMail;
  CardNumber: String;
begin

  Edit1.NumbersOnly := true;
  Edit1.MaxLength := 16;
  LblEdtAmount.NumbersOnly := true;
  Date := Now;
  RedDisplay.Clear;
  bFlag := False;
  CardNumber := Edit1.Text;
  iPos := Pos(' ', LblEdtName.Text);
  DonorName := copy(LblEdtName.Text, 1, iPos - 1);
  DonorSurname := copy(LblEdtName.Text, iPos + 1);
  DonorEmail := LblEdtEmail.Text;
  CVC := LblEdtCVC.Text;
  Amount := strtofloat(LblEdtAmount.Text);
  ObjReceipt := TReceipt.create(DonorName, DonorSurname, DonorID, DonorEmail,
    Amount, Date);
  if LblEdtName.Text = ' ' then
  begin
    showmessage('No name entered.');
    LblEdtName.Color := clred;
    exit;
  end
  else if LblEdtAmount.Text = ' ' then
  begin
    showmessage('No amount entered.');
    LblEdtAmount.Color := clred;
    exit;
  end
  else if LblEdtCVC.Text = ' ' then
  begin
    showmessage('No card CVC entered.');
    LblEdtCVC.Color := clred;
    exit;
  end
  else if LblEdtEmail.Text = ' ' then
  begin
    showmessage('No email address entered.');
    LblEdtEmail.Color := clred;
    exit;
  end
  else if (ObjReceipt.ValidateEmail = true) and
    (ObjReceipt.ValidateName = true) and (ObjReceipt.ValidateAmount = true)
    then
  begin
    bFlag := true;
  end;

  if bFlag = true then
  begin

    DonorID := copy(DonorName, 1, 1) + copy(DonorSurname, 1, 1) + copy
      (DonorEmail, 1, 1) + inttostr(randomrange(1, 99));
    DonationID := inttostr(randomrange(1, 99)) + copy(DonorID, 1, 1) + inttostr
      (randomrange(1, 99));
    // Test code - RedDisplay.Lines.Add(DonorID);
    with DMConnection do
    begin
      TblDonor.Last;
      TblDonor.Insert;
      TblDonor['DonorID'] := DonorID;
      TblDonor['DonorName'] := DonorName;
      TblDonor['DonorSurname'] := DonorSurname;
      TblDonor['DonorEmail'] := DonorEmail;
      TblDonor['NumofDonations'] := 1;
      TblDonor.Post;
      TblDonor.Refresh;
      TblDonation.Last;
      TblDonation.Insert;
      TblDonation['DonationID'] := DonationID;
      TblDonation['DonorID'] := DonorID;
      TblDonation['DonationDate'] := Date;
      TblDonation['Amount'] := Amount;
      TblDonation.Post;
      TblDonation.Refresh;
    end;
    RedDisplay.ScrollBars := ssVertical;
    RedDisplay.Lines.Add('Mission Winnow' + #13 + '========================' +
        'Dear ' + DonorName + ' ' + DonorSurname +
        ' thank you for your donation. You have been given a unique donor ID for future donations. This is: ' + DonorID + ', if you would like to donate to Mission Winnow again, please use your donor ID in the previous screen and enter your ammount as your details are now saved in our databases. Thank you.');
    RedDisplay.Lines.Add
      (#13 + DonorName + ' ' + DonorSurname + ' ' + DonorID + #13 + 'Date: ' +
        DateToStr(Date) + #13 + 'Amount donated: ' + floattostrf(Amount,
        ffcurrency, 5, 2));

    showmessage('Successful');
    ObjReceipt.ToString;
    ObjReceipt.WriteTo;

  end;

end;

procedure TFrmCheckout.BtnReturnClick(Sender: TObject);
begin
  FrmGuest.Show;
  FrmCheckout.Hide;
end;

// ====================send email of receipt======================//
procedure TFrmCheckout.Button1Click(Sender: TObject);
VAR
  oSmtp: TMail;
  Email: String;
begin
  Email := LblEdtEmail.Text;
  // code to send email
  oSmtp := TMail.create(Application);
  oSmtp.LicenseCode := 'TryIt';

  // sender Gmail email address
  oSmtp.FromAddr := 'missionwinnow11@gmail.com';

  // recipient email address
  oSmtp.AddRecipientEx(Email, 0);

  // email subject
  oSmtp.Subject := 'Mission Winnow Newsletter';
  // email attachment
  oSmtp.AddAttachment('Receipt.txt');

  // email body
  oSmtp.BodyText := 'Below is your donation receipt with your unique DonorID.';

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
end;

// ==========formatting================//
procedure TFrmCheckout.FormCreate(Sender: TObject);
begin
  FrmCheckout.Position := poDesktopCenter;
end;

// =============formatting==============//
procedure TFrmCheckout.FormShow(Sender: TObject);
begin
  LblEdtName.Clear;
  LblEdtAmount.Clear;
  LblEdtCVC.Clear;
  LblEdtEmail.Clear;
  RedDisplay.Clear;
end;

end.
