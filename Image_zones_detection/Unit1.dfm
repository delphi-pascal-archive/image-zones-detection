object principale: Tprincipale
  Left = 240
  Top = 130
  Width = 472
  Height = 374
  AutoSize = True
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Image zones detection'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 120
  TextHeight = 16
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 464
    Height = 326
    TabOrder = 0
    object trame: TImage
      Left = 0
      Top = 0
      Width = 149
      Height = 149
      AutoSize = True
      Visible = False
    end
    object fond: TImage
      Left = 0
      Top = 0
      Width = 139
      Height = 139
      AutoSize = True
    end
    object coloriage: TImage
      Left = 0
      Top = 0
      Width = 129
      Height = 129
      AutoSize = True
      Transparent = True
    end
    object zone: TImage
      Left = 0
      Top = 0
      Width = 119
      Height = 119
      AutoSize = True
      Transparent = True
      OnMouseDown = zoneMouseDown
      OnMouseMove = zoneMouseMove
      OnMouseUp = zoneMouseUp
    end
    object StatusBar1: TStatusBar
      Left = 1
      Top = 306
      Width = 462
      Height = 19
      Panels = <
        item
          Width = 150
        end
        item
          Width = 50
        end>
    end
  end
  object MainMenu1: TMainMenu
    Left = 240
    Top = 8
    object Fichier1: TMenuItem
      Caption = 'File'
      object Option1: TMenuItem
        Caption = 'Options'
        object Previsualisation: TMenuItem
          Caption = 'Previsualization regions'
          OnClick = PrevisualisationClick
        end
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Quitter1: TMenuItem
        Caption = 'Exit'
        OnClick = Quitter1Click
      end
    end
    object Informations: TMenuItem
      Caption = 'Info'
      object couleurs: TMenuItem
        Caption = 'Colors ...'
        OnClick = couleursClick
      end
    end
  end
end
