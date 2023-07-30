unit Request;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin, JvExControls, JvSpeedButton, ExtCtrls, JvComCtrls,
  JvComponentBase, JvAppStorage, JvAppIniStorage, Menus, JvMenus,
  TypInfo;

type
  TRequestForm = class(TForm)
    BottomPanel: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Bevel1: TBevel;
    Label1: TLabel;
    OkBtn: TJvSpeedButton;
    VarAdrEdit: TSpinEdit;
    VarLengthEdit: TSpinEdit;
    FunctionCBox: TComboBox;
    ValueEdit: TSpinEdit;
    BitCBox: TCheckBox;
    SlaveAdrEdit: TSpinEdit;
    IpPopupMenu: TJvPopupMenu;
    IpOpenMenuClick: TMenuItem;
    IpSaveConfigClick: TMenuItem;
    LoadBtn: TJvSpeedButton;
    SaveModelBtn: TJvSpeedButton;
    IpPanel: TPanel;
    IPAdrEdit: TJvIPAddress;
    Label8: TLabel;
    Label7: TLabel;
    IPPortEdit: TSpinEdit;
    TopPanel: TPanel;
    Bevel2: TBevel;
    NameEdit: TEdit;
    Label6: TLabel;
    SwapCBox: TCheckBox;
    procedure FunctionCBoxChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure IpOpenMenuClickClick(Sender: TObject);
    procedure IpSaveConfigClickClick(Sender: TObject);
    procedure IPAdrEditChange(Sender: TObject);
    procedure OkBtnClick(Sender: TObject);
    procedure LoadBtnClick(Sender: TObject);
    procedure SaveModelBtnClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    NameResult: widestring;
    IpPanel_PosY: integer;
    BottomPanel_PosY: integer;
    function EditCOMReq: TModalResult;
    function EditIPReq: TModalResult;
  end;

var
  RequestForm: TRequestForm;

implementation

{$R *.dfm}

uses gnugettext, Main, IdModbusClient, ModbusConsts, Model, SetupIP;


function TRequestForm.EditIPReq: TModalResult;
begin
  IpPanel.Visible := True;
  BottomPanel.Top := BottomPanel_PosY;
  AdjustSize;
  result := ShowModal;
end;



function TRequestForm.EditCOMReq: TModalResult;
begin
  IpPanel.Visible := False;
  BottomPanel.Top := IpPanel_PosY;
  AdjustSize;
  result := ShowModal;
end;



procedure TRequestForm.FormCreate(Sender: TObject);
begin
  DefaultInstance.TranslateComponent(self);

  FunctionCBox.ItemIndex := 0;
  FunctionCBoxChange(nil);

  IpPanel_PosY := IpPanel.Top;
  BottomPanel_PosY := BottomPanel.Top;
end;



procedure TRequestForm.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then ModalResult := mrOk;
  if Key = VK_ESCAPE then ModalResult := mrCancel;
end;



procedure TRequestForm.FormShow(Sender: TObject);
begin
  //
end;




procedure TRequestForm.FunctionCBoxChange(Sender: TObject);
var
  MaxLen: integer;
begin
  // VarLength
  MaxLen := 0;
  case FunctionCBox.ItemIndex of
    0, 1, 4, 6:
      begin
        MaxLen := MaxCoils;
      end;
    2, 3, 5, 7:
      begin
        MaxLen := MaxBlockLength;
      end;
  end;
  if MaxLen > 0 then begin
    VarLengthEdit.MaxValue := MaxLen;
    VarLengthEdit.Value := VarLengthEdit.Value;
  end;

  case FunctionCBox.ItemIndex of
    4, 5:
      begin
        VarLengthEdit.Enabled := False;
      end;
  else
    begin
        VarLengthEdit.Enabled := True;
    end;
  end;

  // ValueEdit and BitCBox
  case FunctionCBox.ItemIndex of
    0, 1, 2, 3:
      begin
        ValueEdit.Enabled := False;
        BitCBox.Enabled := False;
      end;
    4, 6:
      begin
        ValueEdit.Enabled := False;
        BitCBox.Enabled := True;
      end;
    5, 7:
      begin
        ValueEdit.Enabled := True;
        BitCBox.Enabled := False;
      end;
  end;

  // SwapCBox
  case FunctionCBox.ItemIndex of
    2, 3, 5, 7:
      begin
        SwapCBox.Enabled := True;
      end;
  else
      begin
        SwapCBox.Enabled := False;
    end;
  end;
end;




procedure TRequestForm.IPAdrEditChange(Sender: TObject);
begin
  IPAdrEdit.Refresh; // To avoid weird display (bug ?)
end;



procedure TRequestForm.IpOpenMenuClickClick(Sender: TObject);
begin
  if MainForm.OpenIpDlg.Execute then begin
    with MainForm.IpFileStorage do begin
      FileName := MainForm.OpenIpDlg.FileName;
      Reload;
      IPAdrEdit.Text := ReadString('IP', '127.0.0.1');
      IPPortEdit.Value := ReadInteger('Port', 502);
      SlaveAdrEdit.Value := ReadInteger('Slave', 1);
      //SetupIPForm.TimeoutEdit.Value := ReadInteger('Timeout', 1000);
    end;
  end;
end;



procedure TRequestForm.IpSaveConfigClickClick(Sender: TObject);
begin
  if MainForm.SaveIpDlg.Execute then begin
    with MainForm.IpFileStorage do begin
      FileName := MainForm.SaveIpDlg.FileName;
      WriteString('IP', IPAdrEdit.Text);
      WriteInteger('Port', IPPortEdit.Value);
      WriteInteger('Slave', SlaveAdrEdit.Value);
      //WriteInteger('Timeout', SetupIPForm.TimeoutEdit.Value);
      Flush;
    end;
  end;
end;





procedure TRequestForm.OkBtnClick(Sender: TObject);
begin
  FunctionCBoxChange(FunctionCBox);
  if BitCBox.Enabled then
    if BitCBox.Checked then
      ValueEdit.Value := 1
    else
      ValueEdit.Value := 0;
end;



//
// Model load/save
//
procedure TRequestForm.LoadBtnClick(Sender: TObject);
begin
  ModelForm.ShowModal;
  if ModelForm.ModalResult = mrOk then begin
    with MainForm do begin
      if DatabaseModel.RecordCount <= 0 then Exit;
      FunctionCBox.ItemIndex := GetEnumValue(TypeInfo(TMyMBusFuncCode), DatabaseModel.FieldByName('FUNCTION').AsString);
      VarAdrEdit.Value := DatabaseModel.FieldByName('ADDRESS').AsInteger;
      VarLengthEdit.Value := DatabaseModel.FieldByName('LENGTH').AsInteger;
      ValueEdit.Value := DatabaseModel.FieldByName('VALUE').AsInteger;
      SwapCbox.Checked := DatabaseModel.FieldByName('SWAP').AsBoolean;
      NameEdit.Text := DatabaseModel.FieldByName('NAME').AsString;
      NameResult := DatabaseModel.FieldByName('NAME_RESULT').AsString;
    end;
  end;
end;



procedure TRequestForm.SaveModelBtnClick(Sender: TObject);
var
  S: string;
  Value: integer;
begin
  if FunctionCBox.ItemIndex in [4, 6] then
    Value := Integer(BitCBox.Checked)
  else
    Value := ValueEdit.Value;

  S := '';
  if InputQuery(_('Prompt'), _('Enter a model name'), S) then begin
    with MainForm do begin
      DatabaseModel.Insert;
      DatabaseModel.FieldByName('FUNCTION').AsString := GetEnumName(TypeInfo(TMyMBusFuncCode), FunctionCBox.ItemIndex);
      DatabaseModel.FieldByName('ADDRESS').AsInteger := VarAdrEdit.Value;
      DatabaseModel.FieldByName('LENGTH').AsInteger := VarLengthEdit.Value;
      DatabaseModel.FieldByName('VALUE').AsFloat := Value;
      DatabaseModel.FieldByName('SWAP').AsBoolean := SwapCbox.Checked;
      DatabaseModel.FieldByName('NAME').AsString := S;
      DatabaseModel.FieldByName('NAME_RESULT').AsString := NameResult;
      DatabaseModel.Post;
      ShowMessage(_('Model saved.'));
    end;
  end;
end;


end.
