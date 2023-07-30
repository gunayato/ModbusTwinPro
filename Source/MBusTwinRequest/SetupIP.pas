unit SetupIP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvExControls, JvSpeedButton, StdCtrls, Spin;

type
  TSetupIPForm = class(TForm)
    Label9: TLabel;
    ReqTimeoutEdit: TSpinEdit;
    OkBtn: TJvSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    ConnectTimeoutEdit: TSpinEdit;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  SetupIPForm: TSetupIPForm;

implementation

{$R *.dfm}

uses gnugettext;

procedure TSetupIPForm.FormCreate(Sender: TObject);
begin
  DefaultInstance.TranslateComponent(self);
end;



end.
