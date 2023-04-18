object MainFrame: TMainFrame
  Left = 0
  Top = 0
  Width = 562
  Height = 840
  Margins.Left = 5
  Margins.Top = 5
  Margins.Right = 5
  Margins.Bottom = 5
  ParentBackground = False
  TabOrder = 0
  PixelsPerInch = 168
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 562
    Height = 71
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alTop
    BevelOuter = bvNone
    Color = clSilver
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -23
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
    StyleElements = [seFont, seBorder]
    object btnProjPath: TSpeedButton
      AlignWithMargins = True
      Left = 476
      Top = 4
      Width = 86
      Height = 67
      Hint = 'Select project folder'
      Margins.Left = 0
      Margins.Top = 4
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alRight
      BiDiMode = bdLeftToRight
      ImageIndex = 0
      ImageName = 'Configuration'
      Images = vimgProjTree
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHighlight
      Font.Height = 32
      Font.Name = 'Segoe UI'
      Font.Style = [fsItalic]
      ParentFont = False
      ParentShowHint = False
      ParentBiDiMode = False
      ShowHint = True
      StyleElements = [seFont, seBorder]
      OnClick = btnProjPathClick
      ExplicitHeight = 53
    end
    object lblProjFolder: TLabel
      Left = 0
      Top = 0
      Width = 476
      Height = 71
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alClient
      AutoSize = False
      Caption = '< no project folder set >'
      EllipsisPosition = epEndEllipsis
      Layout = tlCenter
      StyleElements = [seFont, seBorder]
      ExplicitWidth = 639
      ExplicitHeight = 44
    end
  end
  object tvProjectTree: TTreeView
    Left = 0
    Top = 71
    Width = 562
    Height = 769
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alClient
    Indent = 33
    TabOrder = 1
    StyleElements = [seFont, seBorder]
    OnDblClick = tvProjectTreeDblClick
    OnExpanding = tvProjectTreeExpanding
    Items.NodeData = {
      0303000000240000000000000000000000FFFFFFFFFFFFFFFF00000000000000
      000300000001036F006E006500280000000000000000000000FFFFFFFFFFFFFF
      FF00000000000000000000000001056F006E0065002D00610028000000000000
      0000000000FFFFFFFFFFFFFFFF00000000000000000000000001056F006E0065
      002D006200280000000000000000000000FFFFFFFFFFFFFFFF00000000000000
      000000000001056F006E0065002D006300240000000000000000000000FFFFFF
      FFFFFFFFFF0000000000000000060000000103740077006F0020000000000000
      0000000000FFFFFFFFFFFFFFFF00000000000000000000000001016100200000
      000000000000000000FFFFFFFFFFFFFFFF000000000000000000000000010162
      00200000000000000000000000FFFFFFFFFFFFFFFF0000000000000000000000
      0001016300200000000000000000000000FFFFFFFFFFFFFFFF00000000000000
      000000000001016400200000000000000000000000FFFFFFFFFFFFFFFF000000
      00000000000000000001016500200000000000000000000000FFFFFFFFFFFFFF
      FF00000000000000000000000001016600280000000000000000000000FFFFFF
      FFFFFFFFFF000000000000000000000000010574006800720065006500}
  end
  object vimgProjTree: TVirtualImageList
    Images = <
      item
        CollectionIndex = 1
        CollectionName = 'Configuration'
        Name = 'Configuration'
      end>
    ImageCollection = dmProjTreePluginResources.ImageCollection1
    Width = 28
    Height = 28
    Left = 208
    Top = 81
  end
  object dlgRzSelectFolder: TRzSelectFolderDialog
    Left = 336
    Top = 160
  end
end
