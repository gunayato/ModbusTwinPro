unit MyFunctions;

interface

uses SysUtils, Windows, Classes, Types, Forms, DB, DBGrids, JclFileUtils;

procedure WordSwap(var a: word);

function Bool2Str(B: Boolean): string;

procedure Explode(S: string; Into: TStrings; ClearList: boolean = False; Sep: TSysCharSet = [' ', ',']);

function GetAppVersion: string;

function IntToBinary(const Value: Int64; const ALength: Integer): String;
function BinaryToInt(Value: String): Int64;

procedure AutoSizeCol(aGrid: TDBGrid);

procedure SetFormPosition(Form: TForm);



implementation



//
// Swap word bytes
//
procedure WordSwap(var a: word);
begin
  a := word(a shl 8) + byte(a shr 8);
end;



//
// Boolean to string conversion
//
function Bool2Str(B: Boolean): string;
const
  cSimpleBoolStrs: array [boolean] of String = ('0', '1');
begin
    Result := cSimpleBoolStrs[B];
end;


//
// Explode a string
//
procedure Explode(S: string; Into: TStrings; ClearList: boolean = False; Sep: TSysCharSet = [' ', ',']);
var
  i, n: integer;
  currentWord: string;
begin
  if ClearList then Into.Clear;
  n := Length(s);
  i := 1;
  while (i <= n) do
  begin
    currentWord := '';
    // Skip separator
    while (i <= n) and (S[i] in Sep) do
      inc(i);
    // Get word
    while (i <= n) and not (S[i] in Sep) do
    begin
      currentWord := currentWord + S[i];
      Inc(i);
    end;
    if (currentWord <> '') then Into.Add(currentWord);
  end;
end;




//
// Version function
//
function GetAppVersion: string;
begin
  result := VersionFixedFileInfoString(Application.ExeName);
end;



//
// Integer/Binary
//
function IntToBinary(const Value: Int64; const ALength: Integer): String;
var
  iWork: Int64;
begin
  Result := '';
  iWork := Value;
  while (iWork > 0) do
  begin
    Result := IntToStr(iWork mod 2) + Result;
    iWork := iWork div 2;
  end;
  while (Length(Result) < ALength) do
    Result := '0' + Result;
end; { IntToBinary }




function BinaryToInt(Value: String): Int64;
var
  i, Size: Integer;
begin
  Result := 0;
  Size := Length(Value);
  for i := Size downto 1 do
    if Value[i] = '1' then Result := Result+(1 shl (Size-i));
end;




//
// Autosize column
//
procedure AutoSizeCol(aGrid: TDBGrid);
var
  MaxWidth, //Largeur maximale de la colonne
  MinWidth, //Largeur minimale de la colonne
  CurrentWidth: integer; //Largeur actuelle
  FieldSize: integer; //Taille du champ d'après son contenu
  DS: TDataSet;
  BookMark: TBookmark;
  Col: integer;
begin

  //Pour alléger l'écriture !...
  DS := aGrid.DataSource.DataSet;
  with aGrid do
  begin
    //Mémoriser la ligne actuellement sélectionnée
    BookMark := DS.GetBookmark;
    //Pour ne pas voir toutes les lignes défiler
    Ds.DisableControls;
    for Col := 0 to aGrid.Columns.Count - 1 do
      //ne traiter que les colonnes visibles
      if aGrid.Columns[Col].Visible then
      begin
        //prendre en compte la largeur des titres
        MaxWidth := Canvas.TextWidth(aGrid.Columns[Col].Title.Caption) + 5;
        MinWidth := MaxWidth;
        //Parcours de toutes les lignes de l'ensemble de données
        DS.First;
        while not DS.Eof do
        begin
          //Déterminer la largeur en pixels du contenu de l'enregistrement lu
          FieldSize := Canvas.TextWidth(aGrid.Columns[Col].Field.AsString) + 5;
          //Réajuster la largeur maximale ?
          if MaxWidth < FieldSize then
            MaxWidth := FieldSize;
          //Réajuster la largeur minimale ?
          if MinWidth > FieldSize then
            MinWidth := FieldSize;
          DS.Next;
        end;
        //Largeur de la colonne cliquée
        CurrentWidth := aGrid.Columns[Col].Width;

        if CurrentWidth <> MaxWidth then
          CurrentWidth := MaxWidth;

        if CurrentWidth < MinWidth then
          CurrentWidth := MinWidth;
        //Affectation de la nouvelle largeur à la colonne
        Columns[Col].Width := CurrentWidth;
      end; {if Grid.Columns[Col].Visible}
    //repositionner le curseur de l'ensemble de données
    DS.GotoBookmark(BookMark);
    DS.FreeBookmark(BookMark);
    //Rétablir l'affichage du TDbGrid
    DS.EnableControls;
  end;
end;




//
// Set correctly a popup form
//
procedure SetFormPosition(Form: TForm);
var
  Pos : TPoint;
  InvPartY, InvPartX: integer;
begin
  with Form do begin
    Windows.GetCursorPos(Pos);
    Left := Pos.X - Width div 2;
    Top := Pos.Y - Height div 2;
    InvPartX := Left + Width - Screen.DesktopWidth;
    if InvPartX > 0 then Left := Left - InvPartX;
    InvPartY := Top + Height - Screen.DesktopHeight;
    if InvPartY > 0 then Top := Top - InvPartY;
    if Left < 0 then Left := 0;
    if Top < 0 then Top := 0;
  end;
end;




end.
