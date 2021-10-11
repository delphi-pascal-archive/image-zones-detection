object info: Tinfo
  Left = 893
  Top = 370
  AutoSize = True
  BorderStyle = bsDialog
  Caption = 'Info'
  ClientHeight = 69
  ClientWidth = 159
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 120
  TextHeight = 16
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 159
    Height = 69
    TabOrder = 0
    object quelle_zone: TLabel
      Left = 39
      Top = 39
      Width = 110
      Height = 21
      AutoSize = False
      Caption = 'quelle_zone'
      Layout = tlCenter
    end
    object Label_: TLabel
      Left = 39
      Top = 10
      Width = 110
      Height = 21
      AutoSize = False
      Caption = 'Couleur en cours'
      Layout = tlCenter
    end
    object couleur_zone: TPanel
      Left = 10
      Top = 39
      Width = 21
      Height = 21
      TabOrder = 0
    end
    object couleur_encours: TPanel
      Left = 10
      Top = 10
      Width = 21
      Height = 21
      TabOrder = 1
    end
  end
end
