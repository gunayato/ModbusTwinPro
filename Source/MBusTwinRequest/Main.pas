unit Main;


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Spin, ExtCtrls, Grids,
  ValEdit, TypInfo, ShellApi, Menus,
  JvMenus, JvAppStorage, JvAppIniStorage,
  IdModBusClient, ModbusConsts, ModbusTypes, JvExExtCtrls, JvNetscapeSplitter,
  JvFormPlacement, DB, JvDataSource, JvCsvData, DBGrids, JvDBGridExport,
  JvDBGrid, JvExGrids, JvStringGrid, ImgList, JvSplitter, AppEvnts,
  CPort, JvStatusBar, XPMan, JvExComCtrls, JvExDBGrids, JvComponentBase,
  JvExControls, JvSystemPopup, JvSpeedButton, JvMRUList, JvExStdCtrls, JvButton,
  JvRecentMenuButton, JvDragDrop, JvArrowButton, JvHint, JvBalloonHint;

const
  MyMBusFuncCodePrefix = 'mbfc';

type
  TMyMBusFuncCode = (mbfcReadCoilStatus, mbfcReadInputStatus, mbfcReadNHoldingRegister, mbfcReadNInputRegister,
        mbfcWriteCoil, mbfcWrite1Register, mbfcWriteNCoil, mbfcWriteNRegister);
  TMyMBusRetCode = (mbrcOk, mbrcException, mbrcNoAnswer);

  TTabControlModbus = (tcmIP, tcmCOM, tcmHELP);

  TMainForm = class(TForm)
    XPManifest: TXPManifest;
    MainTabControl: TTabControl;
    RequestPanel: TPanel;
    RequestBottomPanel: TPanel;
    RequestBtn: TJvSpeedButton;
    RequestAllBtn: TJvSpeedButton;
    ExportBtn: TJvSpeedButton;
    LoopCB: TCheckBox;
    RequestTopPanel: TPanel;
    AddBtn: TJvSpeedButton;
    DelBtn: TJvSpeedButton;
    ClearBtn: TJvSpeedButton;
    LoadBtn: TJvArrowButton;
    SaveBtn: TJvSpeedButton;
    COMPanel: TPanel;
    Logo: TImage;
    TransferBtn: TJvSpeedButton;
    BusScanBtn: TJvSpeedButton;
    OpenDlg: TOpenDialog;
    SaveDlg: TSaveDialog;
    SaveExportDlg: TSaveDialog;
    ConfigFileStorage: TJvAppIniFileStorage;
    FormStorage: TJvFormStorage;
    SaveIpDlg: TSaveDialog;
    OpenIpDlg: TOpenDialog;
    IpFileStorage: TJvAppIniFileStorage;
    Database: TJvCsvDataSet;
    DatabaseSource: TJvDataSource;
    DatabaseModelSource: TJvDataSource;
    DatabaseModel: TJvCsvDataSet;
    TabImageList: TImageList;
    SetupBtn: TJvSpeedButton;
    RequestDBGrid: TJvDBGrid;
    ResPanel: TPanel;
    ResultRegisterSGrid: TJvStringGrid;
    REQPanel: TPanel;
    NetscapeSplitter: TJvNetscapeSplitter;
    OrderDownBtn: TJvSpeedButton;
    OrderUpBtn: TJvSpeedButton;
    DebugCB: TCheckBox;
    MainPanel: TPanel;
    ReqTabControl: TTabControl;
    ResTabControl: TTabControl;
    RequestImageList: TImageList;
    ApplicationEvents: TApplicationEvents;
    StatusBar: TJvStatusBar;
    TrackerCB: TCheckBox;
    RequestTimer: TTimer;
    RequestAllTimer: TTimer;
    MRUList: TJvMRUList;
    MRUMenu: TPopupMenu;
    BalloonHint: TJvBalloonHint;
    MRUClearList: TMenuItem;
    MRUBreak: TMenuItem;
    ResultImageList: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure RequestAllBtnClick(Sender: TObject);
    procedure AddBtnClick(Sender: TObject);
    procedure DelBtnClick(Sender: TObject);
    procedure LoadBtnClick(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
    procedure MRUItemClick(Sender: TObject);
    procedure ClearBtnClick(Sender: TObject);
    procedure LogoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ExportBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RequestBtnClick(Sender: TObject);
    procedure TransferBtnClick(Sender: TObject);
    procedure BusScanBtnClick(Sender: TObject);
    procedure RequestDBGridDblClick(Sender: TObject);
    procedure RequestDBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormResize(Sender: TObject);
    procedure DatabaseAfterScroll(DataSet: TDataSet);
    procedure ResultRegisterSGridDblClick(Sender: TObject);
    procedure LoopCBClick(Sender: TObject);
    procedure SetupBtnClick(Sender: TObject);
    procedure MainTabControlChange(Sender: TObject);
    procedure OrderDownBtnClick(Sender: TObject);
    procedure OrderUpBtnClick(Sender: TObject);
    procedure DebugCBClick(Sender: TObject);
    procedure ApplicationEventsIdle(Sender: TObject; var Done: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure TrackerCBClick(Sender: TObject);
    procedure RequestTimerTimer(Sender: TObject);
    procedure RequestAllTimerTimer(Sender: TObject);
    procedure MRUListEnumText(Sender: TObject; Value: string; Index: Integer);
    procedure AddBtnMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MRUClearListClick(Sender: TObject);
  private
    { Private declarations }
    FormCaption: string;
    function DoRequest: boolean;
    procedure ShowRequestResult;
    function ModbusTypeSelected: TTabControlModbus;
    function RequestModbus(FuncCode, IpPort, SlaveAdr, VarAdr, VarLength: integer;
                             Value: single; IpAdr: string; var Data: string): integer;
    function GetErrorMsg: string;
    procedure ShowStatus(Text: string);
    function DoLastChangeData(Data, DataPrevious, LastChange: string): string;
  public
    { Public declarations }
  end;


  TByteBuffer = array[0..65535] of Byte;
  PByteBuffer = ^TByteBuffer;
  TWordBuffer = array[0..65535] of Smallint;
  PWordBuffer = ^TWordBuffer;
  TDoubleBuffer = array[0..65535] of Longint;
  PDoubleBuffer = ^TDoubleBuffer;
  TFloatBuffer = array[0..65535] of Single;
  PFloatBuffer = ^TFloatBuffer;


var
  MainForm: TMainForm;
  Msg, Status: string;
  StopSignal: boolean = False;
  RequestActive: boolean = False;
  AppLaunched: boolean = False;
  NoRefreshRequestResult: boolean = False;

const
  RequestBtnTxt = 'Request';
  RequestAllBtnTxt = 'Request all';
  StopBtnTxt = 'Stop';
  RequestProgressTxt = 'Request in progress... ';

  Sep = '|';
  NewLine = #13 + #10;
  IniFileName = 'MBusTwinRequestPro';

  ReqState_Bad          = -1;
  ReqState_None         = 0;
  ReqState_Ok           = 1;
  ReqState_InProgress   = 2;
  ReqState_TimeOut      = 3;
  ReqState_Exception    = 4;

  ModbusSlaveID_MIN     = 0;
  ModbusSlaveID_MAX     = 255;


implementation

uses gnugettext,
     ModbusIP, TransferIP, ScanIP, Request, SetupIP,
     ModbusCOM, TransferCOM, ScanCOM,
     MyFunctions, Model, Debug, Help, Tracker, SetupCOM, ScanReq;

{$R *.dfm}


//
// Status bar
//
procedure TMainForm.ShowStatus(Text: string);
begin
  StatusBar.Panels[0].Text := Text;
end;


//
// Form
//
procedure TMainForm.FormCreate(Sender: TObject);
var
  I: integer;
begin
  DefaultInstance.TranslateComponent(self);
  for I := 0 to RequestDBGrid.Columns.Count-1 do
    RequestDBGrid.Columns[I].Title.Caption := _(RequestDBGrid.Columns[I].Title.Caption);

  InitModbusIP;
  InitModbusCOM;

  Database.TextBufferSize := 90000; // Max row buffer size
  DatabaseModel.TextBufferSize := 90000;

  Database.Open;
//  Database.Sort('ID', True);
  DatabaseModel.CsvFieldDef := Database.CsvFieldDef;
  DatabaseModel.FileName := IniFileName + '.mod';
  DatabaseModel.Open;
  DatabaseModel.LoadFromFile(DatabaseModel.FileName);

  AddBtn.Hint := AddBtn.Caption;
  DelBtn.Hint := DelBtn.Caption;
  ClearBtn.Hint := ClearBtn.Caption;
  LoadBtn.Hint := LoadBtn.Caption;
  SaveBtn.Hint := SaveBtn.Caption;
  ExportBtn.Hint := ExportBtn.Caption;
  RequestBtn.Hint := RequestBtn.Caption;
  RequestAllBtn.Hint := RequestAllBtn.Caption;
  TransferBtn.Hint := TransferBtn.Caption;
  BusScanBtn.Hint := BusScanBtn.Caption;
  SetupBtn.Hint := SetupBtn.Caption;
  ResultRegisterSGrid.Hint := RequestDBGrid.Hint;

  ResultRegisterSGrid.FixedFont := ResultRegisterSGrid.Font;

  ConfigFileStorage.FileName := IniFileName + '.ini';
  ConfigFileStorage.Reload;

  FormStorage.Active := True;

  OpenDlg.InitialDir := ExtractFileDir(Application.ExeName);

  MRUList.Open;
  MRUList.EnumItems;

  FormCaption := Caption;
end;



procedure TMainForm.FormShow(Sender: TObject);
begin
  // Version
  Caption := Caption + Format(' [v%s]', [GetAppVersion]);

  // Parameters ini file
  RequestForm.IPAdrEdit.Text := ConfigFileStorage.ReadString('IP', '127.0.0.1');
  RequestForm.IPPortEdit.Value := ConfigFileStorage.ReadInteger('Port', 502);
  RequestForm.SlaveAdrEdit.Value := ConfigFileStorage.ReadInteger('Slave', 1);

  SetupIPForm.ReqTimeoutEdit.Value := ConfigFileStorage.ReadInteger('ReqTimeout', 1000);
  SetupIPForm.ConnectTimeoutEdit.Value := ConfigFileStorage.ReadInteger('ConnectTimeout', 1000);
  ScanIPForm.StartIPAdrEdit.Text := ConfigFileStorage.ReadString('ScanStartIP', '127.0.0.1');

  ScanIPForm.IPPortEdit.Value := ConfigFileStorage.ReadInteger('ScanPort', 502);
  ScanIPForm.StartSlaveAdrEdit.Value := ConfigFileStorage.ReadInteger('ScanStartSlave', 1);
  ScanIPForm.EndSlaveAdrEdit.Value := ConfigFileStorage.ReadInteger('ScanEndSlave', 1);
  ScanIPForm.EndIPAdrEdit.Text := ConfigFileStorage.ReadString('ScanEndIP', '127.0.0.1');
  ScanIPForm.StartIPAdrEdit.Text := ConfigFileStorage.ReadString('ScanStartIP', '127.0.0.1');
  ScanReqForm.VarAdrEdit.Value := ConfigFileStorage.ReadInteger('ScanCustomReqVarAdr', 0);
  ScanReqForm.VarLengthEdit.Value := ConfigFileStorage.ReadInteger('ScanCustomReqVarLength', 1);
  ScanReqForm.FunctionCBox.ItemIndex := ConfigFileStorage.ReadInteger('ScanCustomReqFunction', 0);
  ScanReqForm.CustomReqActiveyCBox.Checked := ConfigFileStorage.ReadBoolean('ScanCustomReqActive', False);

  REQPanel.Height := FormStorage.ReadInteger('REQPanel', REQPanel.Height);

  AutoSizeCol(RequestDBGrid);
end;


procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  StopSignal := True;
  if RequestActive then begin
    Sleep(2000);
    Application.ProcessMessages;
    RequestActive := False;
    Action := caNone;
    Exit;
  end;

  FormStorage.WriteInteger('REQPanel', REQPanel.Height);

  ConfigFileStorage.WriteString('IP', RequestForm.IPAdrEdit.Text);
  ConfigFileStorage.WriteInteger('Port', RequestForm.IPPortEdit.Value);
  ConfigFileStorage.WriteInteger('Slave', RequestForm.SlaveAdrEdit.Value);

  ConfigFileStorage.WriteInteger('ReqTimeout', SetupIPForm.ReqTimeoutEdit.Value);
  ConfigFileStorage.WriteInteger('ConnectTimeout', SetupIPForm.ConnectTimeoutEdit.Value);

  ConfigFileStorage.WriteString('ScanStartIP', ScanIPForm.StartIPAdrEdit.Text);
  ConfigFileStorage.WriteInteger('ScanPort', ScanIPForm.IPPortEdit.Value);
  ConfigFileStorage.WriteInteger('ScanStartSlave', ScanIPForm.StartSlaveAdrEdit.Value);
  ConfigFileStorage.WriteInteger('ScanEndSlave', ScanIPForm.EndSlaveAdrEdit.Value);
  ConfigFileStorage.WriteString('ScanEndIP', ScanIPForm.EndIPAdrEdit.Text);
  ConfigFileStorage.WriteInteger('ScanEndSlave', ScanIPForm.EndSlaveAdrEdit.Value);
  ConfigFileStorage.WriteInteger('ScanCustomReqVarAdr', ScanReqForm.VarAdrEdit.Value);
  ConfigFileStorage.WriteInteger('ScanCustomReqVarLength', ScanReqForm.VarLengthEdit.Value);
  ConfigFileStorage.WriteInteger('ScanCustomReqFunction', ScanReqForm.FunctionCBox.ItemIndex);
  ConfigFileStorage.WriteBoolean('ScanCustomReqActive', ScanReqForm.CustomReqActiveyCBox.Checked);

  ConfigFileStorage.Free;

  DatabaseModel.SaveToFile(DatabaseModel.FileName);
end;



procedure TMainForm.FormDestroy(Sender: TObject);
begin
  ExitModbusIP;
  ExitModbusCOM;
end;



procedure TMainForm.FormResize(Sender: TObject);
begin
  AutoSizeCol(RequestDBGrid);
end;








//
// Modbus IP or Serial (COM)
//
function TMainForm.ModbusTypeSelected: TTabControlModbus;
begin
  case MainTabControl.TabIndex of
    0 : result := tcmIP;
    1 : result := tcmCOM;
    2 : result := tcmHELP;
  end;
end;







procedure TMainForm.MainTabControlChange(Sender: TObject);
begin
  if RequestActive Then begin
      StopSignal := True;
      Exit;
  end;

  case ModbusTypeSelected of
    tcmIP  :
    begin
      RequestDBGrid.Columns[0].Visible := True;
      RequestDBGrid.Columns[1].Visible := True;
      if MBus.Connected then MBus.Close;
      HelpForm.HelpPanel.Hide;
    end;
    tcmCOM : begin
      RequestDBGrid.Columns[0].Visible := False;
      RequestDBGrid.Columns[1].Visible := false;
      HelpForm.HelpPanel.Hide;
    end;
    tcmHELP : begin
      HelpForm.HelpPanel.Parent := MainTabControl;
      HelpForm.HelpPanel.Show;
    end;
  end;
end;



function TMainForm.GetErrorMsg: string;
begin
  case ModbusTypeSelected of
    tcmIP  : result := GetErrorMsgIP;
    tcmCOM : result := GetErrorMsgCOM;
  end;
end;



function TMainForm.RequestModbus(FuncCode, IpPort, SlaveAdr, VarAdr, VarLength: integer;
                       Value: single; IpAdr: string; var Data: string): integer;
begin
  case ModbusTypeSelected of

    tcmIP  :
    begin
      result := RequestModbusIP(FuncCode, IpPort, SlaveAdr, VarAdr, VarLength,
                                SetupIPForm.ReqTimeoutEdit.Value, SetupIPForm.ConnectTimeoutEdit.Value,
                                Value, IpAdr, Data);
      if (result = ReqState_Ok) or (result = ReqState_Exception) then begin
        PrintRequest(GetSendRequestIP(DebugForm.HexCB.Checked));
        PrintResult(GetReceiveRequestIP(DebugForm.HexCB.Checked));
      end;
    end;

    tcmCOM :
    begin
      result := RequestModbusCOM(FuncCode, SlaveAdr, VarAdr, VarLength,
                                  Value, Data);
      if (result = ReqState_Ok) or (result = ReqState_Exception) then begin
        PrintRequest(GetSendRequestCOM(DebugForm.HexCB.Checked));
        PrintResult(GetReceiveRequestCOM(DebugForm.HexCB.Checked));
      end;
    end;
  end;
end;





//
// Execute requests
//
procedure TMainForm.RequestAllBtnClick(Sender: TObject);

begin
  if Database.RecordCount <= 0 then Exit;

  if RequestAllBtn.Caption = StopBtnTxt then
  begin
    StopSignal := True;
    Exit;
  end
  else
    StopSignal := False;

  RequestAllBtn.Caption := StopBtnTxt;

  Database.First;

  RequestAllTimer.Enabled := True; // Run request
end;


procedure TMainForm.RequestAllTimerTimer(Sender: TObject);
var
  Res: boolean;
  ErrStr: string;
begin
  RequestAllTimer.Enabled := False;

  AddBtn.Enabled := False;
  DelBtn.Enabled := False;
  ClearBtn.Enabled := False;
  OrderUpBtn.Enabled := False;
  OrderDownBtn.Enabled := False;
  TransferBtn.Enabled := False;
  RequestBtn.Enabled := False;
  BusScanBtn.Enabled := False;
  LoopCB.Enabled := False;
  //DebugCB.Enabled := False;
  LoadBtn.Enabled := False;
  SaveBtn.Enabled := False;
  ExportBtn.Enabled := False;
  SetupBtn.Enabled := False;

  RequestActive := True;

  try


    // Request
    ShowStatus(_(RequestProgressTxt));
    //Application.ProcessMessages;
    try Res := DoRequest; except Res := False; end;

    // Error or ok
    if Res then
      Status := _('Request ok')
    else begin
      ErrStr := _(GetErrorMsg);
      Status := Format(_('Request error: %s'), [ErrStr]);
    end;
    ShowStatus(Status);

  except
    ;
  end;

  // Next request
  Database.Next;

  if StopSignal or (not LoopCB.Checked and Database.Eof)then
  begin
    RequestActive := False;

    RequestAllBtn.Caption := _(RequestAllBtnTxt);

    AddBtn.Enabled := True;
    DelBtn.Enabled := True;
    ClearBtn.Enabled := True;
    OrderUpBtn.Enabled := True;
    OrderDownBtn.Enabled := True;
    LoopCB.Enabled := True;
    DebugCB.Enabled := True;
    TransferBtn.Enabled := True;
    RequestBtn.Enabled := True;
    BusScanBtn.Enabled := True;
    LoadBtn.Enabled := True;
    SaveBtn.Enabled := True;
    ExportBtn.Enabled := True;
    SetupBtn.Enabled := True;
  end
  else
  begin
    if Database.Eof and LoopCB.Checked then Database.First;
    RequestAllTimer.Enabled := True;
  end;
end;





procedure TMainForm.RequestBtnClick(Sender: TObject);
begin
  if Database.RecordCount <= 0 then Exit;

  if RequestBtn.Caption = StopBtnTxt then
  begin
    StopSignal := True;
    Exit;
  end
  else
    StopSignal := False;

  RequestBtn.Caption := StopBtnTxt;

  RequestTimer.Enabled := True; // Run request
end;


procedure TMainForm.RequestTimerTimer(Sender: TObject);
var
  Res: boolean;
  ErrStr: string;
begin
  RequestTimer.Enabled := False;

  AddBtn.Enabled := False;
  DelBtn.Enabled := False;
  ClearBtn.Enabled := False;
  OrderUpBtn.Enabled := False;
  OrderDownBtn.Enabled := False;
  TransferBtn.Enabled := False;
  RequestAllBtn.Enabled := False;
  BusScanBtn.Enabled := False;
  LoopCB.Enabled := False;
  //DebugCB.Enabled := False;
  LoadBtn.Enabled := False;
  SaveBtn.Enabled := False;
  ExportBtn.Enabled := False;
  SetupBtn.Enabled := False;

  RequestActive := True;

  try

    // Request
    ShowStatus(_(RequestProgressTxt));
  //  Application.ProcessMessages;
    try Res := DoRequest; except Res := False; end;

    // Error or ok
    if Res then
      Status := _('Request ok')
    else begin
      ErrStr := _(GetErrorMsg);
      Status := Format(_('Request error: %s'), [ErrStr]);
    end;
    ShowStatus(Status);
//    Application.ProcessMessages;
//    Sleep(100);


  except
    ;
  end;

  // Loop request or not ?
  if StopSignal or (LoopCB.Checked = False) then
  begin
    RequestActive := False;

    RequestBtn.Caption := _(RequestBtnTxt);

    AddBtn.Enabled := True;
    DelBtn.Enabled := True;
    ClearBtn.Enabled := True;
    OrderUpBtn.Enabled := True;
    OrderDownBtn.Enabled := True;
    LoopCB.Enabled := True;
    DebugCB.Enabled := True;
    TransferBtn.Enabled := True;
    RequestAllBtn.Enabled := True;
    BusScanBtn.Enabled := True;
    LoadBtn.Enabled := True;
    SaveBtn.Enabled := True;
    ExportBtn.Enabled := True;
    SetupBtn.Enabled := True;
  end
  else
    RequestTimer.Enabled := True; // Loop mode

end;





function TMainForm.DoRequest: boolean;
var
  FuncCode, IpPort, SlaveAdr, VarAdr, VarLength: integer;
  Value: single;
  IpAdr, Data, DataPrevious, LastChange: string;
  Swap: boolean;
  ResCode: integer;
  ResponseTime: TDateTime;
  rtHour, rtMin, rtSec, rtMSec: Word;
begin
  result := False;

  // Explode Params
  FuncCode := GetEnumValue(TypeInfo(TMyMBusFuncCode), MyMBusFuncCodePrefix + Database.FieldByName('FUNCTION').AsString);
  IpAdr := Database.FieldByName('IP').AsString;
  IpPort := Database.FieldByName('PORT').AsInteger;
  SlaveAdr := Database.FieldByName('SLAVE').AsInteger;
  VarAdr := Database.FieldByName('ADDRESS').AsInteger;
  VarLength := Database.FieldByName('LENGTH').AsInteger;
  Value := Database.FieldByName('VALUE').AsFloat;
  Swap := Database.FieldByName('SWAP').AsBoolean;

  try

    // In progress
    Database.Edit;
    Database.FieldByName('RESULT').AsInteger := ReqState_InProgress;
    Database.Post;

    DataPrevious := Database.FieldByName('DATA').AsWideString;

    //Application.ProcessMessages;

    // Do request
    ResponseTime := Now;
    ResCode := RequestModbus(FuncCode, IpPort, SlaveAdr, VarAdr, VarLength,
                                               Value, IpAdr, Data);
    ResponseTime := Now - ResponseTime;
    DecodeTime(ResponseTime, rtHour, rtMin, rtSec, rtMSec);

    // Timestamp data changes
    LastChange := DoLastChangeData(Data, DataPrevious, Database.FieldByName('LAST_CHANGE').AsWideString);

    // Store data and code result
    Database.Edit;
    Database.FieldByName('DATA').AsWideString := Data;
    Database.FieldByName('RESULT').AsInteger := ResCode;
    Database.FieldByName('RESULT_MSG').AsString := GetErrorMsg;
    Database.FieldByName('LAST_CHANGE').AsWideString := LastChange;
    Database.FieldByName('RESPONSE_TIME').AsString := Format('%ds %dms', [rtSec, rtMSec]);
    Database.Post;

    Application.ProcessMessages;

    // Show request data result
    ShowRequestResult;

  except
    ;
  end;


  result := (ResCode = 1);
end;



//
// Show request data result
//
procedure TMainForm.ShowRequestResult;
var
  Data, NameResult, LastChange: TStringList;
  I, I1, I2, VarAdr, R, ColName: integer;
  Swap: boolean;
  Value: Word;
  W1, W2: Word;
  DWord: Longword;
  PWord: PWordBuffer;
  Float: single;
  PFloat: PFloatBuffer;
  S1, S2, VarAdrPrefix, LC: string;
  FuncCode: integer;
begin
  if Database.RecordCount <= 0 then begin
    ResultRegisterSGrid.ColCount := 0;
    ResultRegisterSGrid.RowCount := 0;
    Exit;
  end;

  Data := TStringList.Create;
  LastChange := TStringList.Create;

  try


    if Database.FieldByName('RESULT').AsInteger <> ReqState_Bad then begin
      // Get req data
      Swap := Database.FieldByName('SWAP').AsBoolean;
      Explode(Database.FieldByName('DATA').AsString, Data, True, [Sep]);
      R := Database.FieldByName('LENGTH').AsInteger + 1;

      // Get last change data
      Explode(Database.FieldByName('LAST_CHANGE').AsString, LastChange, True, [Sep]);
      
      FuncCode := GetEnumValue(TypeInfo(TMyMBusFuncCode), MyMBusFuncCodePrefix + Database.FieldByName('FUNCTION').AsString);
      VarAdr := Database.FieldByName('ADDRESS').AsInteger;
      VarAdrPrefix := '';

      // Column title for Coils (bits)
      if TMyMBusFuncCode(FuncCode) in [mbfcReadCoilStatus, mbfcReadInputStatus, mbfcWriteCoil, mbfcWriteNCoil] then begin
        VarAdrPrefix := '%M';
        if (ResultRegisterSGrid.ColCount <> 3) or (ResultRegisterSGrid.RowCount <> R) then begin
          with ResultRegisterSGrid do begin
//            Clear;
            ColCount := 4;
            FixedCols := 0;
            RowCount := 2;
            FixedRows := 1;
            Cells[0, 0]    := _('Address');
            Cells[1, 0]    := _('Bit');
            Cells[2, 0]    := _('Name');
            Cells[3, 0]    := _('Last change');
            Cells[0, 1]    := '';
            Cells[1, 1]    := '';
            Cells[2, 1]    := '';
            Cells[3, 1]    := '';
            if TMyMBusFuncCode(FuncCode) in [mbfcWriteCoil, mbfcWriteNCoil] then R := 0;
            RowCount := R;
          end;
        end;
      end;

      // Column title for Registers
      if TMyMBusFuncCode(FuncCode) in [mbfcReadNHoldingRegister, mbfcReadNInputRegister, mbfcWriteNRegister, mbfcWrite1Register] then begin
        VarAdrPrefix := '%MW';
        if (ResultRegisterSGrid.ColCount <> 6) or (ResultRegisterSGrid.RowCount <> R) then begin
          with ResultRegisterSGrid do begin
//            Clear;
            ColCount := 8;
            FixedCols := 0;
            RowCount := 2;
            FixedRows := 1;
            Cells[0, 0]    := _('Address');
            Cells[1, 0]    := _('Word');
            Cells[2, 0]    := _('DWord');
            Cells[3, 0]    := _('Float');
            Cells[4, 0]    := _('Hex');
            Cells[5, 0]    := _('Binary');
            Cells[6, 0]    := _('Name');
            Cells[7, 0]    := _('Last change');
            Cells[0, 1]    := '';
            Cells[1, 1]    := '';
            Cells[2, 1]    := '';
            Cells[3, 1]    := '';
            Cells[4, 1]    := '';
            Cells[5, 1]    := '';
            Cells[6, 1]    := '';
            Cells[7, 1]    := '';
            RowCount := R;
          end;
        end;
      end;

      ResultRegisterSGrid.Rows[0].BeginUpdate;

      // Var address
      for I := 1 to ResultRegisterSGrid.RowCount-1 do
      begin
        ResultRegisterSGrid.Cells[0, I] := Format('%s%d', [VarAdrPrefix, VarAdr+I-1]);
      end;

      // Restore all result names
      NameResult := TStringList.Create;
      Explode(Database.FieldByName('NAME_RESULT').AsString, NameResult, True, [Sep]);
      ColName := ResultRegisterSGrid.Rows[0].IndexOf(_('Name'));
      for I := 1 to ResultRegisterSGrid.RowCount-1 do
      begin
        if I > NameResult.Count then 
          ResultRegisterSGrid.Cells[ColName, I] :=  ''
        else
          ResultRegisterSGrid.Cells[ColName, I] := TrimLeft(NameResult[I-1]);
      end;
      NameResult.Free;

      // Show data
      PWord := @DWord;
      PFloat := @DWord;
      for I := 0 to Data.Count-1 do begin
        DWord := 0;

        // Word
        Value := StrToInt(Data[I]);
        if Swap then WordSwap(Value); // Swap word Lo/hi bytes ?

        // DWord/Float
        S1 := Data[I];
        if (I < Data.Count-1) then S2 := Data[I+1] else S2 := '';
        if S1 = '' then
          W1 := 0
        else
          W1 := StrToInt(S1);
        if S2 = '' then
          W2 := 0
        else
          W2 := StrToInt(S2);
        if Swap then begin // Swap word Lo/hi bytes ?
          WordSwap(W1);
          WordSwap(W2);
        end;
        PWord[0] := W1;
        PWord[1] := W2;

        if W1 > 32767 then // Signed Word (Int)
          I1 := -(65536 - W1)
        else
          I1 := W1;
        if DWord > 2147483647 then // Signed DWord (DInt)
          I2 := -(4294967296 - DWord)
        else
          I2 := DWord;
        Float := PFloat[0];

        // Result
        try LC := DateTimeToStr(StrToFloat(LastChange[I])); except LC := '-'; end;
        ResultRegisterSGrid.Cells[1, I+1] := IntToStr(I1);
        if ResultRegisterSGrid.ColCount <= 4 then begin
          // Boolean result
          ResultRegisterSGrid.Cells[3, I+1] := LC;
        end
        else begin
          // Numerical result
          ResultRegisterSGrid.Cells[2, I+1] := IntToStr(I2);
          ResultRegisterSGrid.Cells[3, I+1] := FloatToStrF(Float, ffGeneral, 8, 2);
          ResultRegisterSGrid.Cells[4, I+1] := IntToHex(Value, 4);
          ResultRegisterSGrid.Cells[5, I+1] := IntToBinary(Value, 16);
          ResultRegisterSGrid.Cells[7, I+1] := LC;
        end;

      end;

      // If no result available -> blank cells
      for I := Data.Count+1 to ResultRegisterSGrid.RowCount-1 do begin
        ResultRegisterSGrid.Cells[1, I] := '';
        ResultRegisterSGrid.Cells[2, I] := '';
        ResultRegisterSGrid.Cells[3, I] := '';
        ResultRegisterSGrid.Cells[4, I] := '';
        ResultRegisterSGrid.Cells[5, I] := '';
        ResultRegisterSGrid.Cells[7, I] := '';
      end;

      ResultRegisterSGrid.AutoSizeCol(-1, -1);
      ResultRegisterSGrid.Rows[0].EndUpdate;
    end
    else
    begin
      ResultRegisterSGrid.ColCount := 0;
      ResultRegisterSGrid.RowCount := 0;
    end;

  except
    ;
  end;

  ResTabControl.Images.Clear;
  ResTabControl.Images.AddImage(RequestImageList, Database.FieldByName('RESULT').AsInteger);

  LastChange.Free;
  Data.Free;
end;





//
// Timestamp last change of datas
//
function TMainForm.DoLastChangeData(Data, DataPrevious, LastChange: string): string;
var
  DataTab, DataPreviousTab, LastChangeTab: TStrings;
  S, S2, LC: string;
  I: integer;
begin
  S := ''; S2 := '';

  DataTab := TStringList.Create;
  DataPreviousTab := TStringList.Create;
  LastChangeTab := TStringList.Create;


  try

    // Get req data
    Explode(Data, DataTab, True, [Sep]);
    Explode(DataPrevious, DataPreviousTab, True, [Sep]);
    Explode(LastChange, LastChangeTab, True, [Sep]);

    // Check if data changed between two requests
    for I := 0 to DataTab.Count-1 do
    begin
      try LC := LastChangeTab[I]; except LC := ''; end;
      if (DataTab[I] <> DataPreviousTab[I]) or (LC = '') then begin
        S := S + S2 + FloatToStr(Now);
        S2 := Sep;
        PrintTracker(Database.FieldByName('NAME').AsString + ' - ' + Format(_('%s / New value %s (Old value %s)'), [ResultRegisterSGrid.Cells[0, I+1], DataTab[I], DataPreviousTab[I]]));
      end
      else begin
        S := S + S2 + LastChangeTab[I];
        S2 := Sep;
      end;
    end;

  except
    ;
  end;

  result := S;

  DataTab.Free;
  DataPreviousTab.Free;
  LastChangeTab.Free;
end;





//
// Request list buttons
//
procedure TMainForm.AddBtnClick(Sender: TObject);
var
  FuncCode: string;
  ModalRes: integer;
  Ok: boolean;
begin
  RequestForm.NameResult := '';

  if Sender <> nil then
  begin
    case ModbusTypeSelected of
      tcmIP  : ModalRes := RequestForm.EditIPReq;
      tcmCOM : ModalRes := RequestForm.EditCOMReq;
    end;
    Ok := RequestForm.ShowModal = mrOk;
  end
  else
    Ok := True; // Duplicate

  if Ok then begin
    with RequestForm do begin
      FuncCode := GetEnumName(TypeInfo(TMyMBusFuncCode), FunctionCBox.ItemIndex);
      Database.Insert;
      Database.FieldByName('ID').AsDateTime := Now;
      Database.FieldByName('IP').AsString := IpAdrEdit.Text;
      Database.FieldByName('PORT').AsInteger := IpPortEdit.Value;
      Database.FieldByName('SLAVE').AsInteger := SlaveAdrEdit.Value;
      Database.FieldByName('FUNCTION').AsString := StringReplace(FuncCode, MyMBusFuncCodePrefix, '', [rfReplaceAll, rfIgnoreCase]);
      Database.FieldByName('ADDRESS').AsInteger := VarAdrEdit.Value;
      Database.FieldByName('LENGTH').AsInteger := VarLengthEdit.Value;
      Database.FieldByName('VALUE').AsFloat := ValueEdit.Value;
      Database.FieldByName('SWAP').AsBoolean := SwapCBox.Checked;
      Database.FieldByName('NAME').AsString := NameEdit.Text;
      Database.FieldByName('NAME_RESULT').AsString := NameResult;
      Database.Post;
    end;
  end;

  AutoSizeCol(RequestDBGrid);
end;


procedure TMainForm.AddBtnMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  var
  aField: Variant;
  i: Integer;
  AddOne: integer;
begin
  AddOne := 0;
  if Button in [mbRight, mbMiddle] then begin

    // Duplicate a row (right and middle click)
    // and add one to slave address (if middle click)
    if Button in [mbMiddle] then AddOne := 1;


    if Database.RecordCount <= 0 then Exit;

    // Create a variant Array
    aField := VarArrayCreate([0, Database.Fieldcount-1], VarVariant);


    // read values into the array
    for i := 0 to (Database.Fieldcount-1) do
    begin
      aField[i] := Database.Fields[i].Value;
      if Database.FieldDefs[i].Name = 'SLAVE' then
      begin
        aField[i] := aField[i] + AddOne;
        if aField[i] > ModbusSlaveID_MAX then aField[i] := ModbusSlaveID_MAX;
      end;
    end;

    Database.Insert;

    // Put array values into new the record
    for i := 0 to (Database.Fieldcount-1) do
    begin
      Database.Fields[i].Value := aField[i];
    end;
    Database.Post;

    ShowRequestResult;
  end;
end;

//RequestForm.SlaveAdrEdit.Value := RequestForm.SlaveAdrEdit.Value + 1;



procedure TMainForm.DelBtnClick(Sender: TObject);
begin
  if Database.RecordCount > 0 then Database.Delete;
end;



procedure TMainForm.ClearBtnClick(Sender: TObject);
begin
  Database.DeleteRows(0, Database.RecordCount-1);
end;





procedure TMainForm.LoadBtnClick(Sender: TObject);
var
  Ok: boolean;
begin
  Ok := False;
  if (Sender <> nil) then Ok := OpenDlg.Execute;
  if Ok or (Sender = nil) then begin
    try
      NoRefreshRequestResult := True;
      if FileExists(OpenDlg.FileName) then begin
        Database.LoadFromFile(OpenDlg.FileName);
        Application.ProcessMessages;
        AutoSizeCol(RequestDBGrid);
        MRUList.AddString(OpenDlg.FileName);
        MRUList.EnumItems;
        OpenDlg.InitialDir := ExtractFileDir(OpenDlg.FileName);
        OpenDlg.FileName := ExtractFileName(OpenDlg.FileName);
        SaveDlg.InitialDir := OpenDlg.InitialDir;
        SaveDlg.FileName := OpenDlg.FileName;
        ShowRequestResult;
        MainForm.Caption := FormCaption + ' - ' + OpenDlg.FileName;
        ShowStatus(_('File loaded'));
      end else
        ShowStatus(_('Error'));
    finally
      NoRefreshRequestResult := False;
    end;
  end;
end;


procedure TMainForm.SaveBtnClick(Sender: TObject);
begin
  if SaveDlg.Execute then begin
    Database.SaveToFile(SaveDlg.FileName);
    MRUList.AddString(SaveDlg.FileName);
    MRUList.EnumItems;
    OpenDlg.InitialDir := ExtractFileDir(SaveDlg.FileName);
    OpenDlg.FileName := ExtractFileName(SaveDlg.FileName);
    SaveDlg.InitialDir := OpenDlg.InitialDir;
    SaveDlg.FileName := OpenDlg.FileName;
    MainForm.Caption := FormCaption + ' - ' + OpenDlg.FileName;
  end;
end;




procedure TMainForm.DebugCBClick(Sender: TObject);
begin
  DebugForm.Visible := DebugCB.Checked;
  DebugForm.BringToFront;
end;






procedure TMainForm.TrackerCBClick(Sender: TObject);
begin
  TrackerForm.Visible := TrackerCB.Checked;
  TrackerForm.BringToFront;
end;




//
// MRU
//
procedure TMainForm.MRUListEnumText(Sender: TObject; Value: String;
  Index: Integer);
var
  Menu: TMenuItem;
begin
  if Value <> '' then begin

    if MRUMenu.Items.Find(Value) = nil then begin
      Menu := TMenuItem.Create(nil);
      Menu.Caption := Value;
      Menu.OnClick := MRUItemClick;
      Menu.Tag := Index;
      MRUMenu.Items.Add(Menu);
    end
    else
      null;

  end;
end;




procedure TMainForm.MRUItemClick(Sender: TObject);
begin
  OpenDlg.FileName := TMenuItem(Sender).Caption;
  LoadBtnClick(nil);
end;



procedure TMainForm.MRUClearListClick(Sender: TObject);
var
  I: integer;
begin
  // Delete all MRU items
  for I := MRUList.GetItemsCount - 1 downto 0 do
  begin
    MRUList.DeleteItem(I);
  end;

  // Delete all popup items
  for I := MRUMenu.Items.Count - 1 downto 0 do
  begin
    if MRUMenu.Items[I].Tag <> -1 then MRUMenu.Items.Delete(I);
  end;

end;



//
// Setup
//
procedure TMainForm.SetupBtnClick(Sender: TObject);
begin
  case ModbusTypeSelected of
    tcmIP  : SetupIPForm.ShowModal;
    tcmCOM : SetupCOMForm.ShowModal;
  end;
end;



//
// Data transfert
//
procedure TMainForm.TransferBtnClick(Sender: TObject);
begin
  case ModbusTypeSelected of
    tcmIP  : TransfertIPForm.ShowModal;
    tcmCOM : TransfertCOMForm.ShowModal;
  end;
end;



//
// Scan
//
procedure TMainForm.BusScanBtnClick(Sender: TObject);
begin
  case ModbusTypeSelected of
    tcmIP  : ScanIPForm.ShowModal;
    tcmCOM : ScanCOMForm.ShowModal;
  end;
end;




//
// Application event
//

procedure TMainForm.ApplicationEventsIdle(Sender: TObject; var Done: Boolean);
begin
  AppLaunched := True;
  ApplicationEvents.OnIdle := nil;
end;




//
// Logo
//
procedure TMainForm.LogoClick(Sender: TObject);
begin
  ShellExecute(Handle,'OPEN','http://gunayato.free.fr',Nil,Nil,SW_SHOW);
end;


procedure TMainForm.LoopCBClick(Sender: TObject);
begin

end;

//
// Refresh result
//
procedure TMainForm.DatabaseAfterScroll(DataSet: TDataSet);
begin
  if NoRefreshRequestResult then Exit;
  
  ShowRequestResult;
  if RequestActive or Not AppLaunched then Exit;
  try
    if Database.FieldByName('RESULT_MSG').AsString <> '' then
      ShowStatus(Database.FieldByName('RESULT_MSG').AsString)
    else
      ShowStatus('');
  except
    ;
  end;
end;



//
// Request details window
//
procedure TMainForm.RequestDBGridDblClick(Sender: TObject);
var
  FuncCodeIdx, ModalRes: integer;
  FuncCode: string;
  Value: single;
begin
  if Database.RecordCount = 0 then Exit;

  FuncCodeIdx := GetEnumValue(TypeInfo(TMyMBusFuncCode), MyMBusFuncCodePrefix + Database.FieldByName('FUNCTION').AsString);

  with RequestForm do begin
    IpAdrEdit.Text := Database.FieldByName('IP').AsString;
    IpPortEdit.Value := Database.FieldByName('PORT').AsInteger ;
    FunctionCBox.ItemIndex := FuncCodeIdx;
    SlaveAdrEdit.Value := Database.FieldByName('SLAVE').AsInteger;
    VarAdrEdit.Value := Database.FieldByName('ADDRESS').AsInteger;
    SwapCBox.Checked := Database.FieldByName('SWAP').AsBoolean;
    VarLengthEdit.Value := Database.FieldByName('LENGTH').AsInteger;
    if FunctionCBox.ItemIndex in [4, 6] then
      BitCBox.Checked := (Database.FieldByName('VALUE').AsInteger = Integer(True))
    else
      ValueEdit.Value := Database.FieldByName('VALUE').AsInteger;
    NameEdit.Text := Database.FieldByName('NAME').AsString;
    NameResult := Database.FieldByName('NAME_RESULT').AsString;

    FunctionCBoxChange(nil);

    // Show request form
    case ModbusTypeSelected of
      tcmIP  : ModalRes := EditIPReq;
      tcmCOM : ModalRes := EditCOMReq;
    end;
    if ModalRes = mrOk then begin
      FuncCode := GetEnumName(TypeInfo(TMyMBusFuncCode), FunctionCBox.ItemIndex);
      if FunctionCBox.ItemIndex in [4, 6] then
        Value := Integer(BitCBox.Checked)
      else
        Value := ValueEdit.Value;

      Database.Edit;
      Database.FieldByName('IP').AsString := IpAdrEdit.Text;
      Database.FieldByName('PORT').AsInteger := IpPortEdit.Value;
      Database.FieldByName('SLAVE').AsInteger := SlaveAdrEdit.Value;
      Database.FieldByName('FUNCTION').AsString := StringReplace(FuncCode, MyMBusFuncCodePrefix, '', [rfReplaceAll, rfIgnoreCase]);
      Database.FieldByName('ADDRESS').AsInteger := VarAdrEdit.Value;
      Database.FieldByName('LENGTH').AsInteger := VarLengthEdit.Value;
      Database.FieldByName('VALUE').AsFloat := Value;
      Database.FieldByName('SWAP').AsBoolean := SwapCBox.Checked;
      Database.FieldByName('NAME').AsString := NameEdit.Text;
      Database.FieldByName('NAME_RESULT').AsString := NameResult;
      Database.Post;
    end;
    ShowRequestResult;
  end;

end;




//
// Result name modification
//
procedure TMainForm.ResultRegisterSGridDblClick(Sender: TObject);
var
  S, S2, S3: string;
  I, ColName: integer;
begin
  if (Database.RecordCount = 0) or (ResultRegisterSGrid.RowCount <= 1) then Exit;

  ColName := ResultRegisterSGrid.Rows[0].IndexOf(_('Name'));
  S := TrimLeft(ResultRegisterSGrid.Cells[ColName, ResultRegisterSGrid.Row]);
  if InputQuery(_('Prompt'), _('Enter a name'), S) then begin
    // Set name
    ResultRegisterSGrid.Cells[ColName, ResultRegisterSGrid.Row] := TrimLeft(S);
    // Save all result names
    S := ''; S2 := '';
    for I := 1 to ResultRegisterSGrid.RowCount-1 do
    begin
      S3 := ResultRegisterSGrid.Cells[ColName, I];
      if S3 = '' then S3 := ' ';
      S := S + S2 + S3;
      S2 := Sep;
    end;
    Database.Edit;
    Database.FieldByName('NAME_RESULT').AsString := S;
    Database.Post;
  end;
end;




//
// Grid result
//
procedure TMainForm.RequestDBGridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  CellColorSave: TColor;
  CellStyleSave: TBrushStyle;
  Bitmap: TBitmap;
  Rect2: TRect;
  X, Y: integer;
begin
  if Database.RecordCount = 0 then Exit;

  if Column.Field.FieldName = 'RESULT' then begin

    Bitmap := TBitmap.Create;
    try
        CellColorSave := RequestDBGrid.Canvas.Brush.Color;
        CellStyleSave := RequestDBGrid.Canvas.Brush.Style;

        case Column.Field.AsInteger of

          ReqState_Bad: begin
            RequestImageList.GetBitmap(0, Bitmap);
          end;

          ReqState_Ok: begin
            RequestImageList.GetBitmap(1, Bitmap);
          end;

          ReqState_InProgress: begin
            RequestImageList.GetBitmap(2, Bitmap);
          end;

          ReqState_TimeOut: begin
            RequestImageList.GetBitmap(3, Bitmap);
          end;

          ReqState_Exception: begin
            RequestImageList.GetBitmap(4, Bitmap);
          end;
        end;

        RequestDBGrid.Canvas.FillRect(Rect);
        X := ((Rect.Right - Rect.Left) div 2) - (Bitmap.Width div 2) + Rect.Left;
        Y := ((Rect.Bottom - Rect.Top) div 2) - (Bitmap.Height div 2) + Rect.Top;
        Rect2.TopLeft := Point(X, Y);
        Rect2.BottomRight := Point(X + Bitmap.Width, Y + Bitmap.Height);
        Bitmap.Transparent := True;
        RequestDBGrid.Canvas.StretchDraw(Rect2, Bitmap);

        RequestDBGrid.Canvas.Brush.Color := CellColorSave;
        RequestDBGrid.Canvas.Brush.Style := CellStyleSave;

    finally
      Bitmap.Free;
    end;

  end;
end;




//
// Move up or down a record
//
procedure TMainForm.OrderDownBtnClick(Sender: TObject);
var
  aField : Variant;
  i      : Integer;
begin
  if Database.RecordCount <= 0 then Exit;
  if Database.RecNo = Database.RecordCount-1 then Exit;

  // Create a variant Array
  aField := VarArrayCreate([0, Database.Fieldcount-1], VarVariant);

  // read values into the array
  for i := 0 to (Database.Fieldcount-1) do
  begin
     aField[i] := Database.Fields[i].Value ;
  end;

    Database.Delete;
    if Database.RecNo <> Database.RecordCount-1 then begin
    Database.Next;
    Database.Insert;
  end
  else begin
    Database.Append;
  end;


  // Put array values into new the record
  for i := 0 to (Database.Fieldcount-1) do
  begin
     Database.Fields[i].Value := aField[i] ;
  end;
  Database.Post;

  ShowRequestResult;
end;



procedure TMainForm.OrderUpBtnClick(Sender: TObject);
var
  aField: Variant;
  i: Integer;
begin
  if Database.RecordCount <= 0 then Exit;
  if Database.RecNo = 0 then Exit;

  // Create a variant Array
  aField := VarArrayCreate([0, Database.Fieldcount-1], VarVariant);

  // read values into the array
  for i := 0 to (Database.Fieldcount-1) do
  begin
     aField[i] := Database.Fields[i].Value ;
  end;

  if Database.RecNo <> Database.RecordCount-1 then begin
    Database.Delete;
    Database.Prior;
  end
  else
    Database.Delete;
  Database.Insert;

  // Put array values into new the record
  for i := 0 to (Database.Fieldcount-1) do
  begin
     Database.Fields[i].Value := aField[i] ;
  end;
  Database.Post;

  ShowRequestResult;
end;



//
// Export to CSV
//
procedure TMainForm.ExportBtnClick(Sender: TObject);
begin
  if Database.RecordCount <= 0 then Exit;
  if SaveExportDlg.Execute then begin
    ResultRegisterSGrid.SaveToCSV(SaveExportDlg.FileName);
  end;
end;
















end.

