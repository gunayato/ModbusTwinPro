unit MBusCPort;
{$I CPort.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  CPort;

const
	Buf_Size    = 260;
	Max_Words   = 127;
  Max_Bits    = 2040;

  MBus_Func_ReadCoilStatus        = 1;
  MBus_Func_ReadInputStatus       = 2;
	MBus_Func_ReadNHoldingRegister  = 3;
  MBus_Func_ReadNInputRegister    = 4;
  MBus_Func_WriteCoil             = 5;
  MBus_Func_Write1Register        = 6;
  MBus_Func_WriteNCoil            = 15;
  MBus_Func_WriteNRegister        = 16;

  BitWeight : array[0..7] of byte = (1, 2, 4, 8, 16, 32, 64, 128);

  
type
	TMBusBuf     = array[0..Buf_Size-1] of Byte;

  TMBusErrCode = (MBus_OK,MBus_ERR_SEND, MBus_ERR_READ,
                MBus_ERR_NOANSWER,MBus_ERR_ANSWER,MBus_ERR_EXCEPTION,
                MBus_ERR_DIFFUSION,MBus_ERR_NUMBER);

  TMBusReqType = (InputRegister, HoldingRegister, InputStatus, CoilStatus);

  TMBusWordsArray   = array[0..Max_Words-1] of smallint;
  TMBusBitsArray    = array[0..Max_Bits-1] of byte;

  TModBus = class(TCustomComPort)
  private
    FSlaveNum     : Byte;
    FAddress   	  : Word;
    FNumElements	: Word;
    FRequestSz  	: Word;
    FAnswerSz   	: Word;
    FFuncCode     : Byte;
    FRequestBuf 	: TMBusBuf;
    FAnswerBuf  	: TMBusBuf;
    FErrorCode    : TMBusErrCode;
    FWordsArray   : TMBusWordsArray;
    FBitsArray    : TMBusBitsArray;
  protected
    procedure DoAfterOpen; override;
    procedure DoError(Errors: TComErrors); override;
    procedure DoRxChar(Count: Integer); override;
  public
    constructor Create(AOwner: TComponent); override;
    function CRC16(Buf: TMBusBuf; Len: Word): Word;
    function AnalyseAnswer(Buf: TMBusBuf; Len: Word): TMBusErrCode;
    procedure BuildHeader(var Buf: TMBusBuf; SlaveNum: Byte; FuncCode: Byte; Address: Word; NumElements: Word = 0);
    procedure ReadNRegister(SlaveNum: Byte; Address: Word; NumElements: Word; RequestType: TMBusReqType);
    procedure WriteNRegister(SlaveNum: Byte; Address: Word; NumElements: Word; Value: array of Word);
    procedure Write1Register(SlaveNum: Byte; Address: Word; Value: Word);    
    procedure WriteNCoil(SlaveNum: Byte; Address: Word; NumElements: Word; Value: array of Byte);
    procedure WriteCoil(SlaveNum: Byte; Address: Word; Value: Boolean);
    procedure ReadCoilInputStatus(SlaveNum: Byte; Address: Word; NumElements: Word; RequestType: TMBusReqType);      

    property SlaveNum     : Byte read FSlaveNum write FSlaveNum;
    property Address    	: Word read FAddress write FAddress;
    property NumElements	: Word read FNumElements write FNumElements;
    property FuncCode   	: Byte read FFuncCode write FFuncCode;
    property RequestSz  	: Word read FRequestSz write FRequestSz;
    property AnswerSz   	: Word read FAnswerSz write FAnswerSz;        
    property RequestBuf 	: TMBusBuf read FRequestBuf write FRequestBuf;
    property AnswerBuf  	: TMBusBuf read FAnswerBuf write FAnswerBuf;
    property ErrorCode    : TMBusErrCode read FErrorCode write FErrorCode;
    property WordsArray   : TMBusWordsArray read FWordsArray write FWordsArray;
    property BitsArray    : TMBusBitsArray read FBitsArray write FBitsArray;    
  published
    property Connected;
    property BaudRate;
    property Port;
    property Parity;
    property StopBits;
    property DataBits;
    property DiscardNull;
    property EventChar;
    property Events;
    property Buffer;
    property FlowControl;
    property Timeouts;
    property SyncMethod;

  end;

procedure Register;

implementation


procedure Register;
begin
  RegisterComponents('ModBus', [TModBus]);
end;

constructor TModBus.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Timeouts.ReadInterval := 100;
  Timeouts.ReadTotalMultiplier := 100;
  Timeouts.ReadTotalConstant := 100;
end;

procedure TModBus.DoAfterOpen;
begin
  inherited DoAfterOpen;
end;

procedure TModBus.DoRxChar(Count: Integer);
begin
  inherited DoRxChar(Count);
end;

procedure TModBus.DoError(Errors: TComErrors);
begin
//  Application.ProcessMessages;
  if Errors = [] then Exit;
  inherited DoError(Errors);
end;




// Compute checksum
function TModBus.CRC16(Buf: TMBusBuf; Len: Word): Word;
var
	CS: Word;
  Index, Shift: integer;
begin
	CS := $FFFF;
	for Index := 0 to Len-1 do
	begin
    	CS := CS xor Byte(Buf[Index]);
	  	for Shift := 0 to 7 do
    	begin
  			if (CS and $0001) = $0001 then
  			begin
     			CS := CS shr 1;
        	CS := CS xor $A001;
        end
     		else
     			CS := CS shr 1;
  		end;
	end;
	result := CS;
end;



// Analyse answer packet
function TModBus.AnalyseAnswer(Buf: TMBusBuf; Len: Word): TMBusErrCode;
var
	CS: Word;
  H, L: Byte;
begin
	if (Len > 4) then
  begin
  	CS := CRC16(Buf, Len - 2);
    H := Byte(Buf[Len - 1]);
    L := Byte(Buf[Len - 2]);
    if (H = Byte(HI(CS))) and (L = Byte(LO(CS))) then
    begin
      if (Buf[1] > 128) then Result := MBus_ERR_EXCEPTION else Result := MBus_OK;
    end
    else
      Result := MBus_ERR_ANSWER;
  end
  else
    Result := MBus_ERR_NOANSWER;
end;



// Build packet header
procedure TModBus.BuildHeader(var Buf: TMBusBuf; SlaveNum: Byte; FuncCode: Byte; Address: Word; NumElements: Word = 0);
begin
	Buf[0] := Byte(SlaveNum);
  Buf[1] := Byte(FuncCode);
  Buf[2] := Byte(HI(Address));
  Buf[3] := Byte(LO(Address));
  if NumElements > 0 then
  begin
    Buf[4] := Byte(HI(NumElements));
    Buf[5] := Byte(LO(NumElements));
  end;
end;




procedure TModBus.ReadNRegister(SlaveNum: Byte; Address: Word; NumElements: Word; RequestType: TMBusReqType);
var
	CS, I, J: word;
  N, Sz: word;
begin
  // Store param
  FSlaveNum := SlaveNum;
  FAddress := Address;
  FNumElements := NumElements;
  FErrorCode := MBus_ERR_READ;

  // Func type
  case RequestType of
    InputRegister   : FFuncCode := MBus_Func_ReadNInputRegister;
    HoldingRegister : FFuncCode := MBus_Func_ReadNHoldingRegister;
  else
    FFuncCode := MBus_Func_ReadNInputRegister;
  end;

  // Build the request
  BuildHeader(FRequestBuf, FSlaveNum, FFuncCode, FAddress, FNumElements);
  CS := CRC16(FRequestBuf, 6);
  FRequestBuf[6] := Byte(LO(CS));
  FRequestBuf[7] := Byte(HI(CS));
  Sz := 5+2*FNumElements;

  // Send the request
  if Connected then
  begin
    FRequestSz := 8;
    ClearBuffer(True, True);
    Write(FRequestBuf, FRequestSz);
    FAnswerSz := Read(FAnswerBuf, Sz);
    FErrorCode := AnalyseAnswer(FAnswerBuf, FAnswerSz);
    // Get data
    if FErrorCode = MBus_OK then
    begin
      J := 0;
      N := (Word(FAnswerBuf[2]) div 2) -1;  // Bug corrected by Antonio Carlos 02/2024
      for I := 0 to N do
      begin
        FWordsArray[I] := (byte(FAnswerBuf[J+3])*256)+(byte(FAnswerBuf[J+4]));
        Inc(J, 2);
      end;
    end;
  end;

end;



// Write n register
procedure TModBus.WriteNRegister(SlaveNum: Byte; Address: Word; NumElements: Word; Value: array of Word);
var
	CS, I ,J: Word;
begin
  // Store param
  FSlaveNum := SlaveNum;
  FAddress := Address;
  FNumElements := NumElements;
  FErrorCode := MBus_ERR_SEND;

  // Build the request
  FFuncCode := MBus_Func_WriteNRegister;
	BuildHeader(FRequestBuf, FSlaveNum, FFuncCode, FAddress, FNumElements);
  I := 6;
  FRequestBuf[I] := Byte(FNumElements * 2); Inc(I);
  for J := 0 to FNumElements-1 do
  begin
    FRequestBuf[I] := Byte(HI(Value[J])); Inc(I);
    FRequestBuf[I] := Byte(LO(Value[J])); Inc(I);
  end;
  CS := CRC16(FRequestBuf, I);
  FRequestBuf[I] := Byte(LO(CS)); Inc(I);
  FRequestBuf[I] := Byte(HI(CS)); Inc(I);
  if Connected then
  begin
    FRequestSz := I;
    ClearBuffer(True, True);
    Write(FRequestBuf, FRequestSz);
    FAnswerSz := Read(FAnswerBuf, 8);
    FErrorCode := AnalyseAnswer(FAnswerBuf, FAnswerSz);
  end;

end;




// Write one register
procedure TModBus.Write1Register(SlaveNum: Byte; Address: Word; Value: Word);
var
	CS: Word;
begin
  // Store param
  FSlaveNum := SlaveNum;
  FAddress := Address;
  FNumElements := 1;
  FErrorCode := MBus_ERR_SEND;

  // Build the request
  FFuncCode := MBus_Func_Write1Register;
	BuildHeader(FRequestBuf, FSlaveNum, FFuncCode, FAddress);
  FRequestBuf[4] := Byte(HI(Value));
  FRequestBuf[5] := Byte(LO(Value));
  CS := CRC16(FRequestBuf, 6);
  FRequestBuf[6] := Byte(LO(CS));
  FRequestBuf[7] := Byte(HI(CS)); 
  if Connected then
  begin
    FRequestSz := 8;
    ClearBuffer(True, True);
    Write(FRequestBuf, FRequestSz);
    FAnswerSz := Read(FAnswerBuf, 8);
    FErrorCode := AnalyseAnswer(FAnswerBuf, FAnswerSz);
  end;

end;




// Write n coil
procedure TModBus.WriteNCoil(SlaveNum: Byte; Address: Word; NumElements: Word; Value: array of Byte);
var
	CS: Word;
  I, I_Bit, NumBit: Word;
  B	: Byte;
begin
  // Store param
  FSlaveNum := SlaveNum;
  FAddress := Address;
  FNumElements := NumElements;
  FErrorCode := MBus_ERR_SEND;

  // Build the request
  FFuncCode := MBus_Func_WriteNCoil;
	BuildHeader(FRequestBuf, FSlaveNum, FFuncCode, FAddress, FNumElements);
  I := 0;
  I_Bit := 0;
  NumBit := 0;
  B := 0;
  while I_Bit < FNumElements do
  begin
  	if NumBit = 0 then Inc(I);
    if Value[I_Bit] = 1 then B := B or BitWeight[NumBit];
    FRequestBuf[6 + I]:= B;
    if NumBit >= 7 then
    begin
      B := 0;
      NumBit := 0;
    end
    else
      Inc(NumBit);
    Inc(I_Bit);
  end;
  FRequestBuf[6] := Byte(I);
  CS := CRC16(FRequestBuf, 7 + I);
  FRequestBuf[7 + I] := Byte(LO(CS));
  FRequestBuf[8 + I] := Byte(HI(CS));

  if Connected then
  begin
    FRequestSz := 9 + I;
    ClearBuffer(True, True);
    Write(FRequestBuf, FRequestSz);
    FAnswerSz := Read(FAnswerBuf, 8);
    FErrorCode := AnalyseAnswer(FAnswerBuf, FAnswerSz);
  end;
end;




// Write one coil
procedure TModBus.WriteCoil(SlaveNum: Byte; Address: Word; Value: Boolean);
var
	CS: Word;
  V: Byte;
begin
  // Store param
  FSlaveNum := SlaveNum;
  FAddress := Address;
  FNumElements := 1;
  FErrorCode := MBus_ERR_SEND;

  // Build the request
  FFuncCode := MBus_Func_WriteCoil;
	BuildHeader(FRequestBuf, FSlaveNum, FFuncCode, FAddress);
  if Value then V := $FF else V := 0;
  FRequestBuf[4] := V;
  FRequestBuf[5] := 0;
  CS := CRC16(FRequestBuf, 6);
  FRequestBuf[6] := Byte(LO(CS));
  FRequestBuf[7] := Byte(HI(CS));

  if Connected then
  begin
    FRequestSz := 8;
    ClearBuffer(True, True);
    Write(FRequestBuf, FRequestSz);
    FAnswerSz := Read(FAnswerBuf, 8);
    FErrorCode := AnalyseAnswer(FAnswerBuf, FAnswerSz);
  end;
end;



// Read coil/input status
procedure TModBus.ReadCoilInputStatus(SlaveNum: Byte; Address: Word; NumElements: Word; RequestType: TMBusReqType);
var
	CS, I, J: word;
  N, Sz: word;
begin
  // Store param
  FSlaveNum := SlaveNum;
  FAddress := Address;
  FNumElements := NumElements;
  FErrorCode := MBus_ERR_READ;

  // Func type
  case RequestType of
    InputStatus   : FFuncCode := MBus_Func_ReadInputStatus;
    CoilStatus    : FFuncCode := MBus_Func_ReadCoilStatus;
  else
    FFuncCode := MBus_Func_ReadCoilStatus;
  end;

  // Build the request
  BuildHeader(FRequestBuf, FSlaveNum, FFuncCode, FAddress, FNumElements);
  CS := CRC16(FRequestBuf, 6);
  FRequestBuf[6] := Byte(LO(CS));
  FRequestBuf[7] := Byte(HI(CS));
  Sz := 5 + FNumElements div 8;
  if (FNumElements mod 8) > 0 then Inc(Sz);

  // Send the request
  if Connected then
  begin
    FRequestSz := 8;
    ClearBuffer(True, True);
    Write(FRequestBuf, FRequestSz);
    FAnswerSz := Read(FAnswerBuf, Sz);
    FErrorCode := AnalyseAnswer(FAnswerBuf, FAnswerSz);
    // Get data
    if FErrorCode = MBus_OK then
    begin
      N := Word(FAnswerBuf[2]);
      for I := 0 to N-1 do
        for J := 0 to 7 do
        begin
          if (Byte(FAnswerBuf[I+3]) and BitWeight[J]) = BitWeight[J] then
            FBitsArray[J+(I*8)] := 1
          else
            FBitsArray[J+(I*8)] := 0;
        end;
    end;
  end;



end;

end.
