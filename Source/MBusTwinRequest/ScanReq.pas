unit ScanReq;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, JvExControls, JvSpeedButton, Spin;

type
  TScanReqForm = class(TForm)
    Label2: TLabel;
    VarAdrEdit: TSpinEdit;
    Label3: TLabel;
    VarLengthEdit: TSpinEdit;
    Label4: TLabel;
    FunctionCBox: TComboBox;
    OkBtn: TJvSpeedButton;
    CustomReqActiveyCBox: TCheckBox;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ScanReqForm: TScanReqForm;

implementation

{$R *.dfm}

uses gnugettext;


procedure TScanReqForm.FormCreate(Sender: TObject);
begin
  DefaultInstance.TranslateComponent(self);
end;

end.
