unit Login_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, jpeg, ExtCtrls, StdCtrls, Buttons, Math;

type
  TFrmLogin = class(TForm)
    PgCtrl: TPageControl;
    TabSignup: TTabSheet;
    TabLogin: TTabSheet;
    TabGuest: TTabSheet;
    Image2: TImage;
    Image3: TImage;
    BtnHome: TButton;
    LblEdtLoginUsername: TLabeledEdit;
    LblEdtLoginPassword: TLabeledEdit;
    BtBtnClose: TBitBtn;
    LblEdtName: TLabeledEdit;
    LblEdtUsername: TLabeledEdit;
    Button2: TButton;
    LblPassword: TLabel;
    Button3: TButton;
    procedure BtnHomeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LblPasswordMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LblPasswordMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button2Click(Sender: TObject);
    Function ValidateLogin: Boolean;
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject); // dynamic button event
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmLogin: TFrmLogin;
  TFile: Textfile;
  Line: String;
  Button1: TButton; // dynamically creating button

implementation

uses GuestHome_u, Admin_u;
{$R *.dfm}

procedure TFrmLogin.BtnHomeClick(Sender: TObject);
begin
  FrmGuest.Show;
  FrmLogin.Hide;
end;

procedure TFrmLogin.Button1Click(Sender: TObject);
begin
  FrmAdmin.Show;
  FrmLogin.Hide;
end;

// ===========create admin account===================//
procedure TFrmLogin.Button2Click(Sender: TObject);
VAR
  iPos, LengthName, LengthSurname, LengthUser: Integer;
  Password, Username: String;
  bValidate: Boolean;
begin
  bValidate := false;
  iPos := Pos(' ', LblEdtName.Text);
  LengthName := length(copy(LblEdtName.Text, 1, iPos - 1));
  LengthSurname := length(copy(LblEdtName.Text, iPos + 1));
  LengthUser := length(copy(LblEdtUsername.Text, 1));
  Username := LblEdtUsername.Text;

  if (LengthName = 0) or (LengthSurname = 0) or (LengthUser = 0) or
    (Username = '') then
  begin
    showmessage('Incorrect Details entered.');
    exit;
  end
  else
  begin
    bValidate := True;
  end; // if end for bvalidate

  if bValidate = True then
  begin
    Password := IntToStr(LengthName) + IntToStr(LengthSurname) + IntToStr
      (LengthUser) + IntToStr(random(99));
    showmessage('Account created.' + ' Your password is: ' + Password);
    FrmAdmin.Show;
    FrmLogin.Hide;
    assignfile(TFile, 'UsernamePassword.txt');
    reset(TFile);
    append(TFile);
    Writeln(TFile, Username + '#' + Password);
    closefile(TFile);
  end
  else
  begin
    showmessage('Incorrect Details entered. Please try again.');
    exit;
  end; // else end

end;

// ================validates details then makes dynamic component visible====//
procedure TFrmLogin.Button3Click(Sender: TObject);
begin
  if ValidateLogin = false then
  begin
    showmessage('Incorrect details entered.');
    LblEdtLoginUsername.Clear;
    LblEdtLoginPassword.Clear;
    LblEdtLoginUsername.Color := clred;
    LblEdtLoginPassword.Color := clred;
  end
  else
  begin
    Button1.visible := True;
  end;
end;

procedure TFrmLogin.FormCreate(Sender: TObject);
begin
  PgCtrl.TabIndex := 0;
  FrmLogin.Position := poDesktopCenter;
  LblEdtLoginUsername.NumbersOnly := false; // prevents numbers being entered.
  LblEdtLoginPassword.NumbersOnly := True; // prevents letters being entered.
  LblEdtName.NumbersOnly := false;
  LblEdtUsername.NumbersOnly := false;

  // Dynamically creating login button
  Button1 := TButton.Create(FrmLogin);
  Button1.Left := 168;
  Button1.Top := 179;
  Button1.Width := 145;
  Button1.Height := 25;
  Button1.visible := false;
  Button1.Enabled := True;
  Button1.Parent := TabLogin;
  Button1.Caption := 'Login';
  Button1.Font.Size := 11;
  Button1.Font.Name := 'Century Gothic';
  Button1.OnClick := Button1Click;
  Button1.Hint := 'Click here to go the admin screen.';
  Button1.ShowHint := True;
end;

// ==============seeing and hiding password===============//
procedure TFrmLogin.LblPasswordMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin

  LblEdtLoginPassword.PasswordChar := #0;
  LblPassword.Caption := 'Hide Password';
end;

procedure TFrmLogin.LblPasswordMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  LblEdtLoginPassword.PasswordChar := '*';
  LblPassword.Caption := 'Show Password';
end;

// ==================modular programming to validate credentials==============//
function TFrmLogin.ValidateLogin: Boolean;
VAR
  Username, Password, TextUser, TextPass: String;
  iPos: Integer;
  bFlag: Boolean;
begin
  bFlag := false;
  Username := LblEdtLoginUsername.Text;
  Password := LblEdtLoginPassword.Text;
  assignfile(TFile, 'UsernamePassword.txt');
  reset(TFile);

  if (Username = ' ') or (Password = ' ') then
  begin
    showmessage('Incorrect details entered.');
    exit;
  end;

  while not eof(TFile) do
  begin
    Readln(TFile, Line);
    iPos := Pos('#', Line);
    TextUser := copy(Line, 1, iPos - 1);
    TextPass := copy(Line, iPos + 1);
    if (Username = TextUser) and (Password = TextPass) then
      bFlag := True;
  end;
  if bFlag = True then
  begin
    Result := True;
  end
  else
  begin
    Result := false;
  end;
  closefile(TFile);
end;

end.
