object TransfertIPForm: TTransfertIPForm
  Left = 585
  Top = 410
  BorderWidth = 2
  Caption = 'Data transfer'
  ClientHeight = 414
  ClientWidth = 375
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    375
    414)
  PixelsPerInch = 96
  TextHeight = 13
  object ToPlcBtn: TJvSpeedButton
    Left = 12
    Top = 345
    Width = 157
    Height = 36
    Anchors = [akLeft, akBottom]
    Caption = 'Send to plc'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    Glyph.Data = {
      F6060000424DF606000000000000360000002800000018000000180000000100
      180000000000C0060000320B0000320B00000000000000000000FF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF42088C4208844208843108
      7B31086B31086BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF6B18A56B18A57B29AD
      8431AD8431AD7B21A56B189C4A108431086B31086BFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF7B39B58429B5AD
      63CECE84DECE84DEC673DEBD5AD6B542CEAD39C6A531C68C29BD5A108C29085A
      29085AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF7321
      ADAD63CEDEADF7E7BDEFD69CEFC673D6B552CEAD39C6A531C69C31C69C29C69C
      29C68C29C68418BD42087B42086BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FF7321ADCE84DEE7BDEFE7BDEFCE8CDEB552CEA539C6A539C6A539C6A539
      C69429BD9429BD8C21BD8421BD8421BD8418BD42087B31086BFF00FFFF00FFFF
      00FFFF00FFFF00FF7331B5CE84DEEFCEF7E7BDEFC67BD6A542C69C29C6AD39C6
      E7BDEFFFFFFFF7E7FFA542CE8418BD8418BD8418BD7B18BD7318BD6B10BD3108
      6B290063FF00FFFF00FFFF00FF7331B5B56BD6EFCEF7EFCEF7C673D6A539C69C
      29C6A539C6A542C6F7E7FFFFFFFFFFF7FF9442C65A10B56B10B57310B57318BD
      6B10B55A10B55208AD29005A18004AFF00FFFF00FF8429B5DEADF7F7DEFFCE8C
      DEA542C69C29C6A531C6A539C6A542C6F7E7FFFFFFFFFFF7FF8439C65A08B563
      08B56308B56B10B55A10B55A08B55A08B542088C18004AFF00FF7331B5BD6BD6
      EFCEF7E7B5EFAD5ACE9C29C6A531C6A539C6A539C6A542C6F7E7FFFFFFFFFFF7
      FF8C39C65A08B55A08B55A10B55208AD5A08B55A08B55A08B55208AD29085A18
      004A8429B5D69CEFEFCEF7CE8CDEA531C6A531C6A539C6A539C6A539C6A542C6
      F7E7FFFFFFFFFFF7FF8442C65A08B55A08B55A08B55A08B55208AD5A08B55A08
      B55A08BD42088418004A8C39BDDEADF7E7BDEFBD6BD6A531C6A539C6A539C6A5
      39C6A539C6A542C6F7E7FFFFFFFFFFF7FF8439C65A08B55A08B55A08B55A08B5
      5A08B55200B55A08B55A08B54208942100528C39BDDEADF7DEADF7B552CEA542
      C6BD6BD6DEB5EFC673D6A531C6A539C6F7E7FFFFFFFFFFF7FF8439C65A08B55A
      10B5B58CDEA57BD65A08B55200B55A08B55A08B54A089C29085A9439BDD6A5EF
      D6A5EFAD4ACEA539C6F7E7FFFFFFFFFFEFFFAD5ACE8C21BDEFE7FFFFFFFFFFF7
      FF8439C65A08B5C6A5EFFFFFFFF7EFFF5A08B55A08B55A08B55A08B54A089C29
      085A8C39B5CE8CDED69CEFAD4ACE9C31C6EFCEF7FFFFFFFFFFFFF7DEFFA542CE
      EFD6FFFFFFFFFFF7FF7B31BDBD94DEFFFFFFFFFFFFF7EFFF5A08B55A08B55A08
      B55A08B54A089C2100527321A5C673D6CE8CDEB552CE9C31C6A542C6F7DEFFFF
      FFFFFFFFFFEFCEF7EFE7FFFFFFFFF7EFFFD6BDEFFFFFFFFFFFFFFFFFFFC6ADEF
      5A08B55A08B55A08B55A08BD42088C18004A4A1084AD4ACEC673D6B552CE9C29
      C69421BDA54ACEF7E7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFCEADEF5A10B55A08B55A08B55A08B55A08B529006318004AFF00FF7B29A5
      B552CEA542C69C29C68C21BD8421BD9C52CEF7E7FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFC6A5EF5A10B55A08B55A08B55A08B55A08B5420894210052FF
      00FFFF00FF42087B9439BDA539C68C29BD8421BD8418BD7B18BDAD5ACEFFEFFF
      FFFFFFFFFFFFFFFFFFFFFFFFC6A5EF5A10B55A08B55A08B55A08B55A08B55A08
      B531086B18004AFF00FFFF00FFFF00FF4A10849C29C68421BD8418BD7B18BD7B
      18BD8418BDA563CEFFF7FFFFFFFFFFFFFFC69CEF5A10B55A08B55A08B55A08B5
      5A08B55A08BD420884210052FF00FFFF00FFFF00FFFF00FFFF00FF4A10848421
      BD8418BD7310B56B10B57B18BD8418BD9C63CEF7EFFFB58CDE5A08B55A08B55A
      08B55A08B55A08B55A08BD420884210052FF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FF42087B7318BD7310BD6B10B55A10B56B10B56308B55A08B55A08
      B55A08B55A08B55A08B55A08BD5A08B5420884210052FF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FF29085A4A088C6308B55A08BD5A08BD
      5A08BD5A08B55A08BD5A08BD5A08BD5A08B5420894290063210052FF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF29
      085A31007342088C4208944A089C42089442088C31087B29085A210052FF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FF210052210052290063210052210052210052FF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
    Layout = blGlyphLeft
    ParentFont = False
    Spacing = 10
    OnClick = ToPlcBtnClick
  end
  object FromPlcBtn: TJvSpeedButton
    Left = 216
    Top = 345
    Width = 144
    Height = 36
    Anchors = [akRight, akBottom]
    Caption = 'Get from plc'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    Glyph.Data = {
      76060000424D7606000000000000360400002800000018000000180000000100
      08000000000040020000320B0000320B00000001000000010000004A00000052
      0800005A0800085A080000630800086B080000730800087B0800086B10000884
      1000088C100008941000089C100000B51000086B1800087B1800088C180008AD
      180008B5180008BD18001084210008B5210010B5210008BD210010B5290010BD
      2900108C310018A5310010B5310010BD310018BD310021BD3100189C390021AD
      390010BD390018BD390021A5420031B5420018BD420021BD420031BD420021A5
      4A0029A54A0029AD4A0029B54A0039B54A0021BD4A0039C64A0031AD520021BD
      520029BD520021C6520029C6520039B55A0021BD5A0039BD5A0021C65A0029C6
      5A0031C65A0039BD630029C6630031C6630031C66B0039C66B0039C6730042CE
      730042CE7B004ACE7B0052CE7B0052CE84005ACE840063CE84007BD684005AD6
      8C0063D68C006BD68C006BD694008CDE940073D69C007BD69C0073DE9C0094DE
      9C007BDEA50084DEA50084DEAD008CDEAD00A5E7AD00ADE7AD009CE7B500ADE7
      B500A5E7BD00BDEFBD00ADEFC600B5EFC600BDEFC600B5EFCE00BDEFCE00C6EF
      D600C6EFDE00CEF7DE00D6F7DE00DEF7E700E7F7E700E7F7EF00EFFFEF00EFFF
      F700F7FFF700FF00FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
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
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF006B6B6B6B6B6B
      6B6B00000103030100006B6B6B6B6B6B6B6B6B6B6B6B6B6B000003090B0C0C0C
      0A0401006B6B6B6B6B6B6B6B6B6B6B04020A2E131212121213120B05016B6B6B
      6B6B6B6B6B6B0808112E2E16121212121212121209016B6B6B6B6B6B6B0E0F19
      2E231812120D3F3F121212121309016B6B6B6B6B030F262E2E18151212526A5A
      3A121212121309016B6B6B6B03262E231E1812124E6A6C6C5612121212121204
      6B6B6B081A342E261C15124C6A6C6C6C6C5612121212130B016B6B0832393126
      18154A686C6C6C6C6C6C571212121212036B05143E3C32261846676C6C6C6C6C
      6C6C6C591212121307010520403D3D2E45666C6C64676C6A5B6C6C6C57121213
      0A010729423E3F45616C6C6544656C6A2F516C6C681212130B01093049403F45
      676C69462F666C6A2F12566C681212120C04093050453F454B5D4C272F656C6A
      2818184D481215130B010A2B544E3F3F363A34322F656C6A2823232323261813
      0A016B1B5458453C3F3F3D3D2F656C6A282E2E26231E1613066B6B1B47605541
      3C3E3F3F2F656C6A282E2623231C1815036B6B6B2C5C614F3F3C3E3F2F656C6A
      28312E26231C1D106B6B6B6B2D4761614E413C3E2F656C6A2839312E26261E03
      6B6B6B6B6B2153636255463E2F5E6C651F3C39322E2E0F6B6B6B6B6B6B6B2154
      63655F554C4543434545413F39146B6B6B6B6B6B6B6B6B254B5C6263615C5A58
      554E453B146B6B6B6B6B6B6B6B6B6B6B252C4C585C5C5A554E432A0F6B6B6B6B
      6B6B6B6B6B6B6B6B6B6B252C37373B3524146B6B6B6B6B6B6B6B}
    Layout = blGlyphLeft
    ParentFont = False
    Spacing = 10
    OnClick = FromPlcBtnClick
  end
  object Label2: TLabel
    Left = 12
    Top = 291
    Width = 65
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'Start address'
  end
  object Label3: TLabel
    Left = 114
    Top = 290
    Width = 33
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'Length'
  end
  object Label5: TLabel
    Left = 12
    Top = 244
    Width = 52
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'IP Address'
  end
  object Label6: TLabel
    Left = 162
    Top = 243
    Width = 33
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'IP Port'
  end
  object Label4: TLabel
    Left = 239
    Top = 243
    Width = 45
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'Slave adr'
  end
  object LoadBtn: TJvSpeedButton
    Left = 216
    Top = 55
    Width = 148
    Height = 36
    Anchors = [akTop, akRight]
    Caption = 'Load'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
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
    Layout = blGlyphLeft
    ParentFont = False
    Spacing = 10
    OnClick = LoadBtnClick
  end
  object SaveBtn: TJvSpeedButton
    Left = 10
    Top = 55
    Width = 159
    Height = 36
    Caption = 'Save'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
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
    Layout = blGlyphLeft
    ParentFont = False
    Spacing = 10
    OnClick = SaveBtnClick
  end
  object Label1: TLabel
    Left = 10
    Top = 10
    Width = 45
    Height = 13
    Caption = 'File name'
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 394
    Width = 375
    Height = 20
    Panels = <>
    ParentFont = True
    SimplePanel = True
    SimpleText = 'Ready'
    UseSystemFont = False
  end
  object StartEdit: TJvSpinEdit
    Left = 12
    Top = 308
    Width = 91
    Height = 21
    MaxValue = 65535.000000000000000000
    Anchors = [akLeft, akBottom]
    TabOrder = 1
  end
  object LengthEdit: TJvSpinEdit
    Left = 114
    Top = 308
    Width = 91
    Height = 21
    MaxValue = 32768.000000000000000000
    MinValue = 1.000000000000000000
    Value = 1.000000000000000000
    Anchors = [akLeft, akBottom]
    TabOrder = 2
  end
  object RegistersWordSGrid: TJvStringGrid
    Left = 12
    Top = 104
    Width = 348
    Height = 135
    Anchors = [akLeft, akTop, akRight, akBottom]
    ColCount = 1
    DefaultRowHeight = 18
    FixedCols = 0
    RowCount = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -9
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing]
    ParentFont = False
    TabOrder = 3
    OnGetEditText = RegistersWordSGridGetEditText
    OnKeyPress = RegistersWordSGridKeyPress
    Alignment = taLeftJustify
    FixedFont.Charset = DEFAULT_CHARSET
    FixedFont.Color = clWindowText
    FixedFont.Height = -10
    FixedFont.Name = 'Arial'
    FixedFont.Style = []
    OnExitCell = RegistersWordSGridExitCell
  end
  object IPAdrEdit: TJvIPAddress
    Left = 12
    Top = 259
    Width = 131
    Height = 21
    Anchors = [akLeft, akBottom]
    ParentColor = False
    TabOrder = 4
    OnChange = IPAdrEditChange
  end
  object IPPortEdit: TSpinEdit
    Left = 162
    Top = 259
    Width = 61
    Height = 22
    Anchors = [akLeft, akBottom]
    MaxValue = 65535
    MinValue = 0
    TabOrder = 5
    Value = 502
  end
  object SlaveAdrEdit: TSpinEdit
    Left = 239
    Top = 259
    Width = 58
    Height = 22
    Anchors = [akLeft, akBottom]
    MaxValue = 255
    MinValue = 1
    TabOrder = 6
    Value = 1
  end
  object FileEdit: TJvFilenameEdit
    Left = 10
    Top = 28
    Width = 354
    Height = 21
    AddQuotes = False
    Filter = 'All files (*.*)|*.*|Data file|*.data'
    FilterIndex = 2
    InitialDir = '.'
    ButtonWidth = 18
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 7
  end
  object IpPopupMenu: TJvPopupMenu
    ImageMargin.Left = 0
    ImageMargin.Top = 0
    ImageMargin.Right = 0
    ImageMargin.Bottom = 0
    ImageSize.Height = 0
    ImageSize.Width = 0
    Left = 122
    Top = 240
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
