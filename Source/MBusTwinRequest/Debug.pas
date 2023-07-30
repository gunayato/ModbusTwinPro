unit Debug;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, JvExControls, JvComponent, JvSpeedButton;

type
  TDebugForm = class(TForm)
    Label7: TLabel;
    RequestMemo: TMemo;
    StayOnTopCB: TCheckBox;
    ClearBtn: TJvSpeedButton;
    HexCB: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure StayOnTopCBClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ClearBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  procedure PrintRequest(Text: string);
  procedure PrintResult(Text: string);

var
  DebugForm: TDebugForm;

implementation

uses gnugettext, Main;

{$R *.dfm}



procedure PrintRequest(Text: string);
var
  S: string;
begin
  if not DebugForm.Visible then Exit;
  if Text = '' then Exit;
  if DebugForm.RequestMemo.Lines.Count > 1000 then
    DebugForm.RequestMemo.Lines.Delete(0);
  S := '<S>' + DateTimeToStr(Now) + ' / ' + Text;
  DebugForm.RequestMemo.Lines.Add(S);
end;



procedure PrintResult(Text: string);
var
  S: string;
begin
  if not DebugForm.Visible then Exit;
  if Text = '' then Text := '<null>';
  if DebugForm.RequestMemo.Lines.Count > 1000 then
    DebugForm.RequestMemo.Lines.Delete(0);
  S := '<R>' + DateTimeToStr(Now) + ' / ' + Text;
  DebugForm.RequestMemo.Lines.Add(S);
end;



procedure TDebugForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  MainForm.DebugCB.Checked := False;
end;


procedure TDebugForm.StayOnTopCBClick(Sender: TObject);
begin
  if StayOnTopCB.Checked then
    FormStyle := fsStayOnTop
  else
    FormStyle := fsNormal;
end;


procedure TDebugForm.FormShow(Sender: TObject);
begin
  Constraints.MaxWidth := Width;
end;

procedure TDebugForm.ClearBtnClick(Sender: TObject);
begin
  RequestMemo.Clear;
end;

procedure TDebugForm.FormCreate(Sender: TObject);
begin
  DefaultInstance.TranslateComponent(self);
end;

end.
