object ScanCOMForm: TScanCOMForm
  Left = 518
  Top = 507
  Caption = 'Bus Scan'
  ClientHeight = 300
  ClientWidth = 366
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    366
    300)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 7
    Top = 7
    Width = 40
    Height = 13
    Caption = 'Start adr'
  end
  object ScanBtn: TJvSpeedButton
    Left = 184
    Top = 48
    Width = 168
    Height = 40
    Caption = 'Scan'
    Constraints.MinHeight = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    Glyph.Data = {
      76060000424D7606000000000000360400002800000018000000180000000100
      08000000000040020000420B0000420B00000001000000010000006300000073
      0000007308001073100008841000087B1800107B18000884180010841800316B
      2100317B21001084210018842100188C2100109C2900427B3100218431004284
      3100528C3900529439004A944200529442006394420021A5420021AD420029AD
      420052944A002994520031BD52005A5A5A0084A55A0084A5630031C663005263
      6B00846B6B009C6B6B0039CE6B0039D66B0042D66B00636B7300A5737300A57B
      730042DE7300AD847B008CB57B004AE77B0052E77B00AD8C8400B5A584009CB5
      8400EFBD84004AE7840052EF8400BD8C8C00BD9C8C00C69C8C009CBD8C00F7BD
      8C0052F78C005AF78C00738494007B84940084849400C6949400C69C9400CE9C
      9400CEA59400F7C69400F7CE94009C9C9C00BD9C9C00CEA59C00F7CE9C003973
      A500ADADA500D6ADA500D6B5A500F7D6A500C6ADAD00D6C6AD00E7C6AD00F7D6
      AD002173B5006394B500EFDEB500F7E7BD00FFE7BD00FFEFBD00EFDEC600FFEF
      C600FFF7CE003184D600FFFFD600C6CEDE00FFFFDE00EFEFE700FFFFE700218C
      EF00FFFFEF00FF00FF0031A5FF0039A5FF0042A5FF004AB5FF0052BDFF005ABD
      FF007BC6FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
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
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00631D27406363
      6363636363636363636363636363636363634A49523C41636363636363636363
      63636363636363636363536561523D4163636363636363636363636363636363
      636367696661523D416363636363636363636363636363636363646869666152
      3D4163636363636363636363636363636363636468696661523E416363636363
      6363636363636363636363636468696661523E41636363636363636363636363
      63636363636468696661523E6363636363636363636363636363636363636468
      69655B2163632312000104020F0F63636363636363636364686A5D45222F111F
      1E16030E18051463636363636363636363635F4E425A5C5E5C5C5C091820061A
      636363636363636363634E4257565A5C5C5C5E5E0B251C076363636363636363
      63633554002C5A5C5C5E6062082A2D05296363636363636363634C00080D385C
      5C080808072D330B0808636363636363633F000C3B3408305C120A1726333A2D
      19106363636363636300062E3B3A24035C5E1303243A3B2E0615636363636363
      0010192D3A3326170A5E5E1308343B0C15366363636363630808080B332D0808
      08085E5C380D08134F3F63636363636363634B052D2A08484D555A5C5C2C315C
      36636363636363636363351B1C250B484443515555595C582863636363636363
      636363370620180943323943515759366363636363636363636363634605180E
      03161E1F115540636363636363636363636363636300040204010012503F6363
      6363636363636363636363636363632B37474740636363636363}
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = []
    Layout = blGlyphLeft
    ParentFont = False
    Spacing = 4
    OnClick = ScanBtnClick
  end
  object Label2: TLabel
    Left = 184
    Top = 7
    Width = 37
    Height = 13
    Caption = 'End adr'
  end
  object ReqBtn: TJvSpeedButton
    Left = 8
    Top = 48
    Width = 159
    Height = 40
    Hint = 'Custom request to send during the scan '
    Caption = 'Custom request'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    Glyph.Data = {
      76060000424D7606000000000000360400002800000018000000180000000100
      08000000000040020000130B0000130B0000000100000001000010799C001B7C
      9F00FF00FF000E80AA001184AE001B8FB9001195BF001D90B8001D92BC002F86
      A400258FB5002291B8002D95BA002B99BE003699BC00379CBF004298B40060A8
      B9001A9DC500139FCA00299EC3000FA4CF0017A0CA001AA1CA0015ACD70013AD
      D8001FAFD9001EB0D9002CA9CF0036A2C60035A6CA0021ACD60033ADD1003FB2
      D50035B4D8003DB2DB003ABFDE000FBFEB0015B5E00012BCE80049A5C50041A8
      CA0044A9CB0042ACCC0047ADCD004EACCB0048AFCF0056AEC20054ACCA0056AE
      CB0057B2C70044AFD10046B2D4004DB6D40043B9D40044B5D90043BCDE0056B6
      D40060B3CF0060B8D40069B9D3006BBBD5006CBBD50069BDD7006EBCD6000FC9
      F5001CC6F0001BCDF60010CCF90012CFFB0010CFFC0010D1FE0017D2FE0018D2
      FE0019D2FE001CD3FE002AC3E70027C3EB0035C6EB0038C7EB0024CBF40023D4
      FE0024D5FE0027D5FE002AD6FE002ED6FE002FD6FE0033D7FE0036D8FE003AD9
      FE003DDAFE0059C1DA0073C0DA0073C3DB007CC5DC0040C6E70047C5E60040DA
      FE0041DAFE0042DAFE0045DBFE004BDBFD0049DCFE0057D2F10054D8F80055D9
      F80055DEFE005BDAF90059DFFE0061C8E3006BCDE8007ACBE0007ACCE4007BD2
      EA007CD7EE0067D7F30060E0FE0066E2FE0067E2FE0068E2FE006BE2FE0072E1
      FB0071E3FE0073E4FE007BE6FF007EE6FF008280800090909000999797009A9A
      9A009D9A9A009F9E9E00A29D9D00A29E9E00A49C9C00A69C9C00A99F9F00A3A2
      A200A6A0A000A5A4A400A5A5A500A6A6A600A8A0A000AAA1A100ADA0A000ACA1
      A100ADA1A100ABABAB00ACACAC00ADADAD00AFAFAF00B0A2A200B9A8A800B5B5
      B500B9B9B900BABABA00BDBDBD00BEBEBE00C0AAAA00C2ACAC00CEB1B100CFB7
      B800D7B6B600DAB9B900DCBABA0080C8DF0088CCE1008BCEE3008DD1E10096D9
      EB0085DEF2008FDEF300A4DEEE0081E1F80084E3FA0080E7FE0084E7FE0086E7
      FF008AE2F8008BE5FB008BE8FF008DE9FF0096E7FB0096E8FC0096EBFF009CEC
      FE009DECFF00A1E0F100A1EDFE00A4EDFF00A5EEFF00A6EEFE00AAEEFF00ADEF
      FF00B0E5F300B2E6F400BBECF900BAEDF900BAEEFA00BDEDF900BDEFFC00B5F0
      FE00B4F1FF00B6F1FF00BBF2FF00BCF3FF00BFF3FF00C6C6C600C9C8C800CACA
      CA00CCCBCB00CCCCCC00CECDCD00D2D1D100D6D6D600DADADA00DCDCDC00C3F1
      FC00C2F3FF00C4F2FC00C5F3FE00C4F4FF00C7F4FF00C8F4FE00E1E0E000E8E8
      E800EAE9E900F3F2F200F5F4F400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000020202020202
      02020202030303030202020202020202020202020202030303020203124E5F2C
      03020203030302020202020202032C202C0303001B171C170703032C2B010302
      02020202020314604F4D261913506538176DAA72170D03020202020202030B33
      17171816424B616B1E35173F3E0E030202020203031D2EAD796717175349576A
      7371BBC7C73103030302032DAB6E17B27D786C63564B516476B4BCBFB3213723
      0803030F3B1770B6B17B746658524A555A62595447271A1F2C030328ACC5C9BD
      B57C77695B322F36434747474746444115030203A5DCCEC1B8B06F7F968C8497
      7F244547474747250402033917C4DDCABAA87FD7D1938E9FA37F4C4856666806
      0503030C5EDBDECCBE7F9CE1D1938E9FA4A1117AB9CBC83D05030310A9C3D9DA
      C17FD3E1D1938E9FA4A27FAFC0C6C2A6300302030A3AA7DCCB7FD3E1D1938E9F
      A4A27F7BB75D03030302020202033CDFCD7FD3E1D1938E9FA4A27F75AE2A0302
      02020202020309405C7FD3E1D1938E9FA4A27F22342903020202020202020303
      037FD3E1D1938E9FA4A27F03030302020202020202020202027FD3E1D1938E9F
      A4A27F02020202020202020202020202027FD0D4948180869EA07F0202020202
      0202020202020202027F8D9A9B95859192877F02020202020202020202020202
      027FD2E2D69D8B8A98907F02020202020202020202020202027FD8E4E2D59989
      8F887F02020202020202020202020202027F83D4E3E0CF94827E7F0202020202
      020202020202020202027F7F7F7F7F817F7F0202020202020202}
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'Arial'
    HotTrackFont.Style = []
    Layout = blGlyphLeft
    ParentFont = False
    Spacing = 4
    OnClick = ReqBtnClick
  end
  object StartAdrEdit: TSpinEdit
    Left = 7
    Top = 20
    Width = 78
    Height = 22
    MaxValue = 255
    MinValue = 1
    TabOrder = 0
    Value = 1
  end
  object EndAdrEdit: TSpinEdit
    Left = 184
    Top = 20
    Width = 79
    Height = 22
    MaxValue = 255
    MinValue = 1
    TabOrder = 1
    Value = 2
  end
  object ResultMemo: TMemo
    Left = 7
    Top = 144
    Width = 351
    Height = 131
    Anchors = [akLeft, akTop, akRight, akBottom]
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 281
    Width = 366
    Height = 19
    Panels = <>
    SimplePanel = True
    ExplicitTop = 254
  end
  object TryAllSpeedCB: TCheckBox
    Left = 7
    Top = 102
    Width = 345
    Height = 14
    Caption = 'Try all speed configuration'
    TabOrder = 4
  end
  object GoodResOnlyCBox: TCheckBox
    Left = 7
    Top = 123
    Width = 345
    Height = 14
    Caption = 'Show only right result'
    TabOrder = 5
  end
end
