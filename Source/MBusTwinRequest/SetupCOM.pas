unit SetupCOM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvExControls, JvSpeedButton, StdCtrls, Spin;

type
  TSetupCOMForm = class(TForm)
    OkBtn: TJvSpeedButton;
    ComPortBtn: TJvSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure ComPortBtnClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  SetupCOMForm: TSetupCOMForm;

implementation

{$R *.dfm}

uses ModbusCOM, gnugettext;

procedure TSetupCOMForm.ComPortBtnClick(Sender: TObject);
begin
  try
    MBus.ShowSetupDialog;
  except
    MessageDlg(_('Error: No com port available ?'), mtError , [mbOk], 0);
  end;
end;

procedure TSetupCOMForm.FormCreate(Sender: TObject);
begin
  DefaultInstance.TranslateComponent(self);
end;

end.
