object ModelForm: TModelForm
  Left = 0
  Top = 0
  Caption = 'Model'
  ClientHeight = 279
  ClientWidth = 369
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    369
    279)
  PixelsPerInch = 96
  TextHeight = 13
  object OkBtn: TJvSpeedButton
    Left = 120
    Top = 249
    Width = 131
    Height = 24
    Anchors = [akBottom]
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
  object ModelDBGrid: TJvDBGrid
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 363
    Height = 237
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    DrawingStyle = gdsGradient
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = ModelDBGridDblClick
    OnKeyUp = ModelDBGridKeyUp
    AutoSizeColumns = True
    SelectColumnsDialogStrings.Caption = 'Select columns'
    SelectColumnsDialogStrings.OK = '&OK'
    SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
    EditControls = <>
    RowsHeight = 17
    TitleRowHeight = 17
    Columns = <
      item
        Expanded = False
        FieldName = 'IP'
        Title.Caption = 'Ip'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'PORT'
        Title.Caption = 'Port'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'SLAVE'
        Title.Caption = 'Slave'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'FUNCTION'
        Title.Caption = 'Function'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ADDRESS'
        Title.Caption = 'Address'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LENGTH'
        Title.Caption = 'Length'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SWAP'
        Title.Caption = 'Swap'
        Width = 54
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALUE'
        Title.Caption = 'Value to write'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'RESULT'
        Title.Caption = 'Result'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'NAME'
        Title.Caption = 'Name'
        Width = 59
        Visible = True
      end>
  end
end
