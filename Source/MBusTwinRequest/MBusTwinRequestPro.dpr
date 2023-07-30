program MBusTwinRequestPro;



uses
  Forms,
  Controls,
  Main in 'Main.pas' {MainForm},
  TransferIP in 'TransferIP.pas' {TransfertIPForm},
  ScanIP in 'ScanIP.pas' {ScanIPForm},
  Request in 'Request.pas' {RequestForm},
  Model in 'Model.pas' {ModelForm},
  SetupIP in 'SetupIP.pas' {SetupIPForm},
  ModbusIP in 'ModbusIP.pas',
  ModbusCOM in 'ModbusCOM.pas',
  TransferCOM in 'TransferCOM.pas' {TransfertCOMForm},
  ScanCOM in 'ScanCOM.pas' {ScanCOMForm},
  Debug in 'Debug.pas' {DebugForm},
  MyFunctions in 'MyFunctions.pas',
  gnugettext in 'gnugettext.pas',
  Help in 'Help.pas' {HelpForm},
  Tracker in 'Tracker.pas' {TrackerForm},
  SetupCOM in 'SetupCOM.pas' {SetupCOMForm},
  ScanReq in 'ScanReq.pas' {ScanReqForm};

{$R *.res}


begin
  AddDomainForResourceString('cport');
  AddDomainForResourceString('modbustwinpro');
  AddDomainForResourceString('delphi');
  TextDomain('modbustwinpro');
  TP_GlobalIgnoreClassProperty(TControl,'HelpKeyword');

  Application.Initialize;
  Application.Title := 'Modbus Twin Request Pro';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(THelpForm, HelpForm);
  Application.CreateForm(TTransfertIPForm, TransfertIPForm);
  Application.CreateForm(TScanIPForm, ScanIPForm);
  Application.CreateForm(TRequestForm, RequestForm);
  Application.CreateForm(TModelForm, ModelForm);
  Application.CreateForm(TSetupIPForm, SetupIPForm);
  Application.CreateForm(TTransfertCOMForm, TransfertCOMForm);
  Application.CreateForm(TScanCOMForm, ScanCOMForm);
  Application.CreateForm(TDebugForm, DebugForm);
  Application.CreateForm(TTrackerForm, TrackerForm);
  Application.CreateForm(TSetupCOMForm, SetupCOMForm);
  Application.CreateForm(TScanReqForm, ScanReqForm);
  Application.Run;
end.

