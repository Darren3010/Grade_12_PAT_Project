program PAT_p;

uses
  Forms,
  splash_u in 'splash_u.pas' {FrmSplash},
  Login_u in 'Login_u.pas' {FrmLogin},
  GuestHome_u in 'GuestHome_u.pas' {FrmGuest},
  Checkout_u in 'Checkout_u.pas' {FrmCheckout},
  Admin_u in 'Admin_u.pas' {FrmAdmin},
  DMConnection_u in 'DMConnection_u.pas' {DMConnection: TDataModule},
  Receipt_u in 'Receipt_u.pas',
  EASendMailObjLib_TLB in 'EASendMailObjLib_TLB.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmSplash, FrmSplash);
  Application.CreateForm(TFrmLogin, FrmLogin);
  Application.CreateForm(TFrmGuest, FrmGuest);
  Application.CreateForm(TFrmCheckout, FrmCheckout);
  Application.CreateForm(TFrmAdmin, FrmAdmin);
  Application.CreateForm(TDMConnection, DMConnection);
  Application.Run;
end.
