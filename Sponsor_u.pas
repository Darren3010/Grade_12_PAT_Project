unit Sponsor_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls;

type
  TFrmSponsor = class(TForm)
    BtnReturn: TButton;
    BtnConfirm: TButton;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    RichEdit1: TRichEdit;
    Button1: TButton;
    procedure BtnReturnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmSponsor: TFrmSponsor;

implementation

uses GuestHome_u;
{$R *.dfm}

procedure TFrmSponsor.BtnReturnClick(Sender: TObject);
begin
  FrmGuest.Show;
  FrmSponsor.Hide;
end;

procedure TFrmSponsor.FormCreate(Sender: TObject);
begin
  FrmSponsor.Position := poDesktopCenter;
end;

end.
