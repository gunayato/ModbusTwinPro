unit ScanCOM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvExControls, JvComponent, JvSpeedButton, StdCtrls, Spin,
  ComCtrls, Cport, MBusCPort;

type
  TScanCOMForm = class(TForm)
    Label1: TLabel;
    StartAdrEdit: TSpinEdit;
    ScanBtn: TJvSpeedButton;
    Label2: TLabel;
    EndAdrEdit: TSpinEdit;
    ResultMemo: TMemo;
    StatusBar: TStatusBar;
    TryAllSpeedCB: TCheckBox;
    GoodResOnlyCBox: TCheckBox;
    ReqBtn: TJvSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure ScanBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ReqBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  
const
  ScanBtnTxt = 'Scan';


var
  ScanCOMForm: TScanCOMForm;

implementation

uses gnugettext, Main, ModbusCOM, ScanReq;

{$R *.dfm}


//
// Form
//
procedure TScanCOMForm.FormShow(Sender: TObject);
begin
  ScanBtn.Enabled := True;
  StatusBar.SimpleText := '';
  ScanBtn.Caption := _(ScanBtnTxt);
  ResultMemo.Clear;
end;


procedure TScanCOMForm.FormCreate(Sender: TObject);
begin
  DefaultInstance.TranslateComponent(self);

  Constraints.MaxWidth := Width;
  Constraints.MinWidth := Width;  
end;



//
// Custom request
//
procedure TScanCOMForm.ReqBtnClick(Sender: TObject);
begin
  ScanReqForm.ShowModal;
end;


//
// Scan
//
procedure TScanCOMForm.ScanBtnClick(Sender: TObject);
var
  I: integer;
  Status: string;
  Ok: boolean;
  BR: TBaudRate;

  procedure DoScan;
  var
    I: integer;
    CustomReqActive: boolean;
    CustomReqAdr: integer;
    CustomReqLen: integer;
    CustomReqFunc: integer;
  begin
    // Custom request
    CustomReqActive := ScanReqForm.CustomReqActiveyCBox.Checked;
    CustomReqAdr := ScanReqForm.VarAdrEdit.Value;
    CustomReqLen := ScanReqForm.VarLengthEdit.Value;
    CustomReqFunc := ScanReqForm.FunctionCBox.ItemIndex;
    if CustomReqActive then ResultMemo.Lines.Add(_('Custom request is active'));

    with MBus do
    begin
      for I := StartAdrEdit.Value to EndAdrEdit.Value do begin

        // Loop
        StatusBar.SimpleText := Format(_('Scanning address %d'), [I]);
        try
          if CustomReqActive then begin
            case CustomReqFunc of
              0 : ReadCoilInputStatus(I, CustomReqAdr + 1, CustomReqLen, CoilStatus);
              1 : ReadCoilInputStatus(I, CustomReqAdr + 1, CustomReqLen, InputStatus);
              2 : ReadNRegister(I, CustomReqAdr + 1, CustomReqLen, HoldingRegister);
              3 : ReadNRegister(I, CustomReqAdr + 1, CustomReqLen, InputRegister);
            end;
          end
          else
            ReadNRegister(I, 1, 1, HoldingRegister);
        except
          ;
        end;

        // Error code
        Ok := False;
        case ErrorCode of
          MBus_OK, MBus_ERR_EXCEPTION:
            begin
              Status := _('Request ok');
              Ok := True;
            end;
          MBus_ERR_ANSWER:
            begin
              Status := _('Answer error');
              Sleep(1000);
            end;
          MBus_ERR_NOANSWER:
            begin
              Status := _('No answer');
              Sleep(1000);
            end
        else
          Status := _('Unknown error');
          Sleep(1000);
        end;

        if not GoodResOnlyCBox.Checked or (GoodResOnlyCBox.Checked and Ok) then
          ResultMemo.Lines.Add(Format(_('Address %d -> %s'), [I, Status]));

        Application.ProcessMessages;
        if StopSignal then Break;
      end;
    end;
  end;

begin

  if ScanBtn.Caption = _(StopBtnTxt) then
  begin
    StopSignal := True;
    Exit;
  end
  else
    StopSignal := False;

  ScanBtn.Caption := _(StopBtnTxt);


  ResultMemo.Clear;
  StatusBar.SimpleText := _('Scanning start');
  Application.ProcessMessages;

  try

    with MBus do
    begin
      if not Connected then MBus.Open;
      if TryAllSpeedCB.Checked then
      begin
        BR := BaudRate; // Backup actual baudrate
        for I := 0 to 6 do begin
          case I of
            0: begin BaudRate := br1200;  end;
            1: begin BaudRate := br2400;  end;
            2: begin BaudRate := br4800;  end;
            3: begin BaudRate := br9600;  end;
            4: begin BaudRate := br14400; end;
            5: begin BaudRate := br19200; end;
            6: begin BaudRate := br38400; end;
          end;
          ResultMemo.Lines.Add(Format(_('Using baudrate: %s bps'), [BaudRateToStr(BaudRate)]));
          DoScan;
          if StopSignal then Break;
        end;
        BaudRate := BR;
      end
      else
        begin
          ResultMemo.Lines.Add(Format(_('Using baudrate: %s bps'), [BaudRateToStr(BaudRate)]));
          DoScan;
        end;

    end;

  except
    MessageDlg(_('Error: No com port available ?'), mtError , [mbOk], 0);
  end;
  
  StatusBar.SimpleText := _('Scanning terminated');
  ScanBtn.Caption := _(ScanBtnTxt);
end;



end.
