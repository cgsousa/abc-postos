object frmPrinc00: TfrmPrinc00
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 
    'Posto ABC /Gerenciar os abastecimentos e tanques de combust'#237'veis' +
    ' '
  ClientHeight = 452
  ClientWidth = 794
  Color = clWindow
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Trebuchet MS'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 18
  object pnlFooter: TStackPanel
    Left = 0
    Top = 402
    Width = 794
    Height = 50
    Align = alBottom
    BevelOuter = bvNone
    BorderStyle = bsSingle
    ControlCollection = <
      item
        Control = Button1
      end
      item
        Control = Button2
      end
      item
        Control = Button3
      end
      item
        Control = Button4
      end>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Trebuchet MS'
    Font.Style = []
    Orientation = spoHorizontal
    Padding.Left = 5
    ParentFont = False
    Spacing = 3
    TabOrder = 0
    object Button1: TButton
      Left = 5
      Top = 9
      Width = 100
      Height = 30
      Action = actFilter
      TabOrder = 0
    end
    object Button2: TButton
      Left = 108
      Top = 9
      Width = 100
      Height = 30
      Action = actNew
      TabOrder = 1
    end
    object Button3: TButton
      Left = 211
      Top = 9
      Width = 100
      Height = 30
      Action = actReport
      TabOrder = 2
    end
    object Button4: TButton
      Left = 314
      Top = 9
      Width = 100
      Height = 30
      Action = actClose
      TabOrder = 3
    end
  end
  object pnlFilter: TStackPanel
    Left = 0
    Top = 0
    Width = 150
    Height = 402
    Align = alLeft
    BevelOuter = bvNone
    BorderStyle = bsSingle
    ControlCollection = <
      item
        Control = Label1
        HorizontalPositioning = sphpFill
        VerticalPositioning = spvpTop
      end>
    TabOrder = 1
    object Label1: TLabel
      Left = 0
      Top = 0
      Width = 148
      Height = 18
      Align = alTop
      Alignment = taCenter
      Caption = 'Filtro'
      Color = clGradientInactiveCaption
      ParentColor = False
      Transparent = False
    end
  end
  object lvPedidos: TListView
    Left = 150
    Top = 0
    Width = 644
    Height = 402
    Align = alClient
    Columns = <
      item
        Caption = 'ID'
      end
      item
        Alignment = taCenter
        Caption = 'Data'
        Width = 75
      end
      item
        Caption = 'Descri'#231#227'o'
        Width = 121
      end
      item
        Alignment = taRightJustify
        Caption = 'Qtde'
        Width = 65
      end
      item
        Alignment = taRightJustify
        Caption = 'Pre'#231'o'
        Width = 75
      end
      item
        Alignment = taRightJustify
        Caption = 'Total'
        Width = 75
      end
      item
        Alignment = taRightJustify
        Caption = '%Imposto'
        Width = 75
      end
      item
        Alignment = taRightJustify
        Caption = 'Imposto'
        Width = 75
      end>
    ReadOnly = True
    TabOrder = 2
    ViewStyle = vsReport
  end
  object ActionList1: TActionList
    Left = 536
    Top = 16
    object actFilter: TAction
      Caption = 'Filtro'
      OnExecute = actFilterExecute
    end
    object actNew: TAction
      Caption = 'PDV'
      OnExecute = actNewExecute
    end
    object actReport: TAction
      Caption = 'Relat'#243'rio'
    end
    object actClose: TAction
      Caption = 'Terminar'
      OnExecute = actCloseExecute
    end
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 544
    Top = 144
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 528
    Top = 80
  end
end
