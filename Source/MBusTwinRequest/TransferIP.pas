unit TransferIP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, JvExMask, JvToolEdit, ComCtrls, JvSpin,
  JvExControls, JvSpeedButton, Grids, JvExGrids, JvStringGrid,
  ExtCtrls, StrUtils, JvComponentBase, JvFormAutoSize,
  ModbusConsts, Spin, JvComCtrls, Menus, JvMenus, JvAppStorage,
  JvAppIniStorage;

type
  TTransfertIPForm = class(TForm)
    StatusBar: TStatusBar;
    IpPopupMenu: TJvPopupMenu;
    IpOpenMenuClick: TMenuItem;
    IpSaveConfigClick: TMenuItem;
    ToPlcBtn: TJvSpeedButton;
    FromPlcBtn: TJvSpeedButton;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label4: TLabel;
    StartEdit: TJvSpinEdit;
    LengthEdit: TJvSpinEdit;
    RegistersWordSGrid: TJvStringGrid;
    IPAdrEdit: TJvIPAddress;
    IPPortEdit: TSpinEdit;
    SlaveAdrEdit: TSpinEdit;
    LoadBtn: TJvSpeedButton;
    SaveBtn: TJvSpeedButton;
    FileEdit: TJvFilenameEdit;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FromPlcBtnClick(Sender: TObject);
    procedure RegistersWordSGridKeyPress(Sender: TObject; var Key: Char);
    procedure RegistersWordSGridGetEditText(Sender: TObject; ACol,
      ARow: Integer; var Value: String);
    procedure SaveBtnClick(Sender: TObject);
    procedure LoadBtnClick(Sender: TObject);
    procedure RegistersWordSGridExitCell(Sender: TJvStringGrid; AColumn,
      ARow: Integer; const EditText: String);
    procedure ToPlcBtnClick(Sender: TObject);
    procedure IpOpenMenuClickClick(Sender: TObject);
    procedure IpSaveConfigClickClick(Sender: TObject);
    procedure IPAdrEditChange(Sender: TObject);
  private
    { Private declarations }
    RegistersWordCol: integer;
    RegistersWordRow: integer;
    procedure ShowStatus(Txt: string);
    procedure ClearGrid(Grid: TStringGrid; Count: integer = -1);
    procedure SetRegisterValue(const RegNo: Integer; Value: Integer);
    function GetRegisterValue(const RegNo: Integer): Smallint;
  public
    { Public declarations }
  end;

const
  DataFileExt           = '.data';
  RegCol_No             = 0;  // Number of column index
  RegCol_Val            = 1;
  MW                    = '%MW';
  TransfMaxBlockLength  = 64; // Most compatible...

var
  TransfertIPForm: TTransfertIPForm;

implementation

uses gnugettext, Main, SetupIP, ModbusIP;

{$R *.dfm}


//
// Status bar
//
procedure TTransfertIPForm.ShowStatus(Txt: string);
begin
  StatusBar.SimpleText := Txt;
  Application.ProcessMessages;
  Sleep(200);
end;


//
// IP edit
//
procedure TTransfertIPForm.IPAdrEditChange(Sender: TObject);
begin
  IPAdrEdit.Refresh;
end;


//
// Form
//
procedure TTransfertIPForm.FormShow(Sender: TObject);
begin
//
end;

procedure TTransfertIPForm.FormCreate(Sender: TObject);
begin
  DefaultInstance.TranslateComponent(self);

  Constraints.MaxWidth := Width;
  Constraints.MinWidth := Width;
    
  // Set grid headers titles
  with RegistersWordSGrid do begin
    FixedFont := Font;
    ColCount := 2;
    Cells[RegCol_No, 0]     := _('Num');
    ColWidths[RegCol_No  ]  := 12 * (Font.Size) + 4;
    Cells[RegCol_Val, 0]    := _('Value');
    ColWidths[RegCol_Val ]  := 16 * (Font.Size) + 4;
  end;
end;



//
// Get data from plc
//
procedure TTransfertIPForm.FromPlcBtnClick(Sender: TObject);
var
  Start, Len: integer;
  I, Line, BlockLength: integer;
  Res: boolean;
  RegistersData: array[0..MaxBlockLength] of Word;
begin
  Start := Trunc(StartEdit.Value) + 1; // +1 = Modbus address convention
  Len := Trunc(LengthEdit.Value);
  ClearGrid(RegistersWordSGrid, Len+1);
  Line := 1;

  try

    with MBusIp do begin

      // Load parameters
      if Connected then DisConnect;
      UnitID := SlaveAdrEdit.Value;
      Host := IPAdrEdit.Text;
      Port := IPPortEdit.Value;
      TimeOut := SetupIPForm.ReqTimeoutEdit.Value;

      // Connection
      ShowStatus(_('Connecting to plc...'));
      try Connect; except ; end;
      if not Connected then begin
        ShowStatus(_('Error !'));
        Exit;
      end;

      // Reading loop
      repeat
        // Frame parameter
        if Len < TransfMaxBlockLength then
          BlockLength := Len
        else
          BlockLength := TransfMaxBlockLength;

        // Go !
        ShowStatus(Format(_('Reading address %d'), [Start-1]));
        try
          Res := ReadHoldingRegisters(Start, BlockLength, RegistersData);
        except
          Res := False;
        end;

        // Error
        if not Res then begin
          ShowStatus(Format(_('Error in reading address %d !'), [Start]));
          Exit;
        end;

        // Result
        for I := 0 to BlockLength-1 do begin
          RegistersWordSGrid.Cells[RegCol_No, Line] := MW+Format('%d', [Start+I-1]);
          RegistersWordSGrid.Cells[RegCol_Val, Line] := IntToStr(RegistersData[I]);
          Inc(Line);
        end;

        // Next frame
        Start := Start + TransfMaxBlockLength;
        Len := Len - TransfMaxBlockLength;
      until Len <= 0;

      ShowStatus(_('Get from plc terminated'));
    end;

  finally
    MBusIp.DisConnect;
  end;
end;




//
// Send data to plc
//
procedure TTransfertIPForm.ToPlcBtnClick(Sender: TObject);
var
  Start, Len, BlockLength: integer;
  I, V, Line: integer;
  Res: boolean;
  S: string;
  RegistersData: array[0..MaxBlockLength] of Word;
begin
  S := AnsiReplaceText(RegistersWordSGrid.Cells[RegCol_No, 1], MW, '');
  if not TryStrToInt(S, V) then Exit;
  Start := V + 1; // +1 = Modbus address convention
  Len := RegistersWordSGrid.RowCount - 1;
  Line := 1;

  try

    with MBusIp do begin

      UnitID := SlaveAdrEdit.Value;
      Host := IPAdrEdit.Text;
      Port := IPPortEdit.Value;
      TimeOut := SetupIPForm.ReqTimeoutEdit.Value;

      // Connection
      ShowStatus(_('Connecting to plc...'));
      try Connect; except ; end;
      if not Connected then begin
        ShowStatus(_('Error !'));
        Exit;
      end;

      // Reading loop
      repeat
        // Frame parameter
        if Len < TransfMaxBlockLength then
          BlockLength := Len
        else
          BlockLength := TransfMaxBlockLength;

        // Build word buffer
        for I := 0 to BlockLength-1 do begin
          RegistersData[I] := GetRegisterValue(Line);
          Inc(Line);
        end;

        // Go !
        ShowStatus(Format(_('Writing address %d'), [Start-1]));
        try
          Res := WriteRegisters(Start, BlockLength, RegistersData);
        except
          Res := False;
        end;

        // Error
        if not Res then begin
          ShowStatus(Format(_('Error in writing address %d !'), [Start]));
          Exit;
        end;

        // Next frame
        Start := Start + TransfMaxBlockLength;
        Len := Len - TransfMaxBlockLength;
      until Len <= 0;

      ShowStatus(_('Send to plc terminated'));
    end;

  finally
    MBusIp.DisConnect;
  end;
end;


//
// Grid
//
procedure TTransfertIPForm.ClearGrid(Grid: TStringGrid; Count: integer = -1);
var
  i: Integer;
begin
  with Grid do begin
    RowCount := 2;
    for i := 0 to (ColCount - 1) do
      Cells[i, 1] := '';
    if Count > 0 then RowCount := Count;
  end;
  Application.ProcessMessages;
end;


procedure TTransfertIPForm.RegistersWordSGridKeyPress(Sender: TObject;
  var Key: Char);
var
  I: integer;
begin
  // Key filter
  if RegistersWordCol = RegCol_Val then begin
    // Backspace
    if Key = #8 then Exit;
    if Key = #13 then begin
      if TryStrToInt(RegistersWordSGrid.Cells[RegistersWordCol, RegistersWordRow], I) then
        SetRegisterValue(RegistersWordRow, I);
    end
    else
      if not (Key in ['0','1','2','3','4','5','6','7','8','9', '-']) then Key := #0;
  end
  else
    Key := #0;

end;

procedure TTransfertIPForm.RegistersWordSGridGetEditText(Sender: TObject;
  ACol, ARow: Integer; var Value: String);
begin
  RegistersWordCol := ACol;
  RegistersWordRow := ARow;
end;

procedure TTransfertIPForm.RegistersWordSGridExitCell(Sender: TJvStringGrid;
  AColumn, ARow: Integer; const EditText: String);
var
  Key: char;
begin
  Key := #13;
  RegistersWordSGridKeyPress(Sender, Key); // 'Enter' key simul
end;


procedure TTransfertIPForm.SetRegisterValue(const RegNo: Integer; Value: integer);
begin
    if Value > +32767 then Value := +32767;
    if Value < -32768 then Value := -32768;
    RegistersWordSGrid.Cells[RegCol_Val, RegNo] := IntToStr(Value);
end;


function TTransfertIPForm.GetRegisterValue(const RegNo: Integer): Smallint;
begin
  if (RegNo <= RegistersWordSGrid.RowCount -1) then
    Result := StrToInt(RegistersWordSGrid.Cells[RegCol_Val, RegNo])
  else
    Result := 0;
end;




//
// File
//
procedure TTransfertIPForm.SaveBtnClick(Sender: TObject);
begin
  if FileEdit.Text <> '' then begin
    RegistersWordSGrid.SaveToCSV(ChangeFileExt(FileEdit.Text, DataFileExt));
    ShowStatus(_('Save terminated'));
  end;
end;


procedure TTransfertIPForm.LoadBtnClick(Sender: TObject);
var
  Start: integer;
  S: string;
begin
  if FileEdit.Text <> '' then begin
    RegistersWordSGrid.LoadFromCSV(ChangeFileExt(FileEdit.Text, DataFileExt));
    ShowStatus(_('Load terminated'));

    // Get start address and length
    if RegistersWordSGrid.RowCount > 1 then begin
      S := AnsiReplaceText(RegistersWordSGrid.Cells[RegCol_No, 1], MW, '');
      if TryStrToInt(S, Start) then begin
        StartEdit.Value := Start;
        LengthEdit.Value := RegistersWordSGrid.RowCount - 1;
      end;
    end;

  end;
end;




//
// Ip load/save
//
procedure TTransfertIPForm.IpOpenMenuClickClick(Sender: TObject);
begin
  if MainForm.OpenIpDlg.Execute then begin
    with MainForm.IpFileStorage do begin
      FileName := MainForm.OpenIpDlg.FileName;
      Reload;
      IPAdrEdit.Text := ReadString('IP', '127.0.0.1');
      IPPortEdit.Value := ReadInteger('Port', 502);
      SlaveAdrEdit.Value := ReadInteger('Slave', 1);
      SetupIPForm.ReqTimeoutEdit.Value := ReadInteger('ReqTimeout', 1000);
      SetupIPForm.ConnectTimeoutEdit.Value := ReadInteger('ConnectTimeout', 2000);
    end;
  end;
end;



procedure TTransfertIPForm.IpSaveConfigClickClick(Sender: TObject);
begin
  if MainForm.SaveIpDlg.Execute then begin
    with MainForm.IpFileStorage do begin
      FileName := MainForm.SaveIpDlg.FileName;
      WriteString('IP', IPAdrEdit.Text);
      WriteInteger('Port', IPPortEdit.Value);
      WriteInteger('Slave', SlaveAdrEdit.Value);
      WriteInteger('ReqTimeout', SetupIPForm.ReqTimeoutEdit.Value);
      WriteInteger('ConnectTimeout', SetupIPForm.ConnectTimeoutEdit.Value);
      Flush;
    end;
  end;
end;


end.
