unit Model;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, JvExDBGrids, JvDBGrid, JvExControls, JvSpeedButton;

type
  TModelForm = class(TForm)
    ModelDBGrid: TJvDBGrid;
    OkBtn: TJvSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ModelDBGridKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ModelDBGridDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ModelForm: TModelForm;

implementation

{$R *.dfm}

uses gnugettext, MyFunctions, Main;


procedure TModelForm.FormCreate(Sender: TObject);
var
  I: integer;
begin
  DefaultInstance.TranslateComponent(self);
  for I := 0 to ModelDBGrid.Columns.Count-1 do
    ModelDBGrid.Columns[I].Title.Caption := _(ModelDBGrid.Columns[I].Title.Caption);
end;

procedure TModelForm.FormShow(Sender: TObject);
begin
  if Not Assigned(ModelDBGrid.DataSource) then
    ModelDBGrid.DataSource := MainForm.DatabaseModelSource;
  AutoSizeCol(ModelDBGrid);
end;

procedure TModelForm.ModelDBGridDblClick(Sender: TObject);
begin
  if MainForm.DatabaseModel.RecordCount > 0 then
    OkBtn.Click;
end;

procedure TModelForm.ModelDBGridKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_DELETE then begin
    if MainForm.DatabaseModel.RecordCount > 0 then
      MainForm.DatabaseModel.Delete;
  end;
end;

end.
