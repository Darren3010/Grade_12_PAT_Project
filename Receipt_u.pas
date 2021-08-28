unit Receipt_u;

interface

Uses
  sysutils, dialogs, dateutils, math;

type
  TReceipt = Class(TObject)

  private
    fName: String;
    fSurname: String;
    fDonorID: String;
    fEmail: String;
    fAmount: Real;
    fDate: TDate;
  public
    constructor create(sName, sSurname, sDonorID, sEmail: String;
      rAmount: Real; dDate: TDateTime);
    Function ValidateEmail: Boolean;
    Function ToString: String;
    Procedure WriteTo;
    Function ValidateName: Boolean;
    Function ValidateAmount: Boolean;
  End;

implementation

uses Checkout_u;

{ TReceipt }

constructor TReceipt.create(sName, sSurname, sDonorID, sEmail: String;
  rAmount: Real; dDate: TDateTime);
begin
  fName := sName;
  fSurname := sSurname;
  fDonorID := sDonorID;
  fEmail := sEmail;
  fAmount := rAmount;
  fDate := dDate;
end;

function TReceipt.ValidateAmount: Boolean;
begin
  if fAmount <= 0 then
  begin
    Result := False;
  end
  else
  begin
    Result := True;
  end;

end;

function TReceipt.ValidateName: Boolean;
begin
  if (fName = '') OR (fSurname = '') then
  begin
    Result := False;
  end
  else
  begin
    Result := True;
  end;

end;

procedure TReceipt.WriteTo;
VAR
  Content: String;
  TFile: Textfile;
begin

  Content := ToString; // storing the formatted data from the ToString method to a variable to make it easier to work with
  assignfile(TFile, 'Receipt.txt');
  rewrite(TFile);
  append(TFile);
  writeln(TFile, Content);
  closefile(TFile);
end;

function TReceipt.ToString: String;
begin
  Result := fName + ' ' + fSurname + #13 + DateToStr(fDate)
    + #9 + 'Donor ID: ' + fDonorID + #13 +
    'Thank you so much for making a donation of ' + FloatToStrF(fAmount,
    ffcurrency, 5, 2) +
    '. If you wish to make a donation again, please use your unique DonorID: '
    + fDonorID + ' so that you will not have to enter your details again.';
end;

function TReceipt.ValidateEmail: Boolean;
VAR
  iPos: Integer;
begin
  iPos := pos('@', fEmail);
  if (iPos > 0) AND (fEmail <> '') then
  begin
    Result := True;
  end
  else
  begin
    Result := False;
  end;

end;

end.
