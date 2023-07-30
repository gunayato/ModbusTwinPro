unit ModbusCOM;

interface

uses CPort, MBusCPort, SysUtils, Forms;


procedure InitModbusCOM;
procedure ExitModbusCOM;
function RequestModbusCOM(FuncCode, SlaveAdr, VarAdr, VarLength: integer;
                         Value: single; var Data: string): integer;
function GetErrorMsgCOM: string;
function GetSendRequestCOM(Hex: boolean): string;
function GetReceiveRequestCOM(Hex: boolean): string;


var
  MBus: TModBus;

implementation

uses gnugettext, Main, MyFunctions;


procedure InitModbusCOM;
begin
  MBus := TModBus.Create(nil);
  MBus.Name := 'MBus';
  MBus.LoadSettings(stIniFile, '.\' + IniFileName + '.ini');

  // Maximum time, in milliseconds, allowed to elapse between the arrival of two characters
  MBus.Timeouts.ReadInterval := 500;
  // Timeout = (MULTIPLIER * number_of_bytes) + CONSTANT
  MBus.Timeouts.ReadTotalMultiplier := 100;
  MBus.Timeouts.ReadTotalConstant := 1000;
end;


procedure ExitModbusCOM;
begin
  try
    if Assigned(MBus) then begin
      MBus.StoreSettings(stIniFile, '.\' + IniFileName + '.ini');
      FreeAndNil(MBus);
    end;
  finally
    ;
  end;
end;


function RequestModbusCOM(FuncCode, SlaveAdr, VarAdr, VarLength: integer;
                         Value: single; var Data: string): integer;
var
  Res: boolean;
  I: integer;
  S, S2: string;
  ArW: array of Word;
  ArB: array of Byte;  
begin
  Data := ''; S := ''; S2 := '';
  try

    if not MBus.Connected then MBus.Open;

    // Func type
    case FuncCode of
      0: MBus.ReadCoilInputStatus(SlaveAdr, VarAdr, VarLength, CoilStatus);
      1: MBus.ReadCoilInputStatus(SlaveAdr, VarAdr, VarLength, InputStatus);
      2: MBus.ReadNRegister(SlaveAdr, VarAdr, VarLength, HoldingRegister);
      3: MBus.ReadNRegister(SlaveAdr, VarAdr, VarLength, InputRegister);
      4: MBus.WriteCoil(SlaveAdr, VarAdr, Boolean(Trunc(Value)));
      5: MBus.Write1Register(SlaveAdr, VarAdr, Trunc(Value));
      6: begin
          SetLength(ArB, VarLength);
          for I := 0 to VarLength - 1 do ArB[I] := Byte(Trunc(Value));
          MBus.WriteNCoil(SlaveAdr, VarAdr, VarLength, ArB);
        end;
      7: begin
          SetLength(ArW, VarLength);
          for I := 0 to VarLength - 1 do ArW[I] := Trunc(Value);
          MBus.WriteNRegister(SlaveAdr, VarAdr, VarLength, ArW);
        end;
    else
      ;
    end;

  except
    result := ReqState_Bad;
    Exit;
  end;

  // Data result
  if MBus.ErrorCode = MBus_OK then begin
    // Bit result
    if FuncCode in [0, 1] then begin
      for I := 0 to VarLength-1 do
      begin
        S := S + S2 + Bool2Str(Boolean(MBus.BitsArray[I]));
        S2 := Sep;
      end;
      Data := S;
    end;
  end;
    // Register result
    if FuncCode in [2, 3] then begin
      for I := 0 to VarLength-1 do
      begin
        S := S + S2 + IntToStr(MBus.WordsArray[I]);
        S2 := Sep;
      end;
      Data := S;
    end;

  // Error or ok
  case MBus.ErrorCode of
    MBus_OK:
      result := ReqState_Ok;
    MBus_ERR_EXCEPTION :
      result := ReqState_Exception;
    MBus_ERR_NOANSWER:
      result := ReqState_TimeOut;
  else
    result := ReqState_Bad;
  end;    
end;





function GetErrorMsgCOM: string;
var
  ErrStr: string;
begin
  Result := '';
  with MBus do
  begin
    // Error code
    case ErrorCode of
      MBus_OK:            ErrStr := 'Ok';
      MBus_ERR_EXCEPTION: ErrStr := 'Exception';
      MBus_ERR_ANSWER:    ErrStr := 'Answer error';
      MBus_ERR_NOANSWER:  ErrStr := 'No answer';
    end;
    Result := ErrStr;
  end;
end;




function GetSendRequestCOM(Hex: boolean): string;
var
  S, S2, FormatReq: string;
  I: integer;
begin
  S := ''; S2 := '';
  if Hex then FormatReq := '%.2x' else FormatReq := '%d';
  with MBus do
  begin
    for I := 0 to RequestSz - 1 do begin
      S := S +  S2 + Format(FormatReq, [ord(RequestBuf[I])]);
      S2 := '-';
    end;
    Result := S;
  end;
end;




function GetReceiveRequestCOM(Hex: boolean): string;
var
  S, S2, FormatReq: string;
  I: integer;
begin
  S := ''; S2 := '';
  if Hex then FormatReq := '%.2x' else FormatReq := '%d';
  with MBus do
  begin
    for I := 0 to AnswerSz - 1 do begin
      S := S +  S2 + Format(FormatReq, [ord(AnswerBuf[I])]);
      S2 := '-';
    end;
    Result := S;
  end;
end;



end.
