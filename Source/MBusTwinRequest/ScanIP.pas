unit ScanIP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvExControls, JvComponent, JvSpeedButton, StdCtrls, Spin,
  ComCtrls, ModbusConsts, ExtCtrls, JvComCtrls, CommCtrl;

type
  TScanIPForm = class(TForm)
    ResultMemo: TMemo;
    StatusBar: TStatusBar;
    GroupBox1: TGroupBox;
    IPPortEdit: TSpinEdit;
    StartIPAdrEdit: TJvIPAddress;
    Label8: TLabel;
    Label7: TLabel;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    Label4: TLabel;
    EndIPAdrEdit: TJvIPAddress;
    EndSlaveAdrEdit: TSpinEdit;
    Image1: TImage;
    StartSlaveAdrEdit: TSpinEdit;
    Label1: TLabel;
    GoodResOnlyCBox: TCheckBox;
    ScanBtn: TJvSpeedButton;
    ReqBtn: TJvSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure ScanBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure StartIPAdrEditChange(Sender: TObject);
    procedure StartSlaveAdrEditChange(Sender: TObject);
    procedure EndSlaveAdrEditChange(Sender: TObject);
    procedure EndIPAdrEditChange(Sender: TObject);
    procedure ReqBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  
const
  ScanBtnTxt = 'Scan';
  LowTimeoutTxt = 'Note: a low timeout can result wrong scan result.';



var
  ScanIPForm: TScanIPForm;

implementation

uses gnugettext, Main, SetupIP, ModbusIP, ScanReq;

{$R *.dfm}


//
// Form
//
procedure TScanIPForm.FormShow(Sender: TObject);
begin
  StatusBar.SimpleText := '';
  ScanBtn.Caption := _(ScanBtnTxt);
  ResultMemo.Clear;
  if SetupIPForm.ReqTimeoutEdit.Value < 5000 then
    ResultMemo.Lines.Add(_(LowTimeoutTxt));
  StartIPAdrEditChange(nil);
end;



procedure TScanIPForm.FormCreate(Sender: TObject);
begin
  DefaultInstance.TranslateComponent(self);

  Constraints.MaxWidth := Width;
  Constraints.MinWidth := Width;

  EndIPAdrEdit.Text := StartIPAdrEdit.Text;
end;


//
// Scan
//
procedure TScanIPForm.ScanBtnClick(Sender: TObject);
var
  I, J: integer;
  Status: string;
  Res, Coil: boolean;
  HoldingRegister: word;
  CustomReqActive: boolean;
  CustomReqAdr: integer;
  CustomReqLen: integer;
  CustomReqFunc: integer;
  CoilsData: array[0..MaxCoils] of Boolean;
  RegistersData: array[0..MaxBlockLength] of Word;
begin
  if ScanBtn.Caption = _(StopBtnTxt) then
  begin
    StopSignal := True;
    Exit;
  end
  else
    StopSignal := False;

  ScanBtn.Caption := _(StopBtnTxt);

  // Custom request
  CustomReqActive := ScanReqForm.CustomReqActiveyCBox.Checked;
  CustomReqAdr := ScanReqForm.VarAdrEdit.Value;
  CustomReqLen := ScanReqForm.VarLengthEdit.Value;
  CustomReqFunc := ScanReqForm.FunctionCBox.ItemIndex;

  ResultMemo.Clear;
  StatusBar.SimpleText := _('Scanning start');

  Application.ProcessMessages;

  with MBusIp do
  begin
    TimeOut := SetupIPForm.ReqTimeoutEdit.Value;
    ConnectTimeout := SetupIPForm.ConnectTimeoutEdit.Value;

    if CustomReqActive then ResultMemo.Lines.Add(_('Custom request is active'));

    for I := StartIPAdrEdit.Address to EndIPAdrEdit.Address do begin

      // Load parameters
      DisConnect;
      Host := Format('%d.%d.%d.%d', [FIRST_IPADDRESS(I),
          SECOND_IPADDRESS(I), THIRD_IPADDRESS(I), FOURTH_IPADDRESS(I)]);
      Port := IPPortEdit.Value;
      Status := '';

      // Connection
      StatusBar.SimpleText := Format(_('Scanning address %s'), [Host]);
      Application.ProcessMessages;
      try
        Connect;
      except
        DisConnect;
      end;
      if not Connected then begin
        if not GoodResOnlyCBox.Checked then begin
          Status := _('Connection error');
          ResultMemo.Lines.Add(Format(_('Address %d.%d.%d.%d -> %s'), [FIRST_IPADDRESS(I),
            SECOND_IPADDRESS(I), THIRD_IPADDRESS(I), FOURTH_IPADDRESS(I), Status]));
        end;
        Application.ProcessMessages;
      end
      else
        for J := StartSlaveAdrEdit.Value to EndSlaveAdrEdit.Value do begin
          UnitID := J;

          // Scan request
          if CustomReqActive then begin
            case CustomReqFunc of
              0 : Res := ReadCoils(CustomReqAdr + 1, CustomReqLen, CoilsData);
              1 : Res := ReadInputBits(CustomReqAdr + 1, CustomReqLen, CoilsData);
              2 : Res := ReadHoldingRegisters(CustomReqAdr + 1, CustomReqLen, RegistersData);
              3 : Res := ReadInputRegisters(CustomReqAdr + 1, CustomReqLen, RegistersData);
            end;
          end
          else
            Res := ReadCoil(1, Coil);


          if Res then begin
            Status := _('Connected and request ok');
          end
          else begin
            if ModbusErrCode = mbecEXCEPTION then
              Status := Format(_('Connected but request exception %d'), [ModbusErrCode])
            else
              Status := _('Connected but request error');
          end;


          ResultMemo.Lines.Add(Format(_('Address %d.%d.%d.%d/%d -> %s'), [FIRST_IPADDRESS(I),
            SECOND_IPADDRESS(I), THIRD_IPADDRESS(I), FOURTH_IPADDRESS(I), UnitID, Status]));

          Application.ProcessMessages;
          Sleep(100);

          if StopSignal then Break;
        end;

      if Connected then DisConnect;
      if StopSignal then Break;
    end;
  end;

  StatusBar.SimpleText := _('Scanning terminated');
  ScanBtn.Caption := _(ScanBtnTxt);
end;



//
// Custom request
//
procedure TScanIPForm.ReqBtnClick(Sender: TObject);
begin
  ScanReqForm.ShowModal;
end;



//
// IP Field
//
procedure TScanIPForm.StartIPAdrEditChange(Sender: TObject);
begin
  StartIPAdrEdit.AddressValues.Address := StartIPAdrEdit.Address;
  EndIPAdrEdit.Range.Field1Min := StartIPAdrEdit.AddressValues.Value1;
  EndIPAdrEdit.Range.Field1Max := EndIPAdrEdit.Range.Field1Min;
  EndIPAdrEdit.Range.Field2Min := StartIPAdrEdit.AddressValues.Value2;
  EndIPAdrEdit.Range.Field2Max := EndIPAdrEdit.Range.Field2Min;
  EndIPAdrEdit.Range.Field3Min := StartIPAdrEdit.AddressValues.Value3;
  EndIPAdrEdit.Range.Field3Max := EndIPAdrEdit.Range.Field3Min;
  EndIPAdrEdit.Range.Field4Min := StartIPAdrEdit.AddressValues.Value4;
  EndIPAdrEdit.AddressValues.Address := EndIPAdrEdit.Address;
  EndIPAdrEdit.AddressValues.Value1 := StartIPAdrEdit.AddressValues.Value1;
  EndIPAdrEdit.AddressValues.Value2 := StartIPAdrEdit.AddressValues.Value2;
  EndIPAdrEdit.AddressValues.Value3 := StartIPAdrEdit.AddressValues.Value3;
  if EndIPAdrEdit.AddressValues.Value4 < EndIPAdrEdit.Range.Field4Min then
    EndIPAdrEdit.AddressValues.Value4 := EndIPAdrEdit.Range.Field4Min;
  EndIPAdrEdit.Address := EndIPAdrEdit.AddressValues.Address;
  StartIPAdrEdit.Refresh;
end;



procedure TScanIPForm.EndIPAdrEditChange(Sender: TObject);
begin
  EndIPAdrEdit.Refresh;
end;



//
// Slave addresss field
//
procedure TScanIPForm.StartSlaveAdrEditChange(Sender: TObject);
begin
  try
    if StartSlaveAdrEdit.Value > EndSlaveAdrEdit.Value then
      EndSlaveAdrEdit.Value := StartSlaveAdrEdit.Value;
  except
    ;
  end;
end;


procedure TScanIPForm.EndSlaveAdrEditChange(Sender: TObject);
begin
  try
    if EndSlaveAdrEdit.Value < StartSlaveAdrEdit.Value then
      StartSlaveAdrEdit.Value := EndSlaveAdrEdit.Value;
  except
    ;
  end;
end;

end.
