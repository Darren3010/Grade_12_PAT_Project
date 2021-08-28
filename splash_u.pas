unit splash_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, jpeg, ComCtrls;

type
  TFrmSplash = class(TForm)
    ImgSplash: TImage;
    Label1: TLabel;
    TimProgBar: TTimer;
    PbLoading: TProgressBar;
    LblProgress: TLabel;
    procedure TimProgBarTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmSplash: TFrmSplash;
  K: Integer = 0;

implementation

uses Login_u;
{$R *.dfm}

procedure TFrmSplash.FormCreate(Sender: TObject);
begin
  TimProgBar.Enabled := True;
  FrmSplash.Position := poDesktopCenter;
end;

procedure TFrmSplash.TimProgBarTimer(Sender: TObject);
begin
  PbLoading.StepIt;

  K := K + 1;
  LblProgress.Caption := inttostr(K) + '%';
  if (K = 101) then // Set to 101 so that you can see the progress reach 100
  begin
    TimProgBar.Enabled := false;
    FrmSplash.Hide;
    FrmLogin.Show;
  end;
end;

end.
