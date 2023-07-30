unit TransferCOM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, JvExMask, JvToolEdit, ComCtrls, JvSpin,
  JvExControls, JvSpeedButton, Grids, JvExGrids, JvStringGrid,
  ExtCtrls, StrUtils, JvComponentBase, JvFormAutoSize, MBusCPort, Spin;

type
  TTransfertCOMForm = class(TForm)
    StatusBar: TStatusBar;
    ToPlcBtn: TJvSpeedButton;
    FromPlcBtn: TJvSpeedButton;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    StartEdit: TJvSpinEdit;
    LengthEdit: TJvSpinEdit;
    RegistersWordSGrid: TJvStringGrid;
    SlaveAdrEdit: TSpinEdit;
    Label1: TLabel;
    SaveBtn: TJvSpeedButton;
    LoadBtn: TJvSpeedButton;
    FileEdit: TJvFilenameEdit;
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
    procedure StartEditChange(Sender: TObject);
    procedure LengthEditChange(Sender: TObject);
  private
    { Private declarations }
    RegistersWordCol: integer;
    RegistersWordRow: integer;
    NoRefresh: boolean;
    procedure ShowStatus(Txt: string);
    procedure ClearGrid(Grid: TStringGrid; Start, Count: integer; Clear: boolean = True);
    procedure SetRegisterValue(const RegNo: Integer; Value: Integer);
    function GetRegisterValue(const RegNo: Integer): Smallint;
  public
    { Public declarations }
  end;

const
  DataFileExt = '.data';

  RegCol_No       = 0;  // Number of column index
  RegCol_Val      = 1;

  MW              = '%MW';

var
  TransfertCOMForm: TTransfertCOMForm;

implementation

uses gnugettext, Main, ModbusCOM;

{$R *.dfm}


//
// Status bar
//
procedure TTransfertCOMForm.ShowStatus(Txt: string);
begin
  StatusBar.SimpleText := Txt;
  Application.ProcessMessages;
  Sleep(200);
end;



//
// Form
//
procedure TTransfertCOMForm.FormShow(Sender: TObject);
begin
//
end;

procedure TTransfertCOMForm.FormCreate(Sender: TObject);
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
  ClearGrid(RegistersWordSGrid, Trunc(StartEdit.Value), Trunc(LengthEdit.Value));
end;



//
// Get data from plc
//
procedure TTransfertCOMForm.FromPlcBtnClick(Sender: TObject);
var
  Start, Len, BlockLength, RegNumber: integer;
  SlaveAdr, I, Line: integer;
  Res: boolean;
begin
  Start := Trunc(StartEdit.Value);
  Len := Trunc(LengthEdit.Value);
  ClearGrid(RegistersWordSGrid, Start, Len);
  Line := 1;

  try

    with MBus do begin

      if not Connected then MBus.Open;

      // Reading loop
      repeat
        // Frame parameter
        RegNumber := Start;
        if Len < Max_Words then
          BlockLength := Len
        else
          BlockLength := Max_Words;

        // Go !
        ShowStatus(Format(_('Reading address %d'), [Start]));
        try
          ReadNRegister(SlaveAdrEdit.Value, RegNumber, BlockLength, HoldingRegister);
        except
          ;
        end;

        // Error
        if not (ErrorCode = MBus_OK) then begin
          ShowStatus(Format(_('Error in reading address %d !'), [Start]));
          Exit;
        end;

        // Result
        for I := 0 to BlockLength-1 do begin
//          RegistersWordSGrid.Cells[RegCol_No, Line] := MW+Format('%d', [Start+I-1]);
          RegistersWordSGrid.Cells[RegCol_Val, Line] := IntToStr(WordsArray[I]);
          Inc(Line);
        end;

        // Next frame
        Start := Start + Max_Words;
        Len := Len - Max_Words;
      until Len <= 0;

      ShowStatus(_('Get from plc terminated'));
    end;

    Close;
    
  except
    MessageDlg(_('Error: No com port available ?'), mtError , [mbOk], 0);
  end;
end;




//
// Send data to plc
//
procedure TTransfertCOMForm.ToPlcBtnClick(Sender: TObject);
var
  Start, Len, BlockLength, RegNumber: integer;
  I, V, Line: integer;
  Res: boolean;
  S: string;
  ArW: array of Word;
begin
  SetLength(ArW, Max_Words+1);
  S := AnsiReplaceText(RegistersWordSGrid.Cells[RegCol_No, 1], MW, '');
  if not TryStrToInt(S, V) then Exit;
  Start := V;
  Len := RegistersWordSGrid.RowCount - 1;
  Line := 1;

  try

    with MBus do begin

      if not Connected then MBus.Open;

      // Reading loop
      repeat
        // Frame parameter
        RegNumber := Start;
        if Len < Max_Words then
          BlockLength := Len
        else
          BlockLength := Max_Words;

        // Build word buffer
        for I := 0 to BlockLength-1 do begin
          ArW[I] := GetRegisterValue(Line);
          Inc(Line);
        end;

        // Go !
        ShowStatus(Format(_('Writing address %d'), [Start]));
        try
          WriteNRegister(SlaveAdrEdit.Value, RegNumber, BlockLength, ArW);
        except
          ;
        end;

        // Error
        if not (ErrorCode = MBus_OK) then begin
          ShowStatus(Format(_('Error in writing address %d !'), [Start]));
          Exit;
        end;

        // Next frame
        Start := Start + Max_Words;
        Len := Len - Max_Words;
      until Len <= 0;

      ShowStatus(_('Send to plc terminated'));
    end;

    Close;
    
  except
    MessageDlg(_('Error: No com port available ?'), mtError , [mbOk], 0);
  end;
end;





//
// Grid
//
procedure TTransfertCOMForm.StartEditChange(Sender: TObject);
begin
  if not NoRefresh then
    ClearGrid(RegistersWordSGrid, Trunc(StartEdit.Value), Trunc(LengthEdit.Value));
end;

procedure TTransfertCOMForm.LengthEditChange(Sender: TObject);
begin
  if not NoRefresh then
    ClearGrid(RegistersWordSGrid, Trunc(StartEdit.Value), Trunc(LengthEdit.Value), False);
end;


procedure TTransfertCOMForm.ClearGrid(Grid: TStringGrid; Start, Count: integer; Clear: boolean = True);
var
  I: Integer;
begin
  Inc(Count);
  with Grid do begin

    if Count > 0 then
      RowCount := Count
    else
      RowCount := 2;

    if Start >=0 then
      for I := 1 to RowCount do begin
        Cells[RegCol_No, I] := MW+Format('%d', [Start+I-1]);
        if Clear then Cells[RegCol_Val, I] := '';
      end;

  end;
  Application.ProcessMessages;
end;


procedure TTransfertCOMForm.RegistersWordSGridKeyPress(Sender: TObject;
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

procedure TTransfertCOMForm.RegistersWordSGridGetEditText(Sender: TObject;
  ACol, ARow: Integer; var Value: String);
begin
  RegistersWordCol := ACol;
  RegistersWordRow := ARow;
end;

procedure TTransfertCOMForm.RegistersWordSGridExitCell(Sender: TJvStringGrid;
  AColumn, ARow: Integer; const EditText: String);
var
  Key: char;
begin
  Key := #13;
  RegistersWordSGridKeyPress(Sender, Key); // 'Enter' key simul
end;


procedure TTransfertCOMForm.SetRegisterValue(const RegNo: Integer; Value: integer);
begin
    if Value > +32767 then Value := +32767;
    if Value < -32768 then Value := -32768;
    RegistersWordSGrid.Cells[RegCol_Val, RegNo] := IntToStr(Value);
end;


function TTransfertCOMForm.GetRegisterValue(const RegNo: Integer): Smallint;
begin
  if (RegNo <= RegistersWordSGrid.RowCount -1) then
    Result := StrToInt(RegistersWordSGrid.Cells[RegCol_Val, RegNo])
  else
    Result := 0;
end;



//
// File
//
procedure TTransfertCOMForm.SaveBtnClick(Sender: TObject);
begin
  if FileEdit.Text <> '' then begin
    RegistersWordSGrid.SaveToCSV(ChangeFileExt(FileEdit.Text, DataFileExt));
    ShowStatus(_('Save terminated'));
  end;
end;



procedure TTransfertCOMForm.LoadBtnClick(Sender: TObject);
var
  Start: integer;
  S: string;
begin
  NoRefresh := True;
  try

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

  finally
    NoRefresh := False;
  end;
end;





end.
