unit Tracker;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, JvExControls, JvComponent, JvSpeedButton;

type
  TTrackerForm = class(TForm)
    Label7: TLabel;
    TrackerMemo: TMemo;
    StayOnTopCB: TCheckBox;
    ClearBtn: TJvSpeedButton;
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

  procedure PrintTracker(Text: string);

var
  TrackerForm: TTrackerForm;

implementation

uses gnugettext, Main;

{$R *.dfm}



procedure PrintTracker(Text: string);
var
  S: string;
begin
  if not TrackerForm.Visible then Exit;
  if Text = '' then Exit;
  if TrackerForm.TrackerMemo.Lines.Count > 30000 then
    TrackerForm.TrackerMemo.Lines.Delete(0);
  S := DateTimeToStr(Now) + ' / ' + Text;
  TrackerForm.TrackerMemo.Lines.Add(S);
end;




procedure TTrackerForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  MainForm.TrackerCB.Checked := False;
end;


procedure TTrackerForm.StayOnTopCBClick(Sender: TObject);
begin
  if StayOnTopCB.Checked then
    FormStyle := fsStayOnTop
  else
    FormStyle := fsNormal;
end;


procedure TTrackerForm.FormShow(Sender: TObject);
begin
  Constraints.MaxWidth := Width;
end;

procedure TTrackerForm.ClearBtnClick(Sender: TObject);
begin
  TrackerMemo.Clear;
end;

procedure TTrackerForm.FormCreate(Sender: TObject);
begin
  DefaultInstance.TranslateComponent(self);
end;

end.
