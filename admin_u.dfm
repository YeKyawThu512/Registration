object Form5: TForm5
  Left = 0
  Top = 465
  Caption = 'Admin Dashboard'
  ClientHeight = 430
  ClientWidth = 479
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object pnl1: TPanel
    Left = 0
    Top = 341
    Width = 479
    Height = 89
    Align = alBottom
    TabOrder = 0
    ExplicitTop = 257
    ExplicitWidth = 476
    object btnLogOut: TButton
      Left = 412
      Top = -163
      Width = 75
      Height = 36
      Cancel = True
      Caption = 'Log Out'
      TabOrder = 0
    end
    object DBNavigator1: TDBNavigator
      Left = 0
      Top = 6
      Width = 390
      Height = 75
      DataSource = Form6.DataSource1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
    end
    object btnLogOut2: TButton
      Left = 396
      Top = 24
      Width = 75
      Height = 57
      Caption = 'Log Out'
      TabOrder = 2
      OnClick = btnLogOut2Click
    end
  end
  object pnl2: TPanel
    Left = 0
    Top = 0
    Width = 479
    Height = 49
    Align = alTop
    TabOrder = 1
    ExplicitWidth = 476
    object lblTop: TLabel
      Left = 184
      Top = 18
      Width = 28
      Height = 13
      Caption = 'lplTop'
    end
  end
  object DBGrid2: TDBGrid
    Left = 0
    Top = 49
    Width = 479
    Height = 292
    Align = alClient
    DataSource = Form6.DataSource1
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'ID'
        Width = 40
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Username'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Password'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Confirmed Password'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Email'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Age'
        Width = 40
        Visible = True
      end>
  end
end
