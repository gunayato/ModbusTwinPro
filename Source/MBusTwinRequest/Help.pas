unit Help;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, JvExStdCtrls, OleCtrls, ExtCtrls,
  JvDataEmbedded, ComCtrls;

type
  THelpForm = class(TForm)
    HelpPanel: TPanel;
    RichEdit: TRichEdit;
    HelpEngData: TJvDataEmbedded;
    HelpFraData: TJvDataEmbedded;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  HelpForm: THelpForm;

implementation

{$R *.dfm}

uses gnugettext;


procedure THelpForm.FormCreate(Sender: TObject);
begin
  DefaultInstance.TranslateComponent(self);

  RichEdit.Clear;
  if _('ENG') =  'FRA' then begin
    RichEdit.Lines.LoadFromStream(HelpFraData.Data);
  end
  else begin
    RichEdit.Lines.LoadFromStream(HelpEngData.Data);
  end;
end;





end.
