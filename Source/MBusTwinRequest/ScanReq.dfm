object ScanReqForm: TScanReqForm
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Custom scan request'
  ClientHeight = 199
  ClientWidth = 184
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 8
    Top = 10
    Width = 58
    Height = 13
    Caption = 'Var Address'
  end
  object Label3: TLabel
    Left = 8
    Top = 45
    Width = 52
    Height = 13
    Caption = 'Var Length'
  end
  object Label4: TLabel
    Left = 8
    Top = 79
    Width = 69
    Height = 13
    Caption = 'Function Code'
  end
  object OkBtn: TJvSpeedButton
    Left = 8
    Top = 159
    Width = 168
    Height = 27
    Caption = 'Ok'
    Constraints.MinHeight = 22
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    Glyph.Data = {
      F6060000424DF606000000000000360000002800000018000000180000000100
      180000000000C006000074120000741200000000000000000000FF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FF104A10104A10104A10104A10FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FF104A10108C1839CE3939CE3963AD63428C42FF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FF63AD63108C1839CE3939CE3939CE3963AD63428C
      42FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF108C1839CE3939CE3939CE39
      39CE3939CE39108C18FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF63AD6321A52173
      DE7373DE7373DE7339CE3939CE3963AD63108C18FF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF63AD
      63108C1873DE7373DE7373DE7373DE7373DE7373DE7339CE39108C18FF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FF108C18428C4294F79C84EF8C94F79C84EF8439CE3973DE7373DE7373DE
      7339CE39108C18FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FF108C1873DE7394F79C94F79C94F79C84EF84108C1839CE39
      39CE3994F79C73DE7373DE73108C18FF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FF63AD6373DE7394F79C94F79C84EF8410
      8C18FF00FF428C4239CE3984EF8494F79C73DE7373DE73108C18FF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF63AD6339CE3973DE
      7339CE39108C18FF00FFFF00FFFF00FF428C4239CE3984EF8494F79C73DE7339
      CE39428C42FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FF63AD6363AD6363AD63FF00FFFF00FFFF00FFFF00FFFF00FF108C1873DE
      7394F79C94F79C73DE7363AD63FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FF108C1884EF8494F79C94F79C73DE73108C18FF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FF63AD6384EF8494F79C94F79C73DE73
      428C42FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF63AD6384
      EF8494F79C94F79C39CE3963AD63FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FF39CE39BDFFBDBDFFBD94F79C39CE3963AD63FF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF39CE39BDFFBDBDFFBD94F79C39CE
      3963AD63FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF39CE39
      BDFFBDBDFFBD94F79C63AD63FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FF39CE39BDFFBD73DE7363AD63FF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF39CE3963AD63FF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = []
    Layout = blGlyphLeft
    ModalResult = 1
    ParentFont = False
    Spacing = 4
  end
  object VarAdrEdit: TSpinEdit
    Left = 8
    Top = 23
    Width = 168
    Height = 22
    MaxValue = 90000
    MinValue = 0
    TabOrder = 0
    Value = 0
  end
  object VarLengthEdit: TSpinEdit
    Left = 8
    Top = 58
    Width = 168
    Height = 22
    MaxValue = 240
    MinValue = 1
    TabOrder = 1
    Value = 1
  end
  object FunctionCBox: TComboBox
    Left = 8
    Top = 94
    Width = 168
    Height = 21
    Style = csDropDownList
    TabOrder = 2
    Items.Strings = (
      'ReadCoilStatus=1'
      'ReadInputStatus=2'
      'ReadNHoldingRegister=3'
      'ReadNInputRegister=4')
  end
  object CustomReqActiveyCBox: TCheckBox
    Left = 8
    Top = 128
    Width = 168
    Height = 13
    Caption = 'Active'
    TabOrder = 3
  end
end
