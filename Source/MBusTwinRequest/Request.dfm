object RequestForm: TRequestForm
  Left = 0
  Top = 0
  AutoSize = True
  BorderStyle = bsDialog
  Caption = 'Request'
  ClientHeight = 465
  ClientWidth = 244
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnKeyUp = FormKeyUp
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object BottomPanel: TPanel
    Left = 0
    Top = 122
    Width = 244
    Height = 343
    BevelOuter = bvNone
    TabOrder = 0
    object Label2: TLabel
      Left = 6
      Top = 47
      Width = 58
      Height = 13
      Caption = 'Var Address'
    end
    object Label3: TLabel
      Left = 6
      Top = 82
      Width = 52
      Height = 13
      Caption = 'Var Length'
    end
    object Label4: TLabel
      Left = 6
      Top = 116
      Width = 69
      Height = 13
      Caption = 'Function Code'
    end
    object Label5: TLabel
      Left = 6
      Top = 152
      Width = 66
      Height = 13
      Caption = 'Value to write'
    end
    object Bevel1: TBevel
      Left = 6
      Top = 41
      Width = 231
      Height = 7
      Shape = bsTopLine
    end
    object Label1: TLabel
      Left = 6
      Top = 4
      Width = 45
      Height = 13
      Caption = 'Slave adr'
    end
    object OkBtn: TJvSpeedButton
      Left = 6
      Top = 313
      Width = 231
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
      OnClick = OkBtnClick
    end
    object LoadBtn: TJvSpeedButton
      Left = 6
      Top = 242
      Width = 231
      Height = 29
      Caption = 'Load a model'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Glyph.Data = {
        76060000424D7606000000000000360400002800000018000000180000000100
        08000000000040020000220B0000220B00000001000000010000006B00000073
        080008730800087B080008731000087B100008841000088C1000089410001084
        180008941800089C180008A5180008AD180010AD210018AD290021AD310021AD
        390021BD390029AD4A0029BD4A0031BD4A0029C64A0031AD520039BD5A0039C6
        5A0039BD630042CE6B004AD66B004AD67B0052DE84005AE78C005AEF940010A5
        D60018A5D60021A5D60021ADD60029ADD60029ADDE0031ADDE0029B5DE0031B5
        DE0039B5DE0042B5DE0039BDDE004ABDDE0039BDE70042BDE7004ABDE7005ABD
        E70063BDE7004AC6E70052C6E7005AC6E70063C6E70073C6E70052CEE7005ACE
        E7007BCEE70052CEEF005ACEEF007BCEEF008CCEEF005AD6EF0063D6EF0084D6
        EF0094D6EF0063DEEF005ACEF70063D6F7006BD6F70063DEF70073DEF700ADDE
        F7007BE7F70094E7F700BDE7F70094EFF700BDEFF700FF00FF0073DEFF007BE7
        FF0084E7FF007BEFFF0084EFFF008CEFFF009CEFFF0084F7FF008CF7FF0094F7
        FF009CF7FF00A5F7FF00B5F7FF00C6F7FF00CEF7FF008CFFFF0094FFFF009CFF
        FF00A5FFFF00B5FFFF00BDFFFF00C6FFFF00CEFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF004F4F4F4F4F4F
        4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F
        4F4F4F4F4F4F4F4F4F4F4F232323352F2523224F4F4F4F4F4F4F4F4F4F4F4F4F
        4F4F4F2249636159554A46342B2523224F4F4F4F4F4F4F4F4F4F4F2132665859
        595959595855483C33292322224F4F4F4F4F4F232B4E61595959595858585959
        55555240274F4F4F4F4F4F25354263585959595858555555555555523C234F4F
        4F4F4F254A365D5859595958585555555555554A482C4F4F4F4F4F254D384C61
        5959595858555555555555485040224F4F4F4F2556433E645859595858555555
        555555484855254F4F4F4F254D582D5E6259585858555555555555480509334F
        4F4F4F254D613F324C4E5D5D645A5455555555021A1D09224F4F4F2556605940
        38353636374C5C54555500171F1F18044F4F4F255660596160595554402B495D
        590213201E1C1011024F4F255660595959595959594A2F3A021017181B191410
        10014F255A605959595959585859553F020202041515020202024F255B605959
        5959595858585559555354021112024F4F4F4F255C6059595959595656565656
        56565A040F0E024F4F4F4F223A63606059595427272A2B2B2D2D31060E0B024F
        4F4F4F4F23414B4B565B39214F4F4F4F4F4F020B0E06024F4F4F4F4F4F222323
        2525234F4F4F4F4F4F060B0C07024F4F4F4F4F4F4F4F4F4F4F4F4F4F4F020209
        0A0A0A05024F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F02040202024F4F4F4F4F
        4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F4F}
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      Layout = blGlyphLeft
      ParentFont = False
      Spacing = 4
      OnClick = LoadBtnClick
    end
    object SaveModelBtn: TJvSpeedButton
      Left = 6
      Top = 277
      Width = 231
      Height = 27
      Caption = 'Save as model'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      Glyph.Data = {
        76060000424D7606000000000000360400002800000018000000180000000100
        08000000000040020000320B0000320B00000001000000010000942121009429
        2900943131009C3131009C393900A5393900944242009C424200A5424200AD42
        4200A54A42009C424A009C4A4A00A54A4A00AD4A4A00B54A4A009C525200B552
        5200BD525200C6525200BD5A5A00C65A5A00CE5A5A009C636300A5636300C663
        6300CE6363009C6B6B00B56B6B00BD6B6B00C66B6B00CE6B6B00AD736B00B573
        6B009C737300A5737300B5737300BD737300C6737300CE737300B5847300A57B
        7B00AD7B7B00BD7B7B00C67B7B00CE7B7B00A5848400B5848400BD848400C684
        8400B58C8400A58C8C00AD8C8C00B58C8C00C68C8C00CE8C8C00BD949400D694
        94009C9C9C00BD9C9C00C69C9C00CE9C9C00CEA59C00ADA5A500CEA5A500D6A5
        A500C6ADAD00CEADAD00D6ADAD00B5B5B500BDB5B500DEB5B500BDBDB500B5BD
        BD00BDBDBD00D6BDBD00DEBDBD00C6C6C600CEC6C600DEC6C600E7C6C600C6CE
        CE00CECECE00D6CECE00DECECE00D6D6D600DEDED600DEDEDE00E7DEDE00E7E7
        DE00EFE7DE00E7E7E700EFE7E700F7E7E700EFEFE700F7EFE700EFEFEF00F7EF
        EF00F7F7EF00F7F7F700FFF7F700FFFFF700FF00FF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00666666666666
        6666666666666666666666666666666666666666661E191A111B454545454545
        454545240102040C66666666281E1A1A141B332F43546265635E5B2401020415
        0C666666281E1A1A14222904213C5C636462602B010204150C666666281E1A1A
        14232E02072456606364632B010204150C666666281E1A1A14233402020C4D59
        6064672C010204150C666666281E1A1A112A350101023F525961673101020415
        0C666666281E1A1A112A421818173A4555606731010204140C666666281E1A1A
        1424413C3B3834343C44502608090E190C666666281E1A1A1A1A1A1A1A1A1A1A
        1919191A1A1A1A1A0C666666281E14191E2727272727272727272727272D1F1A
        0C666666280E0A1C36434B4B4B4B4B4B4B4B4B4B4B4F371A0C66666628093D62
        616161616161616161616161615C37150C666666280940676363636363636363
        63636363645C37140C66666628094067616161616161616161616161635C3714
        0C666666280940675B4E5252525252525252524D585C37140C66666628094067
        615C5C5C5C5C5C5C5C5C5C5C615C37140C666666280940675C53535353535353
        535353525B5C37140C666666280940675E5858585858585858585858605C3714
        0C666666280940675E5858585858585858585858605C37140C66666628094067
        5B52535353535353535353525B5C37140C666666280940676464646464646464
        64646464645C37150C66666666093D514D4D4D4D4D4D4D4D4D4D4D4D4D4D3611
        6666666666666666666666666666666666666666666666666666}
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      Layout = blGlyphLeft
      ParentFont = False
      Spacing = 4
      OnClick = SaveModelBtnClick
    end
    object VarAdrEdit: TSpinEdit
      Left = 6
      Top = 60
      Width = 231
      Height = 22
      MaxValue = 90000
      MinValue = 0
      TabOrder = 0
      Value = 0
    end
    object VarLengthEdit: TSpinEdit
      Left = 6
      Top = 95
      Width = 231
      Height = 22
      MaxValue = 240
      MinValue = 1
      TabOrder = 1
      Value = 1
    end
    object FunctionCBox: TComboBox
      Left = 6
      Top = 131
      Width = 231
      Height = 21
      Style = csDropDownList
      TabOrder = 2
      OnChange = FunctionCBoxChange
      Items.Strings = (
        'ReadCoilStatus=1'
        'ReadInputStatus=2'
        'ReadNHoldingRegister=3'
        'ReadNInputRegister=4'
        'WriteCoil=5'
        'Write1Register=6'
        'WriteNCoil=15'
        'WriteNRegister=16')
    end
    object ValueEdit: TSpinEdit
      Left = 6
      Top = 167
      Width = 231
      Height = 22
      Enabled = False
      MaxValue = 32767
      MinValue = -32768
      TabOrder = 3
      Value = 0
    end
    object BitCBox: TCheckBox
      Left = 6
      Top = 193
      Width = 231
      Height = 13
      Caption = 'Bit 0 / 1'
      Enabled = False
      TabOrder = 4
    end
    object SlaveAdrEdit: TSpinEdit
      Left = 6
      Top = 17
      Width = 231
      Height = 22
      MaxValue = 255
      MinValue = 1
      TabOrder = 5
      Value = 1
    end
    object SwapCBox: TCheckBox
      Left = 6
      Top = 216
      Width = 231
      Height = 13
      Caption = 'Byte swap'
      Enabled = False
      TabOrder = 6
    end
  end
  object IpPanel: TPanel
    Left = 0
    Top = 48
    Width = 244
    Height = 71
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    BevelOuter = bvNone
    TabOrder = 1
    object Label8: TLabel
      Left = 6
      Top = 2
      Width = 52
      Height = 13
      Caption = 'IP Address'
      PopupMenu = IpPopupMenu
    end
    object Label7: TLabel
      Left = 6
      Top = 37
      Width = 33
      Height = 13
      Caption = 'IP Port'
    end
    object IPAdrEdit: TJvIPAddress
      Left = 6
      Top = 15
      Width = 231
      Height = 21
      ParentColor = False
      PopupMenu = IpPopupMenu
      TabOrder = 0
      OnChange = IPAdrEditChange
    end
    object IPPortEdit: TSpinEdit
      Left = 6
      Top = 50
      Width = 231
      Height = 22
      MaxValue = 65535
      MinValue = 0
      TabOrder = 1
      Value = 502
    end
  end
  object TopPanel: TPanel
    Left = 0
    Top = 0
    Width = 244
    Height = 49
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object Bevel2: TBevel
      Left = 6
      Top = 42
      Width = 231
      Height = 7
      Shape = bsTopLine
    end
    object Label6: TLabel
      Left = 6
      Top = 1
      Width = 27
      Height = 13
      Caption = 'Name'
    end
    object NameEdit: TEdit
      Left = 6
      Top = 15
      Width = 231
      Height = 21
      Color = 12188927
      MaxLength = 40
      TabOrder = 0
    end
  end
  object IpPopupMenu: TJvPopupMenu
    ImageMargin.Left = 0
    ImageMargin.Top = 0
    ImageMargin.Right = 0
    ImageMargin.Bottom = 0
    ImageSize.Height = 0
    ImageSize.Width = 0
    Left = 98
    Top = 64
    object IpOpenMenuClick: TMenuItem
      Caption = 'Load'
      OnClick = IpOpenMenuClickClick
    end
    object IpSaveConfigClick: TMenuItem
      Caption = 'Save'
      OnClick = IpSaveConfigClickClick
    end
  end
end