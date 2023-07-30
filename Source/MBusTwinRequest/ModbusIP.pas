unit ModbusIP;

interface

uses IdModBusClient, ModbusConsts, ModbusTypes, SysUtils, Forms;


procedure InitModbusIP;
procedure ExitModbusIP;
function RequestModbusIP(FuncCode, IpPort, SlaveAdr, VarAdr, VarLength, ReqTimeout, CntTimeout: integer;
                         Value: single; IpAdr: string; var Data: string): integer;
function GetErrorMsgIP: string;
function GetSendRequestIP(Hex: boolean): string;
function GetReceiveRequestIP(Hex: boolean): string;


var
  MBusIp: TIdModBusClient;


implementation

uses gnugettext, Main, MyFunctions;


procedure InitModbusIP;
begin
  MBusIp := TIdModBusClient.Create(nil);
end;


procedure ExitModbusIP;
begin
  if Assigned(MBusIp) then
    FreeAndNil(MBusIp);
end;



function RequestModbusIP(FuncCode, IpPort, SlaveAdr, VarAdr, VarLength, ReqTimeout, CntTimeout: integer;
                         Value: single; IpAdr: string; var Data: string): integer;
var
  Res: boolean;
  I: integer;
  S, S2: string;
  CoilsData: array[0..MaxCoils] of Boolean;
  RegistersData: array[0..MaxBlockLength] of Word;
begin
  Data := '';
  try
    with MBusIp do
    begin

      // Load parameters
      if Connected then DisConnect;
      UnitID := SlaveAdr;
      Host := IpAdr;
      Port := IpPort;
      TimeOut := ReqTimeout;
      ConnectTimeout := CntTimeout;

      // Connection
      ModBusErrCode := mbecNULL;
      try Connect; except ModBusErrCode := mbecCONNECTION; end;
      if Connected then begin

        // Func type
        Res := False;
        case FuncCode of
          0 : Res := ReadCoils(VarAdr + 1, VarLength, CoilsData);
          1 : Res := ReadInputBits(VarAdr + 1, VarLength, CoilsData);
          2 : Res := ReadHoldingRegisters(VarAdr + 1, VarLength, RegistersData);
          3 : Res := ReadInputRegisters(VarAdr + 1, VarLength, RegistersData);
          4 : begin
                Res := WriteCoil(VarAdr + 1, Boolean(Trunc(Value)));
              end;
          5 : begin
                Res := WriteRegister(VarAdr + 1, Trunc(Value));
              end;
          6 : begin
                if VarLength > Length(CoilsData) then VarLength := Length(CoilsData);
                for I := 0 to VarLength-1 do
                  CoilsData[I] := Boolean(Trunc(Value));
                Res := WriteCoils(VarAdr + 1, VarLength, CoilsData)
              end;
          7 : begin
                if VarLength > Length(RegistersData) then VarLength := Length(RegistersData);
                for I := 0 to VarLength-1 do RegistersData[I] := Trunc(Value);
                Res := WriteRegisters(VarAdr + 1, VarLength, RegistersData)
              end;
        end;


        // Request ok then get values
        if Res then
        begin
          Result := ReqState_Ok;
          S := ''; S2 := '';

          // ReadRegister result
          if FuncCode in [2, 3] then
          begin
            for I := 0 to VarLength-1 do
            begin
              S := S + S2 + IntToStr(RegistersData[I]);
              S2 := Sep;
            end;
            Data := S;
           end

          // ReadCoil result
          else if FuncCode in [0, 1] then
          begin
            for I := 0 to VarLength-1 do
            begin
              S := S + S2 + Bool2Str(CoilsData[I]);
              S2 := Sep;
            end;
            Data := S;
          end

        end
        else begin
          if (ModbusErrCode = mbecEXCEPTION) or (ModbusErrCode = mbecUndefined) then
            Result := ReqState_Exception
          else
            Result := ReqState_Bad;
        end;

      end
      else
        Result := ReqState_TimeOut;

    end;

  finally
    MBusIp.DisConnect;
  end;
end;





function GetErrorMsgIP: string;
var
  ErrStr: string;
begin
  Result := '';
  with MBusIp do
  begin
    case ModBusErrCode of
      mbecOK:        ErrStr := 'Ok';
      mbecUndefined: ErrStr := 'Error';
      mbecNOANSWER:  ErrStr := 'No answer';
      mbecEXCEPTION: ErrStr := 'Exception';
      mbecCONNECTION:ErrStr := 'Connection';
    end;
    Result := ErrStr;
  end;
end;








function GetSendRequestIP(Hex: boolean): string;
var
  S, S2, FormatReq: string;
  I: integer;
  P: PByteArray;
begin
  S := ''; S2 := '';
  if Hex then FormatReq := '%.2x' else FormatReq := '%d';
  with MBusIp do
  begin
    P := @SendBuffer;
    for I := 0 to Swap(SendBuffer.Header.RecLength) + 6 - 1 do begin
      S := S + S2 + Format(FormatReq, [ord(P[I])]);
      S2 := '-';
    end;
    Result := S;
  end;
end;




function GetReceiveRequestIP(Hex: boolean): string;
var
  S, S2, FormatReq: string;
  I: integer;
  P: PByteArray;
begin
  S := ''; S2 := '';
  if Hex then FormatReq := '%.2x' else FormatReq := '%d';
  with MBusIp do
  begin
    P := @ReceiveBuffer;
    for I := 0 to Swap(ReceiveBuffer.Header.RecLength) + 6 - 1 do begin
      S := S + S2 + Format(FormatReq, [ord(P[I])]);
      S2 := '-';
    end;
    Result := S;
  end;
end;



end.
