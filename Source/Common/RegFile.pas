unit RegFile;

interface

uses SysUtils, Classes, Math, Windows;


function FindVolumeSerial(const Drive : PChar): Cardinal;
function LoadRegistrationFile(Filename: string; Product: Byte): boolean;
function SaveRegistrationFile(Filename: string): boolean;
procedure RegistrationCryptDeCrypt(Key:integer);
procedure RegistrationScramble;
function RegistrationChecksum(zerobased: Boolean): Longint;


const
  CryptKey              = 128;
  MaxInfoLen            = 1024;
  KeyFileName           = 'Key.dat';
  KeyExtFileName        = '.dat';

  Product_Any           = 255;
  Product_Twin          = 123;


type
  TRegistrationData = record
    CheckSum        : integer;
    Info            : array[0..MaxInfoLen] of AnsiChar;
    Product         : Byte;
  end;




var
  RegistrationData: TRegistrationData;
  RegisteredVersion: boolean;


implementation

//
// Harddisk serial number
//
function FindVolumeSerial(const Drive : PChar): Cardinal;
var
   VolumeSerialNumber : DWORD;
   MaximumComponentLength : DWORD;
   FileSystemFlags : DWORD;
begin
   Result:=0;

   GetVolumeInformation(
        Drive,
        nil,
        0,
        @VolumeSerialNumber,
        MaximumComponentLength,
        FileSystemFlags,
        nil,
        0) ;
   Result := VolumeSerialNumber;
end; (*FindVolumeSerial*)



//
// Load/save registration file
//
function LoadRegistrationFile(Filename: string; Product: Byte): boolean;
var
  Handle, Len, CS: Integer;
begin
  result := False;
  Len := sizeof(RegistrationData);
  Handle := FileOpen(Filename, fmOpenRead);
  if Handle = -1 then Exit; // Open error
  try
    FileRead(Handle, RegistrationData, Len);
    CS := RegistrationChecksum(False);
    RegistrationCryptDeCrypt(CryptKey);
    if (CS = RegistrationData.CheckSum) then
      if (Product = Product_Any) or (RegistrationData.Product = Product_Any) or
         (Product = RegistrationData.Product) then
       result := True;
  finally
    FileClose(Handle)
  end;
  RegisteredVersion := result;
end;



function SaveRegistrationFile(Filename: string): boolean;
var
  Handle: Integer;
begin
  result := False;
  Handle := FileCreate(Filename);
  try
    RegistrationScramble;  
    RegistrationCryptDeCrypt(CryptKey);
    RegistrationData.CheckSum := RegistrationChecksum(False);
    FileWrite(Handle, RegistrationData, sizeof(RegistrationData));
    RegistrationCryptDeCrypt(CryptKey);
    result := True;
  finally
    FileClose(Handle)
  end;
end;




//
// Crypt/Decrypt/Checksum of a string
//
procedure RegistrationCryptDeCrypt(Key: integer);
var
  I: integer;
begin
  Randomize;
  for I := 0 to sizeof(RegistrationData.Info)-1 do begin
    RegistrationData.Info[I] := AnsiChar(Byte(RegistrationData.Info[I]) xor Key shr 8);
  end;
end;


function RegistrationChecksum(zerobased: Boolean): Longint;
var
  I: integer;
  L: integer;
begin
  Result := 0;
  L := sizeof(RegistrationData.Info);
  if L > 0 then
  begin
    for I := 0 to L-1 do
      if zerobased then
        Inc(Result, Byte(RegistrationData.Info[I]) - 65)
    else
      Inc(Result, Byte(RegistrationData.Info[I]));
  end;
end;



procedure RegistrationScramble;
var
  I: integer;
  B: boolean;
begin
  Randomize;
  B := False;

  for I := 0 to sizeof(RegistrationData.Info)-1 do begin
    if (RegistrationData.Info[I]) = #0 then begin
      if B then
        RegistrationData.Info[I] := AnsiChar(RandomRange(32, 127));
      B := True;
    end;
  end;
end;



initialization
  RegisteredVersion := False;

end.
